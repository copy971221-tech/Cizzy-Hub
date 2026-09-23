repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local ConfigFile = "Cizzy_FPS_Config.json"
local DefaultConfig = {
    Aimbot = false, ESP = false, SpeedHack = false, TeamCheck = false,
    ShowName = false, ShowIcon = false, Antenna = false, ShowDistance = true, ShowHealth = true,
    ClickTeleport = false, AimbotFOV = 150, Smoothing = 15, WalkSpeed = 22
}
_G.Config = table.clone(DefaultConfig)
shared.CizzySave = function()
    pcall(function() if writefile then writefile(ConfigFile, HttpService:JSONEncode(_G.Config)) end end)
end
local function Load()
    pcall(function()
        if isfile and isfile(ConfigFile) then
            local data = HttpService:JSONDecode(readfile(ConfigFile))
            for k, v in pairs(data) do _G.Config[k] = v end
        end
    end)
end
Load()

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Cizzy_FPS_Script"
ScreenGui.DisplayOrder = 100
shared.CizzyScreenGui = ScreenGui
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 520, 0, 340)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -170)
MainFrame.BackgroundColor3, MainFrame.BackgroundTransparency = Color3.fromRGB(15, 15, 15), 0.2
MainFrame.Visible, MainFrame.Active = false, true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
shared.MainFrameObj = MainFrame
shared.MainStrokeObj = Instance.new("UIStroke", MainFrame)

local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size, TopBar.BackgroundTransparency = UDim2.new(1, 0, 0, 45), 1
local BrandIcon = Instance.new("ImageLabel", TopBar)
BrandIcon.Size, BrandIcon.Position = UDim2.new(0, 28, 0, 28), UDim2.new(0, 12, 0, 10)
BrandIcon.Image = "rbxthumb://type=Asset&id=94631713993007&w=420&h=420"
Instance.new("UICorner", BrandIcon).CornerRadius = UDim.new(0, 6)
shared.BrandIconImg = BrandIcon.Image
local BrandTitle = Instance.new("TextLabel", TopBar)
BrandTitle.Size, BrandTitle.Position = UDim2.new(1, -50, 1, 0), UDim2.new(0, 48, 0, 0)
BrandTitle.Text = "Cizzy V2.0 FPS script"
BrandTitle.TextColor3, BrandTitle.Font, BrandTitle.TextSize = Color3.new(1, 1, 1), Enum.Font.GothamBold, 16
BrandTitle.BackgroundTransparency, BrandTitle.TextXAlignment = 1, Enum.TextXAlignment.Left

local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size, Sidebar.Position = UDim2.new(0, 140, 1, -50), UDim2.new(0, 5, 0, 45)
Sidebar.BackgroundColor3, Sidebar.BackgroundTransparency = Color3.fromRGB(10, 10, 10), 0.4
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)
local SidebarLayout = Instance.new("UIListLayout", Sidebar)
SidebarLayout.Padding, SidebarLayout.HorizontalAlignment = UDim.new(0, 6), Enum.HorizontalAlignment.Center
local Container = Instance.new("Frame", MainFrame)
Container.Size, Container.Position = UDim2.new(1, -160, 1, -60), UDim2.new(0, 150, 0, 50)
Container.BackgroundTransparency = 1
local Pages = {}
shared.CreatePage = function(name, emoji)
    local Page = Instance.new("ScrollingFrame", Container)
    Page.Size, Page.BackgroundTransparency, Page.Visible, Page.ScrollBarThickness = UDim2.new(1, 0, 1, 0), 1, false, 0
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 12)
    local TabBtn = Instance.new("TextButton", Sidebar)
    TabBtn.Size, TabBtn.Text = UDim2.new(0.9, 0, 0, 36), emoji.." "..name
    TabBtn.BackgroundColor3, TabBtn.TextColor3, TabBtn.Font = Color3.fromRGB(25, 25, 25), Color3.new(0.6, 0.6, 0.6), Enum.Font.GothamBold
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)
    TabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Page.Visible, TabBtn.TextColor3 = true, Color3.new(1, 1, 1)
        for _, b in pairs(Sidebar:GetChildren()) do if b:IsA("TextButton") and b ~= TabBtn then b.TextColor3 = Color3.new(0.6,0.6,0.6) end end
    end)
    Pages[name] = Page return Page
