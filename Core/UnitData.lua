local _, KeyMaster = ...
KeyMaster.UnitData = {}
local UnitData = KeyMaster.UnitData
local PlayerFrameMapping = KeyMaster.PlayerFrameMapping

local unitInformation = {}

-- Function tries to find the unit location (e.g.; party1-4) by their GUID
-- Parameter: unitGUID = Unique Player GUID value.
-- Returns: unitId e.g.; party1, party2, party3, party4
function UnitData:GetUnitId(unitGUID)
    local player = UnitGUID("player")
    local p1 = UnitGUID("party1")
    local p2 = UnitGUID("party2")
    local p3 = UnitGUID("party3")
    local p4 = UnitGUID("party4")

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
    if unitId == nil then
        KeyMaster:_ErrorMsg("SetUnitData", "UnitData", "UnitId is nil.  Cannot store data for "..unitData.name)
        return
    end
    unitData.unitId = unitId -- set unitId for this client
    unitInformation[unitData.GUID] = unitData

    KeyMaster:_DebugMsg("SetUnitData", "UnitData", "Stored data for "..unitData.name)
end

function UnitData:SetUnitDataUnitPosition(name, newUnitId)
    local unitData = UnitData:GetUnitDataByName(name)
    if unitData == nil then
        KeyMaster:_ErrorMsg("SetUnitDataUnitPostion", "UnitDat", "Cannot update position for "..name.." because a unit cannot be found by that name.")
        return
    end

    unitInformation[unitData.GUID].unitId = newUnitId
    return unitInformation[unitData.GUID]
end

function UnitData:GetUnitDataByUnitId(unitId)
    for guid, tableData in pairs(unitInformation) do
         if (tableData.unitId == unitId) then
            return unitInformation[guid]
        end
    end

    return nil -- NOT FOUND
end

function UnitData:GetUnitDataByGUID(playerGUID)
    return unitInformation[playerGUID]
end

function UnitData:GetUnitDataByName(name)
    for guid, tableData in pairs(unitInformation) do
        if (tableData.name == name) then
           return unitInformation[guid]
       end
   end
end

function UnitData:DeleteUnitDataByUnitId(unitId)
    local data = UnitData:GetUnitDataByUnitId(unitId)
    if (data ~= nil) then
        UnitData:DeleteUnitDataByGUID(data.GUID)
    end
end

function UnitData:DeleteUnitDataByGUID(playerGUID)
    unitInformation[playerGUID] = nil
end

function UnitData:DeleteAllUnitData()
    for guid, unitData in pairs(unitInformation) do
        if unitData.unitId ~= "player" then
            unitInformation[guid] = nil
        end
    end
end