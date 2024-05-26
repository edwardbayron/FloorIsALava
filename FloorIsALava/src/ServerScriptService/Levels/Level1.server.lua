local plates = game.Workspace.LavaLevel1.Plates:GetChildren()
local lavaPlateModel = game.ReplicatedStorage:WaitForChild("LavaPlate")
local ServerStorage = game:GetService("ServerStorage")
local Utils = require(ServerStorage.Utils)

local currentLavaPlate = nil
local originalPlateClone = nil
local previousIndex = nil

local function changePlateToLava()
	if currentLavaPlate then
		originalPlateClone.Parent = game.Workspace
		originalPlateClone.Position = currentLavaPlate.Position
		currentLavaPlate:Destroy()
		currentLavaPlate = nil
		originalPlateClone = nil
	end
	
	local randomIndex = Utils.getNewRandomIndex(plates, previousIndex)
	local randomPlate = plates[randomIndex]
	randomPlate:Destroy()
	local lavaPlate = lavaPlateModel:Clone()
	
	local position = randomPlate.Position
	originalPlateClone = randomPlate:Clone()
	originalPlateClone.Parent = nil
	
	lavaPlate.Parent = game.Workspace
	lavaPlate.Position = position
	
	currentLavaPlate = lavaPlate
	previousIndex = randomIndex
end

while true do
	changePlateToLava()
	wait(1.5)
end