end
local PagePlayer = shared.CreatePage("玩家資訊", "🤡")
local PageSpeed = shared.CreatePage("加速功能", "⚠️")
local PageAim = shared.CreatePage("自瞄設定", "🎯")
local PageESP = shared.CreatePage("透視設定", "👀")
local PageSet = shared.CreatePage("存檔重置", "🛠")
PagePlayer.Visible = true
local function CreateFolder(title, parent)
    local FolderFrame = Instance.new("Frame", parent)
    FolderFrame.Size, FolderFrame.BackgroundTransparency = UDim2.new(0.95, 0, 0, 35), 1
    local Layout = Instance.new("UIListLayout", FolderFrame)
    Layout.Padding, Layout.HorizontalAlignment = UDim.new(0, 6), Enum.HorizontalAlignment.Center
    FolderFrame.AutomaticSize = Enum.AutomaticSize.Y
    local ToggleBtn = Instance.new("TextButton", FolderFrame)
    ToggleBtn.Size, ToggleBtn.BackgroundColor3, ToggleBtn.Text = UDim2.new(1, 0, 0, 35), Color3.fromRGB(40, 40, 40), "📁 " .. title .. " 【點擊展開】"
    ToggleBtn.TextColor3, ToggleBtn.Font, ToggleBtn.TextSize = Color3.new(1,1,1), Enum.Font.GothamBold, 12
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)
    local ContentFrame = Instance.new("Frame", FolderFrame)
    ContentFrame.Size, ContentFrame.BackgroundTransparency, ContentFrame.Visible = UDim2.new(1, 0, 0, 0), 1, false
    ContentFrame.AutomaticSize = Enum.AutomaticSize.Y
    local CLayout = Instance.new("UIListLayout", ContentFrame)
    CLayout.Padding, CLayout.HorizontalAlignment = UDim.new(0, 6), Enum.HorizontalAlignment.Center
    ToggleBtn.MouseButton1Click:Connect(function()
        ContentFrame.Visible = not ContentFrame.Visible
        ToggleBtn.Text = ContentFrame.Visible and "📂 " .. title .. " 【點擊收起】" or "📁 " .. title .. " 【點擊展開】"
    end)
    return ContentFrame
end
local function AddInfoBox(parent, text, height, iconId)
    local Box = Instance.new("Frame", parent)
    Box.Size, Box.BackgroundColor3, Box.BackgroundTransparency = UDim2.new(0.95, 0, 0, height or 45), Color3.fromRGB(30,30,30), 0.2
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 10)
    if iconId then
        local img = Instance.new("ImageLabel", Box)
        img.Size, img.Position = UDim2.new(0, 32, 0, 32), UDim2.new(0, 10, 0.5, -16)
        img.Image, img.BackgroundTransparency = iconId, 1
        Instance.new("UICorner", img).CornerRadius = UDim.new(1, 0)
    end
    local txt = Instance.new("TextLabel", Box)
    txt.Size, txt.Position = UDim2.new(1, iconId and -55 or -20, 1, 0), UDim2.new(0, iconId and 48 or 10, 0, 0)
    txt.Text, txt.TextColor3, txt.Font, txt.TextSize = text, Color3.new(1,1,1), Enum.Font.GothamBold, 13
    txt.BackgroundTransparency, txt.TextXAlignment = 1, Enum.TextXAlignment.Left
    return txt
end
AddInfoBox(PagePlayer, "使用者： " .. LocalPlayer.DisplayName, 52, "rbxthumb://type=AvatarHeadShot&id="..LocalPlayer.UserId.."&w=150&h=150")
AddInfoBox(PagePlayer, "帳號： " .. LocalPlayer.Name, 45)
shared.PingLabel = AddInfoBox(PagePlayer, "延遲： 計算中...", 45)
local function CreateToggle(text, key, parent)
    local B = Instance.new("TextButton", parent)
    B.Size, B.BackgroundColor3, B.Text = UDim2.new(1, 0, 0, 40), Color3.fromRGB(30, 30, 30), "  "..text
    B.TextColor3, B.Font, B.TextXAlignment = Color3.new(1,1,1), Enum.Font.GothamBold, Enum.TextXAlignment.Left
    Instance.new("UICorner", B).CornerRadius = UDim.new(0, 8)
    local D = Instance.new("Frame", B)
    D.Size, D.Position = UDim2.new(0, 18, 0, 18), UDim2.new(1,-30,0.5,-9)
    Instance.new("UICorner", D).CornerRadius = UDim.new(0, 5)
    local function updateUI() D.BackgroundColor3 = _G.Config[key] and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(150, 0, 0) shared.CizzySave() end
    updateUI() B.MouseButton1Click:Connect(function() _G.Config[key] = not _G.Config[key]; updateUI() end)
