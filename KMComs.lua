--------------------------------
-- Namespace
--------------------------------
local _, core = ...
core.Coms = {}

local Coms = core.Coms
local Coms

-- Dependencies: AceAddon-3.0, AceComm-3.0, LibSerialize, LibDeflate
MyAddon = LibStub("AceAddon-3.0"):NewAddon("KeyMaster", "AceComm-3.0")
local LibSerialize = LibStub("LibSerialize")
local LibDeflate = LibStub("LibDeflate")
local comPrefix = "KM2"

-- Notify Successful Registration (DEBUG)
function MyAddon:OnEnable()
    self:RegisterComm(comPrefix)
    core:Print(comPrefix, "communications initialized.")
end

-- Serialize communication data:
function MyAddon:Transmit(data)
    local serialized = LibSerialize:Serialize(data)
    local compressed = LibDeflate:CompressDeflate(serialized)
    local encoded = LibDeflate:EncodeForWoWAddonChannel(compressed)
    self:SendCommMessage(comPrefix, encoded, "WHISPER", UnitName("player"))
end

-- Deserialize communication data:
function MyAddon:OnCommReceived(prefix, payload, distribution, sender)
    local decoded = LibDeflate:DecodeForWoWAddonChannel(payload)
    if not decoded then return end
    local decompressed = LibDeflate:DecompressDeflate(decoded)
    if not decompressed then return end
    local success, data = LibSerialize:Deserialize(decompressed)
    if not success then return end

    -- Handle `data`
    print("Recieved Data: "..data)
    print("Data: "..decoded)
end