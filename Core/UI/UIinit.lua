local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface
local Header = KeyMaster.Header
local ViewModel = KeyMaster.ViewModel
local ConfigFrame = KeyMaster.ConfigFrame
local InfoFrame = KeyMaster.InfoFrame
local PlayerFrame = KeyMaster.PlayerFrame

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
    local mainFrame = _G["KeyMaster_MainFrame"] or MainInterface:CreateMainFrame()
    local addonVersionNotify = _G["KM_AddonOutdated"] or MainInterface:AddonVersionNotify(mainFrame)
    local addonIcon = _G["KeyMaster_Icon"] or MainInterface:createAddonIcon(mainFrame)
    local headerRegion = _G["KeyMaster_HeaderRegion"] or MainInterface:CreateHeaderRegion(mainFrame)
    local headerContent = _G["KeyMaster_HeaderFrame"] or MainInterface:CreateHeaderContent(headerRegion)
    local headerInfoBox = Header:createPlayerInfoBox(headerContent)
    createAffixFramesWithRetries(headerInfoBox)
    local headerKey = _G["KeyMaster_MythicKeyHeader"] or Header:createHeaderKeyFrame(headerContent, headerInfoBox)
    
    --local headerRaiting = _G["KeyMaster_RatingFrame"] or Header:createHeaderRating(headerInfoBox)
    local contentRegion =  _G["KeyMaster_ContentRegion"] or MainInterface:CreateContentRegion(mainFrame, headerRegion);
    local partyContent = _G["KeyMaster_PartyScreen"] or MainInterface:CreatePartyFrame(contentRegion);
    local partyRowsFrame = _G["KeyMaster_Frame_Party"] or MainInterface:CreatePartyRowsFrame(partyContent)
    local configContent = _G["KM_Configuration_Frame"] or ConfigFrame:CreateConfigFrame(contentRegion)
    local infoContent = _G["KM_Info_Frame"] or InfoFrame:CreateInfoFrame(contentRegion)
    local playerContent = _G["KM_Player_Frame"] or PlayerFrame:CreatePlayerFrame(contentRegion)
    local playerInfoFrame = _G["KM_PlayerFrameInfo"] or PlayerFrame:CreateMapData(playerContent)
   

    -- create player row frames
    local playerRow = _G["KM_PlayerRow1"] or MainInterface:CreatePartyMemberFrame("player", partyRowsFrame)
    local playerRowData = _G["KM_PlayerDataFrame1"] or MainInterface:CreatePartyDataFrame(playerRow)

    
    -- create party row frames
    local maxPartySize = 4
    for i=1,maxPartySize,1 do
      local partyRow = MainInterface:CreatePartyMemberFrame("party"..i, _G["KM_PlayerRow"..i])
      local partyRowDataFrames = MainInterface:CreatePartyDataFrame(partyRow)
      partyRow:Hide()
    end

    -- create io score tally frames
    local partyScoreTally = _G["PartyTallyFooter"] or MainInterface:CreatePartyScoreTallyFooter()

    -- Create tabs
    local playerTab = _G["KeyMaster_MainFrameTab1"] or MainInterface:CreateTab(mainFrame, 1, "Player", playerContent, true)
    local partyTab = _G["KeyMaster_MainFrameTab2"] or MainInterface:CreateTab(mainFrame, 2, "Party", partyContent, true)
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
    ViewModel:UpdateUnitFrameData("player", unitData)

    mainUI:SetShown(not mainUI:IsShown())
end