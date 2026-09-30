local TabsManager = _G.YOKUDO_TabsManager
local TweenService = game:GetService("TweenService")

local SettingTab, SettingPage = TabsManager:RegisterTab("Setting", 7, "SETTING")

CreateSectionTitle(SettingPage, "Settings", 1)

local SafeSpeedHolder = Instance.new("Frame")
SafeSpeedHolder.Size = UDim2.new(1, 0, 0, 52)
SafeSpeedHolder.BackgroundTransparency = 1
SafeSpeedHolder.LayoutOrder = 2
SafeSpeedHolder.Parent = SettingPage

local SafeSpeedLabel = Instance.new("TextLabel")
SafeSpeedLabel.Size = UDim2.new(1, -50, 0, 20)
SafeSpeedLabel.Position = UDim2.new(0, 0, 0, 2)
SafeSpeedLabel.BackgroundTransparency = 1
SafeSpeedLabel.Text = "Walk Mode"
SafeSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SafeSpeedLabel.TextSize = 13
SafeSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SafeSpeedLabel.TextYAlignment = Enum.TextYAlignment.Center
SafeSpeedLabel.Font = Enum.Font.GothamBold
SafeSpeedLabel.Parent = SafeSpeedHolder

local SafeSpeedSub = Instance.new("TextLabel")
SafeSpeedSub.Size = UDim2.new(1, -50, 0, 18)
SafeSpeedSub.Position = UDim2.new(0, 0, 0, 24)
SafeSpeedSub.BackgroundTransparency = 1
SafeSpeedSub.Text = "Auto walk to best egg"
SafeSpeedSub.TextColor3 = Color3.fromRGB(180, 180, 180)
SafeSpeedSub.TextSize = 10
SafeSpeedSub.TextXAlignment = Enum.TextXAlignment.Left
SafeSpeedSub.Font = Enum.Font.Gotham
SafeSpeedSub.Parent = SafeSpeedHolder

local SafeSpeedBtn = Instance.new("TextButton")
SafeSpeedBtn.Size = UDim2.new(0, 26, 0, 26)
SafeSpeedBtn.Position = UDim2.new(1, -26, 0.5, -13)
SafeSpeedBtn.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
SafeSpeedBtn.BorderSizePixel = 0
SafeSpeedBtn.Text = ""
SafeSpeedBtn.AutoButtonColor = false
SafeSpeedBtn.Parent = SafeSpeedHolder

local SafeSpeedCorner = Instance.new("UICorner")
SafeSpeedCorner.CornerRadius = UDim.new(0, 6)
SafeSpeedCorner.Parent = SafeSpeedBtn

local SafeSpeedStroke = Instance.new("UIStroke")
SafeSpeedStroke.Color = Color3.fromRGB(200, 200, 220)
SafeSpeedStroke.Thickness = 1.5
SafeSpeedStroke.Parent = SafeSpeedBtn

local SafeSpeedCheck = Instance.new("TextLabel")
SafeSpeedCheck.Size = UDim2.new(1, 0, 1, 0)
SafeSpeedCheck.BackgroundTransparency = 1
SafeSpeedCheck.Text = "✓"
SafeSpeedCheck.TextColor3 = Color3.fromRGB(255, 255, 255)
SafeSpeedCheck.TextSize = 18
SafeSpeedCheck.Font = Enum.Font.GothamBold
SafeSpeedCheck.Visible = false
SafeSpeedCheck.Parent = SafeSpeedBtn

local SafeSpeedEnabled = false

local function ToggleSafeSpeed()
    SafeSpeedEnabled = not SafeSpeedEnabled
    SafeSpeedCheck.Visible = SafeSpeedEnabled

    if SafeSpeedEnabled then
        SafeSpeedBtn.BackgroundColor3 = Color3.fromRGB(105, 90, 190)
        SafeSpeedStroke.Color = Color3.fromRGB(135, 120, 225)
    else
        SafeSpeedBtn.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
        SafeSpeedStroke.Color = Color3.fromRGB(200, 200, 220)
    end

    if _G.YOKUDO_TeleportSystem then
        _G.YOKUDO_TeleportSystem.SetSafeSpeedMode(SafeSpeedEnabled)
    end

    _G.YOKUDO_SafeSpeedMode = SafeSpeedEnabled

    if _G.YOKUDO_ConfigSystem then
        _G.YOKUDO_ConfigSystem.Save()
    end
end

SafeSpeedBtn.MouseButton1Click:Connect(function()
    ToggleSafeSpeed()
end)

local AntiTrapHolder = Instance.new("Frame")
AntiTrapHolder.Size = UDim2.new(1, 0, 0, 52)
AntiTrapHolder.BackgroundTransparency = 1
AntiTrapHolder.LayoutOrder = 3
AntiTrapHolder.Parent = SettingPage