end

local function CreateSlider(title, key, parent, min, max)
    local SFrame = Instance.new("Frame", parent)
    SFrame.Size, SFrame.BackgroundTransparency = UDim2.new(0.95, 0, 0, 50), 1
    local L = Instance.new("TextLabel", SFrame)
    L.Size, L.TextColor3, L.BackgroundTransparency, L.TextSize = UDim2.new(1,0,0,20), Color3.new(0.8,0.8,0.8), 1, 11
    local Bar = Instance.new("Frame", SFrame)
    Bar.Size, Bar.Position, Bar.BackgroundColor3 = UDim2.new(1,0,0,6), UDim2.new(0,0,0,32), Color3.fromRGB(45,45,45)
    Instance.new("UICorner", Bar)
    local Fill = Instance.new("Frame", Bar)
    Fill.BackgroundColor3 = Color3.fromRGB(100,100,255)
    Instance.new("UICorner", Fill)
    local function update(input)
        local move = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + (max-min)*move)
        _G.Config[key] = val Fill.Size = UDim2.new(move, 0, 1, 0) L.Text = title..": "..val shared.CizzySave()
    end
    Fill.Size = UDim2.new(((_G.Config[key] or min)-min)/(max-min), 0, 1, 0) L.Text = title..": "..(_G.Config[key] or min)
    Bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            update(input) local moveConn
            moveConn = UserInputService.InputChanged:Connect(function(moveInput) if moveInput.UserInputType == Enum.UserInputType.Touch or moveInput.UserInputType == Enum.UserInputType.MouseMovement then update(moveInput) end end)
            UserInputService.InputEnded:Connect(function(endInput) if endInput.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then if moveConn then moveConn:Disconnect() end end end)
        end
    end)
end
CreateToggle("加速開關", "SpeedHack", PageSpeed)
CreateSlider("行走速度", "WalkSpeed", PageSpeed, 16, 200)
CreateToggle("自瞄開關", "Aimbot", PageAim)
CreateSlider("自瞄範圍", "AimbotFOV", PageAim, 50, 500)
CreateSlider("平滑程度", "Smoothing", PageAim, 1, 100)

local FolderBaseESP = CreateFolder("透視基本設定", PageESP)
CreateToggle("開啟透視 (框框)", "ESP", FolderBaseESP)
CreateToggle("隊伍檢查", "TeamCheck", FolderBaseESP)
CreateToggle("顯示名字", "ShowName", FolderBaseESP)
CreateToggle("顯示頭像", "ShowIcon", FolderBaseESP)

local FolderAdvESP = CreateFolder("透視進階資訊", PageESP)
CreateToggle("顯示玩家血量", "ShowHealth", FolderAdvESP)
CreateToggle("顯示玩家距離", "ShowDistance", FolderAdvESP)
CreateToggle("開啟天線透視", "Antenna", FolderAdvESP)

local FolderTp = CreateFolder("傳送功能分類", PageESP)
CreateToggle("傳送玩家", "ClickTeleport", FolderTp)

local ResetBtn = Instance.new("TextButton", PageSet)
ResetBtn.Size, ResetBtn.Text = UDim2.new(0.95, 0, 0, 38), "🔄 重置設定"
ResetBtn.BackgroundColor3, ResetBtn.TextColor3, ResetBtn.Font = Color3.fromRGB(100, 30, 30), Color3.new(1,1,1), Enum.Font.GothamBold
Instance.new("UICorner", ResetBtn)
ResetBtn.MouseButton1Click:Connect(function() _G.Config = table.clone({Aimbot=false,ESP=false,SpeedHack=false,TeamCheck=false,ShowName=false,ShowIcon=false,Antenna=false,ShowDistance=true,ShowHealth=true,ClickTeleport=false,AimbotFOV=150,Smoothing=15,WalkSpeed=22}); shared.CizzySave(); warn("設定已重置") end)
local MainBtn = Instance.new("ImageButton", ScreenGui)
MainBtn.Size, MainBtn.Position = UDim2.new(0, 60, 0, 60), UDim2.new(0, 20, 0.4, 0)
MainBtn.BackgroundColor3, MainBtn.Image, MainBtn.ZIndex = Color3.fromRGB(30,30,30), shared.BrandIconImg, 10
Instance.new("UICorner", MainBtn).CornerRadius = UDim.new(0, 12)

