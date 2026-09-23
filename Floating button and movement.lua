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
