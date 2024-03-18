local _, KeyMaster = ...
KeyMaster.UnitData = {}
local UnitData = KeyMaster.UnitData
local PlayerFrameMapping = KeyMaster.PlayerFrameMapping

local unitInformation = {}

-- Function tries to find the unit location (e.g.; party1-4) by their GUID
-- Parameter: unitGUID = Unique Player GUID value.
-- Returns: unitId e.g.; party1, party2, party3, party4
function UnitData:GetUnitId(unitGUID)
    local partyMembers = {"player", "party1", "party2", "party3", "party4"}
    for _,unitId in pairs(partyMembers) do
        if unitGUID == UnitGUID(unitId) then
            return unitId
        end
    end
    return nil
end

local function getUnitRealm(unitGUID)
    local partyMembers = {"player", "party1", "party2", "party3", "party4"}
    for _,unitId in pairs(partyMembers) do
        if unitGUID == UnitGUID(unitId) then
            local name, realm = UnitName(unitId)
            if realm == nil then
                return GetRealmName()
            else
                return realm
            end
        end
    end
    KeyMaster:_ErrorMsg("getUnitRealm", "UnitData", "Cannot find unit for GUID: "..unitGUID)
end

function UnitData:SetUnitData(unitData)
    local unitId = UnitData:GetUnitId(unitData.GUID)
    if unitId == nil then
        KeyMaster:_ErrorMsg("SetUnitData", "UnitData", "UnitId is nil.  Cannot store data for "..unitData.name)
        return
    end
    unitData.unitId = unitId -- set unitId for this client
    
    -- adds backward compatiability from before v0.0.95beta
    if unitData.realm == nil then
        unitData.realm = getUnitRealm(unitData.GUID)
    end
    
    -- STORE DATA IN MEMORY! duh?
    unitInformation[unitData.GUID] = unitData

    KeyMaster:_DebugMsg("SetUnitData", "UnitData", "Stored data for "..unitData.name)
end

function UnitData:SetUnitDataUnitPosition(name, realm, newUnitId)
    local unitData = UnitData:GetUnitDataByName(name, realm)
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

function UnitData:GetUnitDataByName(name, realm)
    for guid, tableData in pairs(unitInformation) do
        if (tableData.name == name and tableData.realm == realm) then
            return unitInformation[guid]
       end
   end
   KeyMaster:_DebugMsg("GetUnitDataByName", "UnitData", "Cannot find unit by name "..name.." and realm "..realm)
   return nil
end

function UnitData:GetAllUnitData()
    return unitInformation
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