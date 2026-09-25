local Services = {
    Players = game:GetService("Players"),
    TweenService = game:GetService("TweenService"),
    UserInputService = game:GetService("UserInputService"),
    RunService = game:GetService("RunService"),
    CoreGui = game:GetService("CoreGui"),
    ContentProvider = game:GetService("ContentProvider"),
}

local Settings = _G.YOKUDO
local Theme = Settings.UI.Theme

local GuiParent = Services.CoreGui

pcall(function()
    if type(gethui) == "function" then
        local HUI = gethui()
        if HUI then
            GuiParent = HUI
        end
    end
end)

pcall(function()
    local Old = GuiParent:FindFirstChild("Player3")
    if Old then
        Old:Destroy()
    end

    local OldToggle = GuiParent:FindFirstChild("ToggleGUI")
    if OldToggle then
        OldToggle:Destroy()
    end
end)

local ASSET_ID = Settings.AssetID

pcall(function()
    Services.ContentProvider:PreloadAsync({ASSET_ID})
end)

--------------------------------------------------
-- RED / BLUE BORDER
--------------------------------------------------

local BorderColors = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 100, 255)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 100, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
})

--------------------------------------------------
-- TOGGLE GUI
--------------------------------------------------

local ToggleScreenGui = Instance.new("ScreenGui")
ToggleScreenGui.Name = "ToggleGUI"
ToggleScreenGui.ResetOnSpawn = false
ToggleScreenGui.IgnoreGuiInset = true
ToggleScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ToggleScreenGui.Parent = GuiParent

local Toggle = Instance.new("ImageButton")
Toggle.Name = "Y"
Toggle.Size = UDim2.new(0, 55, 0, 55)
Toggle.Position = UDim2.new(0.02, 0, 0.5, -27.5)
Toggle.BackgroundColor3 = Color3.fromRGB(18, 20, 30)
Toggle.BorderSizePixel = 0
Toggle.BackgroundTransparency = 0
Toggle.Image = ASSET_ID
Toggle.ZIndex = 999
Toggle.AutoButtonColor = false
Toggle.Parent = ToggleScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 14)
ToggleCorner.Parent = Toggle

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Thickness = 2
ToggleStroke.Transparency = 0.05
ToggleStroke.Color = Color3.fromRGB(255, 0, 0)
ToggleStroke.Parent = Toggle

local ToggleBorderGradient = Instance.new("UIGradient")
ToggleBorderGradient.Color = BorderColors
ToggleBorderGradient.Rotation = 0
ToggleBorderGradient.Parent = ToggleStroke

task.spawn(function()
    while ToggleScreenGui.Parent do
        local Tween = Services.TweenService:Create(
            ToggleBorderGradient,
            TweenInfo.new(
                1.2,
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.InOut
            ),
            {
                Rotation = ToggleBorderGradient.Rotation + 360
            }
        )

        Tween:Play()
        Tween.Completed:Wait()
    end
end)

--------------------------------------------------
-- MAIN GUI
--------------------------------------------------

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Player3"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = GuiParent

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(
    0,
    Settings.UI.Width,
    0,
    Settings.UI.Height
)

Main.Position = UDim2.new(
    0.5,
    -Settings.UI.Width / 2,
    0.5,
    -Settings.UI.Height / 2
)

Main.BackgroundColor3 = Theme.Background
Main.BorderSizePixel = 0

-- Same method as the loading screen.
Main.ClipsDescendants = true

Main.Active = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

local MainBorder = Instance.new("UIStroke")
MainBorder.Thickness = 2
MainBorder.Transparency = 0.05
MainBorder.Color = Color3.fromRGB(255, 0, 0)
MainBorder.Parent = Main

local MainBorderGradient = Instance.new("UIGradient")
MainBorderGradient.Color = BorderColors
MainBorderGradient.Rotation = 0
MainBorderGradient.Parent = MainBorder

task.spawn(function()
    while ScreenGui.Parent do
        local Tween = Services.TweenService:Create(
            MainBorderGradient,
            TweenInfo.new(
                1.2,
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.InOut
            ),
            {
                Rotation = MainBorderGradient.Rotation + 360
            }
        )

        Tween:Play()
        Tween.Completed:Wait()
    end
end)

--------------------------------------------------
-- TOP BAR
--------------------------------------------------

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 58)
TopBar.BackgroundColor3 = Theme.TopBar
TopBar.BorderSizePixel = 0
TopBar.Active = true
TopBar.ZIndex = 20
TopBar.Parent = Main

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 14)
TopCorner.Parent = TopBar

