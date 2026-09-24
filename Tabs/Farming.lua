local TabsManager = _G.YOKUDO_TabsManager
local TweenService = game:GetService("TweenService")

local FarmingTab, FarmingPage = TabsManager:RegisterTab("Auto Farm", 2, "FARMING")

CreateSectionTitle(FarmingPage, "Auto Farm", 1)

local RarityHolder = Instance.new("Frame")
RarityHolder.Size = UDim2.new(1, 0, 0, 52)
RarityHolder.BackgroundTransparency = 1
RarityHolder.LayoutOrder = 2
RarityHolder.ZIndex = 100
RarityHolder.Parent = FarmingPage

local RarityLabel = Instance.new("TextLabel")
RarityLabel.Size = UDim2.new(1, -120, 0, 20)
RarityLabel.Position = UDim2.new(0, 0, 0, 2)
RarityLabel.BackgroundTransparency = 1
RarityLabel.Text = "Select Egg Type"
RarityLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
RarityLabel.TextSize = 13
RarityLabel.TextXAlignment = Enum.TextXAlignment.Left
RarityLabel.TextYAlignment = Enum.TextYAlignment.Center
RarityLabel.Font = Enum.Font.GothamBold
RarityLabel.ZIndex = 101
RarityLabel.Parent = RarityHolder

local RarityTitle = Instance.new("TextLabel")
RarityTitle.Size = UDim2.new(1, -120, 0, 18)
RarityTitle.Position = UDim2.new(0, 0, 0, 24)
RarityTitle.BackgroundTransparency = 1
RarityTitle.Text = "Select Rarity to Farm"
RarityTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
RarityTitle.TextSize = 10
RarityTitle.TextXAlignment = Enum.TextXAlignment.Left
RarityTitle.Font = Enum.Font.Gotham
RarityTitle.ZIndex = 101
RarityTitle.Parent = RarityHolder

local SelectedRarities = {
    Secret = true,
    Eternal = true,
    Divine = true
}

local function GetSelectedText()
    local List = {}

    if SelectedRarities.Secret then
        table.insert(List, "Secret")
    end

    if SelectedRarities.Eternal then
        table.insert(List, "Eternal")
    end

    if SelectedRarities.Divine then
        table.insert(List, "Divine")
    end

    if #List == 0 then
        return "None"
    end

    if #List == 3 then
        return "All"
    end

    return table.concat(List, ", ")
end

local function GetRarityList()
    local List = {}

    if SelectedRarities.Secret then
        table.insert(List, "Secret")
    end

    if SelectedRarities.Eternal then
        table.insert(List, "Eternal")
    end

    if SelectedRarities.Divine then
        table.insert(List, "Divine")
    end

    return List
end

local function UpdateRarities()
    local List = GetRarityList()

    if _G.YOKUDO_EggCheckPremium then
        _G.YOKUDO_EggCheckPremium.SetRarities(List)
    end

    if _G.YOKUDO_FarmingManager then
        _G.YOKUDO_FarmingManager.SetRarities(List)
    end
end

local DropdownBtn = Instance.new("TextButton")
DropdownBtn.Size = UDim2.new(0, 120, 0, 28)
DropdownBtn.Position = UDim2.new(1, -120, 0.5, -14)
DropdownBtn.BackgroundColor3 = Color3.fromRGB(30, 31, 45)
DropdownBtn.BorderSizePixel = 0
DropdownBtn.Text = GetSelectedText() .. " ▼"
DropdownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DropdownBtn.TextSize = 11
DropdownBtn.Font = Enum.Font.GothamBold
DropdownBtn.AutoButtonColor = false
DropdownBtn.ZIndex = 101
DropdownBtn.Parent = RarityHolder

local DdCorner = Instance.new("UICorner")
DdCorner.CornerRadius = UDim.new(0, 6)
DdCorner.Parent = DropdownBtn

local DdStroke = Instance.new("UIStroke")
DdStroke.Color = Color3.fromRGB(200, 200, 220)
DdStroke.Thickness = 1
DdStroke.Transparency = 0.3
DdStroke.Parent = DropdownBtn

local DropdownList = Instance.new("Frame")
DropdownList.Size = UDim2.new(0, 120, 0, 80)
DropdownList.Position = UDim2.new(1, -120, 1, 2)
DropdownList.BackgroundColor3 = Color3.fromRGB(25, 26, 38)
DropdownList.BorderSizePixel = 0
DropdownList.Visible = false
DropdownList.ZIndex = 200
DropdownList.Parent = RarityHolder

