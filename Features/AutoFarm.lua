local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer

local Cache = {
    MeshIdMap = {},
    MeshIdMapBuilt = false,
    PetData = {},
    UidCategory = {},
}

local AutoFarmEnabled = false
local SelectedEgg = nil
local EggList = {}

local Assets = ReplicatedStorage:WaitForChild("Data"):WaitForChild("Assets")
local Configs = Assets:WaitForChild("Configs")
local EggModels = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Models"):WaitForChild("Eggs")

local MutationsModule = nil

pcall(function()
    MutationsModule = require(ReplicatedStorage.Shared.Modules.Mutations)
end)

local Ignored = {
    ["__OBJECTS"] = true,
    ["_Guards"] = true,
    ["__ClientTreadmillRenders"] = true,
    ["Stands"] = true,
    ["ScrambleLocalVisuals"] = true,
    ["__DEBRIS"] = true,
    ["Plots"] = true,
    ["ClientRenderedAssets"] = true,
    ["PlacedEggRenders"] = true
}

local PlayerNames = {}

local function RefreshPlayerNames()
    table.clear(PlayerNames)

    for _, PlayerObject in ipairs(Players:GetPlayers()) do
        PlayerNames[PlayerObject.Name] = true
        PlayerNames[PlayerObject.DisplayName] = true
    end
end

RefreshPlayerNames()

Players.PlayerAdded:Connect(function(PlayerObject)
    PlayerNames[PlayerObject.Name] = true
    PlayerNames[PlayerObject.DisplayName] = true
end)

Players.PlayerRemoving:Connect(function(PlayerObject)
    PlayerNames[PlayerObject.Name] = nil
    PlayerNames[PlayerObject.DisplayName] = nil
end)

local function IsIgnored(Object)
    if not Object then
        return true
    end

    if PlayerNames[Object.Name] then
        return true
    end

    local Current = Object

    while Current and Current ~= Workspace do
        if Ignored[Current.Name] then
            return true
        end

        if PlayerNames[Current.Name] then
            return true
        end

        Current = Current.Parent
    end

    return false
end

local function IsEggUID(Name)
    if type(Name) ~= "string" then
        return false
    end

    if #Name < 23 then
        return false
    end

    return true
end

local function BuildMeshIdMap()
    if Cache.MeshIdMapBuilt then
        return
    end

    for _, Config in ipairs(Configs:GetChildren()) do
        local Success, Module = pcall(function()
            return require(Config)
        end)

        if Success and Module and Module.Egg then
            local ModelName = Module.Egg.ModelName or Config.Name
            local EggTemplate = EggModels:FindFirstChild(ModelName)

            if EggTemplate then
                for _, Descendant in ipairs(EggTemplate:GetDescendants()) do
                    if Descendant:IsA("MeshPart") and Descendant.MeshId ~= "" then
                        Cache.MeshIdMap[Descendant.MeshId] = Config.Name
                    elseif Descendant:IsA("SpecialMesh") and Descendant.MeshId ~= "" then
                        Cache.MeshIdMap[Descendant.MeshId] = Config.Name
                    end
                end
            end
        end
    end

    Cache.MeshIdMapBuilt = true
end

BuildMeshIdMap()

local function GetPetData(AssetCategory)
    if not AssetCategory then
        return nil
    end

    if Cache.PetData[AssetCategory] then
        return Cache.PetData[AssetCategory]
    end

    local Config = Configs:FindFirstChild(AssetCategory)

    if not Config then
        return nil
    end

    local Data = {
        Name = AssetCategory,
        DisplayName = AssetCategory,
        EarningRate = 0,
        Icon = nil
    }

    local Success, Module = pcall(function()
        return require(Config)
    end)

    if Success and Module then
        Data.DisplayName = Module.DisplayName or AssetCategory
        Data.EarningRate = tonumber(Module.EarningRate) or 0
        Data.Icon = Module.Icon
    end

    Cache.PetData[AssetCategory] = Data

    return Data
end

local function FormatMoney(Amount)
    Amount = tonumber(Amount) or 0

    if Amount >= 1e12 then
        return string.format("%.2fT", Amount / 1e12)
    elseif Amount >= 1e9 then
        return string.format("%.2fB", Amount / 1e9)
    elseif Amount >= 1e6 then
        return string.format("%.2fM", Amount / 1e6)
    elseif Amount >= 1e3 then
        return string.format("%.2fK", Amount / 1e3)
    end

    return tostring(math.floor(Amount))
end

local function CalculateRatePerSecond(EarningRate, Scale, Mutations)
    EarningRate = tonumber(EarningRate) or 0
    Scale = tonumber(Scale) or 1

    local PayoutFactor

    if Scale <= 5 then
        PayoutFactor = Scale ^ 1.85
    else
        PayoutFactor = (Scale / 5) ^ 1.2 * 19.637875755794113
    end

    local MutationMultiplier = 1

    if type(Mutations) == "table"
        and #Mutations > 0
        and MutationsModule
    then
        local Success, Result = pcall(function()
            return MutationsModule.EarningsFor(Mutations)
        end)

        if Success and type(Result) == "number" then
            MutationMultiplier = Result
        end
    end

    return math.round(
        EarningRate
        * PayoutFactor
        * MutationMultiplier
    )
end

