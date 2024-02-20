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

-- Global Variables
KM_ADDON_NAME = KeyMasterLocals.ADDONNAME
KM_AUTOVERSION = '0.0.5' -- DO NOT EDIT!
KM_VERSION_STATUS = KeyMasterLocals.BUILDALPHA -- BUILDALPHA BUILDBETA BUILDRELEASE - for display and update notification purposes"
KM_VERSION = tostringall("v"..KM_AUTOVERSION.."-"..KM_VERSION_STATUS) -- for display purposes

--------------------------------
-- Slash Commands and command menu
--------------------------------
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
    ["example"] = {
        ["test"] = function(...)
            KeyMaster:Print("My Value:", tostringall(...))
        end
    }
}

-- Slash commands handler
local function HandleSlashCommands(str)
 
    -- /km
    if (#str == 0) then
        KeyMaster.Commands.show()
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
				KeyMaster.Commands.show()
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
    
    -- Welcome message
    local hexColor = CharacterInfo:GetMyClassColor("player")
    KeyMaster:Print(KeyMasterLocals.WELCOMEMESSAGE, "|cff"..hexColor..UnitName("player").."|r"..KeyMasterLocals.EXCLIMATIONPOINT)
end

local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:SetScript("OnEvent", OnEvent_AddonLoaded)

local lastPartyEvent = ""
local function onEvent_PartyChanges(self, event, ...)
    --print(event, ...)
    
    if (event == "GROUP_JOINED") then
        -- fetch self data
        local playerUnit = UnitData:GetUnitDataByUnitId("player")
        -- Transmit unit data to party members with addon
        MyAddon:Transmit(playerUnit, "PARTY", nil) -- STORES DATA #2 IN RETRIEVE COMS
        lastPartyEvent = "GROUP_JOINED"
    end
    if (event == "GROUP_LEFT") then
        --local partySize, partyId = ...
        -- purge all party data EXCEPT player        
        UnitData:DeleteAllUnitData()
        -- process party1-4 state
        UnitData:MapPartyUnitData()
        -- sets this as the last party event occured
        lastPartyEvent = "GROUP_LEFT"       
    end
    if (event == "GROUP_ROSTER_UPDATE") then
        -- This is checked because when a player joins a party it fires two events e.g., GROUP_LEFT and GROUP_ROSTER_UPDATE.  We only want to process this once.
        -- skip this event since it was all processed in the last one OR not needed
        if lastPartyEvent == "GROUP_LEFT" or lastPartyEvent == "GROUP_JOINED" then
            lastPartyEvent = "GROUP_ROSTER_UPDATE"
            return
        end
        
        -- The following resets the party data then repopulates it.
        local inGroup = UnitInRaid("player") or IsInGroup()
        if inGroup and GetNumGroupMembers() >= 2 then
            -- destroy all party data
            -- UnitData:DeleteAllUnitData()
        end
        lastPartyEvent = "GROUP_ROSTER_UPDATE"
    end

    -- process party1-4 with min. data
    UnitData:MapPartyUnitData()-- STORES DATA #3 IN RETRIEVE COMS
end

local partyEvents = CreateFrame("Frame")
partyEvents:RegisterEvent("GROUP_JOINED")
partyEvents:RegisterEvent("GROUP_LEFT")
partyEvents:RegisterEvent("GROUP_ROSTER_UPDATE")
partyEvents:SetScript("OnEvent", onEvent_PartyChanges)

-- Player Entering World Event
local function onEvent_PlayerEnterWorld(self, event, isLogin, isReload)
    if (event ~= "PLAYER_ENTERING_WORLD") then return end
    
    if (isLogin) then
        -- This section is required because of some C_MythicPlus blizzard functions returning nil without it
        -- see our github issue #6
        C_MythicPlus.RequestCurrentAffixes()
        C_MythicPlus.RequestMapInfo()
        C_MythicPlus.RequestRewards()
        KeyMaster:Print("C_MythicPlus requests sent.")
    end
    if isLogin or isReload then
        -- Create UI frames
        MainInterface:Initialize()

        C_Timer.After(3, function()
            -- Get player data
            local playerData = CharacterInfo:GetMyCharacterInfo()

            -- Stores Data AND shows associated ui frame
            UnitData:SetUnitData(playerData, true)

            -- Changes colors on weekly affixes on unit rows based on current affix week (tyran vs fort)
            MainInterface:SetPartyWeeklyDataTheme() 
        end) 

        -- process party
        local inGroup = UnitInRaid("player") or IsInGroup()
        if inGroup and GetNumGroupMembers() >= 2 then
            print("in player entering world...")
            UnitData:MapPartyUnitData()
        end
    end
end

local playerEnterEvents = CreateFrame("Frame")
playerEnterEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
playerEnterEvents:SetScript("OnEvent", onEvent_PlayerEnterWorld)