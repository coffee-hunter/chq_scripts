local isHeist = false

local pos = {
    [1] = {x = 146.81, y = -1045.81, z = 29.37} -- Legion Bank
}

-- Draw Marker
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(pos) do
            DrawMarker(27, pos[k].x, pos[k].y, pos[k].z-0.75, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0.0, 0.0, 180, false, true, 2, nil, nil, false)
        end
    end
end)

-- Heist FNC
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(pos) do
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(coords.x, coords.y, coords.z, pos[k].x, pos[k].y, pos[k].z)
            if dist < 2 then
                notify("[E] Start Heist")
                
                if IsControlJustPressed(0, 38) then
                    if IsPedArmed(PlayerPedId(), 4) then
                        TriggerServerEvent("chq:isHeist")
                        Citizen.Wait(1000)
                    else
                        notify("You are not a threat")
                    end
                    Citizen.Wait(0)
                end
            elseif isHeist == true and dist > 5 then
                notify("Heist Cancelled!")
                TriggerEvent("chq:stopHeist")
            end
        end
    end
end)

RegisterNetEvent("chq:startHeist")
AddEventHandler("chq:startHeist", function()
    local timer = 10
    isHeist = true
	Citizen.CreateThread(function()
		while timer > 0 and isHeist do
			Citizen.Wait(1000)

			if timer > 0 then
				timer = timer - 1
			end
		end
	end)

	Citizen.CreateThread(function()
		while isHeist do
			Citizen.Wait(0)
			drawTxt(0.66, 1.44, 1.0, 1.0, 0.4, timer, 255, 255, 255, 255)

            if timer == 1 then
                TriggerServerEvent("chq:payHeist")
                Citizen.Wait(1000)
            elseif timer == 0 then
                TriggerEvent("chq:stopHeist")
            end
		end
	end)
end)

RegisterNetEvent("chq:stopHeist")
AddEventHandler("chq:stopHeist", function()
    isHeist = false
end)

-- ///////////////////Msg///////////////////////// --

function notify(str)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(str)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

function drawTxt(x,y, width, height, scale, text, r,g,b,a, outline)
	SetTextFont(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropshadow(0, 0, 0, 0,255)
	SetTextDropShadow()
	if outline then SetTextOutline() end

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x - width/2, y - height/2 + 0.005)
end