Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if nearMenu() ~= false then
            i = nearMenu()
            alert('Press ~b~E~w~ to open menu')
            if IsControlJustReleased(1, 38) then
                if currentlyWorking == false then
                    TriggerEvent("manageMenu", Config.location[i].name, true)
                end
            end
        else
            elBurroMenu:Visible(false)
            docksMenu:Visible(false)
        end
    end
end)