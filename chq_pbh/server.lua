-- ////////////////////////ESX EWH//////////////////////////

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- ////////////////////////ESX EWH//////////////////////////

RegisterServerEvent("chq:isPay")
AddEventHandler("chq:isPay", function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer ~= nil then

        local price = 150
        if xPlayer.getMoney() >= price then
            xPlayer.showNotification("You have been healed!")
            xPlayer.removeMoney(price)
            xPlayer.triggerEvent("chq:heal")
        elseif xPlayer.getMoney() < price then
            xPlayer.showNotification("Not enough money!")
        end

    end
end)