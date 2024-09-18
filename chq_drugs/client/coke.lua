local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("chq_drugs:harvestCoke", function()
    QBCore.Functions.Progressbar("harvestCoke", "Harvesting Coca Leaves", 10000, false, true, {
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
        TriggerServerEvent('chq_drugs:server:addCoke')
        QBCore.Functions.Notify("You got coca leaves", "success")
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "amb@world_human_bum_wash@male@low@idle_a", "idle_a", 1.0)
        QBCore.Functions.Notify("Canceled", "error")
    end)
end)

RegisterNetEvent("chq_drugs:grindCoke", function()
    QBCore.Functions.Progressbar("grindCoke", "Grinding Coca Leaves", 10000, false, true, {
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
        TriggerServerEvent('chq_drugs:server:grindCoke')
        QBCore.Functions.Notify("You got a coke baggy", "success")
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "amb@world_human_bum_wash@male@low@idle_a", "idle_a", 1.0)
        QBCore.Functions.Notify("Canceled", "error")
    end) 
end)

-- THREADS

CreateThread(function() -- Interaction
    TriggerServerEvent("chq_drugs:server:spawnCoke")

    while true do
        local player = PlayerPedId()
        local pos = GetEntityCoords(player)

        for k,v in pairs(Config.Cocaine["cocaleaf"]["position"]) do
            local plantPos = Config.Cocaine["cocaleaf"]["position"][k]
     
            local coords = vector3(plantPos.x, plantPos.y, plantPos.z)
            local dist = #(pos - coords)

            if dist <= 2 then
                if Config.Target then
                    local entity = `prop_plant_fern_02a`
                    exports['qb-target']:AddTargetModel(`prop_plant_fern_02a`, {
                        options = {
                            {
                                type = "client",
                                event = "chq_drugs:harvestCoke",
                                icon = "fas fa-leaf",
                                label = "Harvest Leaves"
                            }
                        },
                        distance = 1.0
                    })
                end
            end
        end

        local coords2 = vector3(327.41, -1009.27, 29.29)
        local dist2 = #(pos - coords2)

        if dist2 <= 2 then
            if Config.Target then
                exports['qb-target']:AddBoxZone("CokeGrinder", vector3(327.41, -1009.27, 29.29), 2, 2, {
                    name = "CokeGrinder",
                    heading = 0.0,
                    debugPoly = false,
                    minZ = 28.0,
                    maxZ = 30.0,
                    }, {
                    options = {
                        {
                            type = "client",
                            event = "chq_drugs:grindCoke",
                            icon = "fas fa-cog",
                            label = "Use Bench",
                        },
                    },
                    distance = 2.0                   
                })
            end
        end
        Wait(0)
    end
end)

RegisterNetEvent("chq_drugs:notify:error", function()
    QBCore.Functions.Notify("You do not have enough goods", "error")
end)