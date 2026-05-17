local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

-- الملاحظة
local Notice = Instance.new("TextLabel")
Notice.Parent = ScreenGui
Notice.Size = UDim2.new(0,500,0,50)
Notice.Position = UDim2.new(0.5,-250,0,120)
Notice.BackgroundTransparency = 1
Notice.Text = "ملاحظة : لازم تدوس 10 مرات وانت داخل القيم على الكشف حتى يبين القاتل والشريف"
Notice.TextColor3 = Color3.fromRGB(0,255,0)
Notice.TextScaled = true
Notice.Font = Enum.Font.GothamBold

task.delay(15,function()
	Notice:Destroy()
end)

-- متغير اظهار الازرار
local Open = false

-- الزر الرئيسي
local MainButton = Instance.new("TextButton")
MainButton.Parent = ScreenGui
MainButton.Size = UDim2.new(0,140,0,40)

-- فوك بالنص
MainButton.Position = UDim2.new(0.5,-70,0,20)

MainButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
MainButton.Text = "script MM2"
MainButton.TextColor3 = Color3.fromRGB(255,0,0)
MainButton.TextScaled = true
MainButton.Font = Enum.Font.GothamBold
MainButton.BorderSizePixel = 0

-- سحب الزر
local dragging = false
local dragInput
local dragStart
local startPos

MainButton.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainButton.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

MainButton.InputChanged:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)

	if input == dragInput and dragging then

		local delta = input.Position - dragStart

		MainButton.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

local Corner1 = Instance.new("UICorner")
Corner1.Parent = MainButton
Corner1.CornerRadius = UDim.new(0,12)

-- زر كشف اللاعبين
local ESPButton = Instance.new("TextButton")
ESPButton.Parent = ScreenGui
ESPButton.Size = UDim2.new(0,180,0,45)
ESPButton.Position = UDim2.new(0.5,-90,0,70)
ESPButton.BackgroundColor3 = Color3.fromRGB(20,20,20)
ESPButton.Text = "كشف اللاعبين"
ESPButton.TextColor3 = Color3.fromRGB(255,255,255)
ESPButton.TextScaled = true
ESPButton.Font = Enum.Font.GothamBold
ESPButton.Visible = false
ESPButton.BorderSizePixel = 0

local Corner2 = Instance.new("UICorner")
Corner2.Parent = ESPButton
Corner2.CornerRadius = UDim.new(0,15)

-- زر الطيران
local FlyButton = Instance.new("TextButton")
FlyButton.Parent = ScreenGui
FlyButton.Size = UDim2.new(0,180,0,45)
FlyButton.Position = UDim2.new(0.5,-90,0,125)
FlyButton.BackgroundColor3 = Color3.fromRGB(20,20,20)
FlyButton.Text = "طيران"
FlyButton.TextColor3 = Color3.fromRGB(255,255,255)
FlyButton.TextScaled = true
FlyButton.Font = Enum.Font.GothamBold
FlyButton.Visible = false
FlyButton.BorderSizePixel = 0

local Corner3 = Instance.new("UICorner")
Corner3.Parent = FlyButton
Corner3.CornerRadius = UDim.new(0,15)

-- زر السرعة
local SpeedButton = Instance.new("TextButton")
SpeedButton.Parent = ScreenGui
SpeedButton.Size = UDim2.new(0,180,0,45)
SpeedButton.Position = UDim2.new(0.5,-90,0,180)
SpeedButton.BackgroundColor3 = Color3.fromRGB(20,20,20)
SpeedButton.Text = "سرعة"
SpeedButton.TextColor3 = Color3.fromRGB(255,255,255)
SpeedButton.TextScaled = true
SpeedButton.Font = Enum.Font.GothamBold
SpeedButton.Visible = false
SpeedButton.BorderSizePixel = 0

local Corner4 = Instance.new("UICorner")
Corner4.Parent = SpeedButton
Corner4.CornerRadius = UDim.new(0,15)

-- اظهار واخفاء الازرار
MainButton.MouseButton1Click:Connect(function()

	Open = not Open

	ESPButton.Visible = Open
	FlyButton.Visible = Open
	SpeedButton.Visible = Open

end)
