local _, KeyMaster = ...
KeyMaster.UnitData = {}
local UnitData = KeyMaster.UnitData
local ViewModel = KeyMaster.ViewModel

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

function UnitData:DisplayUnitData(unitId, unitData)
    ViewModel:UpdateUnitFrameData(unitId, unitData)
    ViewModel:ShowPartyRow(unitId) -- shows UI Frame associated with unitId
end

function UnitData:SetUnitData(unitData, updateUI)
    if updateUI == nil then updateUI = true end

    local unitId = UnitData:GetUnitId(unitData.GUID)
    if unitId == nil then
        KeyMaster:_ErrorMsg("SetUnitData", "UnitData", "UnitId is nil.  Cannot store data for "..unitData.name)
        return
    end
    unitData.unitId = unitId -- set unitId for this client
    unitInformation[unitData.GUID] = unitData

    KeyMaster:_DebugMsg("SetUnitData", "UnitData", "Stored data for "..unitData.name)
    if updateUI then
        UnitData:DisplayUnitData(unitData.unitId, unitData)
    end
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
        ViewModel:HidePartyRow(unitId)
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

function UnitData:MapPartyUnitData()
    for i=1,4,1 do
        local currentUnitId = "party"..i
        if (UnitName(currentUnitId) ~= nil) then
            -- find if we have data for this player, if not get a set of default data from blizzard
            KeyMaster:_DebugMsg("MapPartyUnitData", "UnitData", "Mapping data for "..currentUnitId)
            local unitData = unitInformation[UnitGUID(currentUnitId)]
            if unitData == nil then
                KeyMaster:_DebugMsg("MapPartyUnitData", "UnitData", "Getting Blizzard data on "..currentUnitId)
                unitData = KeyMaster.CharacterInfo:GetUnitInfo(currentUnitId)    
            else
                KeyMaster:_DebugMsg("MapPartyUnitData","UnitData","Found local data on "..currentUnitId)     
                -- Highlight key and level on map frames
                KeyMaster.ViewModel:HighlightKeystones(unitData.ownedKeyId, unitData.ownedKeyLevel)           
            end
            -- remap and display data for this unitid
            UnitData:DisplayUnitData(currentUnitId, unitData)
        else
            -- no active player found, hide ui for this unitid
            _G["KM_PlayerRow"..(i+1)]:Hide() --hide ui frame
        end
    end
    KeyMaster.MainInterface:ResetTallyFramePositioning()
end