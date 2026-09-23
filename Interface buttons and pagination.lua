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