local TopGradient = Instance.new("UIGradient")
TopGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 55, 95)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 31, 48)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 31, 48))
})
TopGradient.Rotation = 0
TopGradient.Parent = TopBar

local TopLine = Instance.new("Frame")
TopLine.Name = "TopLine"
TopLine.Size = UDim2.new(1, 0, 0, 2)
TopLine.Position = UDim2.new(0, 0, 1, -2)
TopLine.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
TopLine.BackgroundTransparency = 0
TopLine.BorderSizePixel = 0
TopLine.ZIndex = 22
TopLine.Parent = TopBar

local TopLineGradient = Instance.new("UIGradient")
TopLineGradient.Color = BorderColors
TopLineGradient.Rotation = 0
TopLineGradient.Parent = TopLine

task.spawn(function()
    while ScreenGui.Parent do
        local Tween = Services.TweenService:Create(
            TopLineGradient,
            TweenInfo.new(
                1.2,
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.InOut
            ),
            {
                Rotation = TopLineGradient.Rotation + 360
            }
        )

        Tween:Play()
        Tween.Completed:Wait()
    end
end)

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -36, 0, 27)
Title.Position = UDim2.new(0, 18, 0, 7)
Title.BackgroundTransparency = 1
Title.Text = Settings.Name
Title.TextColor3 = Theme.Text
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.ZIndex = 21
Title.Parent = TopBar

local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Size = UDim2.new(1, -36, 0, 18)
Subtitle.Position = UDim2.new(0, 18, 0, 32)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = Settings.Version
Subtitle.TextColor3 = Theme.SubText
Subtitle.TextSize = 10
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Font = Enum.Font.GothamMedium
Subtitle.ZIndex = 21
Subtitle.Parent = TopBar

--------------------------------------------------
-- SIDEBAR
--------------------------------------------------

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(
    0,
    Settings.UI.SidebarWidth,
    1,
    -58
)

Sidebar.Position = UDim2.new(
    0,
    0,
    0,
    58
)

Sidebar.BackgroundColor3 = Theme.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 5
Sidebar.Parent = Main

local SidebarLine = Instance.new("Frame")
SidebarLine.Name = "SidebarLine"
SidebarLine.Size = UDim2.new(0, 2, 1, 0)
SidebarLine.Position = UDim2.new(1, -2, 0, 0)
SidebarLine.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
SidebarLine.BackgroundTransparency = 0
SidebarLine.BorderSizePixel = 0
SidebarLine.ZIndex = 6
SidebarLine.Parent = Sidebar

local SidebarLineGradient = Instance.new("UIGradient")
SidebarLineGradient.Color = BorderColors
SidebarLineGradient.Rotation = 90
SidebarLineGradient.Parent = SidebarLine

task.spawn(function()
    while ScreenGui.Parent do
        local Tween = Services.TweenService:Create(
            SidebarLineGradient,
            TweenInfo.new(
                1.2,
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.InOut
            ),
            {
                Rotation = SidebarLineGradient.Rotation + 360
            }
        )

        Tween:Play()
        Tween.Completed:Wait()
    end
end)

local TabScroll = Instance.new("ScrollingFrame")
TabScroll.Name = "TabScroll"
TabScroll.Size = UDim2.new(1, 0, 1, 0)
TabScroll.BackgroundTransparency = 1
TabScroll.BorderSizePixel = 0
TabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
TabScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
TabScroll.ScrollingDirection = Enum.ScrollingDirection.Y
TabScroll.ScrollBarThickness = 0
TabScroll.ScrollBarImageTransparency = 1
TabScroll.Active = true
TabScroll.ZIndex = 6
TabScroll.Parent = Sidebar

local TabPadding = Instance.new("UIPadding")
TabPadding.PaddingTop = UDim.new(0, 6)
TabPadding.PaddingBottom = UDim.new(0, 6)
TabPadding.PaddingLeft = UDim.new(0, 2)
TabPadding.PaddingRight = UDim.new(0, 2)
TabPadding.Parent = TabScroll

local TabList = Instance.new("UIListLayout")
TabList.Padding = UDim.new(0, 2)
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Parent = TabScroll

--------------------------------------------------
-- CONTENT
--------------------------------------------------

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(
    1,
    -Settings.UI.SidebarWidth,
    1,
    -58
)

Content.Position = UDim2.new(
    0,
    Settings.UI.SidebarWidth,
    0,
    58
)

