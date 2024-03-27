local _, KeyMaster = ...
KeyMaster.DungeonTools = {}
local DungeonTools = KeyMaster.DungeonTools
local Theme = KeyMaster.Theme

local maxModifier = 0.4

--------------------------------
-- Challenge Dungeon Instance Abbreviations.
-- Must be manually maintained.
--------------------------------
--[[ local instanceAbbrTable = {
    [463] = "FALL",     -- Dawn of the Infinite: Galakrond's Fall
    [464] = "RISE",     -- Dawn of the Infinite: Murozond's Rise
    [244] = "AD",       -- Atal'Dazar
    [248] = "WCM",      -- Waycrest Manor
    [199] = "BRH",      -- Black Rook Hold
    [198] = "DHT",      -- Darkheart Thicket
    [168] = "EB",       -- The Everbloom
    [456] = "ToTT"       -- Throne of the Tides
}

function DungeonTools:instanceAbbrs()
    return instanceAbbrTable
end ]]

--------------------------------
-- Dungeon Portal spell IDs
-- Must be manually maintained.
--------------------------------
local portalSpellIds = {
    [463] = 424197,     -- Dawn of the Infinite: Galakrond's Fall
    [248] = 424167,     -- Waycrest Manor
    [244] = 424187,     -- Atal'Dazar
    [198] = 424163,     -- Darkheart Thicket
    [199] = 424153,     -- Black Rook Hold
    [464] = 424197,     -- Dawn of the Infinite: Murozond's Rise
    [456] = 424142,     -- Throne of Tides
    [168] = 159901,     -- The Everbloom
    [399] = 393256,     -- Ruby Life Pools
    [400] = 393262,     -- The Nokhud Offensive
    [401] = 393279,     -- The Azure Vault
    [402] = 393273,     -- Algeth'ar Academy
    [403] = 393222,      -- Legacy of Tyr
    [404] = 393276,     -- Neltharus
    [405] = 393267,     -- Brackenhide Hollow
    [406] = 393283      -- Halls of Infusion

}

function DungeonTools:portalSpells()
    return portalSpellIds
end

-- Gets a list of the current weeks affixes.
local weeklyAffixs = nil
function DungeonTools:GetAffixes()
    if weeklyAffixs ~= nil then return weeklyAffixs end
    local affixData = {}
    local affixes = C_MythicPlus.GetCurrentAffixes() -- Bug when this returned nils?
    if (affixes == nil) then return nil end
    for i=1, #affixes, 1 do
       local id = affixes[i].id
       local name, desc, filedataid = C_ChallengeMode.GetAffixInfo(id)
       
       local data = {
          ["id"] = id,
          ["name"] = name,
          ["desc"] = desc,
          ["filedataid"] = filedataid
       }
       tinsert(affixData, data)
    end
    weeklyAffixs = affixData -- stores locally to prevent multiple api calls
    return affixData
 end

 -- Retrieves a dungeon's name by map id.
function DungeonTools:GetMapName(mapid)
    local name,_,_,_,_ = C_ChallengeMode.GetMapUIInfo(mapid)

    if (name == nil) then
        KeyMaster:_ErrorMsg("GetMapName", "DungeonTools", "Unable to find mapname for id " .. mapid)   
        return nil   
    end

    return name
end

-- FUNCTION NOTE:
-- C_MythicPlus.GetCurrentSeason()
-- Returns the current Mythic Plus season. Returns -1 until C_MythicPlus.RequestMapInfo() is called at least once.
-- Returns 0 when there is no active season. (To be confirmed)
-- source: https://wowpedia.fandom.com/wiki/API_C_MythicPlus.GetCurrentSeason
local currentSeason
function DungeonTools:GetCurrentSeason(retryCount)
    if currentSeason ~= nil and currentSeason ~= -1 then return currentSeason end
    if retryCount == nil then retryCount = 0 end
    local maxRetryCount = 5    
    
    local seasonNumber = C_MythicPlus.GetCurrentSeason()
    if seasonNumber ~= nil and seasonNumber ~= -1 then
        currentSeason = seasonNumber -- stores locally to prevent multiple api calls
        return currentSeason
    else
        if retryCount < maxRetryCount then
            C_MythicPlus.RequestMapInfo()
            C_Timer.After(3, function() DungeonTools:GetCurrentSeason(retryCount + 1) end)
        else
            KeyMaster:_ErrorMsg("GetCurrentSeason", "DungeonTools.lua", "Failed to get data from C_MythicPlus.GetCurrentSeason() after " .. maxRetryCount .. " retries.")
            return -1
        end
    end
end

