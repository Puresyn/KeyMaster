--------------------------------
-- KMUI.lua
-- Handles creation of the addon's user interface
--------------------------------

--------------------------------
-- Namespace
--------------------------------
local _, core = ...
core.MainInterface = {}
core.KeyMaster = {}

local MainInterface = core.MainInterface
--local UIWindow
local MainPanel
KeyMaster = core.KeyMaster

--------------------------------
-- UI Functions
--------------------------------
function MainInterface:Toggle()
    -- Shows/Hides the main interface - will only create the window once, otherwise it holds the window pointer
    local mainUI = MainPanel or MainInterface.CreateMainPanel()
    mainUI:SetShown(not mainUI:IsShown())
end


-- F:\Games\World of Warcraft\_retail_\BlizzardInterfaceCode\Interface\SharedXML\SharedUIPanelTemplates.xml
-- Dynamic Buttons? https://www.wowinterface.com/forums/showthread.php?t=53126

-- XML Template

function KeyMaster:Initialize()
end

local function uiEventHandler(self, event, ...)
    local arg1 = select(1, ...);
    -- Do something with event and arg1
    core:Print("UI Event Handler Called.");
    for key, value in pairs(self) do
        core:Print(tostringall(key), tostringall(value))
    end
    core:Print("Event:",event)
    core:Print("Args:", tostringall(...))
 end;


--------------------------------
-- Create Tabs
--------------------------------
-- Setup main UI information regions
-- I've seperated this info to build up to a template system
function GetFrameRegions(myRegion)
    local p, w, h, mh, mw
    local r = myRegion
    if (not r) then return end

    mh = MainPanel:GetHeight()
    mw = MainPanel:GetWidth()
    -- p = points, w = width, h = height
    if (r == "header") then
        myRegionInfo = {
            w = mw - 8,
            h = mh - 668
    } 
    elseif (r == "content") then
        myRegionInfo = {
            w = mw - 8,
            h = mh - 100
        }
    else return
    end

    return myRegionInfo
end
-- Setup header frame
function MainInterface.Headerframe()
    local fr = GetFrameRegions("header")
    HeaderFrame = CreateFrame("Frame", "KeyMaster_HeaderRegion", MainPanel);
    HeaderFrame:SetSize(fr.w, fr.h)
    HeaderFrame:SetPoint("TOPLEFT", MainPanel, "TOPLEFT", 4, -4)
    HeaderFrame.texture = HeaderFrame:CreateTexture()
    HeaderFrame.texture:SetAllPoints(HeaderFrame)
    HeaderFrame.texture:SetColorTexture(0.871, 0.871, 0.871, 1)
    return HeaderFrame
end

-- Setup content frame
function MainInterface.ContentFrame()
    local fr = GetFrameRegions("content")
    ContentFrame = CreateFrame("Frame", "KeyMaster_ContentRegion", MainPanel);
    ContentFrame:SetSize(fr.w, fr.h)
    ContentFrame:SetPoint("TOPLEFT", MainPanel, "TOPLEFT", 4, -104)
    ContentFrame.texture = ContentFrame:CreateTexture()
    ContentFrame.texture:SetAllPoints(ContentFrame)
    ContentFrame.texture:SetColorTexture(0.729, 0.729, 0.729, 1)
    return ContentFrame
end

-- Setup tab strip frame
function MainInterface.TabStrip()
end

-- Tabs
function MainInterface:MainScreen()
    local txtPlaceHolder
    MainScreen = CreateFrame("Frame", "KeyMaster_MainScreen", MainPanel);
    --MainScreen:SetSize(100, 100)
    MainScreen:SetSize(MainPanel:GetWidth(), MainPanel:GetHeight())
    MainScreen:SetPoint("BOTTOMLEFT", MainPanel, "BOTTOMLEFT", 0, 0)
    MainScreen.texture = MainScreen:CreateTexture()
    MainScreen.texture:SetAllPoints(MainScreen)
    --MainScreen.texture:SetTexture("Interface\\AddOns\\KeyMaster\\Imgs\\WHITE8X8")
    MainScreen.texture:SetColorTexture(0.231, 0.231, 0.231, 1)
    txtPlaceHolder = MainScreen:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    local Path, _, Flags = txtPlaceHolder:GetFont()
    txtPlaceHolder:SetFont(Path, 30, Flags)
    txtPlaceHolder:SetPoint("BOTTOMLEFT", 50, 50)
    txtPlaceHolder:SetTextColor(1, 1, 1)
    txtPlaceHolder:SetText("Main Screen")
    return MainScreen
end

