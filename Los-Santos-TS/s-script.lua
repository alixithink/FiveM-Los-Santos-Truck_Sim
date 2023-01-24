RegisterServerEvent('ts:SpawnVeh')
AddEventHandler('ts:SpawnVeh', function(vehicle, coords, heading, isTrailer)
    local veh = CreateVehicle(vehicle, coords, heading, true, true)
end)