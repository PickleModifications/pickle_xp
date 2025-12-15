XP = {}
Categories = Config.Categories

-- Auto-inject SQL table on resource start
CreateThread(function()
    local success = MySQL.query.await([[
        CREATE TABLE IF NOT EXISTS `player_xp` (
            `identifier` varchar(46) NOT NULL,
            `xp` longtext DEFAULT NULL,
            PRIMARY KEY (`identifier`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
    ]])
    
    if success then
        print("^2[Pickle XP]^7 Database table verified/created successfully")
    else
        print("^1[Pickle XP]^7 Failed to create database table")
    end
end)

function AddPlayerXP(source, name, xp)
    if xp < 0 then return print("[Pickle XP] Cannot add to \"".. name .. "\" as the parameter is less than 0.") end
    local category = Categories[name]
    if not category then return print("[Pickle XP] Cannot add to \"".. name .. "\" as it does not exist.") end
    local total = GetPlayerXP(source, name) + xp
    local max = GetLevelXP(name, category.maxLevel)
    if total > max then 
        total = max
    end
    TriggerClientEvent("pickle_xp:xpEvent", source, "add", name, xp, total)
    SetPlayerXP(source, name, total)
end

function RemovePlayerXP(source, name, xp)
    if xp < 0 then return print("[Pickle XP] Cannot remove from to \"".. name .. "\" as the parameter is less than 0.") end
    local category = Categories[name]
    if not category then return print("[Pickle XP] Cannot remove from \"".. name .. "\" as it does not exist.") end
    local total = GetPlayerXP(source, name) - xp
    if total < 0 then 
        total = 0
    end
    TriggerClientEvent("pickle_xp:xpEvent", source, "remove", name, xp, total)
    SetPlayerXP(source, name, total)
end

function GetPlayerXP(source, name)
    return (XP[source] and XP[source][name] or 0)
end

function GetPlayerLevel(source, name)
    return GetCategoryLevel(name, GetPlayerXP(source, name))
end

function GetPlayerXPData(source, name)
    local data = {}
    for k,v in pairs(Categories) do 
        local xp = GetPlayerXP(k)
        local level = GetCategoryLevel(k, xp)
        data[k] = {
            label = v.label,
            xp = xp,
            level = level,
            level_xp = GetLevelXP(k, level),
        }
    end
    return data
end

function SetPlayerXP(source, name, xp)
    InitializePlayerXP(source, function()
        local identifier = GetIdentifier(source)
        XP[source][name] = xp or nil
        TriggerClientEvent("pickle_xp:updateXP", source, XP[source][name], name)
        
        local result = MySQL.query.await("SELECT * FROM player_xp WHERE identifier = ?", {identifier})
        
        if not result or #result == 0 then 
            MySQL.insert.await("INSERT INTO player_xp (identifier, xp) VALUES (?, ?)", {
                identifier,
                json.encode(XP[source])
            })
        else
            MySQL.update.await("UPDATE player_xp SET xp = ? WHERE identifier = ?", {
                json.encode(XP[source]),
                identifier
            })
        end
    end)
end

function InitializePlayerXP(source, cb)
    if XP[source] then
        if cb then cb() end
        return
    end
    local identifier = GetIdentifier(source)
    local result = MySQL.query.await("SELECT * FROM player_xp WHERE identifier = ?", {identifier})
    
    if not result or #result == 0 then 
        XP[source] = {}
    else
        XP[source] = json.decode(result[1].xp) or {}
    end
    
    TriggerClientEvent("pickle_xp:updateXP", source, XP[source])
    
    if cb then 
        cb(XP[source])
    end
end

function RegisterXPCategory(name, label, xpStart, xpFactor, maxLevel)
    Categories[name] = {
        label = label,
        xpStart = xpStart,
        xpFactor = xpFactor,
        maxLevel = maxLevel
    }
    TriggerClientEvent("pickle_xp:updateCategories", -1, Categories)
end

RegisterNetEvent("pickle_xp:initializePlayer", function()
    local source = source
    TriggerClientEvent("pickle_xp:updateCategories", source, Categories)
    InitializePlayerXP(source)
end)

-- Clean up XP data when player disconnects
AddEventHandler('playerDropped', function()
    local source = source
    if XP[source] then
        XP[source] = nil
    end
end)

exports("AddPlayerXP", AddPlayerXP)
exports("RemovePlayerXP", RemovePlayerXP)
exports("GetPlayerXPData", GetPlayerXPData)
exports("GetPlayerLevel", GetPlayerLevel)
exports("SetPlayerXP", SetPlayerXP)
exports("InitializePlayerXP", InitializePlayerXP)
exports("RegisterXPCategory", RegisterXPCategory)
