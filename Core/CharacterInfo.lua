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
    myCharacterInfo.charLevel = UnitLevel("player")
    myCharacterInfo.DungeonRuns = {}
    myCharacterInfo.mythicPlusRating = CharacterInfo:GetCurrentRating()
    myCharacterInfo.unitId = "player"
    myCharacterInfo.hasAddon = true
    myCharacterInfo.buildVersion = KM_AUTOVERSION
    myCharacterInfo.buildType = KM_VERSION_STATUS

    local seasonMaps = DungeonTools:GetCurrentSeasonMaps()
    for mapid, v in pairs(seasonMaps) do
        local keyRun = {}

        -- empty data set
        local emptyData = {
            Rating = 0, -- rating
            Level = 0, -- keystone level
            DurationSec = 0, -- how long took to complete map
            overTime = false -- was completion overtime
        }

        local mapScore, bestOverallScore = C_MythicPlus.GetSeasonBestAffixScoreInfoForMap(mapid)
        if (mapScore == nil or mapScore[1] == nil) then
            keyRun["bestOverall"] = 0
            keyRun["DungeonData"] = emptyData            
        else
            for i,v in pairs(mapScore) do
                -- Only gets the highest score data, instead of each data set for level 4 affix.
                if (v.score == bestOverallScore) then
                    local dungeonDetails = {
                        ["Rating"] = DungeonTools:CalculateRating(mapid, v.level, v.durationSec),
                        ["Level"] = v.level,
                        ["DurationSec"] = v.durationSec,
                        ["overTime"] = v.overTime
                    }
                    keyRun["DungeonData"] = dungeonDetails
                end
            end
            
            keyRun["bestOverall"] = bestOverallScore        
        end 
        myCharacterInfo.DungeonRuns[mapid] = keyRun       
    end

    KeyMaster:_DebugMsg("GetCharInfo", "CharacterInfo", "Character data fetched.")
    return myCharacterInfo
end