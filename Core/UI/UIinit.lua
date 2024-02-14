local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface

function MainInterface:Initialize()
    -- Creates UI structure, but making sure we only create the frames once IF they're not in _G[] Global namespace.
    local mainFrame = _G["KeyMaster_MainFrame"] or MainInterface:CreateMainFrame()
    local addonIcon = _G["KeyMaster_Icon"] or MainInterface:createAddonIcon(mainFrame)
    local headerRegion = _G["KeyMaster_HeaderRegion"] or MainInterface:CreateHeaderRegion(mainFrame)
    local headerContent = _G["KeyMaster_HeaderFrame"] or MainInterface:CreateHeaderContent(headerRegion)
    local contentRegion =  _G["KeyMaster_ContentRegion"] or MainInterface:CreateContentRegion(mainFrame, headerRegion);
    local partyContent = _G["KeyMaster_PartyScreen"] or MainInterface:CreatePartyFrame(contentRegion);
    local partyRowsFrame = _G["KeyMaster_Frame_Party"] or MainInterface:CreatePartyRowsFrame(partyContent)
    local playerRow = _G["KM_PlayerRow1"] or MainInterface:CreatePartyMemberFrame("KM_PlayerRow1", partyRowsFrame)
    local playerPartyData = _G["KM_PlayerDataFrame1"] or MainInterface:CreatePartyDataFrame(playerRow)
    
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
    mainUI:SetShown(not mainUI:IsShown())
end