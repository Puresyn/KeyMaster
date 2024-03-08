local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface
local Header = KeyMaster.Header
local PartyFrameMapping = KeyMaster.PartyFrameMapping
local ConfigFrame = KeyMaster.ConfigFrame
local InfoFrame = KeyMaster.InfoFrame
local PlayerFrame = KeyMaster.PlayerFrame
local PartyFrame = KeyMaster.PartyFrame

-- This retry logic is done because the C_MythicPlus API is not always available right away and this frame depends on it.
local function createAffixFramesWithRetries(parent, retryCount)
  if retryCount == nil then retryCount = 0 end
  local seasonalAffixes = KeyMaster.DungeonTools:GetAffixes()
  if seasonalAffixes ~= nil then
    Header:createAffixFrames(parent, seasonalAffixes)
  else
    if retryCount < 5 then
      C_Timer.After(3, function() createAffixFramesWithRetries(parent, retryCount + 1) end)
    else
      KeyMaster:_DebugMsg("createAffixFramesWithRetries", "UIinit", "Failed to create affix frames after 5 retries.")
    end
  end
end

function MainInterface:Initialize()
    -- Creates UI structure, but making sure we only create the frames once IF they're not in _G[] Global namespace.
    
    -- Main Parent Frame
    local mainFrame = _G["KeyMaster_MainFrame"] or MainInterface:CreateMainFrame()    
    local addonIcon = _G["KeyMaster_Icon"] or MainInterface:createAddonIcon(mainFrame)
    
    -- Main Header
    local headerRegion = _G["KeyMaster_HeaderRegion"] or MainInterface:CreateHeaderRegion(mainFrame)
    local headerContent = _G["KeyMaster_HeaderFrame"] or MainInterface:CreateHeaderContent(headerRegion)
    local addonVersionNotify = _G["KM_AddonOutdated"] or MainInterface:AddonVersionNotify(mainFrame)
    local headerInfoBox = Header:createPlayerInfoBox(headerContent)
    createAffixFramesWithRetries(headerInfoBox)
    local headerKey = _G["KeyMaster_MythicKeyHeader"] or Header:createHeaderKeyFrame(headerContent, headerInfoBox)
    local contentRegion =  _G["KeyMaster_ContentRegion"] or MainInterface:CreateContentRegion(mainFrame, headerRegion)
    
    -- Player Tab
    local playerContent = _G["KM_PlayerContentFrame"] or PlayerFrame:CreatePlayerContentFrame(contentRegion)
    local playerFrame = _G["KM_Player_Frame"] or PlayerFrame:CreatePlayerFrame(playerContent)
    local playerMapFrame = _G["KM_PlayerMapInfo"] or PlayerFrame:CreateMapData(playerFrame)
    local playerExtraFrame = _G["KM_PLayerExtraInfo"] or PlayerFrame:CreateExtraInfoFrame(playerMapFrame)
    local PlayerFrameMapDetails = _G["KM_PlayerFrame_MapDetails"] or PlayerFrame:CreateMapDetailsFrame(playerFrame)

    local partyTabContent = PartyFrame:Initialize(contentRegion)

    -- Config Tab
    local configContent = _G["KM_Configuration_Frame"] or ConfigFrame:CreateConfigFrame(contentRegion)

    -- Info Tab
    local infoContent = _G["KM_Info_Frame"] or InfoFrame:CreateInfoFrame(contentRegion)

    -- Create tabs
    local playerTab = _G["KeyMaster_MainFrameTab1"] or MainInterface:CreateTab(mainFrame, 1, "Player", playerContent, true)
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

    -- Maps Frame UI Elements to Data
    local unitData = KeyMaster.UnitData:GetUnitDataByUnitId("player")
    PartyFrameMapping:UpdateUnitFrameData("player", unitData)

    mainUI:SetShown(not mainUI:IsShown())
end