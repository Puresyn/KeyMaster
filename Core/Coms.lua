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

-- Notify Successful Registration (DEBUG)
function MyAddon:OnEnable()
    self:RegisterComm(comPrefix)
end

-- Serialize communication data:
-- Can communitcate over whatever default channels are avaialable via hidden Addons subchannel.
function MyAddon:Transmit(data)
    local serialized = LibSerialize:Serialize(data)
    local compressed = LibDeflate:CompressDeflate(serialized)
    local encoded = LibDeflate:EncodeForWoWAddonChannel(compressed)
    self:SendCommMessage(comPrefix, encoded, "WHISPER", UnitName("player"))
end

-- Deserialize communication data:
-- Returns nil if something went wrong.
function MyAddon:OnCommReceived(prefix, payload, distribution, sender)
    local decoded = LibDeflate:DecodeForWoWAddonChannel(payload)
    if not decoded then return end
    local decompressed = LibDeflate:DecompressDeflate(decoded)
    if not decompressed then return end
    local success, data = LibSerialize:Deserialize(decompressed)
    if not success then return end
    
    --do something with data
    if (prefix ~= "KM2") then return end    
    if (data == nil) then return end
    --if (data.GUID == UnitGUID("player")) then return end

    --print("Recieved Data: "..data) -- CREATES BLANK LUA ERROR
    
    KeyMaster:Print("Received data from "..sender)
    
    UnitData:SetUnitData(data)
end