local function FindAssetCategory(EggModel)
    if not EggModel then
        return nil
    end

    if Cache.UidCategory[EggModel] then
        return Cache.UidCategory[EggModel]
    end

    for _, Descendant in ipairs(EggModel:GetDescendants()) do
        local MeshId

        if Descendant:IsA("MeshPart") then
            MeshId = Descendant.MeshId
        elseif Descendant:IsA("SpecialMesh") then
            MeshId = Descendant.MeshId
        end

        if MeshId and MeshId ~= "" then
            local Category = Cache.MeshIdMap[MeshId]

            if Category then
                Cache.UidCategory[EggModel] = Category
                return Category
            end
        end
    end

    return nil
end

local function GetEggData(Model)
    if not Model:IsA("Model") then
        return nil
    end

    if IsIgnored(Model) then
        return nil
    end

    if not IsEggUID(Model.Name) then
        return nil
    end

    local AssetCategory = FindAssetCategory(Model)

    if not AssetCategory then
        return nil
    end

    local Data = GetPetData(AssetCategory)

    if not Data then
        return nil
    end

    local Scale = Model:GetAttribute("AssetScale") or 1
    local Mutations = Model:GetAttribute("Mutations") or {}

    local RealRate = CalculateRatePerSecond(
        Data.EarningRate,
        Scale,
        Mutations
    )

    return {
        Id = Model.Name,
        UID = Model.Name,
        Category = AssetCategory,
        DisplayName = Data.DisplayName,
        Icon = Data.Icon,
        EarningRate = RealRate,
        Model = Model
    }
end

local function ScanEggs()
    EggList = {}

    for _, Object in ipairs(Workspace:GetDescendants()) do
        if Object:IsA("Model") then
            local Data = GetEggData(Object)

            if Data then
                table.insert(EggList, Data)
            end
        end
    end

    table.sort(EggList, function(A, B)
        return A.EarningRate > B.EarningRate
    end)

    return EggList
end

local function GetBestEgg()
    local BestEgg
    local BestRate = -math.huge

    for _, Data in ipairs(EggList) do
        local Model = Data.Model

        if Model
            and Model.Parent
            and not IsIgnored(Model)
            and IsEggUID(Model.Name)
        then
            local Scale = Model:GetAttribute("AssetScale") or 1
            local Mutations = Model:GetAttribute("Mutations") or {}

            local PetData = GetPetData(Data.Category)

            if PetData then
                Data.EarningRate = CalculateRatePerSecond(
                    PetData.EarningRate,
                    Scale,
                    Mutations
                )
            end

            if Data.EarningRate > BestRate then
                BestEgg = Data
                BestRate = Data.EarningRate
            end
        end
    end

    return BestEgg
end

local function IsValidEgg(Data)
    if not Data then
        return false
    end

    if not Data.Model then
        return false
    end

    if not Data.Model.Parent then
        return false
    end

    if IsIgnored(Data.Model) then
        return false
    end

    if not IsEggUID(Data.Model.Name) then
        return false
    end

    if Data.UID ~= Data.Model.Name then
        return false
    end

    return true
end

local function EnableAutoFarm()
    AutoFarmEnabled = true
end

local function DisableAutoFarm()
    AutoFarmEnabled = false
end

local function SelectEgg(EggData)
    if not EggData then
        return
    end

    SelectedEgg = EggData
end

local function StartTeleport()
    if not SelectedEgg then
        return
    end

    if _G.YOKUDO_VIPTP
        and _G.YOKUDO_VIPTP.IsEnabled()
    then
        pcall(function()
            _G.YOKUDO_VIPTP.Disable()
        end)
    end

    if _G.YOKUDO_TeleportSystem then
        _G.YOKUDO_TeleportSystem.SetTargetId(
            SelectedEgg.Id
        )

        _G.YOKUDO_TeleportSystem.Enable()
    end
end

local function StopTeleport()
    if _G.YOKUDO_TeleportSystem then
        _G.YOKUDO_TeleportSystem.Disable()
    end
end

_G.YOKUDO_AutoFarm = {
    Enable = EnableAutoFarm,

    Disable = DisableAutoFarm,

    IsEnabled = function()
        return AutoFarmEnabled
    end,

    ScanEggs = ScanEggs,

    GetEggList = function()
        return EggList
    end,

    GetBestEgg = GetBestEgg,

    SelectEgg = SelectEgg,

    StartTeleport = StartTeleport,

    StopTeleport = StopTeleport,

    GetSelectedEgg = function()
        return SelectedEgg
    end,

    FormatMoney = FormatMoney,

    ClearCache = function()
        Cache.UidCategory = {}
    end,
}

if _G.YOKUDO_CharacterSystem then
    _G.YOKUDO_CharacterSystem:RegisterFeature({
        Name = "AutoFarm",

        Enable = EnableAutoFarm,

        Disable = DisableAutoFarm,

        IsEnabled = function()
            return AutoFarmEnabled
        end,

        OnCharacterAdded = function(Char, Hum, Root)
            if AutoFarmEnabled and SelectedEgg then
                task.wait(2)

                pcall(function()
                    if _G.YOKUDO_TeleportSystem
                        and _G.YOKUDO_TeleportSystem.IsEnabled()
                    then
                        StartTeleport()
                    end
                end)
            end
        end
    })
end
