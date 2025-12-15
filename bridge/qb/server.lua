if GetResourceState('qb-core') ~= 'started' then return end

QBCore = exports['qb-core']:GetCoreObject()

function ShowNotification(target, text, nType)
	TriggerClientEvent(GetCurrentResourceName()..":showNotification", target, text, nType)
end

function GetIdentifier(source)
    local xPlayer = QBCore.Functions.GetPlayer(source).PlayerData
    return xPlayer.citizenid 
end