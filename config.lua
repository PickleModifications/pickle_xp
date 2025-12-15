Config = {}

-- Framework Settings (auto-detect if left as 'auto')
-- Options: 'auto', 'esx', 'qb', 'qbx', 'standalone'
Config.Framework = 'auto'

Config.Language = "en"

Config.NotifyXP = true

Config.MenuCommand = "xpdisplay"

-- Use ox_lib context menu instead of NUI (set to false for original NUI)
Config.UseOxLib = true

Config.Categories = {
    ["firefighter"] = {
        label = "Firefighter", 
        xpStart = 1000, 
        xpFactor = 0.2, 
        maxLevel = 2
    },
}