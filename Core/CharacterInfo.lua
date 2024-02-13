local _, KeyMaster = ...
KeyMaster.CharacterInfo = {}
local CharacterInfo = KeyMaster.CharacterInfo
local DungeonTools = KeyMaster.DungeonTools

function CharacterInfo:GetMyClassColor(unit)
    local c,p 
    if (not unit) then unit = "player" end
    local _, myClass, _ = UnitClass(unit)
    local c = string.sub(select(4, GetClassColor(myClass)), 3, -1)
    return c
end

function CharacterInfo:IsMaxLevel()
    if (UnitLevel("player") == GetMaxPlayerLevel()) then
        return true
    else
        return false
    end
end

function CharacterInfo:GetDungeonOverallScore(mapid)
    local mapScore, bestOverallScore = C_MythicPlus.GetSeasonBestAffixScoreInfoForMap(mapid)
    if (not bestOverallScore) then bestOverallScore = 0 end

    return bestOverallScore
end

function CharacterInfo:GetOwnedKey()
    local mapid = C_MythicPlus.GetOwnedKeystoneChallengeMapID()
    local keystoneLevel, mapName

    if (mapid) then
        -- key found in bags
        -- Get Data
        -- name, id, timeLimit, texture, backgroundTexture = C_ChallengeMode.GetMapUIInfo(i)
        -- todo: search local table (KMPlayerInfo:GetCurrentSeasonMaps()) instead of querying for new data
        mapName, _, _, _, _ = C_ChallengeMode.GetMapUIInfo(mapid)
        keystoneLevel = C_MythicPlus.GetOwnedKeystoneLevel(mapid)        
    else
        -- No key but has Vault Ready
        if (C_MythicPlus.IsWeeklyRewardAvailable()) then
            mapid = 0
            mapName = "In Vault"
            keystoneLevel = 0
            -- todo: Tell player to get their vault key
        else
            mapid = 0
            mapName = "Ask Key Merchant"
            keystoneLevel = 0
            -- No Key Available, no vault available
            -- todo: Notify player (if max level) to go get a key from merchant
        end
    end  

    return mapid, mapName, keystoneLevel
end

function CharacterInfo:GetCurrentRating()
    local r = C_ChallengeMode.GetOverallDungeonScore()
    return r
end

function CharacterInfo:GetMplusScoreForMap(mapid, weeklyAffix)
    local mapScore, bestOverallScore = C_MythicPlus.GetSeasonBestAffixScoreInfoForMap(mapid)
    
    if (weeklyAffix ~= "Tyrannical" and weeklyAffix ~= "Fortified") then
       print("Incorrect weeklyAffix value in GetMplusScoreForMap function")
       return nil   
    end
    
    local emptyData = {
       name = weeklyAffix, --WeeklyAffix Name (e.g.; Tyran/Fort)
       score = 0, -- io gained
       level = 0, -- keystone level
       durationSec = 0, -- how long took to complete map
       overTime = false -- was completion overtime
    }
    
    -- Check for empty key runs such as a character that hasn't run any M+ or a particular dungeon/affix combo
    if (mapScore == nil) then
       --print("mapScore returned nil")       
       return emptyData
    end   
    
    if(weeklyAffix == "Tyrannical") then
       if (mapScore[2] == nil) then
          --print ("No Tyrannical Key found.")
          return emptyData
       end
       
       return mapScore[2]
    end
    
    if(weeklyAffix == "Fortified") then
       if (mapScore[1] == nil) then
          -- print ("No Fortified Key found.")
          return emptyData
       end
       
       return mapScore[1]
    end
    
    return nil
end

function CharacterInfo:GetMyCharacterInfo()
    local myCharacterInfo = {}
    local keyId, _, keyLevel = CharacterInfo:GetOwnedKey()
    myCharacterInfo.GUID = UnitGUID("player")
    myCharacterInfo.name = UnitName("player")
    myCharacterInfo.ownedKeyId = keyId
    myCharacterInfo.ownedKeyLevel = keyLevel
    myCharacterInfo.DungeonRuns = {}
    myCharacterInfo.mythicPlusRating = CharacterInfo:GetCurrentRating()

    local seasonMaps = DungeonTools:GetCurrentSeasonMaps()
    for mapid, v in pairs(seasonMaps) do
        local keyRun = {}
        
        -- DEBUG OUTPUT
        -- print()
        -- print("Processing: " .. PlayerInfo:GetMapName(mapid))
        -- print ("MapID: " .. mapid)
        -- print()
        
        -- Overall Dungeon Score
        myCharacterInfo.DungeonRuns["bestOverall"] = CharacterInfo:GetDungeonOverallScore(mapid)

        -- Tyrannical Key Score
        local scoreInfo = CharacterInfo:GetMplusScoreForMap(mapid, "Tyrannical")   
        local dungeonDetails = {
            ["Score"] = scoreInfo.score,
            ["Level"] = scoreInfo.level,
            ["DurationSec"] = scoreInfo.durationSec,
            ["IsOverTime"] = scoreInfo.overTime
        }
        myCharacterInfo.DungeonRuns["Tyrannical"] = dungeonDetails
        
        -- Fortified Key Score
        local scoreInfo = CharacterInfo:GetMplusScoreForMap(mapid, "Fortified")
        local dungeonDetails = {
            ["Score"] = scoreInfo.score,
            ["Level"] = scoreInfo.level,
            ["DurationSec"] = scoreInfo.durationSec,
            ["IsOverTime"] = scoreInfo.overTime
        }
        myCharacterInfo.DungeonRuns["Fortified"] = dungeonDetails
        
        myCharacterInfo.DungeonRuns[mapid] = keyRun
    end

    return myCharacterInfo
end