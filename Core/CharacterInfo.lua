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
            mapName = KeyMasterLocals.CHARACTERINFO["KeyInVault"].text
            keystoneLevel = 0
            -- todo: Tell player to get their vault key
        else
            mapid = 0
            mapName = KeyMasterLocals.CHARACTERINFO["AskMerchant"].text
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
-- This retry logic is done because the C_MythicPlus API is not always available right away and this frame depends on it.
local function fetchCharacterMythicPlusData(mapId, retryCount)
    if retryCount == nil then retryCount = 0 end
    local maxRetryCount = 5
    local retryDelay = 3
    
    local mapScore, bestOverallScore = C_MythicPlus.GetSeasonBestAffixScoreInfoForMap(mapId)
    if mapScore ~= nil then
        return mapScore, bestOverallScore
    else
        if retryCount < 5 then
            KeyMaster:_DebugMsg("fetchCharacterMythicPlusData", "CharacterInfo.lua", "Retrying to fetch mythic plus data after "..tostring(retryCount).." retries.")
            fetchCharacterMythicPlusData(mapId, retryCount + 1)            
        else
            KeyMaster:_ErrorMsg("fetchCharacterMythicPlusData", "CharacterInfo.lua", "Failed to fetch mythic plus data after "..tostring(retryCount).." retries.")
        end
    end
end

function CharacterInfo:GetMplusScoreForMap(mapid, weeklyAffix)
    if (weeklyAffix ~= KeyMasterLocals.TYRANNICAL and weeklyAffix ~= KeyMasterLocals.FORTIFIED) then
       KeyMaster:_ErrorMsg("GetMplusScoreForMap", "CharacterInfo", "Incorrect weeklyAffix value provided.")
       return nil
    end
    
    local emptyData = {
       name = weeklyAffix, --WeeklyAffix Name (e.g.; Tyran/Fort)
       score = 0, -- io gained
       level = 0, -- keystone level
       durationSec = 0, -- how long took to complete map
       overTime = false -- was completion overtime
    }
    
    local mapScore, bestOverallScore = C_MythicPlus.GetSeasonBestAffixScoreInfoForMap(mapid)
    -- this is true when a character has not ran a key for this map on either weekly affix.
    if (mapScore == nil) then
       return emptyData
    end
    -- No data means no keys ran on either weekly affix
    if mapScore[1] == nil and mapScore[2] == nil then
        KeyMaster:_ErrorMsg("GetMplusScoreForMap", "CharacterInfo.lua", "Failed to fetch score data for mapid "..mapid)
        return emptyData
    end
    
    -- This is setup this way because blizzard returns the data in a table with the first index being the weekly affix
    -- So on a tyrannical week mapScore[1] is for Tyrannical information and mapScore[2] is for Fortified information
    -- on a fortified week mapScore[1] is for Fortified information and mapScore[2] is for Tyrannical information
    if mapScore[1].name == weeklyAffix then
        if mapScore[1].name == KeyMasterLocals.FORTIFIED then
            mapScore[1].name = "Fortified"
        else
            mapScore[1].name = "Tyrannical"
        end
        return mapScore[1]
    else
        if mapScore[2] == nil then
            return emptyData
        else
            if mapScore[2].name == KeyMasterLocals.FORTIFIED then
                mapScore[2].name = "Fortified"
            else
                mapScore[2].name = "Tyrannical"
            end
            return mapScore[2]
        end
    end
end

function CharacterInfo:GetPlayerSpecialization(unitId)
    if (unitId == "player") then
        local specId = GetSpecialization()
        if (specId) then
            local _, specName, _, specIcon, specRole, _ = GetSpecializationInfo(specId)
            return specName
        end
    else
        local specId = GetInspectSpecialization(unitId)
        if (specId) then
            local _, specName, _, specIcon, specRole, _ = GetSpecializationInfoByID(specId)
            return specName
        end
    end
    return ""
end

-- Function gets only the available data from a unit e.g.; player or party1-4 that is available from Blizzards API
function CharacterInfo:GetUnitInfo(unitId)
    local unitData = {}
    unitData.GUID = UnitGUID(unitId)
    unitData.name = UnitName(unitId)
    unitData.realm = ""
    unitData.unitId = unitId
    unitData.hasAddon = false

    return unitData
end

function CharacterInfo:GetMyCharacterInfo()
    local myCharacterInfo = {}
    local keyId, _, keyLevel = CharacterInfo:GetOwnedKey()
    myCharacterInfo.GUID = UnitGUID("player")
    myCharacterInfo.name = UnitName("player")
    myCharacterInfo.realm = GetRealmName()
    myCharacterInfo.ownedKeyId = keyId
    myCharacterInfo.ownedKeyLevel = keyLevel
    myCharacterInfo.DungeonRuns = {}
    myCharacterInfo.mythicPlusRating = CharacterInfo:GetCurrentRating()
    myCharacterInfo.unitId = "player"
    myCharacterInfo.hasAddon = true
    myCharacterInfo.buildVersion = KM_AUTOVERSION
    myCharacterInfo.buildType = KM_VERSION_STATUS

    local seasonMaps = DungeonTools:GetCurrentSeasonMaps()
    for mapid, v in pairs(seasonMaps) do
        local keyRun = {}
        
        -- Overall Dungeon Score
        keyRun["bestOverall"] = CharacterInfo:GetDungeonOverallScore(mapid)

        -- Tyrannical Key Score
        local tyrannicalScoreInfo = CharacterInfo:GetMplusScoreForMap(mapid, KeyMasterLocals.TYRANNICAL)
        local dungeonDetails = {
            ["Rating"] = DungeonTools:CalculateRating(mapid, tyrannicalScoreInfo.level, tyrannicalScoreInfo.durationSec),
            ["Level"] = tyrannicalScoreInfo.level,
            ["DurationSec"] = tyrannicalScoreInfo.durationSec,
            ["IsOverTime"] = tyrannicalScoreInfo.overTime
        }
        keyRun["Tyrannical"] = dungeonDetails
        
        -- Fortified Key Score
        local fortifiedScoreInfo = CharacterInfo:GetMplusScoreForMap(mapid, KeyMasterLocals.FORTIFIED)
        local dungeonDetails = {
            ["Rating"] = DungeonTools:CalculateRating(mapid, fortifiedScoreInfo.level, fortifiedScoreInfo.durationSec),
            ["Level"] = fortifiedScoreInfo.level,
            ["DurationSec"] = fortifiedScoreInfo.durationSec,
            ["IsOverTime"] = fortifiedScoreInfo.overTime
        }
        keyRun["Fortified"] = dungeonDetails
        
        myCharacterInfo.DungeonRuns[mapid] = keyRun
    end

    KeyMaster:_DebugMsg("GetMyCharacterInfo", "CharacterInfo", "Character data fetched.")
    KeyMaster:TPrint(myCharacterInfo)
    return myCharacterInfo
end