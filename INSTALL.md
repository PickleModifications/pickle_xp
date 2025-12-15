# 🚀 Installation Guide - Pickle XP

## Prerequisites

Before installing Pickle XP, ensure you have the following:

1. **oxmysql** - [Download here](https://github.com/overextended/oxmysql)
2. **ox_lib** - [Download here](https://github.com/overextended/ox_lib)
3. A supported framework (QBox, ESX, QB-Core) or run standalone

---

## 📦 Step-by-Step Installation

### 1. Download Dependencies

```bash
# In your server resources folder
git clone https://github.com/overextended/oxmysql.git
git clone https://github.com/overextended/ox_lib.git
```

### 2. Install Pickle XP

Place the `pickle_xp` folder in your server's `resources` directory.

### 3. Update server.cfg

Add these lines to your `server.cfg` in the correct order:

```cfg
# Dependencies (must be loaded first)
ensure oxmysql
ensure ox_lib

# Framework (one of these)
ensure qbx_core      # For QBox
# OR
ensure es_extended   # For ESX
# OR
ensure qb-core       # For QB-Core

# Pickle XP (after dependencies and framework)
ensure pickle_xp
```

### 4. Configure the Resource

Edit `config.lua` to your preferences:

```lua
Config = {}

-- Framework: 'auto', 'esx', 'qb', 'qbx', or 'standalone'
Config.Framework = 'auto'  -- Recommended: leave as 'auto'

Config.Language = "en"

-- Show notifications when XP is gained/lost
Config.NotifyXP = true

-- Command to open XP display
Config.MenuCommand = "xpdisplay"

-- Use ox_lib context menu (true) or original NUI (false)
Config.UseOxLib = true

-- Define your XP categories
Config.Categories = {
    ["firefighter"] = {
        label = "Firefighter", 
        xpStart = 1000,      -- XP needed for level 1
        xpFactor = 0.2,      -- 20% increase per level
        maxLevel = 50        -- Maximum level
    },
    -- Add more categories as needed
}
```

### 5. Start Your Server

The resource will automatically:
- Create the `player_xp` database table if it doesn't exist
- Detect your framework
- Initialize the XP system

---

## 🔧 Framework-Specific Notes

### QBox (qbx_core)
```lua
Config.Framework = 'qbx'  -- or 'auto'
```
- Uses `citizenid` as identifier
- Integrates with QBCore:Client:OnPlayerLoaded event
- ox_lib notifications supported

### ESX (es_extended)
```lua
Config.Framework = 'esx'  -- or 'auto'
```
- Uses `identifier` (license) as identifier
- Integrates with esx:playerLoaded event
- ox_lib notifications supported

### QB-Core (qb-core)
```lua
Config.Framework = 'qb'  -- or 'auto'
```
- Uses `citizenid` as identifier
- Integrates with QBCore:Client:OnPlayerLoaded event
- ox_lib notifications supported

### Standalone
```lua
Config.Framework = 'standalone'  -- or 'auto'
```
- Uses first player identifier (usually license)
- No framework events
- Initializes after 1 second delay

---

## 🎮 Usage

### In-Game Commands

- `/xpdisplay` - Opens the XP menu (command is configurable)

### For Developers

See [EXAMPLES.md](EXAMPLES.md) for comprehensive code examples.

Quick example:
```lua
-- Server-side: Award XP
exports.pickle_xp:AddPlayerXP(source, "firefighter", 100)

-- Client-side: Check level
local level = exports.pickle_xp:GetLevel("firefighter")
```

---

## 🗄️ Database

The database table is created automatically on first start:

```sql
CREATE TABLE IF NOT EXISTS `player_xp` (
    `identifier` varchar(46) NOT NULL,
    `xp` longtext DEFAULT NULL,
    PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

**No manual SQL import required!**

---

## ✅ Verification

After installation, check the server console for:

```
^2[Pickle XP]^7 Database table verified/created successfully
```

You should also see:
- No SQL errors
- Framework detection message (if using auto-detect)

---

## 🐛 Troubleshooting

### "MySQL is undefined" Error
- Ensure `oxmysql` is started **before** pickle_xp
- Check server.cfg load order

### "lib is undefined" Error
- Ensure `ox_lib` is started **before** pickle_xp
- Check server.cfg load order

### Framework Not Detected
- Set `Config.Framework` manually instead of 'auto'
- Ensure your framework is started **before** pickle_xp

### Menu Not Opening
- Check the command in Config.MenuCommand
- If using ox_lib menu, ensure ox_lib is properly loaded
- Try setting `Config.UseOxLib = false` to use original NUI

### Database Connection Issues
- Verify your oxmysql configuration
- Check database credentials in your server.cfg
- Ensure MySQL server is running

---

## 🔄 Updating from Old Version

If you're updating from the original pickle_xp (v1.0.4):

1. **Backup your config.lua** - Save your XP categories
2. Replace all files except `config.lua`
3. Add new config options (Framework, UseOxLib)
4. Update server.cfg dependencies (mysql-async → oxmysql)
5. Restart server

**Your existing player XP data will be preserved!**

---

## 📞 Support

For issues or questions:
1. Check [EXAMPLES.md](EXAMPLES.md) for usage help
2. Review [CHANGELOG.md](CHANGELOG.md) for recent changes
3. Verify installation steps above

---

## 🎉 You're Done!

Your XP system is now ready to use! Players can use `/xpdisplay` to view their XP, and you can integrate it into your scripts using the exports.

Happy coding! 🚀
