local plates = game.Workspace.LavaLevel2.Plates:GetChildren()
local lavaPlateModel = game.ReplicatedStorage:WaitForChild("LavaPlate")
local ServerStorage = game:GetService("ServerStorage")
local Utils = require(ServerStorage.Utils)

local currentLavaPlates = {}
local originalPlateClones = {}
local previousIndices = {}

local speed = 1
local partsAmount = 2

local function changePlateToLava()
	previousIndices = {}
	
	for i, lavaPlate in pairs(currentLavaPlates) do
		local originalPlateClone = originalPlateClones[lavaPlate]
		if originalPlateClone then
			originalPlateClone.Parent = game.Workspace
			originalPlateClone.Position = lavaPlate.Position
			lavaPlate:Destroy()
		
		end
	end
	
	currentLavaPlates = {}
	originalPlateClones = {}
	
	local uniqueIndices = Utils.getUniqueRandomIndices(plates, previousIndices, partsAmount)
	
	for _, randomIndex in pairs(uniqueIndices) do
		local randomPlate = plates[randomIndex]
		randomPlate:Destroy()
		local lavaPlate = lavaPlateModel:Clone()
		
		local position = randomPlate.Position
		local originalPlateClone = randomPlate:Clone()
		originalPlateClone.Parent = nil
		
		lavaPlate.Parent = game.Workspace
		lavaPlate.Position = position
		
		currentLavaPlates[randomIndex] = lavaPlate
		originalPlateClones[lavaPlate] = originalPlateClone
	end
end

while true do
	changePlateToLava()
	wait(speed)
end

