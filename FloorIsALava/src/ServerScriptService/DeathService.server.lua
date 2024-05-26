local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local Leaderboard = require(ServerStorage.Leaderboard)
local PlayerData = require(ServerStorage.PlayerData)
local DEATH_KEY_VALUE = PlayerData.DEATH_KEY_VALUE
local DEATH_AMOUNT_TO_ADD = 1

local function updatePlayerDeaths(player, updateFunction)
	local newDeathAmount = PlayerData.updateValue(player, DEATH_KEY_VALUE, updateFunction)
	
	Leaderboard.setStat(player, DEATH_KEY_VALUE, newDeathAmount)
end

local function onPlayerDied(player)
	updatePlayerDeaths(player, function(oldDeathAmount)
		oldDeathAmount = oldDeathAmount or 0
		return oldDeathAmount + DEATH_AMOUNT_TO_ADD
	end)
end

game:GetService("Players").PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid")
		humanoid.Died:Connect(function()
			onPlayerDied(player)
		end)
	end)
end)