local DlCorner = Instance.new("UICorner")
DlCorner.CornerRadius = UDim.new(0, 6)
DlCorner.Parent = DropdownList

local DlStroke = Instance.new("UIStroke")
DlStroke.Color = Color3.fromRGB(200, 200, 220)
DlStroke.Thickness = 1
DlStroke.Transparency = 0.3
DlStroke.Parent = DropdownList

local DlLayout = Instance.new("UIListLayout")
DlLayout.Padding = UDim.new(0, 2)
DlLayout.SortOrder = Enum.SortOrder.LayoutOrder
DlLayout.Parent = DropdownList

local DlPadding = Instance.new("UIPadding")
DlPadding.PaddingTop = UDim.new(0, 4)
DlPadding.PaddingBottom = UDim.new(0, 4)
DlPadding.PaddingLeft = UDim.new(0, 4)
DlPadding.PaddingRight = UDim.new(0, 4)
DlPadding.Parent = DropdownList

local OptionButtons = {}

local function UpdateOptionVisual(Name)
    local Option = OptionButtons[Name]

    if not Option then
        return
    end

    if SelectedRarities[Name] then
        Option.BackgroundColor3 = Color3.fromRGB(105, 90, 190)
        Option.Text = "✓ " .. Name
    else
        Option.BackgroundColor3 = Color3.fromRGB(30, 31, 45)
        Option.Text = Name
    end
end

local function CreateDropdownOption(Name, Order)
    local Option = Instance.new("TextButton")
    Option.Size = UDim2.new(1, 0, 0, 22)
    Option.BackgroundColor3 = Color3.fromRGB(30, 31, 45)
    Option.BorderSizePixel = 0
    Option.Text = Name
    Option.TextColor3 = Color3.fromRGB(255, 255, 255)
    Option.TextSize = 11
    Option.Font = Enum.Font.GothamMedium
    Option.AutoButtonColor = false
    Option.LayoutOrder = Order
    Option.ZIndex = 201
    Option.Parent = DropdownList

    local OptCorner = Instance.new("UICorner")
    OptCorner.CornerRadius = UDim.new(0, 4)
    OptCorner.Parent = Option

    OptionButtons[Name] = Option

    Option.MouseButton1Click:Connect(function()
        SelectedRarities[Name] = not SelectedRarities[Name]
        UpdateOptionVisual(Name)
        DropdownBtn.Text = GetSelectedText() .. " ▼"
        UpdateRarities()
    end)

    Option.MouseEnter:Connect(function()
        if not SelectedRarities[Name] then
            TweenService:Create(
                Option,
                TweenInfo.new(0.1),
                {
                    BackgroundColor3 = Color3.fromRGB(45, 46, 60)
                }
            ):Play()
        end
    end)

    Option.MouseLeave:Connect(function()
        UpdateOptionVisual(Name)
    end)

    UpdateOptionVisual(Name)
end

CreateDropdownOption("Secret", 1)
CreateDropdownOption("Eternal", 2)
CreateDropdownOption("Divine", 3)

DropdownBtn.MouseButton1Click:Connect(function()
    DropdownList.Visible = not DropdownList.Visible
end)

local FarmHolder = Instance.new("Frame")
FarmHolder.Size = UDim2.new(1, 0, 0, 52)
FarmHolder.BackgroundTransparency = 1
FarmHolder.LayoutOrder = 3
FarmHolder.Parent = FarmingPage

local FarmLabel = Instance.new("TextLabel")
FarmLabel.Size = UDim2.new(1, -50, 0, 20)
FarmLabel.Position = UDim2.new(0, 0, 0, 2)
FarmLabel.BackgroundTransparency = 1
FarmLabel.Text = "Auto AFK Farming Egg"
FarmLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmLabel.TextSize = 13
FarmLabel.TextXAlignment = Enum.TextXAlignment.Left
FarmLabel.TextYAlignment = Enum.TextYAlignment.Center
FarmLabel.Font = Enum.Font.GothamBold
FarmLabel.Parent = FarmHolder

local FarmSub = Instance.new("TextLabel")
FarmSub.Size = UDim2.new(1, -50, 0, 18)
FarmSub.Position = UDim2.new(0, 0, 0, 24)
FarmSub.BackgroundTransparency = 1
FarmSub.Text = "Automatically farm selected eggs"
FarmSub.TextColor3 = Color3.fromRGB(150, 150, 170)
FarmSub.TextSize = 10
FarmSub.TextXAlignment = Enum.TextXAlignment.Left
FarmSub.Font = Enum.Font.Gotham
FarmSub.Parent = FarmHolder

