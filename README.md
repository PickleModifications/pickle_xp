# Pickle XP
A standalone XP system, supports ESX &amp; QB Multicharacter Identifiers.

## Preview

![image](https://user-images.githubusercontent.com/111543470/235329827-1ff416d5-a6b8-49a1-b911-baedb29a4599.png)

# Exports

## Client

### GetXPData(void)
```lua
GetXPData()
```
### GetXP(name)
```lua
local data = GetXP("farming")
print(data.level, data.xp)
```
### GetLevel(name)
```lua
local level = GetLevel("farming")
print(level)
```

## Shared

### GetLevelXP(name, level)
```lua
local nextLevelXP = GetLevelXP("farming", 1)
print(nextLevelXP)
```
### GetCategoryLevel(name)
```lua
local level = GetCategoryLevel("farming")
print(level)
```

## Server

### AddPlayerXP(source, name, xp)
```lua
AddPlayerXP(source, "farming", 1000)
```
### RemovePlayerXP(source, name, xp)
```lua
RemovePlayerXP(source, "farming", 1000)
```
### SetPlayerXP(source, name, xp)
```lua
SetPlayerXP(source, "farming", 1000)
```
### GetPlayerXPData(source, name)
```lua
local data = GetPlayerXPData(source, "farming")
print(data.level, data.xp)
```
### GetPlayerLevel(source, name)
```lua
local level = GetPlayerLevel(source, "farming")
print(level)
```
### InitializePlayerXP(source, cb)
```lua
InitializePlayerXP(source, function() 
  -- Player initialized.
end)
```
### RegisterXPCategory(name, label, xpStart, xpFactor, maxLevel)
```lua
RegisterXPCategory("farming", "Farming", 1000, 0.5, 10)
```
