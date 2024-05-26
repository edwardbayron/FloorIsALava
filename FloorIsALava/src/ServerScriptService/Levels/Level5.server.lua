local level4Platform = game.Workspace.LavaLevel4.Level4CheckpointPlate
local movingLavaBricks = game.Workspace.LavaLevel5.MovingLavaBricks:GetChildren()
local randomSpeedNumbers = {0.3, 0.5, 0.7, 0.9, 1.1, 1.3}
local keyset = {}
for i in pairs(randomSpeedNumbers) do
	table.insert(keyset, i)
end

local function movingPlateHandler(movingBrick, speed, initialPos, endPosition)
	local movingForward = true
	coroutine.wrap(function()
		while true do
			local currentPos = movingBrick.CFrame.Position

			if movingForward then
				if currentPos.X < endPosition.X then
					movingBrick.CFrame = movingBrick.CFrame * CFrame.new(speed, 0, 0)
				else
					movingForward = false
				end
			else
				if currentPos.X > initialPos.X then
					movingBrick.CFrame = movingBrick.CFrame * CFrame.new(-speed, 0, 0)
				else
					movingForward = true
				end
			end
			
			wait(0.01)
		end
	end)()
end

for i, brick in pairs(movingLavaBricks) do
	movingPlateHandler(
		brick, 
		randomSpeedNumbers[keyset[math.random(#keyset)]],
		brick.CFrame.Position, 
		brick.CFrame.Position + Vector3.new(level4Platform.Size.X - brick.Size.X, 0, 0))
end