function MainInterface:ConfigScreen()
    local txtPlaceHolder
    ConfigScreen = CreateFrame("Frame", "KeyMaster_MainScreen", MainPanel);
    ConfigScreen:SetSize(ConfigScreen:GetParent():GetWidth(), 100)
    ConfigScreen:SetPoint("BOTTOMLEFT", MainPanel, "BOTTOMLEFT", 0, 0)
   --[[  ConfigScreen:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", 
        edgeFile="", 
        tile = false, 
        tileSize = 0, 
        edgeSize = 0, 
        insets = {left = 0, right = 0, top = 0, bottom = 0}})
    ConfigScreen:SetBackdropColor(120,120,120,1); -- color for testing ]]
    txtPlaceHolder = ConfigScreen:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    local Path, _, Flags = txtPlaceHolder:GetFont()
    txtPlaceHolder:SetFont(Path, 30, Flags)
    txtPlaceHolder:SetPoint("BOTTOMLEFT", 50, 50)
    txtPlaceHolder:SetTextColor(1, 1, 1)
    txtPlaceHolder:SetText("Configuration Screen")
    return ConfigScreen
end

function MainInterface:AboutScreen()
    local txtPlaceHolder
    AboutScreen = CreateFrame("Frame", "KeyMaster_MainScreen", MainPanel);
    AboutScreen:SetSize(100, 100)
    AboutScreen:SetPoint("BOTTOMLEFT", MainPanel, "BOTTOMLEFT", 0, 0)
    --[[ AboutScreen:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", 
        edgeFile="", 
        tile = false, 
        tileSize = 0, 
        edgeSize = 0, 
        insets = {left = 0, right = 0, top = 0, bottom = 0}})
    AboutScreen:SetBackdropColor(160,160,160,1); -- color for testing ]]
    txtPlaceHolder = AboutScreen:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    local Path, _, Flags = txtPlaceHolder:GetFont()
    txtPlaceHolder:SetFont(Path, 30, Flags)
    txtPlaceHolder:SetPoint("BOTTOMLEFT", 50, 50)
    txtPlaceHolder:SetTextColor(1, 1, 1)
    txtPlaceHolder:SetText("About Screen")
    return AboutScreen
end

--------------------------------
-- Create Main UI Frame and shared assets
--------------------------------
function MainInterface:CreateMainPanel()
    MainPanel = CreateFrame("Frame", "KeyMaster_MainPanel", UIParent, "KeyMasterFrame");
    -- Interface\\AddOns\\KeyMaster\\Imgs\\KM_MainPanel_Background
    MainPanel:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", 
        edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", 
        tile = false, 
        tileSize = 0, 
        edgeSize = 16, 
        insets = {left = 4, right = 4, top = 4, bottom = 4}})

    MainPanel:SetBackdropColor(0,0,0,1);
    --frame:SetBackdropColor(red, green, blue[, alpha])
    --frame:SetBackdropBorderColor(red, green, blue[, alpha])
        --MainPanel:SetFrameLevel(10);
    --MainPanel:SetWidth(768)
    --MainPanel:SetHeight(768)
    MainPanel:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
    --MainPanel:EnableMouse(true)
    --MainPanel:SetMovable(true)
    --MainPanel:RegisterForDrag("LeftButton")
    --frame:SetUserPlaced( true );
    --frame:RegisterEvent("ADDON_LOADED");

