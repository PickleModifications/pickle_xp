if GetResourceState('es_extended') ~= 'started' then return end

ESX = exports.es_extended:getSharedObject()

function ShowNotification(text, nType)
	if GetResourceState('ox_lib') == 'started' then
		lib.notify({
			title = 'XP System',
			description = text,
			type = nType or 'info'
		})
	else
		ESX.ShowNotification(text)
	end
end

RegisterNetEvent(GetCurrentResourceName()..":showNotification", function(text, nType)
    ShowNotification(text, nType)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function(xPlayer, isNew, skin)
    TriggerServerEvent("pickle_xp:initializePlayer")
end)