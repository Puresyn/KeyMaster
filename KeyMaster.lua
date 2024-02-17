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
KM_ADDON_NAME = "Key Master"
KM_VERSION_MAJOR = 0 -- Single digit major version release number
KM_VERSION_MINOR = 0.3 -- float value minor version release number
KM_VERSION_STATUS = "alpha" -- "beta" or "release - for display and update notification purposes"
KM_VERSION = tostringall("v"..KM_VERSION_MAJOR.."."..KM_VERSION_MINOR.."-"..KM_VERSION_STATUS) -- for display purposes

--------------------------------
-- Slash Commands and command menu
--------------------------------
KeyMaster.Commands = {
    ["show"] = KeyMaster.MainInterface.Toggle,
    ["help"] = function() 
        local defaultColor = select(4, ColorTheme:GetThemeColor("default")):upper()
        local color = select(4, ColorTheme:GetThemeColor("themeFontColorYellow")):upper()
        print("=====================")
        KeyMaster:Print("List of slash commands:")
        KeyMaster:Print("|cff"..defaultColor.."/km|r |cff"..color.."show|r - shows the main window.")
        KeyMaster:Print("|cff"..defaultColor.."/km|r |cff"..color.."help|r - shows this menu.")
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
    local prefix = string.format("|cff%s%s|r", hex:upper(), "KeyMaster:");	
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
    SLASH_KeyMaster1 = "/km"
    SLASH_KeyMaster2 = "/keymaster"
    SlashCmdList.KeyMaster = HandleSlashCommands
    
    -- Welcome message
    local hexColor = CharacterInfo:GetMyClassColor("player")
    KeyMaster:Print("Welcome back", "|cff"..hexColor..UnitName("player").."|r!")

    -- Initialize UI - doing this here seems to break things,
    --MainInterface:Initialize()
end

local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:SetScript("OnEvent", OnEvent_AddonLoaded)

-- Party Changes Events
local function onEvent_PartyChanges(self, event, ...)
    --print(event, ...)
    
    if (event == "GROUP_JOINED") then
        local partySize, partyId = ...
        local playerData = UnitData:GetUnitDataByUnitId("player")
                
        -- Send data to party members
        MyAddon:Transmit(playerData, "PARTY", nil)
    elseif (event == "GROUP_LEFT") then
        local partySize, partyId = ...
        UnitData:DeleteAllUnitData()

        -- hide all party frames
        -- if _G["KeyMaster_MainFrame"] ~= nil then
        --     KeyMaster.ViewModel:HideAllPartyFrame()
        -- end
        
    elseif (event == "GROUP_ROSTER_UPDATE") then
        local inGroup = UnitInRaid("player") or IsInGroup()
        if inGroup and GetNumGroupMembers() >= 2 then
            -- destroy all party data
            UnitData:DeleteAllUnitData()
            -- update self data
            local playerUnit = UnitData:GetUnitDataByUnitId("player")
            -- Transmit
            MyAddon:Transmit(playerUnit, "PARTY", nil)

            -- update party units
            if (UnitName("party1") ~= nil) then
                local emptyUnitData = {}
                emptyUnitData.GUID = UnitGUID("party1")
                emptyUnitData.name = UnitName("party1")
                emptyUnitData.hasAddon = false
                UnitData:SetUnitData(emptyUnitData)               
            else
                _G["KM_PlayerRow2"]:Hide()
            end
            if (UnitName("party2") ~= nil) then
                local emptyUnitData = {}
                emptyUnitData.GUID = UnitGUID("party2")
                emptyUnitData.name = UnitName("party2")
                emptyUnitData.hasAddon = false
                UnitData:SetUnitData(emptyUnitData)               
            else
                _G["KM_PlayerRow3"]:Hide()
            end
            if (UnitName("party3") ~= nil) then
                local emptyUnitData = {}
                emptyUnitData.GUID = UnitGUID("party3")
                emptyUnitData.name = UnitName("party3")
                emptyUnitData.hasAddon = false
                UnitData:SetUnitData(emptyUnitData)               
            else
                _G["KM_PlayerRow4"]:Hide()
            end
            if (UnitName("party4") ~= nil) then
                local emptyUnitData = {}
                emptyUnitData.GUID = UnitGUID("party4")
                emptyUnitData.name = UnitName("party4")
                emptyUnitData.hasAddon = false
                UnitData:SetUnitData(emptyUnitData)               
            else
                _G["KM_PlayerRow5"]:Hide()
            end
        end
    end
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

    -- Create UI frames
    MainInterface:Initialize()

    C_Timer.After(1, function()
        -- Get player data
        local playerData = CharacterInfo:GetMyCharacterInfo()

        -- Stores Data AND shows associated ui frame
        UnitData:SetUnitData(playerData)
    end)  

    
end

local playerEnterEvents = CreateFrame("Frame")
playerEnterEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
playerEnterEvents:SetScript("OnEvent", onEvent_PlayerEnterWorld)