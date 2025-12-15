# Pickle XP - Usage Examples

## 📝 Basic Usage Examples

### Server-Side Examples

#### Award XP for Completing a Job
```lua
RegisterNetEvent('myjob:completeTask', function()
    local source = source
    exports.pickle_xp:AddPlayerXP(source, "firefighter", 150)
    -- Player will receive a notification: "+150 XP Firefighter"
end)
```

#### Check Player Level Before Allowing Action
```lua
RegisterNetEvent('myjob:advancedTask', function()
    local source = source
    local level = exports.pickle_xp:GetPlayerLevel(source, "firefighter")
    
    if level >= 5 then
        -- Allow advanced task
        TriggerClientEvent('myjob:startAdvancedTask', source)
    else
        TriggerClientEvent('ox_lib:notify', source, {
            type = 'error',
            description = 'You need to be level 5 Firefighter!'
        })
    end
end)
```

#### Dynamically Register a New Category
```lua
-- In your resource's server.lua
CreateThread(function()
    Wait(2000) -- Wait for pickle_xp to load
    
    exports.pickle_xp:RegisterXPCategory(
        "mining",           -- Internal name
        "Mining",           -- Display label
        500,                -- Starting XP (level 1 requirement)
        0.3,                -- XP factor (30% increase per level)
        20                  -- Maximum level
    )
    
    print("Mining XP category registered!")
end)
```

#### Get All Player XP Data
```lua
RegisterCommand('checkxp', function(source)
    local data = exports.pickle_xp:GetPlayerXPData(source)
    
    for category, info in pairs(data) do
        print(string.format("%s - Level %s - XP: %s/%s", 
            info.label, 
            info.level, 
            info.xp, 
            info.level_xp
        ))
    end
end, false)
```

### Client-Side Examples

#### Display Progress on Screen
```lua
RegisterCommand('myxp', function()
    local xp = exports.pickle_xp:GetXP("firefighter")
    local level = exports.pickle_xp:GetLevel("firefighter")
    local nextLevelXP = exports.pickle_xp:GetLevelXP("firefighter", level + 1)
    
    print(string.format("Firefighter Level %s - %s/%s XP", level, xp, nextLevelXP))
end, false)
```

#### Check if Player Can Access Feature
```lua
function CanAccessAdvancedFirefighting()
    local level = exports.pickle_xp:GetLevel("firefighter")
    return level >= 5
end

-- Usage
if CanAccessAdvancedFirefighting() then
    -- Show advanced menu
else
    lib.notify({
        type = 'error',
        description = 'Requires Firefighter Level 5'
    })
end
```

## 🎮 Complete Job Script Example

Here's a complete example of integrating pickle_xp into a job script:

```lua
-- server.lua
local Config = {
    XPRewards = {
        easy = 50,
        medium = 100,
        hard = 200
    }
}

RegisterNetEvent('myjob:taskComplete', function(difficulty)
    local source = source
    local xpAmount = Config.XPRewards[difficulty] or 50
    
    -- Award XP
    exports.pickle_xp:AddPlayerXP(source, "firefighter", xpAmount)
    
    -- Check for level up
    local newLevel = exports.pickle_xp:GetPlayerLevel(source, "firefighter")
    
    -- Could trigger special rewards on certain levels
    if newLevel == 5 then
        TriggerClientEvent('myjob:unlockAdvanced', source)
    elseif newLevel == 10 then
        TriggerClientEvent('myjob:unlockMaster', source)
    end
end)

-- client.lua
RegisterNetEvent('myjob:unlockAdvanced', function()
    lib.notify({
        title = 'Level Up!',
        description = 'You reached Level 5! Advanced equipment unlocked!',
        type = 'success',
        duration = 5000
    })
end)
```

## 🔧 Advanced: Multiple XP Categories

```lua
-- Register multiple categories for a complex job system
CreateThread(function()
    Wait(2000)
    
    local categories = {
        {name = "farming", label = "Farming", start = 500, factor = 0.25, max = 30},
        {name = "mining", label = "Mining", start = 600, factor = 0.3, max = 25},
        {name = "fishing", label = "Fishing", start = 400, factor = 0.2, max = 35},
        {name = "cooking", label = "Cooking", start = 300, factor = 0.15, max = 40},
    }
    
    for _, cat in ipairs(categories) do
        exports.pickle_xp:RegisterXPCategory(
            cat.name,
            cat.label,
            cat.start,
            cat.factor,
            cat.max
        )
    end
    
    print("All job categories registered!")
end)
```

## 💡 Tips

1. **XP Factor**: The `xpFactor` determines how much harder each level becomes. 
   - 0.1 (10%) = Slow progression
   - 0.5 (50%) = Fast progression
   
2. **Starting XP**: The `xpStart` is how much XP is needed to reach level 2.

3. **Max Level**: Set appropriate max levels to prevent endless grinding.

4. **Notifications**: Set `Config.NotifyXP = false` if you want to handle notifications yourself.

5. **Framework**: Leave `Config.Framework = 'auto'` for automatic detection.

6. **Menu Style**: Use `Config.UseOxLib = true` for modern ox_lib menus, or `false` for the original NUI.
