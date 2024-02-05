--------------------------------
-- KMData.lua
-- Handles all in-game addon data funcitons
--------------------------------

--------------------------------
-- Namespace
--------------------------------
local _, core = ...
core.Data = {}
core.Data.PlayerInfo = {}

local Data = core.Data
local dataCheck = false
local myPlayerName = UnitName("player")
local myRealmName = GetRealmName()
local _, myClass, _ = UnitClass("player")

--------------------------------
-- Character Data Queries and party info
--------------------------------

--[[ local function PopulateRunData(playerData, runInfo)

    for i=1, #runInfo, i+1 do
        keyRuns = {
            [runInfo[i].id] = {
                ["name"] = "",
                ["score"] = runInfo[i].score,
                ["level"] = runInfo[i].level,
                ["durationSec"] = runInfo[i].durationSec,
                ["overTime"] = runInfo[i].overTime,
                ["bestOverallScore"] = runInfo[i].bestOverAllScore
            }
        }
        tinsert(keyRuns, playerData)
    end

    return playerData
end ]]



function Data:SetPlayerData(playerInfo, keyInfo, runInfo, ...)
    -- playerData Stuct for addon communication and data display
    if (not playerInfo and keyInfo and runInfo) then return end

    playerData = {
        ["characterGUID"] = playerInfo.characterGUID, -- (int)
        ["name"] = playerInfo.name, -- (str)
        ["ownedKeyId"] = keyInfo.ownedKeyId, -- (int)
        ["ownedKeyLevel"] = keyInfo.ownedKeyLevel, -- (int)
        ["keyRuns"] = {}
    }

    for i=1, #runInfo, i+1 do
        keyRuns = {
            [runInfo[i].id] = {
                ["name"] = "",
                ["Affix"] = "",
                ["score"] = runInfo[i].score,
                ["level"] = runInfo[i].level,
                ["durationSec"] = runInfo[i].durationSec,
                ["overTime"] = runInfo[i].overTime,
                ["bestOverallScore"] = runInfo[i].bestOverAllScore
            }
        }
        tinsert(keyRuns, playerData.keyRuns)
    end

    return playerData
end

--------------------------------
-- Data Queries
--------------------------------
-- Is the current character max level
function Data:IsMaxLevel()
    if (UnitLevel("player") == GetMaxPlayerLevel()) then
        return true
    else
        return false
    end
end

-- Retrieve the color for the class that blizzard has set.
function Data:GetMyClassColor()
    local c
    local _, myClass, _ = UnitClass("player")
    local c = string.sub(select(4, GetClassColor(myClass)), 3, -1)
    return c
end

-- Query what key the character has in bags, if any.
function Data:GetOwnedKey()
    local mapid = C_MythicPlus.GetOwnedKeystoneChallengeMapID()
    local keystoneLevel, mapname

    if (mapid) then
        -- key found in bags
        -- Get Data
        -- name, id, timeLimit, texture, backgroundTexture = C_ChallengeMode.GetMapUIInfo(i)
        -- todo: search local table (Data:GetCurrentSeasonMaps()) instead of querying for new data
        mapName, _, _, _, _ = C_ChallengeMode.GetMapUIInfo(mapid)
        keystoneLevel = C_MythicPlus.GetOwnedKeystoneLevel(mapid)        
    else
        -- No key but has Vault Ready
        if (C_MythicPlus.IsWeeklyRewardAvailable()) then
            mapid = 0
            mapName = "In Vault"
            keystoneLevel = 0
            -- todo: Tell player to get their vault key or go ask key merchant for one
        else
            mapid = 0
            mapName = "Ask Key Merchant"
            keystoneLevel = 0
            -- No Key Available, no vault available
            -- todo: Notify player (if max level) to go get a key from merchant
        end
    end  

    return mapid, mapname, keystoneLevel
end

-- Not Used
-- See GetCurrentSeasonMaps()
local function buildMapTable(...)
    -- todo: check, build, and store season map data
    -- https://wowpedia.fandom.com/wiki/Category:API_namespaces/C_ChallengeMode
end

-- Retrieve from API the current active player's M+ score.
function Data:GetCurrentRating()
    local r = C_ChallengeMode.GetOverallDungeonScore()
    return r
end

