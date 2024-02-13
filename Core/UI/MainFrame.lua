local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface

local function mainFrame_OnLoad(self)
    print("mainFrame Loaded...")
end

function MainInterface:CreateMainFrame()
    local mainFrame = CreateFrame("Frame", "KeyMaster_MainFrame", UIParent, "MainFrameTemplate");
    mainFrame:ClearAllPoints(); -- Fixes SetPoint bug thus far.
    mainFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
    mainFrame:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", 
        edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", 
        tile = false, 
        tileSize = 0, 
        edgeSize = 16, 
        insets = {left = 4, right = 4, top = 4, bottom = 4}})

    mainFrame:SetBackdropColor(0,0,0,1);
    mainFrame:SetScript("OnLoad", mainFrame_OnLoad)

    local fr, mlr, mtb = MainInterface:GetFrameRegions("content", mainFrame)
    local contentFrame = CreateFrame("Frame", "KeyMaster_ContentFrame", mainFrame);
    contentFrame:SetSize(fr.w, fr.h)
    contentFrame:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", mtb, -(100 + (mtb*2)))
    contentFrame.texture = contentFrame:CreateTexture()
    contentFrame.texture:SetAllPoints(contentFrame)
    --ContentFrame.texture:SetTexture("Interface\\AddOns\\KeyMaster\\Imgs\\WHITE8X8")
    contentFrame.texture:SetColorTexture(0, 0, 0, 1)

    mainFrame.closeBtn = CreateFrame("Button", "CloseButton", mainFrame, "UIPanelCloseButton")
    mainFrame.closeBtn:SetPoint("TOPRIGHT")
    mainFrame.closeBtn:SetSize(20, 20)
    mainFrame.closeBtn:SetNormalFontObject("GameFontNormalLarge")
    mainFrame.closeBtn:SetHighlightFontObject("GameFontHighlightLarge")
    mainFrame.closeBtn:SetScript("OnClick", KeyMaster.MainInterface.Toggle)
    mainFrame:Hide()

    return mainFrame
end