--==================================================
-- YOKUDO HUB | TAB | Info
--==================================================

local TabsManager = _G.YOKUDO_TabsManager
local TweenService = game:GetService("TweenService")

local InfoTab, InfoPage = TabsManager:RegisterTab("Info", 1, "INFO")

--==================================================
-- INFO CONTENT
--==================================================
CreateSectionTitle(InfoPage, "YZZ HUB | Steal An Egg", 1)

--==================================================
-- TITLE: Join Group For Notification Update Script
--==================================================
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 26)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Join Discord Server For Update Script"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 13
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.LayoutOrder = 2
TitleLabel.Parent = InfoPage

--==================================================
-- GROUP DISCORD
--==================================================
local GroupLabel = Instance.new("TextLabel")
GroupLabel.Size = UDim2.new(1, 0, 0, 24)
GroupLabel.BackgroundTransparency = 1
GroupLabel.Text = "Discord Server"
GroupLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
GroupLabel.TextSize = 13
GroupLabel.TextXAlignment = Enum.TextXAlignment.Left
GroupLabel.Font = Enum.Font.GothamMedium
GroupLabel.LayoutOrder = 3
GroupLabel.Parent = InfoPage

--==================================================
-- LINK (Clickable Copy)
--==================================================
local LinkBtn = Instance.new("TextButton")
LinkBtn.Size = UDim2.new(1, 0, 0, 30)
LinkBtn.BackgroundColor3 = Color3.fromRGB(28, 29, 42)
LinkBtn.BorderSizePixel = 0
LinkBtn.Text = "Link: https://discord.gg/eER5yhJ4q8"
LinkBtn.TextColor3 = Color3.fromRGB(120, 180, 255)
LinkBtn.TextSize = 12
LinkBtn.TextXAlignment = Enum.TextXAlignment.Left
LinkBtn.Font = Enum.Font.GothamMedium
LinkBtn.AutoButtonColor = false
LinkBtn.LayoutOrder = 4
LinkBtn.Parent = InfoPage

local LinkCorner = Instance.new("UICorner")
LinkCorner.CornerRadius = UDim.new(0, 6)
LinkCorner.Parent = LinkBtn

local LinkStroke = Instance.new("UIStroke")
LinkStroke.Color = Color3.fromRGB(105, 90, 190)
LinkStroke.Thickness = 1
LinkStroke.Transparency = 0.4
LinkStroke.Parent = LinkBtn

local LinkPadding = Instance.new("UIPadding")
LinkPadding.PaddingLeft = UDim.new(0, 10)
LinkPadding.PaddingRight = UDim.new(0, 10)
LinkPadding.Parent = LinkBtn

--==================================================
-- COPY BUTTON
--==================================================
local CopyBtn = Instance.new("TextButton")
CopyBtn.Size = UDim2.new(0, 120, 0, 32)
CopyBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
CopyBtn.BorderSizePixel = 0
CopyBtn.Text = "Copy Link"
CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyBtn.TextSize = 12
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.AutoButtonColor = false
CopyBtn.LayoutOrder = 5
CopyBtn.Parent = InfoPage

local CopyCorner = Instance.new("UICorner")
CopyCorner.CornerRadius = UDim.new(0, 6)
CopyCorner.Parent = CopyBtn

local CopyStroke = Instance.new("UIStroke")
CopyStroke.Color = Color3.fromRGB(120, 130, 255)
CopyStroke.Thickness = 1.5
CopyStroke.Transparency = 0.3
CopyStroke.Parent = CopyBtn

-- ==================================================
-- COPY FUNCTION
-- ==================================================
local DISCORD_LINK = "https://discord.gg/eER5yhJ4q8"

local function CopyDiscord()
    local Success = pcall(function()
        setclipboard(DISCORD_LINK)
    end)

    if Success then
        CopyBtn.Text = "Copied!"
        CopyBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 60)

        task.delay(1.5, function()
            CopyBtn.Text = "Copy Link"
            CopyBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
        end)
    else
        CopyBtn.Text = "Failed!"
        CopyBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)

        task.delay(1.5, function()
            CopyBtn.Text = "Copu Link"
            CopyBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
        end)
    end
end

-- ==================================================
-- BUTTON EVENTS
-- ==================================================
CopyBtn.MouseButton1Click:Connect(CopyDiscord)
LinkBtn.MouseButton1Click:Connect(CopyDiscord)

CopyBtn.MouseEnter:Connect(function()
    if CopyBtn.Text == "Copy Link" then
        TweenService:Create(CopyBtn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(108, 121, 255)
        }):Play()
    end
end)

CopyBtn.MouseLeave:Connect(function()
    if CopyBtn.Text == "Copy Link" then
        TweenService:Create(CopyBtn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(88, 101, 242)
        }):Play()
    end
end)

LinkBtn.MouseEnter:Connect(function()
    TweenService:Create(LinkBtn, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(38, 39, 55)
    }):Play()
end)

LinkBtn.MouseLeave:Connect(function()
    TweenService:Create(LinkBtn, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(28, 29, 42)
    }):Play()
end)
