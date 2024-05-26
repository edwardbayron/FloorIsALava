local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local ServerStorage = game:GetService("ServerStorage")
local restartButton = StarterGui.EndGameScreenGui.RestartButton
local closeButton = StarterGui.EndGameScreenGui.CloseGameButton
local finishPlate = Workspace.Finish.FinishModel.FinishSquare
local congratsFireworks = Workspace.Finish.CongratsModel:GetChildren()
local Leaderboard = require(ServerStorage.Leaderboard)
local PlayerData = require(ServerStorage.PlayerData)
local finishText = ""

game:GetService("Players").PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		player.PlayerGui.EndGameScreenGui.Enabled = false
		player.PlayerGui.EndGameScreenGui.RestartButton.MouseButton1Click:Connect(function()
			
			--game:GetService("TeleportService"):Teleport(game.PlaceId, player) - realized, that it can be used only on Production side, lol
			player.PlayerGui.EndGameScreenGui.TextLabel.Text = "Initializing..."
			player.Character:BreakJoints()
			wait(1.0)
			PlayerData.clearData(player)
			player:FindFirstChild("leaderstats"):Destroy()
		end)

		player.PlayerGui.EndGameScreenGui.CloseGameButton.MouseButton1Click:Connect(function()
			player:Kick()
			player.PlayerGui.EndGameScreenGui.TextLabel.Text = "Closing..."
		end)
		
	end)	
end)

local function hideFireWorks()
	for _, firework in pairs(congratsFireworks) do
		firework.Transparency = 1
		firework.CanCollide = false
	end
end

local function showFireWorks()
	for _, firework in pairs(congratsFireworks) do
		firework.Transparency = 0
		firework.CanCollide = false
	end
end


local function onFinishSquareTouched(otherPart, finishSquare)
	local character = otherPart.Parent
	local player = Players:GetPlayerFromCharacter(character)
	local finishText = ""
	
	if player then
		local leaderstats = player:FindFirstChild("leaderstats")
		if leaderstats then
			local deaths = leaderstats:FindFirstChild("Deaths")
			finishText = player.PlayerGui.EndGameScreenGui.TextLabel.Text .. deaths.Value
		end
		
	end
	
	local humanoid = character:WaitForChild("Humanoid")
	local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
	if player then
		showFireWorks()
		player.PlayerGui.EndGameScreenGui.Enabled = true
		humanoidRootPart.Anchored = true
	end
	player.PlayerGui.EndGameScreenGui.TextLabel.Text = finishText
end

hideFireWorks()

finishPlate.Touched:Connect(function(otherPart)
	onFinishSquareTouched(otherPart, finishPlate)
end)