local AntiTrapLabel = Instance.new("TextLabel")
AntiTrapLabel.Size = UDim2.new(1, -50, 0, 20)
AntiTrapLabel.Position = UDim2.new(0, 0, 0, 2)
AntiTrapLabel.BackgroundTransparency = 1
AntiTrapLabel.Text = "Anti Trap"
AntiTrapLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiTrapLabel.TextSize = 13
AntiTrapLabel.TextXAlignment = Enum.TextXAlignment.Left
AntiTrapLabel.TextYAlignment = Enum.TextYAlignment.Center
AntiTrapLabel.Font = Enum.Font.GothamBold
AntiTrapLabel.Parent = AntiTrapHolder

local AntiTrapTitle = Instance.new("TextLabel")
AntiTrapTitle.Size = UDim2.new(1, -50, 0, 18)
AntiTrapTitle.Position = UDim2.new(0, 0, 0, 24)
AntiTrapTitle.BackgroundTransparency = 1
AntiTrapTitle.Text = "click for remove Trap"
AntiTrapTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
AntiTrapTitle.TextSize = 10
AntiTrapTitle.TextXAlignment = Enum.TextXAlignment.Left
AntiTrapTitle.Font = Enum.Font.Gotham
AntiTrapTitle.Parent = AntiTrapHolder

local AntiTrapCheckButton = Instance.new("TextButton")
AntiTrapCheckButton.Size = UDim2.new(0, 26, 0, 26)
AntiTrapCheckButton.Position = UDim2.new(1, -26, 0.5, -13)
AntiTrapCheckButton.BackgroundColor3 = Color3.fromRGB(105, 90, 190)
AntiTrapCheckButton.BorderSizePixel = 0
AntiTrapCheckButton.Text = ""
AntiTrapCheckButton.AutoButtonColor = false
AntiTrapCheckButton.Parent = AntiTrapHolder

local AntiTrapCorner = Instance.new("UICorner")
AntiTrapCorner.CornerRadius = UDim.new(0, 6)
AntiTrapCorner.Parent = AntiTrapCheckButton

local AntiTrapStroke = Instance.new("UIStroke")
AntiTrapStroke.Color = Color3.fromRGB(135, 120, 225)
AntiTrapStroke.Thickness = 1.5
AntiTrapStroke.Parent = AntiTrapCheckButton

local AntiTrapCheck = Instance.new("TextLabel")
AntiTrapCheck.Size = UDim2.new(1, 0, 1, 0)
AntiTrapCheck.BackgroundTransparency = 1
AntiTrapCheck.Text = "✓"
AntiTrapCheck.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiTrapCheck.TextSize = 18
AntiTrapCheck.Font = Enum.Font.GothamBold
AntiTrapCheck.Visible = true
AntiTrapCheck.Parent = AntiTrapCheckButton

local AntiTrapEnabled = true

local function ToggleAntiTrap()
    AntiTrapEnabled = not AntiTrapEnabled
    AntiTrapCheck.Visible = AntiTrapEnabled

    if AntiTrapEnabled then
        AntiTrapCheckButton.BackgroundColor3 = Color3.fromRGB(105, 90, 190)
        AntiTrapStroke.Color = Color3.fromRGB(135, 120, 225)

        if _G.YOKUDO_AntiTrap then
            _G.YOKUDO_AntiTrap.Enable()
        end
    else
        AntiTrapCheckButton.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
        AntiTrapStroke.Color = Color3.fromRGB(200, 200, 220)

        if _G.YOKUDO_AntiTrap then
            _G.YOKUDO_AntiTrap.Disable()
        end
    end
end

AntiTrapCheckButton.MouseButton1Click:Connect(function()
    ToggleAntiTrap()
end)

local AntiAFKHolder = Instance.new("Frame")
AntiAFKHolder.Size = UDim2.new(1, 0, 0, 52)
AntiAFKHolder.BackgroundTransparency = 1
AntiAFKHolder.LayoutOrder = 6
AntiAFKHolder.Parent = SettingPage

local AntiAFKLabel = Instance.new("TextLabel")
AntiAFKLabel.Size = UDim2.new(1, -50, 0, 20)
AntiAFKLabel.Position = UDim2.new(0, 0, 0, 2)
AntiAFKLabel.BackgroundTransparency = 1
AntiAFKLabel.Text = "Anti AFK"
AntiAFKLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiAFKLabel.TextSize = 13
AntiAFKLabel.TextXAlignment = Enum.TextXAlignment.Left
AntiAFKLabel.TextYAlignment = Enum.TextYAlignment.Center
AntiAFKLabel.Font = Enum.Font.GothamBold
AntiAFKLabel.Parent = AntiAFKHolder

