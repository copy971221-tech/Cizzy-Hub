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
