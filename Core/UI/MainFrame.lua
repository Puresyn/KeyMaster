local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface

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

    return mainFrame
end