local FarmButton = Instance.new("TextButton")
FarmButton.Size = UDim2.new(0, 26, 0, 26)
FarmButton.Position = UDim2.new(1, -26, 0.5, -13)
FarmButton.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
FarmButton.BorderSizePixel = 0
FarmButton.Text = ""
FarmButton.AutoButtonColor = false
FarmButton.Parent = FarmHolder

local FarmCorner = Instance.new("UICorner")
FarmCorner.CornerRadius = UDim.new(0, 6)
FarmCorner.Parent = FarmButton

local FarmStroke = Instance.new("UIStroke")
FarmStroke.Color = Color3.fromRGB(200, 200, 220)
FarmStroke.Thickness = 1.5
FarmStroke.Parent = FarmButton

local FarmCheck = Instance.new("TextLabel")
FarmCheck.Size = UDim2.new(1, 0, 1, 0)
FarmCheck.BackgroundTransparency = 1
FarmCheck.Text = "✓"
FarmCheck.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmCheck.TextSize = 18
FarmCheck.Font = Enum.Font.GothamBold
FarmCheck.Visible = false
FarmCheck.Parent = FarmButton

local FarmEnabled = false

local function SetFarmUI(State)
    FarmEnabled = State
    FarmCheck.Visible = State

    if State then
        FarmButton.BackgroundColor3 = Color3.fromRGB(105, 90, 190)
        FarmStroke.Color = Color3.fromRGB(135, 120, 225)
    else
        FarmButton.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
        FarmStroke.Color = Color3.fromRGB(200, 200, 220)
    end
end

local function EnableFarm()
    if not _G.YOKUDO_FarmingManager then
        return
    end

    UpdateRarities()
    _G.YOKUDO_FarmingManager.Enable()
    SetFarmUI(true)
end

local function DisableFarm()
    if not _G.YOKUDO_FarmingManager then
        return
    end

    _G.YOKUDO_FarmingManager.Disable()
    SetFarmUI(false)
end

local function ToggleFarm()
    if FarmEnabled then
        DisableFarm()
    else
        EnableFarm()
    end
end

FarmButton.MouseButton1Click:Connect(function()
    ToggleFarm()
end)

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local LP = Players.LocalPlayer
local RS = ReplicatedStorage

--==================================================
-- REFERENCES
--==================================================

local Configs =
	RS:WaitForChild("Data")
		:WaitForChild("Assets")
		:WaitForChild("Configs")

local EggModels =
	RS:WaitForChild("Assets")
		:WaitForChild("Models")
		:WaitForChild("Eggs")

local AskFieldEggCarry =
	RS:WaitForChild("Packages")
		:WaitForChild("Networking")
		:WaitForChild("RF/EggWorld/AskFieldEggCarry")

--==================================================
-- EXCLUSIONS
--==================================================

