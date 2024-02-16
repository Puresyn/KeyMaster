local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface
local CharacterInfo = KeyMaster.CharacterInfo
local UnitData = KeyMaster.UnitData

-- globals
KeyMaster_UpdateInterval = 2.0; -- How often the KeyMaster_OnUpdate code will run (in seconds)

function MainInterface:Initialize()
    -- Creates UI structure, but making sure we only create the frames once IF they're not in _G[] Global namespace.
    local mainFrame = _G["KeyMaster_MainFrame"] or MainInterface:CreateMainFrame()
    local addonIcon = _G["KeyMaster_Icon"] or MainInterface:createAddonIcon(mainFrame)
    local headerRegion = _G["KeyMaster_HeaderRegion"] or MainInterface:CreateHeaderRegion(mainFrame)
    local headerContent = _G["KeyMaster_HeaderFrame"] or MainInterface:CreateHeaderContent(headerRegion)
    local contentRegion =  _G["KeyMaster_ContentRegion"] or MainInterface:CreateContentRegion(mainFrame, headerRegion);
    local partyContent = _G["KeyMaster_PartyScreen"] or MainInterface:CreatePartyFrame(contentRegion);
    local partyRowsFrame = _G["KeyMaster_Frame_Party"] or MainInterface:CreatePartyRowsFrame(partyContent)

    local playerRow = _G["KM_PlayerRow1"] or MainInterface:CreatePartyMemberFrame("player", partyRowsFrame)
    local playerRowData = _G["KM_PlayerDataFrame1"] or MainInterface:CreatePartyDataFrame(playerRow)

    local maxPartySize = 4
    for i=1,maxPartySize,1 do
      local partyRow = MainInterface:CreatePartyMemberFrame("party"..i, _G["KM_PlayerRow"..i])
      local partyRowDataFrames = MainInterface:CreatePartyDataFrame(partyRow)
      partyRow:Hide()
    end

    -- Create tabs
    local tabContents = partyContent
    local tab = MainInterface:CreateTab(mainFrame, 1, "Party", tabContents, true)

    -- testing multiple tabs
    local tempFrame = CreateFrame("Frame", "KeyMaster_TempFrame", mainFrame);
    tempFrame:SetSize(mainFrame:GetWidth(), mainFrame:GetHeight())
    tempFrame:SetAllPoints(true)
    tempFrame:Hide()

    local tab2 = MainInterface:CreateTab(mainFrame, 2, "Config", tempFrame, false)

    Tab_OnClick(tab)

    return mainFrame
end

function MainInterface:Toggle()
    -- Shows/Hides the main interface - will only create the windows once, otherwise it holds the window pointer
    local mainUI = _G["KeyMaster_MainFrame"] or MainInterface:Initialize()

    -- Maps Frame UI Elements to Data
    MainInterface:UpdateUnitFrameData("player")

    mainUI:SetShown(not mainUI:IsShown())
end

--------------------------------
-- Global data refresh timer,       
-- This only runs when the frame
-- it is attached to is visible.
-- Currently attached to the main
-- interface panel in
-- MainFrameTemplate.xml onLoad
--------------------------------

function KeyMaster_OnUpdate(self, elapsed)
  self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed; 	

  if (self.TimeSinceLastUpdate > KeyMaster_UpdateInterval) then

    MainInterface:UpdateUnitFrameData("player")
    
    self.TimeSinceLastUpdate = 0;
  end
end

-- Close addon window any time we cast a spell -- DOES NOT WORK BECAUSE THIS FUNCTION IS NOT SECURE
--[[ function MainInterface:hideOnSpellCast()
    local mainUI = _G["KeyMaster_MainFrame"]
    if (mainUI) then 
        mainUI:Hide()
    end
end
hooksecurefunc("CastSpellByName", MainInterface:hideOnSpellCast()) ]]