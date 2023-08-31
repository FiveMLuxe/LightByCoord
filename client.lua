local excludedProps = {
    {
        hash = GetHashKey("prop_generator_03b"),
        coords = vector3(-456.43765258789, 5905.3330078125, 37.324668884277),
    },
   
}
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