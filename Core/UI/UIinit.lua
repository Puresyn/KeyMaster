local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface

function MainInterface:Initialize()
    -- Creates UI structure, but making sure we only create the frames once IF they're not in _G[] Global namespace.
    local mainFrame = _G["KeyMaster_MainFrame"] or MainInterface:CreateMainFrame()
    local mainHeader = _G["KeyMaster_HeaderFrame"] or MainInterface:CreateHeaderFrame(mainFrame)
    
    -- Create tabs
    local tabContents = MainInterface:CreatePartyFrame(mainFrame)
    local tab = MainInterface:CreateTab(mainFrame, 1, "Party", tabContents, true)

    -- testing multiple tabs
    local tempFrame = CreateFrame("Frame", "KeyMaster_TempFrame", mainFrame);
    tempFrame:SetSize(mainFrame:GetWidth(), mainFrame:GetHeight())
    tempFrame:SetAllPoints(true)
    tempFrame:Hide()

    local tab2 = MainInterface:CreateTab(mainFrame, 2, "Config", tempFrame, false)
    
    return mainFrame
end

function MainInterface:Toggle()
    -- Shows/Hides the main interface - will only create the windows once, otherwise it holds the window pointer
    local mainUI = _G["KeyMaster_MainFrame"] or MainInterface:Initialize()
    mainUI:SetShown(not mainUI:IsShown())
end