function GetLevelXP(index, level)
    local category = Categories[index]
    if not category then return 0 end
    local currentLevel = 1
    local required = category.xpStart
    while currentLevel ~= level do 
        currentLevel = currentLevel + 1
        if category.maxLevel == currentLevel - 1 then 
            break
        end
        required = required + (required * category.xpFactor)
        Wait(0)
    end
    return math.ceil(required)
end

function GetCategoryLevel(index, xp)
    local category = Categories[index]
    if not category then return 0 end
    local currentLevel = 1
    local lastLevel = 1
    local required = category.xpStart
    while required <= xp do 
        lastLevel = currentLevel
        currentLevel = currentLevel + 1
        required = required + (required * category.xpFactor)
        if category.maxLevel == lastLevel then 
            currentLevel = lastLevel
            break
        end
        Wait(0)
    end
    return math.ceil(currentLevel)
end

exports("GetLevelXP", GetLevelXP)
exports("GetCategoryLevel", GetCategoryLevel)