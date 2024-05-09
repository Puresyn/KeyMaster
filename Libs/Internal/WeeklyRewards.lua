local _, KeyMaster = ...
KeyMaster.WeeklyRewards = {}
local WeeklyRewards = KeyMaster.WeeklyRewards

local function runCompare(left, right)
    if left.level == right.level then
        return left.mapChallengeModeID < right.mapChallengeModeID
    else
        return left.level > right.level
    end
end

function WeeklyRewards:GetVaultThresholds(eventTypeId)
    local activities = C_WeeklyRewards.GetActivities(eventTypeId)
    local thresholds = {}
    for i, activityInfo in ipairs(activities) do
        tinsert(thresholds, activityInfo.threshold)
    end
    return thresholds
end
function WeeklyRewards:GetMythicPlusWeeklyVaultTopKeys()
    local MythicPlusEventTypeId = 1
    local thresholds = WeeklyRewards:GetVaultThresholds(MythicPlusEventTypeId)

    local history = C_MythicPlus.GetRunHistory(false, true)
    sort(history, runCompare)

    for i,v in pairs(history) do
        history[i].mapName = C_ChallengeMode.GetMapUIInfo(v.mapChallengeModeID)
        history[i].mapLevel = v.level
    end

    -- stops error but returns false data (aka no data)
    if #thresholds == 0 then
        return {}
    end

    local bestKeys = {}
    for i = 1, thresholds[#thresholds], 1 do
        if history[i] then
            bestKeys[i] = history[i].level
        end
    end
    
    return bestKeys
end

function WeeklyRewards:GetNumMythicZeroRuns()
    local _, mZeros, _ = C_WeeklyRewards.GetNumCompletedDungeonRuns()
    if not mZeros then mZeros = 0 end
    return mZeros
end