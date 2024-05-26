local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local ServerStorage = game:GetService("ServerStorage")

local startButton = StarterGui.StartGameScreenGui.StartButton
local closeButton = StarterGui.StartGameScreenGui.CloseGameButton

local Leaderboard = require(ServerStorage.Leaderboard)
local PlayerData = require(ServerStorage.PlayerData)



game:GetService("Players").PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		local starterGuiEnabled = player.PlayerGui.StartGameScreenGui.Enabled
		local leaderstats = player:FindFirstChild("leaderstats")
		
		if leaderstats == nil then
			player.PlayerGui.StartGameScreenGui.Enabled = true
			humanoidRootPart.Anchored = true

			player.PlayerGui.StartGameScreenGui.StartButton.MouseButton1Click:Connect(function()
				player.PlayerGui.StartGameScreenGui.Enabled = false
				humanoidRootPart.Anchored = false
			end)

			player.PlayerGui.StartGameScreenGui.CloseGameButton.MouseButton1Click:Connect(function()
				player:Kick()
			end)
		end
		
		
		
	end)	
end)

