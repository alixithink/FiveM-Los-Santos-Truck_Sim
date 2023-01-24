truckMenuPool = NativeUI.CreatePool()
controlMenu = NativeUI.CreateMenu("LS Truck Sim", "Welcome to the Control Panel")
elBurroMenu = NativeUI.CreateMenu("LS Truck Sim", "Welcome to El Burro Heights")
docksMenu = NativeUI.CreateMenu("LS Truck Sim", "Welcome to Docks")
store247 = NativeUI.CreateMenu("LS Truck Sim", "Welcome to 24/7")
truckMenuPool:Add(controlMenu)
truckMenuPool:Add(elBurroMenu)
truckMenuPool:Add(docksMenu)
truckMenuPool:Add(store247)

currentlyWorking = false
currentJob = nil
currentTrailer = nil
currentJobBlip = nil
currentJobTruck = nil
currentJobTrailer = nil

function addJob(menu, i, jobName, jobTrailerCode, finalLocation, locat)
    local newItem = NativeUI.CreateItem('Start ' .. jobName, 'Start job.')
    newItem.Activated = function(sender, item)
        if item == newItem then

            
            local coords = vector3(locat.spawnLocationTrailer.x, locat.spawnLocationTrailer.y, locat.spawnLocationTrailer.z)
            local coords2 = vector3(locat.spawnLocationTruck.x, locat.spawnLocationTruck.y, locat.spawnLocationTruck.z)
            TriggerServerEvent('ts:SpawnVeh', jobTrailerCode, coords, locat.spawnHeadingTrailer, true)
            TriggerServerEvent('ts:SpawnVeh', Config.spawnTruckCode, coords2, locat.spawnHeadingTruck, false)

            SetNewWaypoint(finalLocation.x, finalLocation.y)

            currentJob = i
            currentlyWorking = true

            currentJobBlip = AddBlipForCoord(finalLocation.x, finalLocation.y, finalLocation.z)
            SetBlipSprite(currentJobBlip, 492)
            SetBlipDisplay(currentJobBlip, 4)
            SetBlipScale(currentJobBlip, 1.0)
            SetBlipColour(currentJobBlip, 1)
            SetBlipAsShortRange(currentJobBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Destination')
            EndTextCommandSetBlipName(currentJobBlip)


            notify('You have started a job, please follow the GPS location to finish the delivery.')

            elBurroMenu:Visible(false)
            docksMenu:Visible(false)
            store247:Visible(false)

            Citizen.Wait(1000)
            currentJobTruck = GetClosestVehicle(coords2, 15.000, GetHashKey("phantom"), 2)
        end
    end

    menu:AddItem(newItem)
end

function stopJob(menu, currentJobBlip)
    local stopJobItem = NativeUI.CreateItem('End job', 'Ends the current job.')
    stopJobItem.Activated = function(sender, item)
        if item == stopJobItem then
            currentlyWorking = false
            currentJob = nil
            currentTrailer = nil
            currentJobBlip = nil
            DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
            DeleteWaypoint()
            notify('Job Failed.')
            menu:Visible(false)
        end
    end

    menu:AddItem(stopJobItem)
end

truckMenuPool:RefreshIndex()

stopJob(controlMenu, currentJobBlip)

for i = 1, #Config.jobs do
    if Config.jobs[i].startJob == "El Burro" then
        for i = 1, #Config.location do
            if Config.location[i].name == "El Burro" then
                locat = Config.location[i]
            end
        end
        addJob(elBurroMenu, i, Config.jobs[i].jobName, Config.jobs[i].jobTrailerCode, Config.jobs[i].finalLocation, locat)
    elseif Config.jobs[i].startJob == "Docks" then
        for i = 1, #Config.location do
            if Config.location[i].name == "Docks" then
                locat = Config.location[i]
            end
        end
        addJob(docksMenu, i, Config.jobs[i].jobName, Config.jobs[i].jobTrailerCode, Config.jobs[i].finalLocation, locat)
    elseif Config.jobs[i].startJob == "24/7" then
        for i = 1, #Config.location do
            if Config.location[i].name == "24/7" then
                locat = Config.location[i]
            end
        end
        addJob(store247, i, Config.jobs[i].jobName, Config.jobs[i].jobTrailerCode, Config.jobs[i].finalLocation, locat)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        truckMenuPool:ProcessMenus()
    end
end)

