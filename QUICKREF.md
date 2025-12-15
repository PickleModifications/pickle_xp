# 📋 Pickle XP - Quick Reference

## 🎯 Quick Start

### Player Commands
```
/xpdisplay - Open XP menu
```

### Config Quick Setup
```lua
Config.Framework = 'auto'    -- Auto-detect framework
Config.UseOxLib = true       -- Use modern ox_lib menu
Config.NotifyXP = true       -- Show XP gain notifications
Config.MenuCommand = "xpdisplay"
```

---

## 🚀 Common Exports

### Server-Side

#### Add XP
```lua
exports.pickle_xp:AddPlayerXP(source, "category", amount)
```

#### Remove XP
```lua
exports.pickle_xp:RemovePlayerXP(source, "category", amount)
```

#### Set XP
```lua
exports.pickle_xp:SetPlayerXP(source, "category", amount)
```

#### Get Player Level
```lua
local level = exports.pickle_xp:GetPlayerLevel(source, "category")
```

#### Get Player XP Data
```lua
local data = exports.pickle_xp:GetPlayerXPData(source, "category")
-- data.level, data.xp, data.level_xp
```

#### Register New Category
```lua
exports.pickle_xp:RegisterXPCategory(name, label, xpStart, xpFactor, maxLevel)
-- Example:
exports.pickle_xp:RegisterXPCategory("mining", "Mining", 500, 0.3, 20)
```

### Client-Side

#### Get XP
```lua
local xp = exports.pickle_xp:GetXP("category")
```

#### Get Level
```lua
local level = exports.pickle_xp:GetLevel("category")
```

#### Get All XP Data
```lua
local data = exports.pickle_xp:GetXPData()
```

### Shared

#### Get XP Required for Level
```lua
local required = exports.pickle_xp:GetLevelXP("category", level)
```

#### Get Category Level from XP
```lua
local level = exports.pickle_xp:GetCategoryLevel("category", xp)
```

---

## 📊 XP Formula

```lua
xpFactor = Multiplier per level
xpStart = Base XP for level 1

Level 1: xpStart
Level 2: xpStart * (1 + xpFactor)
Level 3: Level2XP * (1 + xpFactor)
...and so on
```

### Example with xpStart=1000, xpFactor=0.2 (20%):
- Level 1: 1,000 XP
- Level 2: 1,200 XP (+200)
- Level 3: 1,440 XP (+240)
- Level 4: 1,728 XP (+288)

---

## 🎨 XP Factor Guide

| Factor | Growth | Best For |
|--------|--------|----------|
| 0.1 (10%) | Very Slow | Long-term progression |
| 0.2 (20%) | Slow | Regular jobs |
| 0.3 (30%) | Medium | Skill-based activities |
| 0.5 (50%) | Fast | Quick progression |
| 1.0 (100%) | Very Fast | Mini-games |

---

## 🔧 Framework Detection

### Auto-Detection Order:
1. QBox (qbx_core)
2. ESX (es_extended)
3. QB-Core (qb-core)
4. Standalone (fallback)

### Manual Override:
```lua
Config.Framework = 'qbx'  -- Forces QBox
Config.Framework = 'esx'  -- Forces ESX
Config.Framework = 'qb'   -- Forces QB-Core
Config.Framework = 'standalone'  -- Forces Standalone
```

---

## 💡 Integration Examples

### Job Completion
```lua
-- Server
RegisterNetEvent('job:complete', function()
    local src = source
    exports.pickle_xp:AddPlayerXP(src, "farming", 100)
end)
```

### Level Requirement Check
```lua
-- Server
RegisterNetEvent('job:start', function()
    local src = source
    local level = exports.pickle_xp:GetPlayerLevel(src, "farming")
    if level >= 5 then
        -- Allow job
    else
        -- Reject
    end
end)
```

### Progress Display
```lua
-- Client
local xp = exports.pickle_xp:GetXP("farming")
local level = exports.pickle_xp:GetLevel("farming")
local nextXP = exports.pickle_xp:GetLevelXP("farming", level + 1)
local progress = math.floor((xp / nextXP) * 100)

print(string.format("Level %d - %d%% to next level", level, progress))
```

---

## 🗄️ Database Structure

```sql
player_xp
├─ identifier (varchar 46) PRIMARY KEY
└─ xp (longtext) JSON format

Example JSON:
{
    "farming": 1500,
    "mining": 800,
    "fishing": 2200
}
```

---

## 🎯 Best Practices

1. **Use appropriate XP amounts**: Don't give too much too fast
2. **Set reasonable max levels**: 20-50 is typical
3. **Use RegisterXPCategory**: For dynamic categories
4. **Check levels before actions**: Gate content by level
5. **Test XP progression**: Ensure it feels rewarding

---

## 📞 Common Issues

| Issue | Solution |
|-------|----------|
| XP not saving | Check oxmysql connection |
| Menu not opening | Verify ox_lib is loaded |
| Notifications not showing | Check Config.NotifyXP = true |
| Wrong framework detected | Set Config.Framework manually |

---

## 🔗 File Structure

```
pickle_xp/
├── fxmanifest.lua       - Resource manifest
├── config.lua           - Configuration
├── server.lua           - Server logic
├── client.lua           - Client logic
├── shared.lua           - Shared functions
├── bridge/              - Framework bridges
│   ├── qbx/            - QBox support
│   ├── esx/            - ESX support
│   ├── qb/             - QB-Core support
│   └── standalone/     - No framework
├── nui/                 - UI files
└── locales/             - Translations
```

---

## ⚡ Performance Tips

- Categories are cached client-side
- XP data loads only when needed
- Automatic cleanup on disconnect
- Efficient SQL queries with oxmysql

---

## 📚 Full Documentation

- [README.md](README.md) - Overview & features
- [INSTALL.md](INSTALL.md) - Installation guide
- [EXAMPLES.md](EXAMPLES.md) - Code examples
- [CHANGELOG.md](CHANGELOG.md) - Version history

---

**Version**: 1.1.0 | **Updated**: December 2025
