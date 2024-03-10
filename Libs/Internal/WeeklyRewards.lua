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

function WeeklyRewards:CalculateMythicPlusWeeklyVault()
    print("Running Test...")
    
    local activities = C_WeeklyRewards.GetActivities(Enum.WeeklyRewardChestThresholdType.Activities)
    
    local lastCompletedIndex = 0
    for i, activityInfo in ipairs(activities) do
        if activityInfo.progress >= activityInfo.threshold then
            lastCompletedIndex = i
        end
    end
    
    print("-------------")
    print("Last Completed Index: ", lastCompletedIndex)
    
    local history = C_MythicPlus.GetRunHistory(false, true)
    sort(history, runCompare)
    
    for i,v in pairs(history) do
        history[i].mapName = C_ChallengeMode.GetMapUIInfo(v.mapChallengeModeID)
        history[i].mapLevel = v.level
        print(history[i].mapName,history[i].mapLevel)
    end
    
    local bestKeys = {}
    for i = 1, 8, 1 do
        if history[i] then
            print(history[i].level)
            bestKeys[i] = history[i].level
        end
    end
    KeyMaster:TPrint(bestKeys)
end