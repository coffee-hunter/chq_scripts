local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("chq_drugs:server:spawnCoke", function()
    for k,v in pairs(Config.Cocaine["cocaleaf"]["position"]) do
        local plantPos = Config.Cocaine["cocaleaf"]["position"][k]

        CreateObject(`prop_plant_fern_02a`, plantPos.x, plantPos.y, plantPos.z - 1, true, true, false)
    end

    for k,v in pairs(Config.Cocaine["grinder"]["position"]) do
        local grinderPos = Config.Cocaine["grinder"]["position"][k]

        CreateObject(`prop_tool_bench02`, grinderPos.x, grinderPos.y, grinderPos.z - 1, true, true, false)
    end
end)

RegisterNetEvent("chq_drugs:server:addCoke", function() 
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem('cocaleaf', math.random(1, 3))
end)

RegisterNetEvent("chq_drugs:server:grindCoke", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local leaf = Player.Functions.GetItemByName('cocaleaf')

    if leaf ~= nil then
        if leaf.amount >= 3 then
            Player.Functions.RemoveItem('cocaleaf', 3)
            Player.Functions.AddItem('cokebaggy', 1)
        else
            TriggerClientEvent('QBCore:Notify', src, "You don't have enough goods", "error")
        end
    end   
end)

RegisterNetEvent("chq_drugs:server:createMeth", function()
    print("function")
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local hydrogen = Player.Functions.GetItemByName('hydrogen')
    local causticsoda = Player.Functions.GetItemByName('causticsoda')
    local muriaticacid = Player.Functions.GetItemByName('muriaticacid')

    if hydrogen.amount >= Config.Meth["cost"]["hydrogen"] and causticsoda.amount >= Config.Meth["cost"]["causticsoda"] and muriaticacid.amount >= Config.Meth["cost"]["muriaticacid"] then
        TriggerClientEvent('chq_drugs:createMeth', src)
        Player.Functions.RemoveItem('hydrogen', Config.Meth["cost"]["hydrogen"])
        Player.Functions.RemoveItem('causticsoda', Config.Meth["cost"]["causticsoda"])
        Player.Functions.RemoveItem('muriaticacid', Config.Meth["cost"]["muriaticacid"])
        Player.Functions.AddItem('meth', 1)
        TriggerClientEvent('QBCore:Notify', src, "You made meth", "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough goods", "error")
    end
end)


