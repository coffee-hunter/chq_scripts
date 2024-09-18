-- ////////////////////////ESX EWH//////////////////////////

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- ////////////////////////ESX EWH//////////////////////////

RegisterServerEvent("chq:isHeist")
AddEventHandler("chq:isHeist", function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer ~= nil then
        local inventory = xPlayer.getInventory()

        local count = 0
        for i=1, #inventory, 1 do
            if inventory[i].name == 'laptop' then
                count = inventory[i].count
            end
        end

        if count >= 1 then
            xPlayer.showNotification("Starting Heist")
            xPlayer.triggerEvent("chq:startHeist")
            xPlayer.removeInventoryItem('laptop', 1)
        elseif count < 1 then
            xPlayer.showNotification("Item not found")
        end
    end
end)

RegisterServerEvent("chq:timeHeist")
AddEventHandler("chq:timeHeist", function()
    local timeout = 1800
    isHeist = false
	Citizen.CreateThread(function()
		while timeout > 0 and isHeist == false do
			Citizen.Wait(1000)

			if timeout > 0 then
				timeout = timeout - 1
			end
		end
	end)
end)

RegisterServerEvent("chq:payHeist")
AddEventHandler("chq:payHeist", function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        xPlayer.addAccountMoney('black_money', math.random(10000, 15000))
    end
    TriggerEvent("chq:timeHeist")
end)