local IgnoredWorkspaceFolders = {
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

local function IsPlayerUsername(Name)

	for _, Player in ipairs(Players:GetPlayers()) do

		if Player.Name == Name
			or Player.DisplayName == Name
		then
			return true
		end

	end

	return false
end

local function IsIgnoredWorkspaceObject(Object)

	if not Object then
		return true
	end

	if IsPlayerUsername(Object.Name) then
		return true
	end

	local Current = Object

	while Current
		and Current ~= Workspace
	do

		if IgnoredWorkspaceFolders[Current.Name] then
			return true
		end

		Current = Current.Parent
	end

	return false
end

--==================================================
-- MESH MAP
--==================================================

local MeshIdToCategory = {}

for _, Config in ipairs(Configs:GetChildren()) do

	local Success, Module =
		pcall(require, Config)

	if Success
		and Module
		and Module.Egg
	then

		local ModelName =
			Module.Egg.ModelName
			or Config.Name

		local Template =
			EggModels:FindFirstChild(ModelName)

		if Template then

			for _, Object in ipairs(
				Template:GetDescendants()
			) do

				if Object:IsA("MeshPart")
					and Object.MeshId ~= ""
				then

					MeshIdToCategory[
						Object.MeshId
					] = Config.Name

				elseif Object:IsA("SpecialMesh")
					and Object.MeshId ~= ""
				then

					MeshIdToCategory[
						Object.MeshId
					] = Config.Name
				end

			end

		end
	end
end

--==================================================
-- MUTATIONS
--==================================================

local MutationsModule

pcall(function()

	MutationsModule =
		require(
			RS.Shared.Modules.Mutations
		)

end)

--==================================================
-- CATEGORY
--==================================================

local function FindAssetCategory(Model)

	for _, Object in ipairs(
		Model:GetDescendants()
	) do

		if Object:IsA("MeshPart")
			and Object.MeshId ~= ""
		then

			local Category =
				MeshIdToCategory[
					Object.MeshId
				]

			if Category then
				return Category
			end

		elseif Object:IsA("SpecialMesh")
			and Object.MeshId ~= ""
		then

			local Category =
				MeshIdToCategory[
					Object.MeshId
				]

			if Category then
				return Category
			end

		end
	end

	return nil
end

--==================================================
-- RATE
--==================================================

local function CalculateRate(
	EarningRate,
	Scale,
	Mutations
)

	EarningRate =
		tonumber(EarningRate)
		or 0

	Scale =
		tonumber(Scale)
		or 1

	local PayoutFactor

	if Scale <= 5 then

		PayoutFactor =
			Scale ^ 1.85

	else

		PayoutFactor =
			(Scale / 5) ^ 1.2
			* 19.637875755794113

	end

	local MutationMultiplier = 1

	if type(Mutations) == "table"
		and #Mutations > 0
		and MutationsModule
	then

		local Success, Result =
			pcall(function()

				return MutationsModule.EarningsFor(
					Mutations
				)

			end)

		if Success
			and type(Result) == "number"
		then

			MutationMultiplier =
				Result

		end
	end

	return math.round(
		EarningRate
		* PayoutFactor
		* MutationMultiplier
	)
end

--==================================================
-- EGG DATA
--==================================================

local function GetEggRate(Model)

	if not Model
		or not Model:IsA("Model")
	then
		return nil
	end

	if IsIgnoredWorkspaceObject(Model) then
		return nil
	end

	local Category =
		FindAssetCategory(Model)

	if not Category then
		return nil
	end

	local Config =
		Configs:FindFirstChild(Category)

	if not Config then
		return nil
	end

	local Success, Module =
		pcall(require, Config)

	if not Success
		or not Module
	then
		return nil
	end

	local Scale =
		Model:GetAttribute("AssetScale")
		or 1

	local Mutations =
		Model:GetAttribute("Mutations")
		or {}

	return {
		Model = Model,

		UID = Model.Name,

		Rate = CalculateRate(
			Module.EarningRate,
			Scale,
			Mutations
		)
	}
end

--==================================================
-- EGG CACHE
--==================================================

local EggCache = {}

local function AddEgg(Model)

	if EggCache[Model] then
		return
	end

	local Data =
		GetEggRate(Model)

	if Data then
		EggCache[Model] = Data
	end
end

local function RemoveEgg(Model)

	EggCache[Model] = nil
end

for _, Object in ipairs(
	Workspace:GetDescendants()
) do

	if Object:IsA("Model") then
		AddEgg(Object)
	end

end

Workspace.DescendantAdded:Connect(function(Object)

	if Object:IsA("Model") then
		AddEgg(Object)
	end

end)

Workspace.DescendantRemoving:Connect(function(Object)

	if Object:IsA("Model") then
		RemoveEgg(Object)
	end

end)

local BestEgg = nil

local function RefreshBestEgg()

	local HighestRate = -math.huge
	local HighestEgg = nil

	for Model, Data in pairs(EggCache) do

		if Model
			and Model.Parent
			and not IsIgnoredWorkspaceObject(Model)
		then

			local CurrentRate =
				GetEggRate(Model)

			if CurrentRate then

				EggCache[Model] =
					CurrentRate

				if CurrentRate.Rate > HighestRate then

					HighestRate =
						CurrentRate.Rate

					HighestEgg =
						CurrentRate

				end

			end

		else

			EggCache[Model] = nil
		end

	end

	BestEgg = HighestEgg

	return HighestEgg
end

local LoopRunning = false
local LoopToken = 0

function StopLoop()

	LoopRunning = false
	LoopToken += 1

end

function StartLoop()

	if LoopRunning then
		return
	end

	LoopRunning = true
	LoopToken += 1

	local Token =
		LoopToken

	task.spawn(function()

		local LastRefresh = 0

		while LoopRunning
			and LoopToken == Token
		do

			local Now =
				os.clock()

			if Now - LastRefresh >= 0.5 then

    			RefreshBestEgg()
				LastRefresh = Now
			end

			if BestEgg
				and BestEgg.Model
				and BestEgg.Model.Parent
			then

				local UID =
					BestEgg.UID
				pcall(function()
					AskFieldEggCarry:InvokeServer({
						Uid = UID
					})

				end)
			end
		end
	end)
end

local GrabHolder = Instance.new("Frame")
GrabHolder.Size = UDim2.new(1, 0, 0, 52)
GrabHolder.BackgroundTransparency = 1
GrabHolder.LayoutOrder = 4
GrabHolder.Parent = FarmingPage

local GrabLabel = Instance.new("TextLabel")
GrabLabel.Size = UDim2.new(1, -50, 0, 20)
GrabLabel.Position = UDim2.new(0, 0, 0, 2)
GrabLabel.BackgroundTransparency = 1
GrabLabel.Text = "Auto Grab"
GrabLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
GrabLabel.TextSize = 13
GrabLabel.TextXAlignment = Enum.TextXAlignment.Left
GrabLabel.TextYAlignment = Enum.TextYAlignment.Center
GrabLabel.Font = Enum.Font.GothamBold
GrabLabel.Parent = GrabHolder

local GrabSub = Instance.new("TextLabel")
GrabSub.Size = UDim2.new(1, -50, 0, 18)
GrabSub.Position = UDim2.new(0, 0, 0, 24)
GrabSub.BackgroundTransparency = 1
GrabSub.Text = "Fast Grab Egg"
GrabSub.TextColor3 = Color3.fromRGB(150, 150, 170)
GrabSub.TextSize = 10
GrabSub.TextXAlignment = Enum.TextXAlignment.Left
GrabSub.Font = Enum.Font.Gotham
GrabSub.Parent = GrabHolder

local GrabButton = Instance.new("TextButton")
GrabButton.Size = UDim2.new(0, 26, 0, 26)
GrabButton.Position = UDim2.new(1, -26, 0.5, -13)
GrabButton.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
GrabButton.BorderSizePixel = 0
GrabButton.Text = ""
GrabButton.AutoButtonColor = false
GrabButton.Parent = GrabHolder

local GrabCorner = Instance.new("UICorner")
GrabCorner.CornerRadius = UDim.new(0, 6)
GrabCorner.Parent = GrabButton

local GrabStroke = Instance.new("UIStroke")
GrabStroke.Color = Color3.fromRGB(200, 200, 220)
GrabStroke.Thickness = 1.5
GrabStroke.Parent = GrabButton

local GrabCheck = Instance.new("TextLabel")
GrabCheck.Size = UDim2.new(1, 0, 1, 0)
GrabCheck.BackgroundTransparency = 1
GrabCheck.Text = "✓"
GrabCheck.TextColor3 = Color3.fromRGB(255, 255, 255)
GrabCheck.TextSize = 18
GrabCheck.Font = Enum.Font.GothamBold
GrabCheck.Visible = false
GrabCheck.Parent = GrabButton

local GrabEnabled = false

local function SetGrabUI(State)
    GrabEnabled = State
    GrabCheck.Visible = State

    if State then
        GrabButton.BackgroundColor3 = Color3.fromRGB(105, 90, 190)
        GrabStroke.Color = Color3.fromRGB(135, 120, 225)
    else
        GrabButton.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
        GrabStroke.Color = Color3.fromRGB(200, 200, 220)
    end
end

local function EnableGrab()
    StartLoop()
    SetGrabUI(true)
end

local function DisableGrab()
    StopLoop()
    SetGrabUI(false)
end

local function ToggleGrab()
    if GrabEnabled then
        DisableGrab()
    else
        EnableGrab()
    end
end

GrabButton.MouseButton1Click:Connect(function()
    ToggleGrab()
end)

task.spawn(function()
    while not _G.YOKUDO_FarmingManager do
        task.wait(0.1)
    end

    UpdateRarities()
    _G.YOKUDO_FarmingManager.Enable()
    SetFarmUI(true)
end)

task.spawn(function()
    while task.wait(1) do
        if _G.YOKUDO_FarmingManager then
            local CurrentState = _G.YOKUDO_FarmingManager.IsEnabled()

            if CurrentState ~= FarmEnabled then
                SetFarmUI(CurrentState)
            end
        end
    end
end)

_G.YOKUDO_RefreshFarmingUI = function()
    if not _G.YOKUDO_FarmingManager then
        return
    end

    local State = _G.YOKUDO_FarmingManager.IsEnabled()

    SetFarmUI(State)

    if State then
        UpdateRarities()
    end
end
