local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface
KM_PLAYER_IN_COMBAT = false

-- mainFrame hide handler for events
local function hideOnEvent(frame)
    if frame and frame:IsShown() then
        frame:Hide() 
    end
end

function MainInterface:CreateMainFrame()
    local yOfs = KeyMaster_DB.addonConfig.interfaceFramePos.yOfs
    local xOfs = KeyMaster_DB.addonConfig.interfaceFramePos.xOfs
    local relativePoint = KeyMaster_DB.addonConfig.interfaceFramePos.relativePoint
    if (yOfs == nil) then yOfs = 0 end
    if (xOfs == nil) then xOfs = 0 end
    if (relativePoint == nil) then relativePoint = "CENTER" end
    local mainFrame = CreateFrame("Frame", "KeyMaster_MainFrame", UIParent, "MainFrameTemplate");
    mainFrame:SetClampedToScreen( true )
    mainFrame:ClearAllPoints(); -- Fixes SetPoint bug thus far.
    mainFrame:SetPoint(relativePoint, "UIParent", relativePoint, xOfs, yOfs)
    mainFrame:SetBackdrop({bgFile="", 
        edgeFile="Interface\\AddOns\\KeyMaster\\Assets\\Images\\UI-Border", 
        tile = false, 
        tileSize = 0, 
        edgeSize = 16, 
        insets = {left = 4, right = 4, top = 4, bottom = 4}})


    mainFrame.closeBtn = CreateFrame("Button", "CloseButton", mainFrame, "UIPanelCloseButton")
    mainFrame.closeBtn:SetPoint("TOPRIGHT")
    mainFrame.closeBtn:SetSize(20, 20)
    mainFrame.closeBtn:SetNormalFontObject("GameFontNormalLarge")
    mainFrame.closeBtn:SetHighlightFontObject("GameFontHighlightLarge")

    mainFrame:Hide()

    -- Closes Key Master whenever a spell is cast or an ability is used
    hooksecurefunc("CastSpellByName", function() hideOnEvent(mainFrame) end)
    hooksecurefunc("CastSpellByID", function() hideOnEvent(mainFrame) end)

    --[[ Commented the following line out because it prevents /km to be used in a macro.
    May need to find a better solution if it becomes an issue. ]]
    --hooksecurefunc("UseAction", function() hideOnEvent(mainFrame) end)

    
    return mainFrame
end

-- this avoids hide() show() taint issues
-- handles combat states and opens window if client tried while in combat.
local combatTrackerFrame = CreateFrame("Frame")
combatTrackerFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
combatTrackerFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
combatTrackerFrame:SetScript("OnEvent", function(self, event,...)
    if event == "PLAYER_REGEN_ENABLED" then
        KM_PLAYER_IN_COMBAT = false
        KeyMaster.EventHooks:ProcessCombatQueue()
        if KM_shownCombatMessage == 1 then
            MainInterface:Toggle()
        end
        KM_shownCombatMessage = 0
    elseif event == "PLAYER_REGEN_DISABLED" then
        KM_PLAYER_IN_COMBAT = true
        hideOnEvent(_G["KeyMaster_MainFrame"])
    end
end)