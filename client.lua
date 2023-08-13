RegisterCommand('car', function(source, args, rawCommand)
    if #args == 0 then
        print('Usage: /car [car_name]')
    else
        local carName = args[1]
        local playerCoords = GetEntityCoords(GetPlayerPed(-1))
        local heading = GetEntityHeading(GetPlayerPed(-1))
        local vehicleHash = GetHashKey(carName)
        if IsModelInCdimage(vehicleHash) and IsModelAVehicle(vehicleHash) then
            RequestModel(vehicleHash)
            while not HasModelLoaded(vehicleHash) do
                Citizen.Wait(0)
            end
            local vehicle = CreateVehicle(vehicleHash, playerCoords.x, playerCoords.y, playerCoords.z, heading, true, false)
            SetEntityAsMissionEntity(vehicle, true, true)
            local vehiclePlate = 'AZUKIOV'
            SetVehicleNumberPlateText(vehicle, vehiclePlate)
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
            TriggerClientEvent('chatMessage', source, '^2Succès^7', {0, 255, 0}, 'Vous avez fait spawn une ' .. carName .. ' avec la plaque d\'immatriculation ' .. vehiclePlate)
        else
            TriggerClientEvent('chatMessage', source, '^1Erreur^7', {255, 0, 0}, 'Nom de voiture invalide. Utilisation : /car [car_name]')
        end
    end
end, false)
