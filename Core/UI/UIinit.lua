local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface
local HeaderFrame = KeyMaster.HeaderFrame
local ConfigFrame = KeyMaster.ConfigFrame
local InfoFrame = KeyMaster.InfoFrame
local PlayerFrame = KeyMaster.PlayerFrame
local PartyFrame = KeyMaster.PartyFrame

function MainInterface:Initialize()
  -- Creates UI structure, but making sure we only create the frames once IF they're not in _G[] Global namespace.

  -- Main Parent Frame
  local mainFrame = _G["KeyMaster_MainFrame"] or MainInterface:CreateMainFrame()    
  local addonIcon = _G["KeyMaster_Icon"] or MainInterface:CreateAddonIcon(mainFrame)
    
  -- Main Header
  local headerRegion = HeaderFrame:Initialize(mainFrame)

  -- Main Content Region
  local contentRegion =  _G["KeyMaster_ContentRegion"] or MainInterface:CreateContentRegion(mainFrame, headerRegion)

  -- Player Tab Content
  local playerTabContent = PlayerFrame:Initialize(contentRegion)

  -- Party Tab Content
  local partyTabContent = PartyFrame:Initialize(contentRegion)

  -- Config Tab
  local configContent = _G["KM_Configuration_Frame"] or ConfigFrame:CreateConfigFrame(contentRegion)

  -- Info Tab
  local infoContent = _G["KM_Info_Frame"] or InfoFrame:CreateInfoFrame(contentRegion)

  -- Create tabs
  local playerTab = _G["KeyMaster_MainFrameTab1"] or MainInterface:CreateTab(mainFrame, 1, "Player", playerTabContent, true)
  local partyTab = _G["KeyMaster_MainFrameTab2"] or MainInterface:CreateTab(mainFrame, 2, "Party", partyTabContent, true)
  local configTab = _G["KeyMaster_MainFrameTab3"] or MainInterface:CreateTab(mainFrame, 3, "Configuration", configContent, false)
  local infoTab = _G["KeyMaster_MainFrameTab4"] or MainInterface:CreateTab(mainFrame, 4, "Information", infoContent, false)

  if(UnitInParty("player")) then
    Tab_OnClick(partyTab)
  else
    Tab_OnClick(playerTab)
  end

  return mainFrame
end

function MainInterface:Toggle()
-- Shows/Hides the main interface - will only create the windows once, otherwise it holds the window pointer
  local mainUI = _G["KeyMaster_MainFrame"] or MainInterface:Initialize()
  mainUI:SetShown(not mainUI:IsShown())
end