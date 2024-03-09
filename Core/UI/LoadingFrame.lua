local _, KeyMaster = ...
local LoadingScreen = {}
LoadingScreen = KeyMaster.LoadingScreen
local MainInterface = KeyMaster.MainInterface
local Theme = KeyMaster.Theme

local function CreateLoadingContent(parentFrame)

    -- Contents
    local MediaPath = "Interface/Addons/KeyMaster/Assets/Images/"
    local LoadingContent = CreateFrame("Frame", "KeyMaster_HeaderFrameContent", parentFrame);
    LoadingContent:SetSize(parentFrame:GetWidth(), parentFrame:GetHeight())
    LoadingContent:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 0, 0)

    LoadingContent.background = LoadingContent.CreateTexture(nil, "BACKGROUND")
    LoadingContent.background:SetPoint("CENTER")
    LoadingContent.background:SetSize(parentFrame:GetWidth(), parentFrame:GetHeight())
    LoadingContent.background.SetTexture(MediaPath..Theme.style)
    LoadingContent.background:SetTexCoord(0, 856/1024, 360/1024, parentFrame:GetHeight()/1024)
    
    
    LoadingContent.logo = LoadingContent:CreateTexture(nil, "OVERLAY")
    LoadingContent.logo:SetPoint("CENTER", LoadingContent, "TOP", 0, -20)
    LoadingContent.logo:SetSize(280, 34)
    LoadingContent.logo:SetTexture(MediaPath..Theme.style)
    LoadingContent.logo:SetTexCoord(20/1024, 353/1024, 970/1024, 1010/1024)
    
    local VersionText = LoadingContent:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    VersionText:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT", -24, -2)
    VersionText:SetText(KM_VERSION)

end

function LoadingScreen:CreateLoadingFrame()
    local LoadingFrame = CreateFrame("Frame", "KeyMaster_LoadingFrame", UIParent, "MainFrameTemplate");
    LoadingFrame:SetClampedToScreen( true )
    LoadingFrame:ClearAllPoints()
    LoadingFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
    LoadingFrame:SetBackdrop({bgFile="", 
        edgeFile="Interface\\AddOns\\KeyMaster\\Assets\\Images\\UI-Border", 
        tile = false, 
        tileSize = 0, 
        edgeSize = 16, 
        insets = {left = 4, right = 4, top = 4, bottom = 4}})


    --[[ mainFrame.closeBtn = CreateFrame("Button", "CloseButton", mainFrame, "UIPanelCloseButton")
    mainFrame.closeBtn:SetPoint("TOPRIGHT")
    mainFrame.closeBtn:SetSize(20, 20)
    mainFrame.closeBtn:SetNormalFontObject("GameFontNormalLarge")
    mainFrame.closeBtn:SetHighlightFontObject("GameFontHighlightLarge") ]]

    CreateLoadingContent(LoadingFrame)
    return LoadingFrame
end