-- Gets a list of the live seasons challenge maps
local currentSeasonMaps
function DungeonTools:GetCurrentSeasonMaps()
    if currentSeasonMaps ~= nil and KeyMaster:GetTableLength(currentSeasonMaps) > 0 then 
        return currentSeasonMaps 
    end

    local maps = C_ChallengeMode.GetMapTable();
    
    local mapTable = {}
    for i,v in ipairs(maps) do
       local name, id, timeLimit, texture, backgroundTexture = C_ChallengeMode.GetMapUIInfo(v)
       mapTable[id] = {
            ["id"] = id,
            ["name"] = name,
            ["timeLimit"] = timeLimit,
            ["texture"] = texture,
            ["backgroundTexture"] = backgroundTexture
       }
    end
    
    currentSeasonMaps = mapTable -- stores locally to prevent multiple api calls
    return mapTable  
end

-- conversion from mapid to abbreviation
function DungeonTools:GetDungeonNameAbbr(mapId --[[int]])
    local a
    if KeyMasterLocals.MAPNAMES[mapId] then
        a = KeyMasterLocals.MAPNAMES[mapId].abbr
    else
        a = KeyMasterLocals.MAPNAMES[9001].abbr
    end
    return a
end

-- Finds portal spells, checks if the client has it and retruns it's information
function DungeonTools:GetPortalSpell(dungeonID)
    local portalSpellId = portalSpellIds[dungeonID]
    if (not portalSpellId) then return nil end -- mapID missing from portalSpellIds table

    local portalSpellName

    local isKnown = IsSpellKnown(portalSpellId)
    if (not isKnown) then
        return nil
    else
        portalSpellName, _ = GetSpellInfo(portalSpellId) -- name, rank, icon, castTime, minRange, maxRange, spellID, originalIcon
        return portalSpellId, portalSpellName
    end
end

 -- Set color of week and off-week key data
 function DungeonTools:GetWeekColor(currentAffix)
    local weeklyAffix, weekColor, offWeekColor, myColor
    local wc = {}
    local cw = {}
    local ow = {}
    cw.r, cw.g, cw.b, _ = Theme:GetThemeColor("party_CurrentWeek")
    ow.r, ow.g, ow.b, _ = Theme:GetThemeColor("party_OffWeek")
    weeklyAffix = DungeonTools:GetAffixes()
    if (weeklyAffix == nil) then
        return 1,1,1
    end
    if(weeklyAffix[1].name == currentAffix) then
        wc.r = cw.r
        wc.g = cw.g
        wc.b = cw.b
    else
        wc.r = ow.r
        wc.g = ow.g
        wc.b = ow.b
    end
    return wc.r, wc.g, wc.b
end

-- Set the font face of the week and off-week key data
function DungeonTools:GetWeekFont(currentAffix)
    local weeklyAffix, weekFont, offWeekFont, myFont, cw, ow
    weekFont = "KeyMasterFontBig"
    offWeekFont = "KeyMasterFontSmall"
    weeklyAffix = DungeonTools:GetAffixes()
    if (weeklyAffix == nil) then
        return offWeekFont
    end
    if(weeklyAffix[1].name == currentAffix) then
        myFont = weekFont
    else
        myFont = offWeekFont
    end
    return myFont
end

function DungeonTools:GetWeeklyAffix()
    local weeklyAffix = DungeonTools:GetAffixes()
    if (weeklyAffix == nil) then
        return "No Affixes"
    end
    return weeklyAffix[1].name
end

-- Calculates the dungeon runs performance based on its timer thresholds. 
---@param dungeonID integer - the id of the dungeon
---@param timeCompleted integer - the runs time in seconds
---@return string - string of the performance i.e. + or +++
function DungeonTools:CalculateChest(dungeonID, timeCompleted)
    if timeCompleted == nil or timeCompleted == 0 then return "" end
    if currentSeasonMaps == nil then
        currentSeasonMaps = DungeonTools:GetCurrentSeasonMaps()
    end
    local timeLimit = currentSeasonMaps[dungeonID].timeLimit
    if(timeCompleted <= (timeLimit * 0.6)) then return "+++" end
    if(timeCompleted <= (timeLimit * 0.8)) then return "++" end
    if(timeCompleted <= timeLimit) then return "+" end
    return ""
end

function DungeonTools:GetChestTimers(mapId)
    local mapTable = DungeonTools:GetCurrentSeasonMaps()
    local timeLimit = mapTable[mapId].timeLimit

    local chestTimers = {
        ["3chest"] = timeLimit * 0.6,
        ["2chest"] = timeLimit * 0.8,
        ["1chest"] = timeLimit
    }
    return chestTimers
