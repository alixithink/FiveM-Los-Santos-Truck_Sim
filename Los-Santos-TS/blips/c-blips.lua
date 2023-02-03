Citizen.CreateThread(function()
    for i = 1, #Config.location do
        addBlip(Config.location[i].x, Config.location[i].y, Config.location[i].z, Config.location[i].name .. ' loading center', 477)
    end
end)