local dragging, isMoving, dragStart, startPos, holdStart = false, false, nil, nil, 0
MainBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging, isMoving, holdStart, dragStart, startPos = true, false, tick(), input.Position, MainBtn.Position
        TweenService:Create(MainBtn, TweenInfo.new(0.1), {Size = UDim2.new(0, 52, 0, 52)}):Play()
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart if delta.Magnitude > 15 then isMoving = true end
        if isMoving then MainBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        if dragging then dragging = false TweenService:Create(MainBtn, TweenInfo.new(0.1), {Size = UDim2.new(0, 60, 0, 60)}):Play()
            if isMoving then
                local sX, sY = ScreenGui.AbsoluteSize.X, ScreenGui.AbsoluteSize.Y
                if sX == 0 then sX, sY = 800, 450 end
                local cur = MainBtn.Position local absX, absY = cur.X.Scale * sX + cur.X.Offset, cur.Y.Scale * sY + cur.Y.Offset
                local tY = math.clamp(absY, 50, sY - 110) local tX = (absX > (sX / 2)) and (sX - 70) or 10
                TweenService:Create(MainBtn, TweenInfo.new(0.3, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {Position = UDim2.new(0, tX, 0, tY)}):Play()
            else
                if tick() - holdStart >= 1.5 then MainBtn.Visible, MainFrame.Visible = false, false else MainFrame.Visible = not MainFrame.Visible end
            end
        end
    end
end)
shared.CizzyMainBtn = MainBtn

local RunService = game:GetService("RunService")
local ScreenGuiObj = shared.CizzyScreenGui

local function GetStatus(p)
    if not p.Character or not p.Character:FindFirstChild("Head") then return nil end
    local isEnemy = (not _G.Config.TeamCheck) or (p.Team ~= LocalPlayer.Team)
    local ray = RaycastParams.new() ray.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    local result = workspace:Raycast(Camera.CFrame.Position, (p.Character.Head.Position - Camera.CFrame.Position).Unit * 1000, ray)
    return {Head = p.Character.Head, Enemy = isEnemy, Visible = (not result) or (result.Instance:IsDescendantOf(p.Character))}
end

