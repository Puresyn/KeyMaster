local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface
local ViewModel = KeyMaster.ViewModel

function MainInterface:Initialize()
    -- Creates UI structure, but making sure we only create the frames once IF they're not in _G[] Global namespace.
    local mainFrame = _G["KeyMaster_MainFrame"] or MainInterface:CreateMainFrame()
    local addonIcon = _G["KeyMaster_Icon"] or MainInterface:createAddonIcon(mainFrame)
    local headerRegion = _G["KeyMaster_HeaderRegion"] or MainInterface:CreateHeaderRegion(mainFrame)
    local headerContent = _G["KeyMaster_HeaderFrame"] or MainInterface:CreateHeaderContent(headerRegion)
    local contentRegion =  _G["KeyMaster_ContentRegion"] or MainInterface:CreateContentRegion(mainFrame, headerRegion);
    local partyContent = _G["KeyMaster_PartyScreen"] or MainInterface:CreatePartyFrame(contentRegion);
    local partyRowsFrame = _G["KeyMaster_Frame_Party"] or MainInterface:CreatePartyRowsFrame(partyContent)

    -- create player row frames
    local playerRow = _G["KM_PlayerRow1"] or MainInterface:CreatePartyMemberFrame("player", partyRowsFrame)
    local playerRowData = _G["KM_PlayerDataFrame1"] or MainInterface:CreatePartyDataFrame(playerRow)
    local partyScoreTally = _G["PartyTallyFooter"] or MainInterface:CreatePartyScoreTallyFooter()

    -- create party row frames
    local maxPartySize = 4
    for i=1,maxPartySize,1 do
      local partyRow = MainInterface:CreatePartyMemberFrame("party"..i, _G["KM_PlayerRow"..i])
      local partyRowDataFrames = MainInterface:CreatePartyDataFrame(partyRow)
      partyRow:Hide()
    end

    -- Create tabs
    local tabContents = partyContent
    local partyTab = _G["KeyMaster_MainFrameTab1"] or MainInterface:CreateTab(mainFrame, 1, "Party", tabContents, true)

    -- testing multiple tabs
    local tempFrame = _G["KeyMaster_TempFrame"] or CreateFrame("Frame", "KeyMaster_TempFrame", mainFrame);
    tempFrame:SetSize(mainFrame:GetWidth(), mainFrame:GetHeight())
    tempFrame:SetAllPoints(true)
    tempFrame:Hide()

    local configTab = _G["KeyMaster_MainFrameTab2"] or MainInterface:CreateTab(mainFrame, 2, "Config", tempFrame, false)

    Tab_OnClick(partyTab)

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