local parts = game.Workspace.LavaLevel3.Plates:GetChildren()
local lavaPlateModel = game.ReplicatedStorage:WaitForChild("LavaPlate")
local ServerStorage = game:GetService("ServerStorage")
local Utils = require(ServerStorage.Utils)
local numRows = 6
local numCols = 3
local rowIndex = 1
local speed = 1
local plates = Utils.partsAsRows(parts, numRows, numCols)
local previousLavaPlates = {}

local function removeLavaPlates()
	for originalPlate, lavaPlate in pairs(previousLavaPlates) do
		local originalPosition = lavaPlate.Position
		originalPlate.Parent = game.Workspace
		originalPlate.Position = originalPosition
		lavaPlate:Destroy()
	end
	previousLavaPlates = {}
end

local function changeToLavaPlates(row)
	removeLavaPlates()

	local randomIndex = math.random(1, #row)

	for i, plate in ipairs(row) do
		if i ~= randomIndex then
			local lavaPlate = lavaPlateModel:Clone()
			local position = plate.Position

			lavaPlate.Parent = game.Workspace
			lavaPlate.Position = position
			plate.Parent = nil
			previousLavaPlates[plate] = lavaPlate
		end
	end
end

while true do
	if rowIndex <= #plates then
		changeToLavaPlates(plates[rowIndex])
		rowIndex = rowIndex + 1
	else
		rowIndex = 1
	end
	wait(speed)
end