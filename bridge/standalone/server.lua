if GetResourceState('es_extended') == 'started' then return end
if GetResourceState('qb-core') == 'started' then return end
if GetResourceState('qbx_core') == 'started' then return end

function ShowNotification(target, text, nType)
	TriggerClientEvent(GetCurrentResourceName()..":showNotification", target, text, nType)
end

function GetIdentifier(source)
    return GetPlayerIdentifier(source, 1)
end