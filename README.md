# Pickle XP - Modernized Edition
A standalone XP system with multi-framework support including **QBox**, ESX, QB-Core, and Standalone modes.

## 🎯 Features

- ✅ **QBox (qbx_core) Support** - Full compatibility with QBox framework
- ✅ **ESX & QB-Core Support** - Works with legacy frameworks
- ✅ **ox_lib Integration** - Modern notifications and UI
- ✅ **Auto SQL Injection** - Database tables created automatically on startup
- ✅ **oxmysql** - Modern async MySQL queries
- ✅ **Multi-character Support** - Uses framework-specific identifiers
- ✅ **Customizable Categories** - Define your own XP categories
- ✅ **Level Progression System** - Configurable XP curves

## 📦 Dependencies

- [oxmysql](https://github.com/overextended/oxmysql) - Required
- [ox_lib](https://github.com/overextended/ox_lib) - Required for notifications

## 🔧 Installation

1. Ensure `oxmysql` and `ox_lib` are installed and started before this resource
2. Drop `pickle_xp` into your resources folder
3. Add `ensure pickle_xp` to your server.cfg
4. The database table will be created automatically on first start
5. Configure your XP categories in `config.lua`

## ⚙️ Configuration

```lua
Config.Framework = 'auto' -- Options: 'auto', 'esx', 'qb', 'qbx', 'standalone'
Config.Language = "en"
Config.NotifyXP = true
Config.MenuCommand = "xpdisplay"

-- Add your own XP categories
Config.Categories = {
    ["firefighter"] = {
        label = "Firefighter", 
        xpStart = 1000,      -- Starting XP for level 1
        xpFactor = 0.2,      -- Multiplier for each level (20% increase)
        maxLevel = 2         -- Maximum level cap
    },
}
```

## 🎮 Usage

Open the XP menu with the command: `/xpdisplay`

## Preview

![image](https://user-images.githubusercontent.com/111543470/235329827-1ff416d5-a6b8-49a1-b911-baedb29a4599.png)

# 📚 Exports

## Client

### GetXPData(void)
```lua
local data = exports.pickle_xp:GetXPData()
-- Returns all XP data for all categories
```

### GetXP(name)
```lua
local xp = exports.pickle_xp:GetXP("farming")
print("Current XP:", xp)
```

### GetLevel(name)
```lua
local level = exports.pickle_xp:GetLevel("farming")
print("Current Level:", level)
```

## Shared

### GetLevelXP(name, level)
```lua
local nextLevelXP = exports.pickle_xp:GetLevelXP("farming", 2)
print("XP needed for level 2:", nextLevelXP)
```

### GetCategoryLevel(name)
```lua
local level = exports.pickle_xp:GetCategoryLevel("farming")
print("Category Level:", level)
```

## Server

### AddPlayerXP(source, name, xp)
```lua
-- Add 100 XP to player's farming category
exports.pickle_xp:AddPlayerXP(source, "farming", 100)
```

### RemovePlayerXP(source, name, xp)
```lua
-- Remove 50 XP from player's farming category
exports.pickle_xp:RemovePlayerXP(source, "farming", 50)
```

### SetPlayerXP(source, name, xp)
```lua
-- Set player's farming XP to exactly 1000
exports.pickle_xp:SetPlayerXP(source, "farming", 1000)
```

### GetPlayerXPData(source, name)
```lua
local data = exports.pickle_xp:GetPlayerXPData(source, "farming")
print("Level:", data.level, "XP:", data.xp)
```

### GetPlayerLevel(source, name)
```lua
local level = exports.pickle_xp:GetPlayerLevel(source, "farming")
print("Player Level:", level)
```

### InitializePlayerXP(source, cb)
```lua
exports.pickle_xp:InitializePlayerXP(source, function() 
  print("Player XP initialized")
end)
```

### RegisterXPCategory(name, label, xpStart, xpFactor, maxLevel)
```lua
-- Register a new XP category dynamically
exports.pickle_xp:RegisterXPCategory("mining", "Mining", 500, 0.3, 15)
```

## 🔄 Framework Support

The resource automatically detects your framework. Supported frameworks:
- **QBox (qbx_core)** - Latest QBox framework
- **ESX (es_extended)** - ESX Legacy
- **QB-Core (qb-core)** - QBCore framework
- **Standalone** - Works without any framework

## 📝 Credits

- **Original Author**: Pickle Mods
- **Modernization**: Updated for QBox, ox_lib, and oxmysql compatibility

## 📄 License

This is abandonware that has been modernized for current FiveM standards.
