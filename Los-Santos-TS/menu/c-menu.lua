truckMenuPool = NativeUI.CreatePool()

-- Selection of menus --
controlMenu = NativeUI.CreateMenu("LS Truck Sim", "Welcome to the Control Panel")
truckPickerMenu = NativeUI.CreateMenu("LS Truck Sim", "Please pick a truck")
elBurroMenu = NativeUI.CreateMenu("LS Truck Sim", "Welcome to El Burro Heights")
docksMenu = NativeUI.CreateMenu("LS Truck Sim", "Welcome to Docks")
store247 = NativeUI.CreateMenu("LS Truck Sim", "Welcome to 24/7")

-- Adding menus to pool --
truckMenuPool:Add(controlMenu)
truckMenuPool:Add(truckPickerMenu)
truckMenuPool:Add(elBurroMenu)
truckMenuPool:Add(docksMenu)
truckMenuPool:Add(store247)

-- Function to add item to menu --
function addJob(menu, i, jobName, jobTrailerCode, finalLocation, locat)
    local newItem = NativeUI.CreateItem('Start ' .. jobName, 'Start job.')
    newItem.Activated = function(sender, item)
        if item == newItem then
            local coords = vector3(locat.spawnLocationTrailer.x, locat.spawnLocationTrailer.y, locat.spawnLocationTrailer.z)
            local coords2 = vector3(locat.spawnLocationTruck.x, locat.spawnLocationTruck.y, locat.spawnLocationTruck.z)

            truckPickerMenu:Visible(true)
            
            TriggerServerEvent('ts:SpawnVeh', jobTrailerCode, coords, locat.spawnHeadingTrailer, true)

            SetNewWaypoint(finalLocation.x, finalLocation.y)

            currentJob = i
            currentlyWorking = true

            currentJobBlip = addBlip(finalLocation.x, finalLocation.y, finalLocation.z, 'Destination', 492)


            notify('You have started a job, please follow the GPS location to finish the delivery.')

            time = 0
            finalTime = Config.jobs[i].time

            elBurroMenu:Visible(false)
            docksMenu:Visible(false)
            store247:Visible(false)
        end
    end

    menu:AddItem(newItem)
end

function addTruckItem(menu, i)
    local newItem = NativeUI.CreateItem('Spawn ' .. Config.spawnTruckCode[i].spawnName, 'Spawns truck to drive.')
    newItem.Activated = function(sender, item)
        if item == newItem then
            if Config.spawnTruckCode[i].spawnName == "None" then
                print(currentJobTruck)
            else
                for ii = 1, #Config.location do
                    if Config.location[ii].name == Config.jobs[currentJob].startJob then
                        coords = vector3(Config.location[ii].spawnLocationTruck.x, Config.location[ii].spawnLocationTruck.y, Config.location[ii].spawnLocationTruck.z)
                        heading = Config.location[ii].spawnHeadingTruck
                    end
                end
                TriggerServerEvent('ts:SpawnVeh', Config.spawnTruckCode[i].spawnCode, coords, heading, false)
                Citizen.Wait(500)
                currentJobTruck = GetClosestVehicle(coords, 15.000, GetHashKey(Config.spawnTruckCode[i].spawnCode), 2)
            end
            menu:Visible(false)
        end
    end

    menu:AddItem(newItem)
end

-- Stopping job menu button --
function stopJob(menu, currentJobBlip)
    local stopJobItem = NativeUI.CreateItem('End job', 'Ends the current job.')
    stopJobItem.Activated = function(sender, item)
        if item == stopJobItem then
            currentlyWorking = false
            currentJob = nil
            currentTrailer = nil
            RemoveBlip(currentJobBlip)
            DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
            DeleteWaypoint()
            notify('Job Failed.')
            menu:Visible(false)
        end
    end

    menu:AddItem(stopJobItem)
end

-- Toggle UI Display --
function toggleUI(menu)
    local toggleUIItem = NativeUI.CreateItem('Toggle UI Display', 'Toggle your display')
    toggleUIItem.Activated = function(sender, item)
        if item == toggleUIItem then
            if Config.totalDamage == true then
                Config.totalDamage = false
                notify('UI Updated to ~b~total display~w~.')
            elseif Config.totalDamage == false then
                Config.totalDamage = true
                notify('UI Updated to ~b~full display~w~.')
            end
        end
    end

    menu:AddItem(toggleUIItem)
end

truckMenuPool:RefreshIndex()

-- Adding stop job item to menu --
stopJob(controlMenu, currentJobBlip)
toggleUI(controlMenu)


-- Looping thoughout the config jobs list and adding to different menus --
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

-- Adds trucks to truck spawning menu --
for i = 1, #Config.spawnTruckCode do
    addTruckItem(truckPickerMenu, i)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        truckMenuPool:ProcessMenus()
    end
end)

AddEventHandler("manageMenu", function(menu, openMenu)
    if menu == 'El Burro' then
        elBurroMenu:Visible(openMenu)
    elseif menu == 'Docks' then
        docksMenu:Visible(openMenu)
    elseif menu == '24/7' then
        store247:Visible(openMenu)
    end
end)