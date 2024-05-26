local Utils = {}

function Utils.getNewRandomIndex(plates, previousIndex)
	local newIndex
	repeat
		newIndex = math.random(1, #plates)
	until newIndex ~= previousIndex
	return newIndex
end

function Utils.getUniqueRandomIndices(plates, previousIndices, partAmount)
	local indices = {}
	while #indices < partAmount do
		local randomIndex = math.random(1, #plates)
		if not indices[randomIndex] and not previousIndices[randomIndex] then
			indices[#indices + 1] = randomIndex
			previousIndices[randomIndex] = true
		end
	end
	return indices
end


function Utils.holdPlayerOnMovingPlatform(plate, RunService)
	local lastPosition = plate.Position
	RunService.Stepped:Connect(function (_, deltaTime)
		local currentPosition = plate.Position
		local deltaPosition = currentPosition - lastPosition
		local velocity = deltaPosition / deltaTime
		plate.AssemblyLinearVelocity = velocity
		lastPosition = currentPosition
	end)
end


function Utils.platesMovementHandle(plate, distance, speed)
	local initialPos = plate.CFrame.Position
	local endPosition = initialPos + Vector3.new(0, 0, distance - plate.Size.Z)
	local movingForward = true

	coroutine.wrap(function()
		while true do
			local currentPos = plate.CFrame.Position

			if movingForward then
				if currentPos.Z < endPosition.Z then
					plate.CFrame = plate.CFrame * CFrame.new(0, 0, speed)
				else
					movingForward = false
				end
			else
				if currentPos.Z > initialPos.Z then
					plate.CFrame = plate.CFrame * CFrame.new(0, 0, -speed)
				else
					movingForward = true
				end
			end

			wait(0.01)
		end
	end)()
end

function Utils.partsAsRows(parts, numRows, numCols)
	local rows = {}
	local index = 1
	for i = 1, numRows do
		rows[i] = {}
		for j = 1, numCols do
			if index <= #parts then
				table.insert(rows[i], parts[index])
				index = index + 1
			end
		end
	end
	return rows
end

return Utils
