local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end)

        Citizen.Wait(0)
    end
end)

-- TPW
RegisterCommand("tpw", function(source)
    TeleportToWaypoint()
end)

TeleportToWaypoint = function()
    ESX.TriggerServerCallback("chq_tp:fetchUserRank", function(playerRank)
        if playerRank == "admin" or playerRank == "superadmin" or playerRank == "mod" then
            local WaypointHandle = GetFirstBlipInfoId(8)

            if DoesBlipExist(WaypointHandle) then
                local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

                for height = 1, 1000 do
                    SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                    local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

                    if foundGround then
                        SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                        break
                    end

                    Citizen.Wait(5)
                end

                ESX.ShowNotification("Teleported.")
            else
                ESX.ShowNotification("Please place your waypoint.")
            end
        else
            ESX.ShowNotification("You do not have rights to do this.")
        end
    end)
end

-- BRING
RegisterCommand("bring", function(source)
    bringPlayer()
end)

bringPlayer = function()
    ESX.TriggerServerCallback("chq_tp:fetchUserRank", function(playerRank)
        if playerRank == "admin" or playerRank == "superadmin" or playerRank == "mod" then
            states.frozenPos = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))
            SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target))))
        end
    end)
end

-- GOTO
RegisterCommand("tp", function(source)
    tpPlayer()
end)

tpPlayer = function()
    ESX.TriggerServerCallback("chq_tp:fetchUserRank", function(playerRank)
        if playerRank == "admin" or playerRank == "superadmin" or playerRank == "mod" then
            SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target))))
        end
    end)
end

-- NOCLIP
RegisterCommand("noclip", function(source)
    noclip()
end)

noclip = function()
    ESX.TriggerServerCallback("chq_tp:fetchUserRank", function(playerRank)
        if playerRank == "admin" or playerRank == "superadmin" or playerRank == "mod" then
            local msg = "disabled"
            if(noclip == false)then
                noclip_pos = GetEntityCoords(PlayerPedId(), false)
            end

            noclip = not noclip

            if(noclip)then
                msg = "enabled"
            end

	        TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Noclip has been ^2^*" .. msg)
        end
    end)
end

-- FREEZE
RegisterCommand("freeze", function(source)
    freezePlayer()
end)

freezePlayer function(state)
    ESX.TriggerServerCallback("chq_tp:fetchUserRank", function(playerRank)
        if playerRank == "admin" or playerRank == "superadmin" or playerRank == "mod" then
            local player = PlayerId()

            local ped = PlayerPedId()

            states.frozen = state
            states.frozenPos = GetEntityCoords(ped, false)

            if not state then
                if not IsEntityVisible(ped) then
                    SetEntityVisible(ped, true)
                end

                if not IsPedInAnyVehicle(ped) then
                    SetEntityCollision(ped, true)
                end

                FreezeEntityPosition(ped, false)
                SetPlayerInvincible(player, false)
            else
                SetEntityCollision(ped, false)
                FreezeEntityPosition(ped, true)
                SetPlayerInvincible(player, true)

                if not IsPedFatallyInjured(ped) then
                    ClearPedTasksImmediately(ped)
                end
            end
        end
    end)
end