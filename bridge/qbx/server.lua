if GetResourceState('qbx_core') ~= 'started' then return end

function ShowNotification(target, text, nType)
    TriggerClientEvent(GetCurrentResourceName()..":showNotification", target, text, nType)
end

function GetIdentifier(source)
    local player = exports.qbx_core:GetPlayer(source)
    if not player then return nil end
    return player.PlayerData.citizenid
end
