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
