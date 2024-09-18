local pos = {
    {x = 312.54, y = -592.45, z = 43.28} -- PBH Front Desk
}

function notify(str)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(str)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

-- Draw Marker
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(pos) do
            DrawMarker(27, pos[k].x, pos[k].y, pos[k].z-0.75, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0.0, 255, 0.0, 180, false, true, 2, nil, nil, false)
        end
    end
end)

-- Heal FNC
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(pos) do
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(coords.x, coords.y, coords.z, pos[k].x, pos[k].y, pos[k].z)
            if dist < 2 then
                if IsControlJustPressed(0, 38) then
                    TriggerServerEvent("chq:isPay")
                    Citizen.Wait(1000)
                else 
                    notify("[E] Heal yourself for $150")
                end
            end
        end
    end
end)

RegisterNetEvent("chq:heal")
AddEventHandler("chq:heal", function()
    SetEntityHealth(PlayerPedId(), 200)
end)