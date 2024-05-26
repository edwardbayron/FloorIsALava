local PlayerData = {}
PlayerData.DEATH_KEY_VALUE = "Deaths"

local playerData = {}

local DEFAULT_PLAYER_DATA = {
	[PlayerData.DEATH_KEY_VALUE] = 0
}

local function getData(player)
	local data = playerData[tostring(player.UserId)] or DEFAULT_PLAYER_DATA
	playerData[tostring(player.UserId)] = data
	return data
end

function PlayerData.updateValue(player, key, updateFunction)
	local data = getData(player)
	local oldValue = data[key]
	local newValue = updateFunction(oldValue)
	
	data[key] = newValue
	return newValue
end

function PlayerData.clearData(player)
	PlayerData.updateValue(player, PlayerData.DEATH_KEY_VALUE, function(oldDeathAmount)
		oldDeathAmount = 0
	end)
end

return PlayerData
