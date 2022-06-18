local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


local voice, money, isTalking, muted, funk = 8,0,false,false,false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(500)
	end

    ESX.PlayerData = ESX.GetPlayerData()
	SendNUIMessage({zeigehud = true})
    StartShowHudThread()
end)


local inVehicle = false

function StartShowHudThread()
    Citizen.CreateThread(function()
        while(true) do
            funk = exports.saltychat:GetRadioChannel(true)
			if funk == nil then
				funk = 0000
			end
            Citizen.Wait(2000)
        end
    end)
end

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1000)
        if ESX.GetPlayerData().money ~= nil then
            if inVehicle then
                SendNUIMessage({
					isTalking = isTalking,
                    voice = voice,
					muted = muted,
                    money = ESX.GetPlayerData().money,
                    funk = funk,
                })
            else
                SendNUIMessage({
					isTalking = isTalking,
                    money = ESX.GetPlayerData().money,
                    voice = voice,
					muted = muted,
                    funk = funk,
                })
            end
        end
        
    end
end)

RegisterNetEvent('esx-hud:Hudaus')
AddEventHandler('esx-hud:Hudaus', function()
	print("Test")
	SendNUIMessage({zeigehud = false})
end)

RegisterNetEvent('esx-hud:Hudan')
AddEventHandler('esx-hud:Hudan', function()
	print("Test2")
	SendNUIMessage({zeigehud = true})
end)

AddEventHandler('SaltyChat_TalkStateChanged', function(talking)
	isTalking = talking
end)

AddEventHandler('SaltyChat_MicStateChanged', function(isMicrophoneMuted)
	muted = isMicrophoneMuted
	print(muted)
end)

AddEventHandler("hud:range", function(range)
    voice = range
    if range == 3.5 then
        TriggerEvent("notifications", "#ff3838", "3 Meter - Sprachweite")
    elseif range == 8 then
        TriggerEvent("notifications", "#ff3838", "8 Meter - Sprachweite")
    elseif range == 15 then
        TriggerEvent("notifications", "#ff3838", "15 Meter - Sprachweite")
    end
end)

RegisterNetEvent('kw_hud:changeVoice')
AddEventHandler('kw_hud:changeVoice', function(voice1)
    voice = voice1
end)
