local _, KeyMaster = ...
KeyMaster.DungeonTools = {}
local DungeonTools = KeyMaster.DungeonTools

-- required for some C_MythicPlus functions to return correct results.
-- see : https://warcraft.wiki.gg/wiki/API_C_MythicPlus.RequestMapInfo
C_MythicPlus.RequestMapInfo()

--------------------------------
-- Challenge Dungeon Instance Abbreviations.
-- Must be manually maintained.
--------------------------------
local instanceAbbTable = {
    [463] = "FALL",    -- Dawn of the Infinite: Galakrond's Fall
    [464] = "RISE",    -- Dawn of the Infinite: Murozond's Rise
    [244] = "AD",       -- Atal'Dazar
    [248] = "WCM",      -- Waycrest Manor
    [199] = "BRH",      -- Black Rook Hold
    [198] = "DHT",      -- Darkheart Thicket
    [168] = "EB",       -- The Everbloom
    [456] = "ToT"       -- Throne of Tides
}

local weeklyAffixs
function DungeonTools:GetAffixes()
    if (weeklyAffixs) then return weeklyAffixs end
    
    local affixData = {}
    local affixes = C_MythicPlus.GetCurrentAffixes() -- Bug when this returned nils?
    for i=1, #affixes, 1 do
       local id = affixes[i].id
       local name, desc, filedataid = C_ChallengeMode.GetAffixInfo(id)
       
       local data = {
          ["id"] = id,
          ["name"] = name,
          ["desc"] = description,
          ["filedataid"] = filedataid
       }
       tinsert(affixData, data)
    end
    weeklyAffixs = affixData -- stores locally to prevent multiple api calls
    return affixData
 end

function DungeonTools:GetMapName(mapid)
    local name,_,_,_,_ = C_ChallengeMode.GetMapUIInfo(mapid)

    if (name == nil) then
        print("Unable to find mapname for id " .. mapid)   
        return nil   
    end

    return name
end

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
    local a = instanceAbbTable[mapId]
    if (not a) then a = "---" end
    return a
end

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
