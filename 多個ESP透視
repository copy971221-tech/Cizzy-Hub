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
