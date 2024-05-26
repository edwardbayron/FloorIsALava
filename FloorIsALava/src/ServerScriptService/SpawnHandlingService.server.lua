local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local ServerStorage = game:GetService("ServerStorage")
local PlayerData = require(ServerStorage.PlayerData)

game:GetService("Players").PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		
		local humanoid = character:WaitForChild("Humanoid")
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		--humanoid.JumpPower = 100
		--humanoid.WalkSpeed = 100
	end)	
end)



