--------------------------------
-- Init.lua
-- Handles addon initialization
--------------------------------

--------------------------------
-- Namespace
--------------------------------
local _, KeyMaster = ...
local CharacterInfo = KeyMaster.CharacterInfo
local MainInterface = KeyMaster.MainInterface
local Theme = KeyMaster.Theme
local UnitData = KeyMaster.UnitData
local KeyScoreCalc = KeyMaster.KeyScoreCalc
local PartyFrame = KeyMaster.PartyFrame

-- Global Variables
KM_ADDON_NAME = KeyMasterLocals.ADDONNAME
KM_AUTOVERSION = '0.0.97'
KM_VERSION_STATUS = KeyMasterLocals.BUILDBETA -- BUILDALPHA BUILDBETA BUILDRELEASE - for display and update notification purposes

--------------------------------
-- Slash Commands and command menu
--------------------------------
-- DO NOT EDIT
SLASH_KeyMaster1 = KeyMasterLocals.COMMANDLINE["/km"].name
SLASH_KeyMaster2 = KeyMasterLocals.COMMANDLINE["/keymaster"].name
--------------

KeyMaster.Commands = {
    [KeyMasterLocals.COMMANDLINE["Show"].name] = KeyMaster.MainInterface.Toggle,
    [KeyMasterLocals.COMMANDLINE["Help"].name] = function() 
        local defaultColor = select(4, Theme:GetThemeColor("themeFontColorYellow")):upper()
        local color = select(4, Theme:GetThemeColor("themeFontColorYellow")):upper()
        print("=====================")
        KeyMaster:Print("List of slash commands:")
        KeyMaster:Print("|cff"..defaultColor..KeyMasterLocals.COMMANDLINE["/km"].text.."|r |cff"..color..KeyMasterLocals.COMMANDLINE["Show"].name.."|r"..KeyMasterLocals.COMMANDLINE["Show"].text)
        KeyMaster:Print("|cff"..defaultColor..KeyMasterLocals.COMMANDLINE["/km"].text.."|r |cff"..color..KeyMasterLocals.COMMANDLINE["Help"].name.."|r"..KeyMasterLocals.COMMANDLINE["Help"].text)
        print("=====================")
    end,
    -- Sample nested command line functions
    --[[ ["example"] = {
        ["test"] = function(...)
            KeyMaster:Print("My Value:", tostringall(...))
        end
    } ]]
}