local AntiAFKTitle = Instance.new("TextLabel")
AntiAFKTitle.Size = UDim2.new(1, -50, 0, 18)
AntiAFKTitle.Position = UDim2.new(0, 0, 0, 24)
AntiAFKTitle.BackgroundTransparency = 1
AntiAFKTitle.Text = "Click when AFK"
AntiAFKTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
AntiAFKTitle.TextSize = 10
AntiAFKTitle.TextXAlignment = Enum.TextXAlignment.Left
AntiAFKTitle.Font = Enum.Font.Gotham
AntiAFKTitle.Parent = AntiAFKHolder

local AntiAFKCheckButton = Instance.new("TextButton")
AntiAFKCheckButton.Size = UDim2.new(0, 26, 0, 26)
AntiAFKCheckButton.Position = UDim2.new(1, -26, 0.5, -13)
AntiAFKCheckButton.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
AntiAFKCheckButton.BorderSizePixel = 0
AntiAFKCheckButton.Text = ""
AntiAFKCheckButton.AutoButtonColor = false
AntiAFKCheckButton.Parent = AntiAFKHolder

local AntiAFKCorner = Instance.new("UICorner")
AntiAFKCorner.CornerRadius = UDim.new(0, 6)
AntiAFKCorner.Parent = AntiAFKCheckButton

local AntiAFKStroke = Instance.new("UIStroke")
AntiAFKStroke.Color = Color3.fromRGB(200, 200, 220)
AntiAFKStroke.Thickness = 1.5
AntiAFKStroke.Parent = AntiAFKCheckButton

local AntiAFKCheck = Instance.new("TextLabel")
AntiAFKCheck.Size = UDim2.new(1, 0, 1, 0)
AntiAFKCheck.BackgroundTransparency = 1
AntiAFKCheck.Text = "✓"
AntiAFKCheck.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiAFKCheck.TextSize = 18
AntiAFKCheck.Font = Enum.Font.GothamBold
AntiAFKCheck.Visible = false
AntiAFKCheck.Parent = AntiAFKCheckButton

local AntiAFKEnabled = false

local function ToggleAntiAFK()
    AntiAFKEnabled = not AntiAFKEnabled
    AntiAFKCheck.Visible = AntiAFKEnabled

    if AntiAFKEnabled then
        AntiAFKCheckButton.BackgroundColor3 = Color3.fromRGB(105, 90, 190)
        AntiAFKStroke.Color = Color3.fromRGB(135, 120, 225)

        if _G.YOKUDO_AntiAFK then
            _G.YOKUDO_AntiAFK.Enable()
        end
    else
        AntiAFKCheckButton.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
        AntiAFKStroke.Color = Color3.fromRGB(200, 200, 220)

        if _G.YOKUDO_AntiAFK then
            _G.YOKUDO_AntiAFK.Disable()
        end
    end
end

AntiAFKCheckButton.MouseButton1Click:Connect(function()
    ToggleAntiAFK()
end)

task.spawn(function()
    task.wait(0.5)

    if _G.YOKUDO_TeleportSystem then
        local SafeState = _G.YOKUDO_TeleportSystem.GetSafeSpeedMode
            and _G.YOKUDO_TeleportSystem.GetSafeSpeedMode()

        if SafeState then
            SafeSpeedEnabled = true
            SafeSpeedCheck.Visible = true
            SafeSpeedBtn.BackgroundColor3 = Color3.fromRGB(105, 90, 190)
            SafeSpeedStroke.Color = Color3.fromRGB(135, 120, 225)
        end
    end

    if _G.YOKUDO_AntiTrap then
        _G.YOKUDO_AntiTrap.Enable()
    end

    if _G.YOKUDO_AntiAFK then
        if _G.YOKUDO_AntiAFK.IsEnabled() then
            AntiAFKEnabled = true
            AntiAFKCheck.Visible = true
            AntiAFKCheckButton.BackgroundColor3 = Color3.fromRGB(105, 90, 190)
            AntiAFKStroke.Color = Color3.fromRGB(135, 120, 225)
        end
    end
end)

_G.YOKUDO_RefreshSettingUI = function()
    if _G.YOKUDO_TeleportSystem then
        local State = _G.YOKUDO_TeleportSystem.GetSafeSpeedMode
            and _G.YOKUDO_TeleportSystem.GetSafeSpeedMode()

        SafeSpeedEnabled = State or false
        SafeSpeedCheck.Visible = SafeSpeedEnabled

        if SafeSpeedEnabled then
            SafeSpeedBtn.BackgroundColor3 = Color3.fromRGB(105, 90, 190)
            SafeSpeedStroke.Color = Color3.fromRGB(135, 120, 225)
        else
            SafeSpeedBtn.BackgroundColor3 = Color3.fromRGB(28, 29, 39)
            SafeSpeedStroke.Color = Color3.fromRGB(200, 200, 220)
        end
    end
end
