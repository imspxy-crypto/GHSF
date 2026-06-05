local player = game.Players.LocalPlayer
local savedPos = nil

local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local saveBtn = Instance.new("TextButton")
saveBtn.Parent = gui
saveBtn.Size = UDim2.new(0,120,0,50)
saveBtn.Position = UDim2.new(1,-140,1,-140)
saveBtn.Text = "حفظ"

local tpBtn = Instance.new("TextButton")
tpBtn.Parent = gui
tpBtn.Size = UDim2.new(0,120,0,50)
tpBtn.Position = UDim2.new(1,-140,1,-80)
tpBtn.Text = "نقل الحفظ"

saveBtn.MouseButton1Click:Connect(function()
	local char = player.Character
	if char and char:FindFirstChild("HumanoidRootPart") then
		savedPos = char.HumanoidRootPart.CFrame
	end
end)

tpBtn.MouseButton1Click:Connect(function()
	local char = player.Character
	if savedPos and char and char:FindFirstChild("HumanoidRootPart") then
		char.HumanoidRootPart.CFrame = savedPos
	end
end)
