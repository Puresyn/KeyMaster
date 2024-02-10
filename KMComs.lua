--------------------------------
-- KMComs.lua
-- Handles all in-game communcaitons
-- between clients via addon channel.
--------------------------------
--------------------------------
-- Namespace
--------------------------------
local _, core = ...
core.Coms = {}
local PartyPlayerData = {}

local Coms = core.Coms
local MainInterface = core.MainInterface

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
    core:Print(comPrefix, "communications initialized.")
end

-- Serialize communication data:
-- Can communitcate over whatever default channels are avaialable via hidden Addons subchannel.
function MyAddon:Transmit(data, target, playerName)
    local serialized = LibSerialize:Serialize(data)
    local compressed = LibDeflate:CompressDeflate(serialized)
    local encoded = LibDeflate:EncodeForWoWAddonChannel(compressed)
    self:SendCommMessage(comPrefix, encoded, target, playerName)
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

    -- todo: Handle data communication events
    -- print("Recieved Data: "..data)
    -- print("PREFIX: " ..prefix)
    -- print("DISTRO: " ..distribution)
    -- print("SENDER: " ..sender)
    --print("Data: "..decoded)'

    if (prefix == "KM2") then
        if (data == nil) then
            return
        end

        if (data.name == UnitName("player")) then
            return
        end        
        if (data.GUID == nil) then
            return
        end

        print(data.GUID)
        MainInterface:SetMemberData(data)
        -- --tprint(data)
        print(prefix..": Recieved data from " ..data.name)
        -- --tinsert(PlayerInfo.PartyPlayerData, data)
        -- PartyPlayerData[data.GUID] = data
        -- --tprint(PartyPlayerData)
        -- --pData[data.GUID] = data
        -- --tprint(PlayerInfo.PartyPlayerData[data.GUID])
        
        -- MainInterface:Refresh_PartyFrames()
    end    
end

function Coms:GetPartyData()
    return PartyPlayerData
end