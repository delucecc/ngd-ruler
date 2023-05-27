local marker = nil
local markerCoords = nil
local distanceText = nil

function CreateMarker(coords)
    if DoesBlipExist(marker) then
        RemoveBlip(marker)
    end
    marker = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(marker, 1)
    SetBlipDisplay(marker, 2)
    SetBlipColour(marker, 2)
    SetBlipAsShortRange(marker, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Marker")
    EndTextCommandSetBlipName(marker)
    CreateThread(function()
        while DoesBlipExist(marker) do
            Wait(0)
            DisplayDistance()
        end
    end)
end

function MeasureDistance()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local distance = GetDistanceBetweenCoords(playerCoords, markerCoords.x, markerCoords.y, markerCoords.z, true)
    return distance
end

function DisplayDistance()
    local distance = MeasureDistance()
    SetTextFont(0)
    SetTextScale(0.5, 0.5)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString("Distance to marker: " .. distance)
    DrawText(0.2, 0.8)
end

function RemoveStuff()
    function RemoveStuff()
        if DoesBlipExist(marker) then
            RemoveBlip(marker)
        end
    end
end

RegisterCommand(Config.Place, function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    markerCoords = playerCoords
    CreateMarker(markerCoords)
end)

RegisterCommand(Config.Remove, function()
    RemoveStuff()
end)
