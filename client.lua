local excludedProps = {}

-- Convert each configured prop into the format you need (e.g., calculating the hash)
for i = 1, #Config.ExcludedProps do
    local propData = Config.ExcludedProps[i]
    table.insert(excludedProps, {
        hash = GetHashKey(propData.model),
        coords = propData.coords,
    })
end

function ApplyBlackoutExceptForProps()
    Citizen.CreateThread(function()
        while true do
            for i = 1, #excludedProps do
                local propInfo = excludedProps[i]
                local hash = propInfo.hash
                local coords = propInfo.coords
                local lightEntity = GetClosestObjectOfType(coords.x, coords.y, coords.z, 30.0, hash, false, false, false)
                if DoesEntityExist(lightEntity) then
                    local forwardVector = GetEntityForwardVector(lightEntity)
                    DrawSpotLightWithShadow(
                        coords.x, coords.y, coords.z,
                        forwardVector.x, forwardVector.y, forwardVector.z,
                        255, 255, 190, 12.0, 1.0, 0.0, 80.0, 10.0
                    )
                    DrawLightWithRange(
                        coords.x, coords.y, coords.z,
                        255, 255, 190, 0.1, 20.0
                    )
                end
            end
            Citizen.Wait(0)  
        end
    end)
end

ApplyBlackoutExceptForProps()