--[[ -- Was playing with in-game models. Maybe later, this doesn't work how I want
    MainPanel.model = CreateFrame("PlayerModel", "myModelFrame", "KeyMaster_MainPanel")
    MainPanel.model:SetSize(600, 800)
    MainPanel.model:SetPoint("CENTER", "KeyMaster_MainPanel", "CENTER")
    MainPanel.model:SetUnit("player")
    MainPanel.model:SetPosition(0, 0, -0.75)
    MainPanel.model:SetCustomCamera(1) -- Yes, it needs to be  here twice
    MainPanel.model:SetCameraPosition(2.8, -1, 0.4)
    MainPanel.model:RefreshCamera()
    MainPanel.model:SetCustomCamera(1) -- Yes, it needs to be  here twice ]]

    MainPanel.closeBtn = CreateFrame("Button", "CloseButton", MainPanel, "UIPanelCloseButton")
    MainPanel.closeBtn:SetPoint("TOPRIGHT")
    MainPanel.closeBtn:SetSize(20, 20)
    MainPanel.closeBtn:SetNormalFontObject("GameFontNormalLarge")
    MainPanel.closeBtn:SetHighlightFontObject("GameFontHighlightLarge")
    MainPanel.closeBtn:SetScript("OnClick", core.MainInterface.Toggle)

    MainPanel.titlePanel = CreateFrame("Frame", "KeyMaster_TitleFrame", MainPanel)
   --MainPanel.titlePanel:SetFrameLevel(11)
    MainPanel.titlePanel:SetWidth(200)
    MainPanel.titlePanel:SetHeight(18)
    MainPanel.titlePanel:SetPoint("TOPRIGHT", -27,0)
    VersionText = MainPanel.titlePanel:CreateFontString(nil, "OVERLAY", "GameTooltipText")
    VersionText:SetPoint("RIGHT")
    VersionText:SetText(KM_VERSION)

    MainPanel.ratingPanel = CreateFrame("Frame", "KeyMaster_RatingFrame", MainPanel)
    --MainPanel.ratingPanel:SetFrameLevel(11)
    MainPanel.ratingPanel:SetWidth(300)
    MainPanel.ratingPanel:SetHeight(13)
    MainPanel.ratingPanel:SetPoint("TOPRIGHT", -2, -38)
    MythicRatingPreText = MainPanel.ratingPanel:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    local Path, _, Flags = MythicRatingPreText:GetFont()
    MythicRatingPreText:SetFont(Path, 12, Flags)
    MythicRatingPreText:SetPoint("CENTER")
    MythicRatingPreText:SetText("|cff"..core.Data:GetMyClassColor()..UnitName("player").."\'s Rating:|r")

    local myCurrentRating = core.Data:GetCurrentRating()
    local myRatingColor = C_ChallengeMode.GetDungeonScoreRarityColor(myCurrentRating)
    MainPanel.ratingPanel = CreateFrame("Frame", "KeyMaster_RatingFrame", MainPanel)
    --MainPanel.ratingPanel:SetFrameLevel(11)
    MainPanel.ratingPanel:SetWidth(300)
    MainPanel.ratingPanel:SetHeight(32)
    MainPanel.ratingPanel:SetPoint("TOPRIGHT", -2, -50)
    MythicRatingText = MainPanel.ratingPanel:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    local Path, _, Flags = MythicRatingText:GetFont()
    MythicRatingText:SetFont(Path, 30, Flags)
    MythicRatingText:SetPoint("CENTER")
    MythicRatingText:SetTextColor(myRatingColor.r, myRatingColor.g, myRatingColor.b)
    MythicRatingText:SetText(myCurrentRating)

    --MainPanel:RegisterEvent("OnMouseDown");
    --MainPanel:RegisterEvent("OnMouseUp");
    --MainPanel:RegisterEvent("OnEnter")
    --MainPanel:RegisterEvent("OnLeave")
    MainPanel:SetScript("OnEvent", uiEventHandler);
    --frame:SetScript("OnDragStart", function(self) self:StartMoving() end);
    --frame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end);

    --tinsert(UISpecialFrames, MainPanel:GetName())

    -- load child windows
    --MainScreen = MainInterface:MainScreen()
    --MainScreen:Show()
    HeaderFrame = MainInterface.Headerframe()
    HeaderFrame:Show()
    ConentFrame = MainInterface.ContentFrame()
    ContentFrame:Show()
    ConfigScreen = MainInterface:ConfigScreen()
    ConfigScreen:Hide();
    AboutScreen = MainInterface:AboutScreen()
    AboutScreen:Hide();
    MainPanel:Hide();
    return MainPanel;
end

--------------------------------
-- Buttton_OnClick actions (template)
--------------------------------
function KeyMaster:Button_OnClick(button)
    local operation = button:GetName():match("KeyMasterButton_(.+)")
	if operation == "New" then
		KeyMaster:Button_New(button)
	elseif operation == "Open" then
		KeyMaster:Button_Open(button)
	elseif operation == "Save" then
		KeyMaster:Button_Save(button)
	elseif operation == "Undo" then
		KeyMaster:Button_Undo(button)
	elseif operation == "Redo" then
		KeyMaster:Button_Redo(button)
	elseif operation == "Delete" then
		KeyMaster:Button_Delete(button)
	elseif operation == "Lock" then
		KeyMaster:Button_Lock(button)
	elseif operation == "Unlock" then
		KeyMaster:Button_Unlock(button)
	elseif operation == "Previous" then
		KeyMaster:Button_Previous(button)
	elseif operation == "Next" then
		KeyMaster:Button_Next(button)
	elseif operation == "Run" then
		KeyMaster:Button_Run(button)
    elseif operation == "Config" then
        KeyMaster:Button_Config(button)
	elseif operation == "Close" then
		KeyMaster:Button_Close(button)
	end
end

-- Frame asset event handlers
function KeyMaster:Button_OnEnter(frame)
end
function KeyMaster:Button_OnLeave(frame)
end
function KeyMaster:Button_Close(frame)
    core.MainInterface.Toggle()
end