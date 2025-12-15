if GetResourceState('qb-core') ~= 'started' then return end

QBCore = exports['qb-core']:GetCoreObject()

function ShowNotification(text, nType)
	if GetResourceState('ox_lib') == 'started' then
		lib.notify({
			title = 'XP System',
			description = text,
			type = nType or 'info'
		})
	else
		QBCore.Functions.Notify(text)
	end
end

RegisterNetEvent(GetCurrentResourceName()..":showNotification", function(text, nType)
    ShowNotification(text, nType)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent("pickle_xp:initializePlayer")
end)