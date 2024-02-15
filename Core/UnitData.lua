local _, KeyMaster = ...
KeyMaster.UnitData = {}
local UnitData = KeyMaster.UnitData

local unitInformation = {}

-- Function tries to find the unit location (e.g.; party1-4) by their GUID
-- Parameter: unitGUID = Unique Player GUID value.
-- Returns: unitId e.g.; party1, party2, party3, party4
function UnitData:GetUnitId(unitGUID)
    local player = UnitGUID("player")
    local p1 = UnitGUID("party1")
    local p2 = UnitGUID("Party2")
    local p3 = UnitGUID("Party3")
    local p4 = UnitGUID("Party4")

    if (unitGUID == player) then
        return "player"
    elseif(unitGUID == p1) then
        return "party1"
    elseif(unitGUID == p2) then
        return "party2"
    elseif(unitGUID == p3) then
        return "party3"
    elseif(unitGUID == p4) then
        return "party4"
    else
        return nil
    end
end

function UnitData:SetUnitData(unitData)
    local unitId = UnitData:GetUnitId(unitData.GUID)
    unitData.unitId = unitId -- set unitId for this client
    unitInformation[unitData.GUID] = unitData
end

function UnitData:GetUnitDataByUnitId(unitId)
    for guid, tableData in pairs(unitInformation) do
        print("GUID: "..tostring(guid))
        print("UnitID: "..tableData.unitId)
        if (tableData.unitId == unitId) then
            return unitInformation[guid]
        end
    end

    return nil -- NOT FOUND
end

function UnitData:GetUnitDataByGUID(playerGUID)
    return unitInformation[playerGUID]
end