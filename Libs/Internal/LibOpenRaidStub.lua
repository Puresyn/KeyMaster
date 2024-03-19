local _, KeyMaster = ...
KeyMaster.openRaidStub = {}
local openRaidStub = KeyMaster.openRaidStub


local comPrefixOpenRaid = "LRS"
local CONST_COMM_KEYSTONE_DATA_PREFIX = "K"
local CONST_COMM_KEYSTONE_DATAREQUEST_PREFIX = "J"

local CONST_COMM_SENDTO_PARTY = "0x1"
local CONST_COMM_SENDTO_RAID = "0x2"
local CONST_COMM_SENDTO_GUILD = "0x4"

KM_OpenRaidStub = LibStub("AceAddon-3.0"):NewAddon("KM_OpenRaidStub", "AceComm-3.0")
function KM_OpenRaidStub:OnEnable()
    self:RegisterComm(comPrefixOpenRaid)
end

-- sends simulated request to party members so they transmit their key data from Open Raid
function KM_OpenRaidStub:TransmitOpenRaidRequest(requestData, distribution)
    if requestData == nil then 
        KeyMaster:_DebugMsg("TransmitOPenRaidRequest", "LibOpenRaidStub", "Invalid data request type.")
        return
    end
    KeyMaster:_DebugMsg("TransmitOPenRaidRequest", "LibOpenRaidStub", "Transmitting openRaid key request to "..distribution.."...")
    self:SendCommMessage(comPrefixOpenRaid, requestData, distribution, nil)
end

function KM_OpenRaidStub:OnCommReceived()
end

function openRaidStub:SendCommData(data, flags, bIgnoreQueue)
    local LibDeflate = LibStub:GetLibrary("LibDeflate")
    local dataCompressed = LibDeflate:CompressDeflate(data, {level = 9})
    local dataEncoded = LibDeflate:EncodeForWoWAddonChannel(dataCompressed)

    if (flags) then
        if (bit.band(flags, CONST_COMM_SENDTO_PARTY)) then --send to party
            if (IsInGroup() and not IsInRaid()) then
                local channel = IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT" or "PARTY"
                KM_OpenRaidStub:TransmitOpenRaidRequest(dataEncoded, channel)
            end
        end

        --send to guild
        -- if (bit.band(flags, CONST_COMM_SENDTO_GUILD)) then
        --     if (IsInGuild()) then
        --         KM_OpenRaidStub:TransmitOpenRaidRequest(dataEncoded, "GUILD")
        --     end
        -- end
    else
        if (IsInGroup() and not IsInRaid()) then --in party only
            local channel = IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT" or "PARTY"
            KM_OpenRaidStub:TransmitOpenRaidRequest(dataEncoded, channel)
        end
    end
end

function openRaidStub:RequestKeystoneDataFromParty()
    if (IsInGroup() and not IsInRaid()) then
        local dataToSend = "" .. CONST_COMM_KEYSTONE_DATAREQUEST_PREFIX
        openRaidStub:SendCommData(dataToSend, 0x1)
        return true
    else
        return false
    end
end