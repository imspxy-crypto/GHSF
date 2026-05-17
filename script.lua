local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

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

-- كشف اللاعبين
ESPButton.MouseButton1Click:Connect(function()

	for _,v in pairs(Players:GetPlayers()) do
		if v ~= LocalPlayer and v.Character then

			local Highlight = Instance.new("Highlight")
			Highlight.Parent = v.Character

			if v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
				Highlight.FillColor = Color3.fromRGB(255,0,0)

			elseif v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
				Highlight.FillColor = Color3.fromRGB(0,0,255)

			else
				Highlight.FillColor = Color3.fromRGB(0,255,0)
			end

			Highlight.OutlineColor = Color3.fromRGB(255,255,255)
		end
	end
end)

-- الطيران
local Flying = false

FlyButton.MouseButton1Click:Connect(function()

	Flying = not Flying

	local Character = LocalPlayer.Character

	if Character and Character:FindFirstChild("HumanoidRootPart") then

		local HRP = Character.HumanoidRootPart

		if Flying then

			local BV = Instance.new("BodyVelocity")
			BV.Name = "FlyForce"
			BV.MaxForce = Vector3.new(999999,999999,999999)
			BV.Velocity = Vector3.new(0,0,0)
			BV.Parent = HRP

			RunService.RenderStepped:Connect(function()

				if Flying and HRP:FindFirstChild("FlyForce") then
					HRP.FlyForce.Velocity = workspace.CurrentCamera.CFrame.LookVector * 60
				end

			end)

		else

			if HRP:FindFirstChild("FlyForce") then
				HRP.FlyForce:Destroy()
			end

		end
	end
end)

-- السرعة
SpeedButton.MouseButton1Click:Connect(function()

	local Character = LocalPlayer.Character

	if Character and Character:FindFirstChild("Humanoid") then
		Character.Humanoid.WalkSpeed = 50
	end

end)

-- اظهار واخفاء الازرار
MainButton.MouseButton1Click:Connect(function()

	Open = not Open

	ESPButton.Visible = Open
	FlyButton.Visible = Open
	SpeedButton.Visible = Open
	InfiniteJumpButton.Visible = Open
	NoclipButton.Visible = Open

end)

-- Infinite Jump
local InfiniteJumpEnabled = false

InfiniteJumpButton.MouseButton1Click:Connect(function()

	InfiniteJumpEnabled = not InfiniteJumpEnabled

	if InfiniteJumpEnabled then
		InfiniteJumpButton.Text = "Infinite Jump ON"
	else
		InfiniteJumpButton.Text = "Infinite Jump OFF"
	end

end)

UserInputService.JumpRequest:Connect(function()

	if InfiniteJumpEnabled then

		local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
end)

-- Noclip
local NoclipEnabled = false

NoclipButton.MouseButton1Click:Connect(function()

	NoclipEnabled = not NoclipEnabled

	if NoclipEnabled then
		NoclipButton.Text = "Noclip ON"
	else
		NoclipButton.Text = "Noclip OFF"
	end

end)

RunService.Stepped:Connect(function()

	if NoclipEnabled and LocalPlayer.Character then

		for _,v in pairs(LocalPlayer.Character:GetDescendants()) do

			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)
