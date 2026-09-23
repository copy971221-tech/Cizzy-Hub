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
