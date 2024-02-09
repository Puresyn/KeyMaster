--------------------------------
-- KMPlayerInfo.lua
-- Handles any player related functions
--------------------------------

--------------------------------
-- Namespace
--------------------------------
local _, core = ...
core.PlayerInfo = {}
local PlayerInfo = core.PlayerInfo

--------------------------------
-- Data Queries
--------------------------------
-- Is the current character max level
function PlayerInfo:IsMaxLevel()
    if (UnitLevel("player") == GetMaxPlayerLevel()) then
        return true
    else
        return false
    end
end

-- Retrieve the color for the class that blizzard has set.
function PlayerInfo:GetMyClassColor(unit)
    local c,p 
    if (not unit) then unit = "player" end
    local _, myClass, _ = UnitClass(unit)
    local c = string.sub(select(4, GetClassColor(myClass)), 3, -1)
    return c
end

----------------------------------
function PlayerInfo:GetMyCharacterInfo()
    local myCharacterInfo = {}
    local id, _, level = PlayerInfo:GetOwnedKey()
    myCharacterInfo.GUID = UnitGUID("player")
    myCharacterInfo.name = UnitName("player")
    myCharacterInfo.ownedKeyId = id
    myCharacterInfo.ownedKeyLevel = level
    myCharacterInfo.keyRuns = {}

    local seasonMaps = PlayerInfo:GetCurrentSeasonMaps()
    for mapid, v in pairs(seasonMaps) do
        local keyRun = {}
        keyRun["bestOverall"] = "BESTKEYHERE" -- TODO: get value from Data:GetMplusScoreForMap
        --print()
        --print("Processing: " .. Data:GetMapName(mapid))
        --print ("MapID: " .. mapid)
        --print()
        
        local scoreInfo = PlayerInfo:GetMplusScoreForMap(mapid, "Tyrannical")   
        local dungeonDetails = {
            ["Score"] = scoreInfo.score,
            ["Level"] = scoreInfo.level,
            ["DurationSec"] = scoreInfo.duration,
            ["IsOverTime"] = scoreInfo.overTime
        }
        keyRun["Tyrannical"] = dungeonDetails
        
        local scoreInfo = PlayerInfo:GetMplusScoreForMap(mapid, "Fortified")
        local dungeonDetails = {
            ["Score"] = scoreInfo.score,
            ["Level"] = scoreInfo.level,
            ["DurationSec"] = scoreInfo.duration,
            ["IsOverTime"] = scoreInfo.overTime
        }
        keyRun["Fortified"] = dungeonDetails
        
        myCharacterInfo.keyRuns[mapid] = keyRun
    end

    return myCharacterInfo
end

-- Query what key the character has in bags, if any.
function PlayerInfo:GetOwnedKey()
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

-- Retrieve from API the current active player's M+ score.
function PlayerInfo:GetCurrentRating()
    local r = C_ChallengeMode.GetOverallDungeonScore()
    return r
end

-- Retrieve current affixes
function PlayerInfo:GetAffixes()
    local i = 0
    local a, id, name, desc, filedataid
    local affixData = {}
    local affixes = C_MythicPlus.GetCurrentAffixes()
    for i=1, #affixes, i+1 do
        id = affixes[i].id
        name, desc, filedataid = C_ChallengeMode.GetAffixInfo(id)
        affixData[i] = {
            ["id"] = id,
            ["name"] = name,
            ["desc"] = description,
            ["filedataid"] = filedataid
        }
    end
    return affixData
end

-- build a current mplus season map table
function PlayerInfo:GetCurrentSeasonMaps()
    m = C_ChallengeMode.GetMapTable();
    
    local mapTable = {}
    for i,v in ipairs(m) do
       name, id, timeLimit, texture, backgroundTexture = C_ChallengeMode.GetMapUIInfo(v)
       mapTable[id] = {
          ["name"] = name,
          ["timeLimit"] = timeLimit,
          ["texture"] = texture,
          ["backgroundTexture"] = backgroundTexture
       }
    end
    
    return mapTable  
 end

-- returns tablehash of score, level, ... for a certain dungeon and affix combo
function PlayerInfo:GetMplusScoreForMap(mapid, weeklyAffix)
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
       print("mapScore returned nil")
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

-- Returns name of map based on passed mapid
-- Returns nil if not found
function PlayerInfo:GetMapName(mapid)
    name,_,_,_,_ = C_ChallengeMode.GetMapUIInfo(mapid)

    if (name == nil) then
        print("Unable to find mapname for id " .. mapid)   
        return nil   
    end

    return name
end