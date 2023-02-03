currentlyWorking = false
currentJob = nil
currentTrailer = nil
currentJobBlip = nil
currentJobTruck = nil
currentJobTrailer = nil

time = nil
finalTime = nil

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

function addBlip(x, y, z, text, icon)
    local blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip, icon)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 37)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)

    return blip
end

function finishJob(currentJob)
    -- Do when job is done --
    print('Finished job, ' .. Config.jobs[currentJob].jobName)

    -- TriggerEvent('addMoney', Config.jobs[currentJob].giveMoney) -- Optional
end