Citizen.CreateThread(function()
    for i = 1, #Config.location do
        blip = AddBlipForCoord(Config.location[i].x, Config.location[i].y, Config.location[i].z)
        SetBlipSprite(blip, 477)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, 37)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.location[i].name .. ' loading center')
        EndTextCommandSetBlipName(blip)
    end

    while true do
        Citizen.Wait(1)
        if nearMenu() ~= false then
            i = nearMenu()
            alert('Press ~b~E~w~ to open menu')
            if IsControlJustReleased(1, 38) then
                if currentlyWorking == false then
                    if Config.location[i].name == "El Burro" then
                        elBurroMenu:Visible(true)
                    elseif Config.location[i].name == "Docks" then
                        docksMenu:Visible(true)
                    elseif Config.location[i].name == "24/7" then
                        store247:Visible(true)
                    end
                end
            end
        else
            elBurroMenu:Visible(false)
            docksMenu:Visible(false)
        end

        if currentlyWorking == true then
            if nearFinalLocation(currentJob) == true then
                alert('Press ~b~E~w~ to finish the job.')
                if IsControlJustReleased(1, 38) then
                    if GetVehicleTrailerVehicle(GetVehiclePedIsIn(PlayerPedId(), false)) == 1 then
                        finishJob(currentJob)
                        currentlyWorking = false
                        currentJob = nil
                        RemoveBlip(currentJobBlip)
                        notify('Delivery Successful!')
                        DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
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

                trailerBip = AddBlipForCoord(GetEntityCoords(currentJobTrailer))
                SetBlipSprite(trailerBip, 478)
                SetBlipDisplay(trailerBip, 4)
                SetBlipScale(trailerBip, 1.0)
                SetBlipColour(trailerBip, 37)
                SetBlipAsShortRange(trailerBip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('Trailer')
                EndTextCommandSetBlipName(trailerBip)
            end

            if GetVehicleBodyHealth(currentJobTrailer) == 0.0 then
                currentlyWorking = false
                currentJob = nil
                currentTrailer = nil
                currentJobTruck = nil
                currentJobTrailer = nil

                notify('Delivery Failed, Trailer was destroyed.')
            end

            truckHealth = GetVehicleBodyHealth(GetVehiclePedIsIn(PlayerPedId(), false))
            if truckHealth < 950 then
                currentlyWorking = false
                currentJob = nil
                currentTrailer = nil
                currentJobTruck = nil
                currentJobTrailer = nil

                notify('Delivery Failed, Truck is too damaged.')
            end

        elseif currentlyWorking == false then
            RemoveBlip(currentJobBlip)
            RemoveBlip(trailerBip)
        end
    end
end)

function nearMenu()
    for i = 1, #Config.location do
        local coords = GetEntityCoords(PlayerPedId(), 0)
        local dist = Vdist(Config.location[i].x, Config.location[i].y, Config.location[i].z, coords.x, coords.y, coords.z)
        if dist < 2 then
            distance = dist
            pos = Config.location[i]
            return i
        end
    end

    return false

    -- local coords = GetEntityCoords(PlayerPedId(), 0)
    -- local dist = Vdist(Config.location[1].x, Config.location.[1].y, Config.location[1].z, coords.x, coords.y, coords.z)
    -- if dist < 2 then
    --     distance = dist
    --     pos = Config.location.elBurro
    --     return true
    -- end
end

function nearFinalLocation(currentJob)
    local coords = GetEntityCoords(PlayerPedId(), 0)
    local finalLocation = Config.jobs[currentJob].finalLocation
    local dist = Vdist(finalLocation.x, finalLocation.y, finalLocation.z, coords.x, coords.y, coords.z)
    if dist < 2 then
        distance = dist
        pos = Config.location[i]
        return true
    end
end

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end

function alert(msg) 
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


function finishJob(currentJob)
    -- Do when job is done --
    print('Finished job, ' .. Config.jobs[currentJob].jobName)

    -- TriggerEvent('addMoney', Config.jobs[currentJob].giveMoney) -- Optional
end