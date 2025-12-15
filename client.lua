XP = {}
Categories = Config.Categories

function GetXP(name)
    return math.ceil(XP and XP[name] or 0)
end 

function GetLevel(name)
    return GetCategoryLevel(name, GetXP(name))
end 

function GetXPData() 
    local data = {}
    for k,v in pairs(Categories) do 
        local xp = GetXP(k)
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

function ShowDisplay()
    if Config.UseOxLib and GetResourceState('ox_lib') == 'started' then
        -- Use ox_lib context menu
        local contextMenu = {}
        local data = GetXPData()
        
        for k, v in pairs(data) do
            local xp = (v.xp > v.level_xp and v.level_xp or v.xp)
            local progress = math.floor((xp / v.level_xp) * 100)
            
            table.insert(contextMenu, {
                title = v.label,
                description = ('Level %s | XP: %s / %s (%s%%)'):format(v.level, xp, v.level_xp, progress),
                icon = 'star',
                iconColor = progress >= 75 and '#00ff00' or progress >= 50 and '#ffff00' or '#ff0000'
            })
        end
        
        lib.registerContext({
            id = 'pickle_xp_menu',
            title = 'XP System',
            options = contextMenu
        })
        
        lib.showContext('pickle_xp_menu')
    else
        -- Use original NUI
        SendNUIMessage({
            type = "show",
            data = GetXPData()
        })
        SetNuiFocus(true, true)
    end
end

RegisterNUICallback("hide", function()
    SetNuiFocus(false, false)
end)

RegisterNetEvent("pickle_xp:updateXP", function(xp, name)
    if name then 
        XP[name] = xp
    else 
        XP = xp
    end
end)

RegisterNetEvent("pickle_xp:updateCategories", function(categories)
    Categories = categories
end)

RegisterNetEvent("pickle_xp:xpEvent", function(event, name, xp, total)
    if Config.NotifyXP then 
        local category = Categories[name]
        if not category then return end
        if event == "add" then 
            ShowNotification(_L("xp_add", xp, category.label))
        elseif event == "remove" then 
            ShowNotification(_L("xp_remove", xp, category.label))
        end 
    end
end)

RegisterCommand(Config.MenuCommand, function()
    ShowDisplay()
end, false)

exports("GetXPData", GetXPData)
exports("GetXP", GetXP)
exports("GetLevel", GetLevel)

AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  Wait(1000)
  TriggerServerEvent("pickle_xp:initializePlayer")
end)