-- Retrieve current affixes
-- https://wowpedia.fandom.com/wiki/API_C_MythicPlus.GetCurrentAffixes
-- Note (info may be outdated): This function will return nil until C_MythicPlus.RequestMapInfo() is called.
-- Though there is a corresponding C_MythicPlus.RequestCurrentAffixes() it does not appear to have any impact.
-- name, description, filedataid = C_ChallengeMode.GetAffixInfo(affixID)
function Data:GetAffixes()
    local i = 0
    local a, id, name, desc, filedataid
    local out = {}
    a = C_MythicPlus.GetCurrentAffixes()
    for i=1, #a, i+1 do
        id = a[i].id
        name, desc, filedataid = C_ChallengeMode.GetAffixInfo(id)
        out[i] = {
            ["id"] = id,
            ["name"] = name,
            ["desc"] = description,
            ["filedataid"] = filedataid
        }
    end
    return out
end

-- build a current season map table pulled from the API
function Data:GetCurrentSeasonMaps()
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
-- 
function Data:GetMplusScoreForMap(mapid, weeklyAffix)
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
function Data:GetMapName(mapid)
    m = C_ChallengeMode.GetMapTable();
    if (not m) then 
       print("Cannot find mapid " .. mapid .. "in Data;GetMapName function.")
       return 
    end
    
    local mapTable = {}
    for i,v in ipairs(m) do
       name,id,_,_,_ = C_ChallengeMode.GetMapUIInfo(v)
       if (id == mapid) then
          return name   
       end
    end
    
    return nil
 end

----------------------------------
function Data:GetMyCharacterInfo()
    local myCharacterInfo = {}
    local id, _, level = Data:GetOwnedKey()
    myCharacterInfo.GUID = UnitGUID("player")
    myCharacterInfo.name = UnitName("player")
    myCharacterInfo.ownedKeyId = id
    myCharacterInfo.ownedKeyLevel = level
    myCharacterInfo.keyRuns = {}

    local seasonMaps = Data:GetCurrentSeasonMaps()
    for mapid, v in pairs(seasonMaps) do
        local keyRun = {}
        keyRun["bestOverall"] = "BESTKEYHERE" -- TODO: get value from Data:GetMplusScoreForMap
        --print()
        --print("Processing: " .. Data:GetMapName(mapid))
        --print ("MapID: " .. mapid)
        --print()
        
        local scoreInfo = Data:GetMplusScoreForMap(mapid, "Tyrannical")   
        local dungeonDetails = {
            ["Score"] = scoreInfo.score,
            ["Level"] = scoreInfo.level,
            ["DurationSec"] = scoreInfo.duration,
            ["IsOverTime"] = scoreInfo.overTime
        }
        keyRun["Tyrannical"] = dungeonDetails
        
        local scoreInfo = Data:GetMplusScoreForMap(mapid, "Fortified")
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

core.Data.PlayerInfo[1] = Data:GetMyCharacterInfo()
--core.Data.PartyInfo = {}


--------------------------------
-- Saved Variables
--------------------------------
-- todo: Evaluate data storage hiarchy and create a code library to validate, store, retrieve, and access it.
-- todo: Use player characters GUID for storage instead of a name. Names can be changed.
-- -I don't belive a GUID can be?
-- name = set characters's name, curKey = keyID | keyLevel, realm = character's realm,
-- myCharacter = is this the player's character or a team member, maxlevel = is this character max level,
-- teamNames = name of teams this character is in.
KeyMaster_DB = {
	characters = {
		[1] = {name = format(myPlayerName, 1), curKey = "0|0", realm = myRealmName, myCharacter = true, maxLevel = Data:IsMaxLevel(), teamNames = ""}
	},
    -- may not be needed? This identifies in saved variables the character they are currently on. (Game crashes will corrupt this)
    -- May be better to use the GUID - UnitGUID("player") - as the index and query Saved Variables based on that?
	currentCharacter = 1
}

-- Unused: Was thought to use this as an overall (Did any data screw up on load) check.
-- - If so, show some kind of "Fix Me" screen.
function Data:Init()
    -- todo: return data query success validation
    return dataCheck
end

-- Function to dump tablehash data
function tprint (tbl, indent)
    if not indent then indent = 0 end
    for k, v in pairs(tbl) do
       formatting = string.rep("  ", indent) .. k .. ": "
       if type(v) == "table" then
          print(formatting)
          tprint(v, indent+1)
       elseif type(v) == 'boolean' then
          print(formatting .. tostring(v))      
       else
          print(formatting .. v)
       end
    end
 end