if GetResourceState('es_extended') ~= 'started' then return end

ESX = exports.es_extended:getSharedObject()

function ShowNotification(target, text, nType)
	TriggerClientEvent(GetCurrentResourceName()..":showNotification", target, text, nType)
end

function GetIdentifier(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    return xPlayer.identifier
end