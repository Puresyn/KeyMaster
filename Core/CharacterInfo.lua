local _, KeyMaster = ...
KeyMaster.CharacterInfo = {}

local CharacterInfo = KeyMaster.CharacterInfo

function CharacterInfo:GetMyClassColor(unit)
    local c,p 
    if (not unit) then unit = "player" end
    local _, myClass, _ = UnitClass(unit)
    local c = string.sub(select(4, GetClassColor(myClass)), 3, -1)
    return c
end