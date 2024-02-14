local _, KeyMaster = ...
KeyMaster.DungeonTools = {}
local DungeonTools = KeyMaster.DungeonTools

function DungeonTools:GetAffixes()
    local affixData = {}
    local affixes = C_MythicPlus.GetCurrentAffixes()
    for i=1, #affixes, 1 do
        local id = affixes[i].id
        local name, desc, filedataid = C_ChallengeMode.GetAffixInfo(id)
        affixData[i] = {
            ["id"] = id,
            ["name"] = name,
            ["desc"] = description,
            ["filedataid"] = filedataid
        }
    end
    
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

function DungeonTools:GetCurrentSeasonMaps()
    local maps = C_ChallengeMode.GetMapTable();
    
    local mapTable = {}
    for i,v in ipairs(maps) do
       local name, id, timeLimit, texture, backgroundTexture = C_ChallengeMode.GetMapUIInfo(v)
       mapTable[id] = {
          ["name"] = name,
          ["timeLimit"] = timeLimit,
          ["texture"] = texture,
          ["backgroundTexture"] = backgroundTexture
       }
    end
    
    return mapTable  
end


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

-- conversion from mapid to abbreviation
function DungeonTools:GetAbbr(mapId --[[int]])
    local a = instanceAbbTable[mapId]
    if (not a) then a = "---" end
    return a
end
