--------------------------------
-- Init.lua
-- Handles addon initialization
--------------------------------

--------------------------------
-- Namespace
--------------------------------
local _, KeyMaster = ...
local CharacterInfo = KeyMaster.CharacterInfo
--local MainInterface = KeyMaster.MainInterface

-- Global Variables
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
        local defaultColor = select(4, KeyMaster:GetThemeColor("default")):upper()
        local color = select(4, KeyMaster:GetThemeColor("themeFontColorYellow")):upper()
        print("=====================")
        KeyMaster:Print("List of slash commands:")
        KeyMaster:Print("|cff"..defaultColor.."/km|r |cff"..color.."show|r - shows the main window.")
        KeyMaster:Print("|cff"..defaultColor.."/km|r |cff"..color.."config|r - shows the configuration menu.")
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
    
end

-- formats strings for end-user display in the chat box
function KeyMaster:Print(...)
    local hex = select(4, KeyMaster:GetThemeColor("default"))
    local prefix = string.format("|cff%s%s|r", hex:upper(), "KeyMaster:");	
    DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", prefix, ...));
end

local function OnInitilize(self, event, name, ...)
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
    
    local myCharacterInfo = CharacterInfo:GetMyCharacterInfo()
    TPrint(myCharacterInfo)
end

function TPrint(myTable, indent)
    if not indent then indent = 0 end
    if (type(myTable) == "table") then
        for i, v in pairs(myTable) do
            local formatting = string.rep("   ", indent)..i..": "
            if (type(v) == "table") then
                TPrint(v, indent+1)
            else
                print(formatting..tostring(v))
            end                
        end
    else
        print(myTable)
    end
end

-- Event Registration
local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:SetScript("OnEvent", OnInitilize)