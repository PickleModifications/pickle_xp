Config = {}

Config.Language = "en"

Config.NotifyXP = true

Config.MenuCommand = "xpdisplay"

Config.Categories = {
    ["example"] = {
        label = "Example", -- Label of the category in the display & notifications.
        xpStart = 1000, -- Level 2 XP requirement.
        xpFactor = 0.5, -- Multiplier for much to increase the next level's XP requirement.
        maxLevel = 10 -- Maximum level achievable.
    },
}