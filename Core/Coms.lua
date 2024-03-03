--------------------------------
-- KMComs.lua
-- Handles all in-game communcaitons
-- between clients via addon channel.
--------------------------------
--------------------------------
-- Namespace
--------------------------------
local _, KeyMaster = ...
KeyMaster.Coms = {}

local Coms = KeyMaster.Coms
local UnitData = KeyMaster.UnitData

-- Dependencies: LibSerialize
-- todo: Verify what ACE libraries are actually needed.
-- -this doesn't currently break but I don't think it has everything
-- -it needs to function as designed. see /libs/
MyAddon = LibStub("AceAddon-3.0"):NewAddon("KeyMaster", "AceComm-3.0")
local LibSerialize = LibStub("LibSerialize")
local LibDeflate = LibStub("LibDeflate")
local comPrefix = "KM2"
local comPrefix2 = "KM3"

-- Notify Successful Registration (DEBUG)
function MyAddon:OnEnable()
    self:RegisterComm(comPrefix)
    self:RegisterComm(comPrefix2)
end

-- Serialize communication data:
-- Can communitcate over whatever default channels are avaialable via hidden Addons subchannel.
function MyAddon:Transmit(data)
    local serialized = LibSerialize:Serialize(data)
    local compressed = LibDeflate:CompressDeflate(serialized)
    local encoded = LibDeflate:EncodeForWoWAddonChannel(compressed)
    
    KeyMaster:_DebugMsg("Transmit", "Coms", "transmitting data ...")
    self:SendCommMessage(comPrefix, encoded, "PARTY", nil)
end

-- sends request to party members to transmit their data
function MyAddon:TransmitRequest(requestData)
    if requestData == nil or requestData.requestType == nil then 
        KeyMaster:_DebugMsg("TransmitRequest", "Coms", "Received invalid data request type.")
        return
    end
    local serialized = LibSerialize:Serialize(requestData)
    local compressed = LibDeflate:CompressDeflate(serialized)
    local encoded = LibDeflate:EncodeForWoWAddonChannel(compressed)
    
    self:SendCommMessage(comPrefix2, encoded, "PARTY", nil)
end

local function processKM3Data(data, distribution, sender)    
    if data.requestType == "playerData" then
        -- send player data to party members
        local playerData = UnitData:GetUnitDataByUnitId("player")
        MyAddon:Transmit(playerData)
        KeyMaster:_DebugMsg("processKM3Data", "Coms", "Request replied with player data...")
    end   
end

-- Deserialize communication data:
-- Returns nil if something went wrong.
function MyAddon:OnCommReceived(prefix, payload, distribution, sender)
    local decoded = LibDeflate:DecodeForWoWAddonChannel(payload)
    if not decoded then return end
    local decompressed = LibDeflate:DecompressDeflate(decoded)
    if not decompressed then return end
    local success, data = LibSerialize:Deserialize(decompressed)
    if not success then
        KeyMaster:_DebugMsg("OnCommReceived", "Coms", "Failed to deserialize data from "..sender)
        return
    end
    if (sender == UnitName("player")) then return end
    
    if (data == nil) then
        KeyMaster:_DebugMsg("OnCommReceived", "Coms", "Received nil data from "..sender)
        return
    end    
    --do something with data
    if (prefix ~= "KM2" and prefix ~= "KM3") then return end   
    if (prefix == "KM3") then
        processKM3Data(data, distribution, sender)
    elseif (prefix == "KM2") then
        KeyMaster:_DebugMsg("OnCommReceived", "Coms", "Received data from "..sender)
        data.hasAddon = true
        UnitData:SetUnitData(data)
        
        -- Calculate keystone upgrades for party members and player
        KeyMaster.ViewModel:CalculateTotalRatingGainPotential()
        
        -- Highlight key and level on map frames
        KeyMaster.ViewModel:UpdateKeystoneHighlights()
    end
end

