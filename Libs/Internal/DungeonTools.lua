local _, KeyMaster = ...
KeyMaster.DungeonTools = {}
local DungeonTools = KeyMaster.DungeonTools
local Theme = KeyMaster.Theme

--------------------------------
-- Challenge Dungeon Instance Abbreviations.
-- Must be manually maintained.
--------------------------------
local instanceAbbrTable = {
    [463] = "FALL",     -- Dawn of the Infinite: Galakrond's Fall
    [464] = "RISE",     -- Dawn of the Infinite: Murozond's Rise
    [244] = "AD",       -- Atal'Dazar
    [248] = "WCM",      -- Waycrest Manor
    [199] = "BRH",      -- Black Rook Hold
    [198] = "DHT",      -- Darkheart Thicket
    [168] = "EB",       -- The Everbloom
    [456] = "ToT"       -- Throne of Tides
}

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
    [168] = 159901      -- The Everbloom

}

-- Gets a list of the current weeks affixes.
local weeklyAffixs
function DungeonTools:GetAffixes()
    if (weeklyAffixs) then return weeklyAffixs end
    
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
        print("Unable to find mapname for id " .. mapid)   
        return nil   
    end

    return name
end

-- Gets a list of the live seasons challenge maps
local currentSeasonMaps
function DungeonTools:GetCurrentSeasonMaps()
    if(currentSeasonMaps) then return currentSeasonMaps end

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
    local a = instanceAbbrTable[mapId]
    if (not a) then a = "No Key" end
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