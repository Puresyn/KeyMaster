--------------------------------
-- KMInit.lua
-- Handles addon initialization
--------------------------------

--------------------------------
-- Namespace
--------------------------------
local _, core = ...
local MainInterface = core.MainInterface
local PlayerInfo = core.PlayerInfo
local Coms = core.Coms

--------------------------------
-- Globals
--------------------------------
KM_ADDON_NAME = "Key Master"
KM_VERSION_MAJOR = 0 -- Single digit major version release number
KM_VERSION_MINOR = 0.3 -- float value minor version release number
KM_VERSION_STATUS = "beta" -- "beta" or "release - for display and update notification purposes"
KM_VERSION = tostringall("v"..KM_VERSION_MAJOR.."."..KM_VERSION_MINOR.."-"..KM_VERSION_STATUS) -- for display purposes

--------------------------------
-- todo:
--------------------------------
-- Integrate Localization

--------------------------------
-- Slash Commands and command menu
--------------------------------
core.commands = {
    ["config"] = core.Config.Toggle,
    ["show"] = core.MainInterface.Toggle,
    ["help"] = function() 
        local themeTextColor = select(4, core.Config:GetThemeColor()):upper()
        local themeYellowTextColor = select(4, core.Config:GetTextColorYellow()):upper()
        print("=====================")
        core:Print("List of slash commands:")
        core:Print("|cff"..themeTextColor.."/km|r |cff"..themeYellowTextColor.."show|r - shows the main window.")

        -- todo: change this to open the config on the new tab system instead of a new window
        core:Print("|cff"..themeTextColor.."/km|r |cff"..themeYellowTextColor.."config|r - shows the configuration menu.")

        core:Print("|cff"..themeTextColor.."/km|r |cff"..themeYellowTextColor.."help|r - shows this menu.")
        print("=====================")
    end,
    -- Sample nested command line functions
    ["example"] = {
        ["test"] = function(...)
            core:Print("My Value:", tostringall(...))
        end
    }

}

-- Bindings.xml functions - for key bindings
function KMWindowBindingToggle()
    core.MainInterface.Toggle()
end

-- Slash commands handler
local function HandleSlashCommands(str)
 
    -- /km
    if (#str == 0) then
        core.commands.show()
        return
    end

    -- processes any passed arguments /km [args]
    local args = {}
	for _, arg in ipairs({ string.split(' ', str) }) do
		if (#arg > 0) then
			table.insert(args, arg)
		end
	end

    local path = core.commands

    -- itterate and process all command line arguments via core.commands table
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
				-- command does not exist!
				core.commands.show()
				return;
			end
		end
	end

end

-- formats strings for end-user display in the chat box
function core:Print(...)
    local hex = select(4, self.Config:GetThemeColor());
    local prefix = string.format("|cff%s%s|r", hex:upper(), "Key Master:");	
    DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", prefix, ...));
end

--------------------------------
-- Event Hander which verifies
-- this addon has loaded then
-- runs scripts accordingly:
--------------------------------
function core:init(event, name, ...)
    if (name ~= "KeyMaster") then return end -- if it's not this addon calling it, ignore the event

    -- Enables using arrow keys in edit boxes (not currently in use)
    for i = 1, NUM_CHAT_WINDOWS do
        _G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false)
    end

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
    -- for ref: local _, myClass, _ = UnitClass("player")
    local myName = UnitName("player")
    core:Print("Welcome back", "|cff"..core.PlayerInfo:GetMyClassColor()..myName.."|r!")
end

function onEvent_Group(self, event, ...)
    --print(event, ...)
    
    if (event == "GROUP_JOINED") then
        local partySize, partyId = ...
        -- Create MainInterface:PartyPlayerData variable (stores all party information)
        local playerInfo = PlayerInfo:GetMyCharacterInfo()
        
        -- only transmit if in a party
        if (GetNumGroupMembers() > 0) then
            MyAddon:Transmit(playerInfo, "PARTY", nil)
        end
    elseif (event == "GROUP_LEFT") then
        local partySize, partyId = ...
        -- Destroy MainInterface:PartyPlayerData variable (stores all party information)
    elseif (event == "GROUP_ROSTER_UPDATE") then
        -- triggers when in party and roster changes (NOT LEAVING OR JOINING)
        -- Refresh Party Frames
    end

    MainInterface:Refresh_PartyFrames()
end

-- Event Registration
local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:RegisterEvent("CHAT_MSG_ADDON")
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:SetScript("OnEvent", core.init)

local events2 = CreateFrame("Frame")
events2:RegisterEvent("GROUP_JOINED")
events2:RegisterEvent("GROUP_LEFT")
events2:RegisterEvent("GROUP_ROSTER_UPDATE")
events2:SetScript("OnEvent", onEvent_Group)