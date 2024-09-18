local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("chq_drugs:createMeth", function()
    QBCore.Functions.Progressbar("createMeth", "Mixing Meth", 10000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@world_human_bum_wash@male@low@idle_a",
        anim = "idle_a",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "amb@world_human_bum_wash@male@low@idle_a", "idle_a", 1.0)
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "amb@world_human_bum_wash@male@low@idle_a", "idle_a", 1.0)
    end)
end)

RegisterNetEvent("chq_drugs:trigger:createMeth", function()
    TriggerServerEvent('chq_drugs:server:createMeth')
end)
-- THREADS

CreateThread(function()
    while true do
        local player = PlayerPedId()
        local pos = GetEntityCoords(player)
        local coords = vector3(1391.83, 3605.82, 38.94)
        local dist = #(pos - coords)

        if dist <= 2 then
            if Config.Target then
                exports['qb-target']:AddBoxZone("MethMake", vector3(1391.83, 3605.82, 38.94), 2, 2, {
                    name = "MethMake",
                    heading = 0.0,
                    debugPoly = false,
                    minZ = 38.0,
                    maxZ = 40.0,
                    }, {
                    options = {
                        {
                            type = "client",
                            event = "chq_drugs:trigger:createMeth",
                            icon = "fas fa-flask",
                            label = "Deposit Items",
                        },
                    },
                    distance = 2.0                   
                })
            end
        end
        Wait(0)
    end
end)