Content.BackgroundColor3 = Theme.Background
Content.BorderSizePixel = 0
Content.ZIndex = 5
Content.Parent = Main

_G.YOKUDO_Main = Main
_G.YOKUDO_TopBar = TopBar
_G.YOKUDO_Sidebar = Sidebar
_G.YOKUDO_TabScroll = TabScroll
_G.YOKUDO_Content = Content
_G.YOKUDO_ScreenGui = ScreenGui
_G.YOKUDO_Toggle = Toggle
_G.YOKUDO_GuiParent = GuiParent

--------------------------------------------------
-- DRAG
--------------------------------------------------

local Dragging = false
local DragStart = nil
local StartPosition = nil
local ActiveTouch = nil

local function StartDrag(Input)
    if Dragging then
        return
    end

    if Input.UserInputType == Enum.UserInputType.Touch then
        ActiveTouch = Input
    end

    Dragging = true
    DragStart = Input.Position
    StartPosition = Main.Position
end

local function StopDrag()
    Dragging = false
    ActiveTouch = nil
    DragStart = nil
    StartPosition = nil
end

TopBar.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        StartDrag(Input)
    end
end)

Services.UserInputService.InputChanged:Connect(function(Input)
    if not Dragging then
        return
    end

    if Input.UserInputType == Enum.UserInputType.Touch then
        if ActiveTouch and Input ~= ActiveTouch then
            return
        end
    end

    if not DragStart or not StartPosition then
        return
    end

    if Input.UserInputType ~= Enum.UserInputType.MouseMovement
        and Input.UserInputType ~= Enum.UserInputType.Touch then

        return
    end

    local Delta = Input.Position - DragStart

    Main.Position = UDim2.new(
        StartPosition.X.Scale,
        StartPosition.X.Offset + Delta.X,
        StartPosition.Y.Scale,
        StartPosition.Y.Offset + Delta.Y
    )
end)

Services.UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.Touch then
        if ActiveTouch and Input == ActiveTouch then
            StopDrag()
        end

        return
    end

    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
        if Dragging then
            StopDrag()
        end
    end
end)

--------------------------------------------------
-- TOGGLE DRAG
--------------------------------------------------

local ToggleDragging = false
local ToggleDragStart = nil
local ToggleStartPos = nil
local ToggleActiveTouch = nil

local function StartToggleDrag(Input)
    if ToggleDragging then
        return
    end

    if Input.UserInputType == Enum.UserInputType.Touch then
        ToggleActiveTouch = Input
    end

    ToggleDragging = true
    ToggleDragStart = Input.Position
    ToggleStartPos = Toggle.Position
end

local function StopToggleDrag()
    ToggleDragging = false
    ToggleActiveTouch = nil
    ToggleDragStart = nil
    ToggleStartPos = nil
end

Toggle.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        StartToggleDrag(Input)
    end
end)

Services.UserInputService.InputChanged:Connect(function(Input)
    if not ToggleDragging then
        return
    end

    if Input.UserInputType == Enum.UserInputType.Touch then
        if ToggleActiveTouch and Input ~= ToggleActiveTouch then
            return
        end
    end

    if not ToggleDragStart or not ToggleStartPos then
        return
    end

    if Input.UserInputType ~= Enum.UserInputType.MouseMovement
        and Input.UserInputType ~= Enum.UserInputType.Touch then

        return
    end

    local Delta = Input.Position - ToggleDragStart

    Toggle.Position = UDim2.new(
        ToggleStartPos.X.Scale,
        ToggleStartPos.X.Offset + Delta.X,
        ToggleStartPos.Y.Scale,
        ToggleStartPos.Y.Offset + Delta.Y
    )
end)

Services.UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.Touch then
        if ToggleActiveTouch and Input == ToggleActiveTouch then
            StopToggleDrag()
        end

        return
    end

    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
        if ToggleDragging then
            StopToggleDrag()
        end
    end
end)

--------------------------------------------------
-- TOGGLE
--------------------------------------------------

local isUIVisible = true

Toggle.MouseButton1Click:Connect(function()
    isUIVisible = not isUIVisible
    ScreenGui.Enabled = isUIVisible

    Services.TweenService:Create(
        Toggle,
        TweenInfo.new(
            0.1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        ),
        {
            Size = UDim2.new(0, 45, 0, 45)
        }
    ):Play()

    task.wait(0.1)

    Services.TweenService:Create(
        Toggle,
        TweenInfo.new(
            0.1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        ),
        {
            Size = UDim2.new(0, 55, 0, 55)
        }
    ):Play()
end)
