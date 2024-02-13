local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface

function MainInterface:Initialize()
    -- Creates UI structure, but making sure we only create the frames once IF they're not in _G[] Global namespace.
    local mainFrame = _G["KeyMaster_MainFrame"] or MainInterface:CreateMainFrame()
    local mainHeader = _G["KeyMaster_HeaderFrame"] or MainInterface:CreateHeaderFrame(mainFrame)
    
    return mainFrame
end

function MainInterface:Toggle()
    -- Shows/Hides the main interface - will only create the windows once, otherwise it holds the window pointer
    local mainUI = _G["KeyMaster_MainFrame"] or Initialize()
    mainUI:SetShown(not mainUI:IsShown())
end