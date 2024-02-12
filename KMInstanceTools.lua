--------------------------------
-- InstanceAbbr.lua
-- Manual conversion of instance names to an abbreviation.
--------------------------------
--------------------------------
-- Namespace
--------------------------------
local _, core = ...
core.InstanceTools = {}

local InstanceTools = core.InstanceTools

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
function InstanceTools:GetAbbr(mapId --[[int]])
    local a = instanceAbbTable[mapId]
    if (not a) then a = "---" end
    return a
end