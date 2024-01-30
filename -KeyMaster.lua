


-- Local Variables
local playerRealm, playerGuild, playerTeams, bestMapScores
local hasKeyStone, keyStoneLevel, challengeMapID, intimeInfo, overtimeInfo, currAffixes, keyMasterSync
local LibSerialize = LibStub("LibSerialize")
local LibDeflate = LibStub("LibDeflate")
local activeMaps = {}
local addonPrefix = "KM2"
local playerName = UnitName("player")

playerGuild = ""
PlayerServer = ""
PlayerTeams = {}

-- Global Variables
--SLASH_KM1 = "/km"
--SLASH_KM2 = "/km2"
KM_VERSION = "0.01"
KM_DEBUG = true

-- Verify Loading
print("KeyMaster: Loaded.")

--[[ Error Handling ]]--
local function SoftExit (Message) 
    print("KeyMaster: "..Message)
    challengeMapID = 0
    return
end

--[[ Load Addon Variables ]]--
function getCurrentSeasonMaps()
    activeMaps = C_ChallengeMode.GetMapTable();
end

local function getMythicRunHistory(mapID)
    affixScores, bestOverAllScore = C_MythicPlus.GetSeasonBestAffixScoreInfoForMap(mapID)
end

--[[ Communication ]]--

local function buildKeyData()
    -- Owned Mythic Plus Key Data
    challengeMapID = C_MythicPlus.GetOwnedKeystoneChallengeMapID()
    if not challengeMapID then
        keyInfo = "0|0"
        SoftExit ("No mythic plus key found on "..playerName)
    else
        --intimeInfo, overtimeInfo = C_MythicPlus.GetSeasonBestForMap(challengeMapID)
        keyStoneLevel = C_MythicPlus.GetOwnedKeystoneLevel()
        keyInfo = challengeMapID.."|"..keyStoneLevel
        getMythicRunHistory(challengeMapID)
    end
    
    return keyInfo
end



local function UpdateKMInfo(t)
    MyAddon:Transmit(t)
end


-- Event Handlers
local function OnEvent(self, event, ...)
    prefix, text, channel, sender, target, zoneChannelID, localID, name, instanceID = ...
    if event == "CHAT_MSG_ADDON" then
        --print(event, ...) --Prints ALL Addons channel messages
        if prefix == addonPrefix then -- Filter this addons messages
            -- Debug
            if KM_DEBUG == true then
                --print(event, ...)
                print("KM Coms Payload: "..text)
                print("--KM DEBUG--")
                MyAddon:OnCommReceived(...)
                print("--KM DEBUG--")
            end

            -- Do Stuff

        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        local isInitialLogin, isReloadingUi = ...
        if isInitialLogin or isReloadingUi then
            --C_ChatInfo.RegisterAddonMessagePrefix(addonPrefix)
            --C_ChatInfo.SendAddonMessage(addonPrefix, "KMTESTCOM1", "WHISPER", playerName)        end
            getCurrentSeasonMaps()
            UpdateKMInfo(buildKeyData())
        end
    end
end
 


-- Debug Communication
local f = CreateFrame("Frame")

-- Run Communication
f:RegisterEvent("CHAT_MSG_ADDON")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
--f:RegisterEvent("CHAT_MSG_ADDON_LOGGED") -- Not Working? Not Needed?
f:SetScript("OnEvent", OnEvent)

--[[ Slash Commands ]]--
--[[
SlashCmdList["KM"] = function(msg) 
    if msg == nil then
        print("Key Master Slash Command Passed.")
    elseif msg == "update" then
        print("Update Command")
    elseif msg == "version" then
        print("KM: Version "..KM_VERSION)
    elseif msg == "debug" then
        -- Toggle Debugging
        if KM_DEBUG == false then
            KM_DEBUG = true 
            print("KM: Debugging Enabled")
        elseif KM_DEBUG == true then
            KM_DEBUG = false
            print("KM: Debugging Disabled")
        end
    elseif msg == "updateinfo" then
        --UpdateKMInfo("Slash Update Called")
        buildKeyData()
    elseif msg == "help" or "?" then
        print("KM: Command line help coming soon.")
    else
        print("KM: "..msg.." is not a valid command. Use /km help for more options.")
    end
end
]]

--[[
    WeakAuras Version: 5.9.2
    Aura Version: 1.0.2
    [string "return function(s, event, ...)"]:38: attempt to index field 'spells' (a nil value)
]]
function(s, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" and ... then
       local _, subEvent, _, sourceGUID, _, sourceFlags, _, destGUID, _, _, _, sourceSpellID = ...
       if subEvent == "SPELL_CAST_START" then
          if sourceSpellID == 408805 then
             aura_env.incorpCount = aura_env.incorpCount + 1
             local flags = format("%X", sourceFlags)
             flags = string.sub(flags, -3)
             if flags == "A48" then
                s[sourceGUID] = {
                   show = true,
                   changed = true,
                   autoHide = true,
                   progressType = "timed",
                   duration = 5,
                   expirationTime = 5 + GetTime(),
                   icon = 298642,
                }
                return true
             end
          end
       elseif subEvent == "SPELL_INTERRUPT" then
          local destSpellID = select(15, ...)
          if destSpellID ==408805  and s[destGUID] then
             aura_env.incorpCount = 0
             s[destGUID].changed = true
             s[destGUID].show = false
             return true
          end
       elseif subEvent == "SPELL_AURA_REMOVED" then
          if sourceSpellID == 408801 and s[sourceGUID] then
             aura_env.incorpCount = 0
             s[sourceGUID].changed = true
             s[sourceGUID].show = false
             return true
          end
       elseif subEvent == "SPELL_AURA_APPLIED" then
          if s[destGUID] and aura_env.spells[sourceSpellID] then
             aura_env.incorpCount = 0
             s[destGUID].changed = true
             s[destGUID].show = false
             return true
          end
       end
    elseif event == "UNIT_SPELLCAST_STOP" and ... then
       local unit, _, spellID = ...
       local guid = UnitGUID(unit)
       if spellID == 408805 and s[guid] then
          aura_env.incorpCount = 0
          s[guid].changed = true
          s[guid].show = false
          return true
       end
    end
 end