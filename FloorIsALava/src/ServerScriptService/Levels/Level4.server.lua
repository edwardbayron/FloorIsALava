local plates = game.Workspace.LavaLevel4.MovingPlates:GetChildren()
local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")
local Utils = require(ServerStorage.Utils)
local movingPlate1 = game.Workspace.LavaLevel4.MovingPlates.MovingPlate1
local movingPlate2 = game.Workspace.LavaLevel4.MovingPlates.MovingPlate2
local checkpointPlate = game.Workspace.LavaLevel4.Level4CheckpointPlate
local movingPlatesSpeed = 0.2
local distance = checkpointPlate.Size.Z

for _, plate in pairs(plates) do
	Utils.platesMovementHandle(plate, distance, movingPlatesSpeed)
	Utils.holdPlayerOnMovingPlatform(plate, RunService)
end