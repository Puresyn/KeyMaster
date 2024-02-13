local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface

function MainInterface:Toggle()
    -- Shows/Hides the main interface - will only create the windows once, otherwise it holds the window pointer
    local mainUI = MainInterface.mainPanel
    mainUI:SetShown(not mainUI:IsShown())
end

-- Create the Inteface frames ONCE.
local function UI_init()
    local mainPanel = MainInterface.mainPanel -- get the existing UI
    if (not ui) then

        -- build out the UI framework
        local mainPanel  = MainInterface.CreateMainInterface()
    end
    return mainPanel
end

MainInterface.mainPanel = UI_init()