end

local function getBaseScore(level)

    -- Break points -- Making some base calculation assumptions about the DF S4 rating system.
    -- These will need verified
    local breakPoints = {}

    -- breakPoints[seasonNum[breakppoint]]
    breakPoints = {
        [1] = { 5, 10 }, -- falback
        [11] = { 7, 14 }, -- DF S3
        [12] = { 5, 10 }, -- DF S4
        [13] = { 5, 10 }, -- TWW S1
        [14] = { 5, 10 } -- TWW S2
    }

    local mPlusSeason = DungeonTools:GetCurrentSeason()

    local lvlBreak1, lvlBreak2
    if (breakPoints[mPlusSeason]) then
        lvlBreak1 = breakPoints[mPlusSeason][1]
        lvlBreak2 = breakPoints[mPlusSeason][2]
    else
        lvlBreak1 = breakPoints[1][1]
        lvlBreak2 = breakPoints[1][2]
    end

    -- Every completed key has a bonus of 20 rating
    local baseRating = 20

    -- First 10 levels are worth 5 rating per level
    local firstRating = 0
    if level >= 10 then
        firstRating = 10 * 5
    else
        firstRating = level * 5
    end

    -- Every level after 10 is worth 7 rating per level
    local secondRating = 0
    if level > 10 then
        secondRating = (level - 10) * 7
    end

    -- Every affix added is worth 10 rating
    -- S3 Currently affixes are added at key level 2, 7 and 14
    -- S4 Currently affixes are added at key level 2, 5 and 10
    local affixScore = 0
    if level >= 2 then
        affixScore = affixScore + 10
    end
    if level >= lvlBreak1 then
        affixScore = affixScore + 10
    end
    if level >= lvlBreak2 then
        affixScore = affixScore + 10
    end

    return baseRating + firstRating + secondRating + affixScore
end

---@param dungeonID integer
---@param keyLevel integer level of mythic plus key to calculate
---@param runTime integer
---@return integer Total score for a dungeon by dungeon id, key level, and run time.
function DungeonTools:CalculateRating(dungeonID, keyLevel, runTime)
    -- ((totaltime - runTime)/(totaltime * maxModifier)) * 5 = bonusScore
    -- Subtract 5 if overtime
    
    if (keyLevel < 2) then
        return 0
    end

    if currentSeasonMaps == nil then
        currentSeasonMaps = DungeonTools:GetCurrentSeasonMaps()
    end
    local bonusRating = 0
    local dungeonTimeLimit = currentSeasonMaps[dungeonID].timeLimit
    -- Runs over time by 40% are a 0 score.
    if(runTime > (dungeonTimeLimit + (dungeonTimeLimit * maxModifier))) then
        return 0
    end
    
    -- Calculate the bonus score from timer
    local numerator = dungeonTimeLimit - runTime
    local denominator = dungeonTimeLimit * maxModifier
    local quotient = numerator/denominator    
    if(quotient >= 1) then bonusRating = 5
    elseif(quotient <= -1) then bonusRating = -5
    else bonusRating = quotient * 5 end

    if(runTime > dungeonTimeLimit) then
        bonusRating  = bonusRating - 5
    end
    
    -- Untimed keys over 20 use the base score of a 20. - DF S3
    -- Making assumptions about DF Season 4 where 10 is the base instead of 20 -- DF S4
    local mPlusSeason = DungeonTools:GetCurrentSeason()
    local base = 20 -- DF S3
    if mPlusSeason >= 12 then
        base = 10 -- DF S4
    end

    if(keyLevel > base and runTime > dungeonTimeLimit) then
        keyLevel = base
    end
    return getBaseScore(keyLevel) + bonusRating
end

--CalculateDungeonTotal - Calculates a dungeons overall score contributing to a players rating.
---@param seasonAffixScore1 integer - best score for dungeon for a weekly affix
---@param seasonAffixScore2 integer - best score for dungeon for a weekly affix
---@return integer - the total rating for the dungeons scores
function DungeonTools:CalculateDungeonTotal(seasonAffixScore1, seasonAffixScore2)
    local total
    if(seasonAffixScore1 > seasonAffixScore2) then
        total = KeyMaster:RoundSingleDecimal(seasonAffixScore1 * 1.5) + KeyMaster:RoundSingleDecimal(seasonAffixScore2 * 0.5)
    else
        total = KeyMaster:RoundSingleDecimal(seasonAffixScore1 * 0.5) + KeyMaster:RoundSingleDecimal(seasonAffixScore2 * 1.5)
    end
    return total
end