-- Slash commands handler
local function HandleSlashCommands(str)
 
    -- /km
    if (#str == 0) then
        KeyMaster.Commands[KeyMasterLocals.COMMANDLINE["Show"].name]()
        return
    end

    -- processes any passed arguments /km [args]
    local args = {}
	for _, arg in ipairs({ string.split(' ', str) }) do
		if (#arg > 0) then
			table.insert(args, arg)
		end
	end

    local path = KeyMaster.Commands

    -- itterate and process all command line arguments via KeyMaster.Commands table
    for id, arg in ipairs(args) do
		if (#arg > 0) then -- if string length is greater than 0.
			arg = arg:lower()		
			if (path[arg]) then
				if (type(path[arg]) == "function") then				
					-- all remaining args passed to our function!
					path[arg](select(id + 1, unpack(args)))
					return;					
				elseif (type(path[arg]) == "table") then				
					path = path[arg] -- another sub-table found!
				end
			else
				-- does not exist!
                local commandColor = select(4, Theme:GetThemeColor("themeFontColorYellow"))
				KeyMaster:Print(KeyMasterLocals.COMMANDERROR1 .." \"|cff" .. commandColor .. arg .. "|r\". ".. KeyMasterLocals.COMMANDERROR2 .. " |cff" .. commandColor .. KeyMasterLocals.COMMANDLINE["/km"].name .. " " .. KeyMasterLocals.COMMANDLINE["Help"].name .."|r " .. KeyMasterLocals.COMMANDERROR3 .. ".")
				return;
			end
		end
	end

end

-- Bindings.xml functions
function KMWindowBindingToggle()
    KeyMaster.MainInterface.Toggle()
end

-- formats strings for end-user display in the chat box
function KeyMaster:Print(...)
    local hex = select(4, Theme:GetThemeColor("default"))
    local prefix = string.format("|cff%s%s|r", hex:upper(), KeyMasterLocals.ADDONNAME..":");	
    DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", prefix, ...));
end

-- This retry logic is done because the C_MythicPlus API is not always available right away and this frame depends on it.
local function intializeUIWithRetries(retryCount)
    if retryCount == nil then retryCount = 0 end
    local seasonalMaps = KeyMaster.DungeonTools:GetCurrentSeasonMaps()
    local seasonalAffixes = KeyMaster.DungeonTools:GetAffixes()
    if KeyMaster:GetTableLength(seasonalMaps) > 0 and seasonalAffixes ~= nil then
        -- fetch player data from bliz and save it to local memory
        -- the next two lines doesn't work if you remove it from here due to data not being available from bliz
        local playerData = CharacterInfo:GetMyCharacterInfo()
        KeyMaster.UnitData:SetUnitData(playerData)

        local mainUI = _G["KeyMaster_MainFrame"] or MainInterface:Initialize()
    else
        if retryCount < 5 then
            C_Timer.After(3, function() intializeUIWithRetries(retryCount + 1) end)
            KeyMaster:_DebugMsg("intializeUIWithRetries", "KeyMaster.lua", "Retrying to create UI frames after "..tostring(retryCount).." retries.")
        else
            KeyMaster:_ErrorMsg("intializeUIWithRetries", "KeyMaster.lua", "Failed to create UI frames after "..tostring(retryCount).." retries.")
        end
    end
end

-- Addon Loading Event
local function OnEvent_AddonLoaded(self, event, name, ...)
    if (name ~= "KeyMaster") then return end
    --------------------------------
    -- Register Slash Commands:
    --------------------------------
    -- todo: Point commands to Localization
    -- todo: Remove these comments and debug functions for release
    SLASH_RELOADUI1 = "/rl" -- Faster reaload
    SlashCmdList.RELOADUI = ReloadUI

    SLASH_FRAMESTK1 = "/fs"; -- slash command for showing framestack tool
	SlashCmdList.FRAMESTK = function()
		LoadAddOn("Blizzard_DebugTools");
		FrameStackTooltip_Toggle();
	end

    -- commands to be included in release
    --SLASH_KeyMaster1 = "/km"  -- Localized
    --SLASH_KeyMaster2 = "/keymaster" -- Localized
    SlashCmdList.KeyMaster = HandleSlashCommands

    KeyMaster:LOAD_SAVED_GLOBAL_VARIABLES()
    
    -- Welcome message
    local hexColor = CharacterInfo:GetMyClassColor("player")
    KeyMaster:Print(KeyMasterLocals.WELCOMEMESSAGE, "|cff"..hexColor..UnitName("player").."|r"..KeyMasterLocals.EXCLIMATIONPOINT)
    
    local hexColor = select(4, Theme:GetThemeColor("color_ERRORMSG"))
    if (KeyMaster_DB.addonConfig.showErrors == true) then
        KeyMaster:Print("|cff"..hexColor.. KeyMasterLocals.ERRORMESSAGESNOTIFY .. "|r")
    end

    local hexColor = select(4, Theme:GetThemeColor("color_DEBUGMSG"))
    if (KeyMaster_DB.addonConfig.showDebugging == true) then
        KeyMaster:Print("|cff"..hexColor.. KeyMasterLocals.DEBUGMESSAGESNOTIFY .. "|r")
    end
end

local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:SetScript("OnEvent", OnEvent_AddonLoaded)

local function onEvent_PartyChanges(self, event, ...)
    --print(event, ...)
    
    -- process party changes
    if (event == "GROUP_ROSTER_UPDATE") then
        -- The following resets the party data then repopulates it.
        local inGroup = UnitInRaid("player") or IsInGroup()
        if inGroup and GetNumGroupMembers() >= 2 then
            -- fetch self data
            local playerUnit = UnitData:GetUnitDataByUnitId("player")

            -- Transmit unit data to party members with addon
            MyAddon:Transmit(playerUnit, "PARTY", nil)
        end
        if not inGroup then
            -- purge all party data EXCEPT player
            UnitData:DeleteAllUnitData()
            KeyMaster:_DebugMsg("onEvent_PartyChanges", "KeyMaster", "purging all party data...")          
        end
        if not inGroup or (inGroup and GetNumGroupMembers() >= 2) then
            -- Only update UI if party tab is open
            local partyTabContentFrame = _G["KeyMaster_PartyScreen"]
            if partyTabContentFrame ~= nil and partyTabContentFrame:IsShown() then
                -- reprocess party1-4 units
                KeyMaster.PartyFrameMapping:UpdatePartyFrameData()
            end
        end
    end
end

local partyEvents = CreateFrame("Frame")
partyEvents:RegisterEvent("GROUP_ROSTER_UPDATE")
partyEvents:SetScript("OnEvent", onEvent_PartyChanges)

-- Player Entering World Event
local function onEvent_PlayerEnterWorld(self, event, isLogin, isReload)
    if (event ~= "PLAYER_ENTERING_WORLD") then return end
    -- isLogin ONLY OCCURS when logging in from character select screen
    -- isReload occurs when reloading the UI
    -- zoning into a new area does not trigger isLogin or isReload

    if (isLogin) then
        -- This section is required because of some C_MythicPlus blizzard functions returning nil without it
        -- see our github issue #6
        C_MythicPlus.RequestCurrentAffixes()
        C_MythicPlus.RequestMapInfo()
        C_MythicPlus.RequestRewards()
        KeyMaster:_DebugMsg("onEvent_PlayerEnteringWorld", "KeyMaster", "C_MythicPlus requests sent.")        
    end
    if isLogin or isReload then
        if isLogin then
            KeyMaster:_DebugMsg("onEvent_PlayerEnterWorld", "KeyMaster", "Logged in...")
        end
        if isReload then
            KeyMaster:_DebugMsg("onEvent_PlayerEnterWorld", "KeyMaster", "Reloaded UI...")
        end        

        -- creates the UI but only when bliz data is avaiable from C_MythicPlus
        intializeUIWithRetries()
    end
    if isReload then
        local inGroup = UnitInRaid("player") or IsInGroup()
        if inGroup and GetNumGroupMembers() >= 2 then
            -- Covers scenario where player reloadUI and doesn't have party data anymore.
            -- This sends a request to players in party to resend their data.
            local requestData = {}
            requestData.requestType = "playerData"

            MyAddon:TransmitRequest(requestData)
        end
    end
end

local playerEnterEvents = CreateFrame("Frame")
playerEnterEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
playerEnterEvents:SetScript("OnEvent", onEvent_PlayerEnterWorld)