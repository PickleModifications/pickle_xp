XP = {}
Categories = Config.Categories

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
        MySQL.Async.fetchAll("SELECT * FROM player_xp WHERE identifier=@identifier;", {["@identifier"] = identifier}, 
        function(results)
            if not results[1] then 
                MySQL.Async.execute("INSERT INTO player_xp (identifier, xp) VALUES (@identifier, @xp);", {
                    ["@identifier"] = identifier,
                    ["@xp"] = json.encode(XP[source])
                })
            else
                MySQL.Async.execute("UPDATE player_xp SET xp=@xp WHERE identifier=@identifier;", {
                    ["@identifier"] = identifier,
                    ["@xp"] = json.encode(XP[source])
                })
            end
        end)
    end)
end

function InitializePlayerXP(source, cb)
    if XP[source] then
        if cb then cb() end
        return
    end
    local identifier = GetIdentifier(source)
    MySQL.Async.fetchAll("SELECT * FROM player_xp WHERE identifier=@identifier;", {["@identifier"] = identifier}, function(results)
        if not results[1] then 
            XP[source] = {}
        else
            XP[source] = json.decode(results[1].xp) or {}
        end
        TriggerClientEvent("pickle_xp:updateXP", source, XP[source])
        if cb then 
            cb(XP[source])
        end
    end)
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

exports("AddPlayerXP", AddPlayerXP)
exports("RemovePlayerXP", RemovePlayerXP)
exports("GetPlayerXPData", GetPlayerXPData)
exports("GetPlayerLevel", GetPlayerLevel)
exports("SetPlayerXP", SetPlayerXP)
exports("InitializePlayerXP", InitializePlayerXP)
exports("RegisterXPCategory", RegisterXPCategory)