local function ApplyESP(p)
    local h = Instance.new("Highlight", CoreGui) h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    local NameTag = Instance.new("BillboardGui", CoreGui) NameTag.Size, NameTag.AlwaysOnTop, NameTag.ExtentsOffset = UDim2.new(0, 200, 0, 80), true, Vector3.new(0, 2.8, 0)
    local Icon = Instance.new("ImageLabel", NameTag) Icon.Size, Icon.Image, Icon.BackgroundTransparency = UDim2.new(0, 25, 0, 25), "rbxthumb://type=AvatarHeadShot&id="..p.UserId.."&w=150&h=150", 1
    local NameLabel = Instance.new("TextLabel", NameTag) NameLabel.Size, NameLabel.Position = UDim2.new(0, 160, 0, 18), UDim2.new(0, 30, 0, 0)
    NameLabel.BackgroundTransparency, NameLabel.Font, NameLabel.TextSize = 1, Enum.Font.GothamBold, 12
    local HealthLabel = Instance.new("TextLabel", NameTag) HealthLabel.Size, HealthLabel.Position = UDim2.new(0, 160, 0, 16), UDim2.new(0, 30, 0, 18)
    HealthLabel.BackgroundTransparency, HealthLabel.Font, HealthLabel.TextSize = 1, Enum.Font.GothamBold, 11
    
    local TouchTrigger = Instance.new("TextButton", NameTag)
    TouchTrigger.Size = UDim2.new(1, 0, 1, 0)
    TouchTrigger.Position = UDim2.new(0, 0, 0, 0)
    TouchTrigger.BackgroundTransparency = 1
    TouchTrigger.Text = ""
    TouchTrigger.ZIndex = 5

    local Antenna = Instance.new("CylinderHandleAdornment", CoreGui)
    Antenna.AlwaysOnTop, Antenna.Height, Antenna.Radius, Antenna.Transparency, Antenna.ZIndex = true, 40, 0.15, 0.35, 10
    Antenna.CFrame = CFrame.new()

    TouchTrigger.MouseButton1Click:Connect(function()
        if _G.Config.ClickTeleport and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
        end
    end)

    RunService.RenderStepped:Connect(function()
        local d = GetStatus(p)
        local hum = p.Character and p.Character:FindFirstChildOfClass("Humanoid")
        if shared.CizzyMainBtn.Visible and d then
            h.Enabled, h.Adornee = _G.Config.ESP, p.Character NameTag.Adornee = p.Character.Head 
            NameLabel.Visible, Icon.Visible, TouchTrigger.Visible = _G.Config.ShowName, _G.Config.ShowIcon, _G.Config.ShowName
            local color = Color3.fromRGB(255, 0, 0) if not d.Enemy then color = Color3.fromRGB(0, 150, 255) elseif d.Visible then color = Color3.fromRGB(0, 255, 0) end
            h.FillColor, NameLabel.TextColor3 = color, color
            local distText = ""
            if _G.Config.ShowDistance and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude)
                distText = " " .. dist .. "m"
            end
            NameLabel.Text = p.Name .. distText
            if _G.Config.ShowHealth and hum then
                HealthLabel.Visible = _G.Config.ShowName
                local currentHp = math.clamp(math.floor(hum.Health), 0, 99999)
                local maxHp = hum.MaxHealth > 0 and hum.MaxHealth or 100
                HealthLabel.Text = tostring(currentHp)
                local hpRatio = currentHp / maxHp
                HealthLabel.TextColor3 = Color3.fromHSV(math.clamp(hpRatio * 0.33, 0, 0.33), 0.9, 1) 
            else HealthLabel.Visible = false end
            if _G.Config.Antenna and p.Character and p.Character:FindFirstChild("Head") then
                Antenna.Enabled, Antenna.Adornee, Antenna.Color3 = true, p.Character.Head, color
                Antenna.CFrame = CFrame.new(0, Antenna.Height/2, 0) * CFrame.Angles(math.rad(90), 0, 0)
            else Antenna.Enabled = false end
        else h.Enabled, NameLabel.Visible, Icon.Visible, HealthLabel.Visible, TouchTrigger.Visible, Antenna.Enabled = false, false, false, false, false, false end
        if not p.Parent then h:Destroy(); NameTag:Destroy(); Antenna:Destroy() end
    end)
end

local FOVCircleUI = Instance.new("Frame", ScreenGuiObj)
FOVCircleUI.Size, FOVCircleUI.Position, FOVCircleUI.AnchorPoint = UDim2.new(0, 300, 0, 300), UDim2.new(0.5, 0, 0.5, 0), Vector2.new(0.5, 0.5)
FOVCircleUI.BackgroundTransparency, FOVCircleUI.Visible = 1, false Instance.new("UICorner", FOVCircleUI) local FOVStrokeUI = Instance.new("UIStroke", FOVCircleUI)

RunService.RenderStepped:Connect(function()
    local c = Color3.fromHSV(tick() % 5 / 5, 0.7, 1) if shared.MainStrokeObj then shared.MainStrokeObj.Color = c end FOVStrokeUI.Color = c
    if _G.Config.SpeedHack and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = _G.Config.WalkSpeed end
    if _G.Config.Aimbot then
        local t, min = nil, _G.Config.AimbotFOV
        for _, p in pairs(Players:GetPlayers()) do local d = GetStatus(p)
            if p ~= LocalPlayer and d and d.Enemy and d.Visible then
                local pos, onScreen = Camera:WorldToViewportPoint(d.Head.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if dist < min then min = dist; t = d.Head end
                end
            end
        end
        if t then Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, t.Position), _G.Config.Smoothing/100) end
    end
    FOVCircleUI.Visible = (_G.Config.Aimbot and shared.CizzyMainBtn.Visible) FOVCircleUI.Size = UDim2.new(0, _G.Config.AimbotFOV*2, 0, _G.Config.AimbotFOV*2)
    if shared.PingLabel and shared.PingLabel.Parent then shared.PingLabel.Text = "延遲： " .. math.floor(LocalPlayer:GetNetworkPing() * 1000) .. " ms" end
end)

for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then ApplyESP(p) end end Players.PlayerAdded:Connect(ApplyESP)
