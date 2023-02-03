Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if currentlyWorking == true then
            if nearFinalLocation(currentJob) == true then
                alert('Press ~b~E~w~ to finish the job.')
                if IsControlJustReleased(1, 38) then
                    isTrailer, trailer = GetVehicleTrailerVehicle(GetVehiclePedIsIn(PlayerPedId(), false))
                    if trailer == currentJobTrailer then
                        finishJob(currentJob)
                        currentlyWorking = false
                        currentJob = nil
                        RemoveBlip(currentJobBlip)
                        RemoveBlip(trailerBip)
                        notify('Delivery Successful!')
                        DetachVehicleFromTrailer(GetVehiclePedIsIn(PlayerPedId()))
                        Citizen.Wait(60000)
                        DeleteVehicle(currentJobTrailer)
                        currentJobTrailer = nil
                    end
                end
            end

            if IsControlJustReleased(1, 244) then
                if currentlyWorking == true then
                    controlMenu:Visible(true)
                end
            end
            
            if currentJobTrailer == nil then
                if GetVehicleTrailerVehicle(currentJobTruck) ~= false then
                    isTrailer, trailer = GetVehicleTrailerVehicle(currentJobTruck)
                    currentJobTrailer = trailer
                end
                Citizen.Wait(10)
            elseif currentJobTrailer ~= nil then
                RemoveBlip(trailerBip)

                local coords = GetEntityCoords(currentJobTrailer)

                trailerBip = addBlip(coords.x, coords.y, coords.z, 'Trailer', 478)
            end

            if GetVehicleBodyHealth(currentJobTrailer) == 0.0 then
                currentlyWorking = false
                currentJob = nil
                currentTrailer = nil
                currentJobTruck = nil
                RemoveBlip(currentJobBlip)
                RemoveBlip(trailerBip)
                DetachVehicleFromTrailer(GetVehiclePedIsIn(PlayerPedId()))
                
                DeleteWaypoint()
                notify('Delivery Failed, Trailer was destroyed.')
                
                Citizen.Wait(60000)
                DeleteVehicle(currentJobTrailer)
                currentJobTrailer = nil
            end

            truckHealth = GetVehicleBodyHealth(GetVehiclePedIsIn(PlayerPedId(), false))
            if truckHealth < 500 then
                currentlyWorking = false
                currentJob = nil
                currentTrailer = nil
                currentJobTruck = nil
                RemoveBlip(currentJobBlip)
                RemoveBlip(trailerBip)
                DetachVehicleFromTrailer(GetVehiclePedIsIn(PlayerPedId()))
                Citizen.Wait(10000)
                DeleteVehicle(currentJobTrailer)
                currentJobTrailer = nil
                
                DeleteWaypoint()

                notify('Delivery Failed, Truck is too damaged.')
            end

        elseif currentlyWorking == false then
            RemoveBlip(currentJobBlip)
            RemoveBlip(trailerBip)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if Config.totalDamage == false then
            if currentJobTrailer ~= nil and currentlyWorking == true then
                SetTextFont(0)
                SetTextScale(0.4, 0.4)
                SetTextColour(255, 255, 255, 255)
                SetTextEntry("STRING")
                AddTextComponentString('Trailer Damage: ' .. math.floor(GetVehicleBodyHealth(currentJobTrailer) / 10) .. '%')
                DrawText( 0.0050, 0.5000)
            
                DrawRect(0.0050, 0.5150, 0.26, 0.040,0, 0, 0, 150)
            end
            if currentJobTruck ~= nil and currentlyWorking == true then
                SetTextFont(0)
                SetTextScale(0.4, 0.4)
                SetTextColour(255, 255, 255, 255)
                SetTextEntry("STRING")
                AddTextComponentString('Truck Damage: ' .. math.floor(GetVehicleBodyHealth(currentJobTruck) / 10) .. '%')
                DrawText( 0.0050, 0.4650)
            
                DrawRect(0.0050, 0.475, 0.26, 0.040,0, 0, 0, 150)
            end
        elseif Config.totalDamage == true then
            if currentlyWorking == true then
                totalDamage = 100
                if math.floor(GetVehicleBodyHealth(currentJobTrailer) / 10) < math.floor(GetVehicleBodyHealth(currentJobTruck) / 10) then
                    totalDamage = math.floor(GetVehicleBodyHealth(currentJobTrailer) / 10)
                elseif math.floor(GetVehicleBodyHealth(currentJobTruck) / 10) < math.floor(GetVehicleBodyHealth(currentJobTrailer) / 10) then
                    totalDamage = math.floor(GetVehicleBodyHealth(currentJobTruck) / 10)
                end

                SetTextFont(0)
                SetTextScale(0.4, 0.4)
                SetTextColour(255, 255, 255, 255)
                SetTextEntry("STRING")
                AddTextComponentString('Total Damage: ' .. totalDamage .. '%')
                DrawText( 0.0050, 0.4650)
                
                DrawRect(0.0050, 0.475, 0.26, 0.040,0, 0, 0, 150)
            end
        end
    end
end)