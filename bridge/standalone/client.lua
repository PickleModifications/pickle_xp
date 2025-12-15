if GetResourceState('es_extended') == 'started' then return end
if GetResourceState('qb-core') == 'started' then return end
if GetResourceState('qbx_core') == 'started' then return end

function ShowNotification(text, nType)
	if GetResourceState('ox_lib') == 'started' then
		lib.notify({
			title = 'XP System',
			description = text,
			type = nType or 'info'
		})
	else
		SetNotificationTextEntry('STRING')
		AddTextComponentString(text)
		DrawNotification(false, true)
	end
end

RegisterNetEvent(GetCurrentResourceName()..":showNotification", function(text, nType)
    ShowNotification(text, nType)
end)

CreateThread(function()
	Wait(1000)
    TriggerServerEvent("pickle_xp:initializePlayer")
end)