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
--local MainPanel, HeaderFrame, ContentFrame
KeyMaster = core.KeyMaster

--------------------------------
-- UI Functions
--------------------------------
function MainInterface:Toggle()
    -- Shows/Hides the main interface - will only create the window once, otherwise it holds the window pointer
    local mainUI = MainPanel or MainInterface.CreateMainPanel()
    mainUI:SetShown(not mainUI:IsShown())
    --mainUI = nil -- possible bug fix from not releaseing variable?
end

-- sort tables by index because LUA doesn't!
function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
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
 end

 --------------------------------
-- Tab Functions
--------------------------------
local contentTableNames = {}
local function Tab_OnClick(self)
    PanelTemplates_SetTab(self:GetParent(), self:GetID())
	
    if(contentTableNames) then
        for key, value in pairs(contentTableNames) do
            _G[value]:Hide()
        end
    end
	self.content:Show();
    PlaySound(SOUNDKIT.IG_SPELLBOOK_OPEN);
end


local function SetTabs(frame, tabs)
    local tabCount = 0
    for _ in pairs(tabs) do tabCount = tabCount + 1 end
    --print("tabcount: ", tabCount)
    frame.numTabs = tabCount

    local contents = {}
    local frameName = frame:GetName()

    local count = 1
    for key, value in spairs(tabs) do
        local tab = CreateFrame("Button", frameName.."Tab"..count, frame, "TabSystemButtonTemplate") -- TabSystemButtonArtTemplate, MinimalTabTemplate
        tab:SetID(count)
        tab:SetText(tabs[key].name)
        tab:SetScript("OnClick", Tab_OnClick)
        table.insert(contentTableNames, "KeyMaster_"..tabs[key].window)
        tab.content = _G["KeyMaster_"..tabs[key].window]
        tab.content:Hide()
        
        table.insert(contents, tab.content)
        if (count == 1) then
            tab:SetPoint("TOPLEFT", MainPanel, "BOTTOMLEFT", 5, 3)
        else
            
            tab:SetPoint("TOPLEFT", frameName.."Tab"..(count - 1), "TOPRIGHT", 0, 0)
        end
        tab:SetWidth(100)
        count = count + 1
    end

    Tab_OnClick(_G[frameName.."Tab1"])

    return unpack(contents)
end
--------------------------------
-- Create Regions
--------------------------------
-- Setup main UI information regions
-- I've seperated this info to build up to a template system
local function GetFrameRegions(myRegion)
    local p, w, h, mh, mw, hh, mtb, mlr
    local r = myRegion
    if (not r) then return end

    mh = MainPanel:GetHeight()
    mw = MainPanel:GetWidth()

    -- desired region heights and margins in pixels.
    -- todo: Needs pulled from saved variables or some other file instead of hard-coded.
    hh = 100 -- header height
    mtb = 4
    mlr = 4

    if (r == "header") then
    -- p = points, w = width, h = height, mtb = margin top and bottom, mlr = margin left and right
        myRegionInfo = {
            w = mw - (mlr*2),
            h = hh
    } 
    elseif (r == "content") then
        myRegionInfo = {
            w = mw - (mlr*2),
            h = mh - hh - (mtb*3)
        }
    else return
    end

    return myRegionInfo, mlr, mtb
end
-- Setup header frame
function MainInterface:Headerframe()
    local fr, mlr, mtb = GetFrameRegions("header")
    HeaderFrame = CreateFrame("Frame", "KeyMaster_HeaderRegion", MainPanel);
    HeaderFrame:SetSize(fr.w, fr.h)
    HeaderFrame:SetPoint("TOPLEFT", MainPanel, "TOPLEFT", mlr, -(mtb))
    HeaderFrame.texture = HeaderFrame:CreateTexture()
    HeaderFrame.texture:SetAllPoints(HeaderFrame)
    HeaderFrame.texture:SetColorTexture(0.531, 0.531, 0.531, 1) -- temporary bg color
    return HeaderFrame
end

-- Setup content frame
function MainInterface:ContentFrame()
    local fr, mlr, mtb = GetFrameRegions("content")
    ContentFrame = CreateFrame("Frame", "KeyMaster_ContentRegion", MainPanel);
    ContentFrame:SetSize(fr.w, fr.h)
    ContentFrame:SetPoint("TOPLEFT", MainPanel, "TOPLEFT", mtb, -(HeaderFrame:GetHeight() + (mtb*2)))
    ContentFrame.texture = ContentFrame:CreateTexture()
    ContentFrame.texture:SetAllPoints(ContentFrame)
    ContentFrame.texture:SetColorTexture(0.231, 0.231, 0.231, 1) -- temporary bg color
    return ContentFrame
end

-- Setup tab strip frame
function MainInterface:TabStrip()
end

-- Tabs
function MainInterface:MainScreen()
    local txtPlaceHolder
    MainScreen = CreateFrame("Frame", "KeyMaster_MainScreen", ContentFrame);
    MainScreen:SetSize(ContentFrame:GetWidth(), ContentFrame:GetHeight())
    MainScreen:SetPoint("TOPLEFT", ContentFrame, "TOPLEFT", 0, 0)
    --[[ MainScreen.texture = MainScreen:CreateTexture()
    MainScreen.texture:SetAllPoints(MainScreen)
    MainScreen.texture:SetTexture("Interface\\AddOns\\KeyMaster\\Imgs\\WHITE8X8")
    MainScreen.texture:SetColorTexture(0.231, 0.231, 0.231, 1) ]]
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
    ConfigScreen = CreateFrame("Frame", "KeyMaster_ConfigScreen", ContentFrame);
    ConfigScreen:SetSize(ContentFrame:GetWidth(), ContentFrame:GetHeight())
    ConfigScreen:SetPoint("TOPLEFT", ContentFrame, "TOPLEFT", 0, 0)
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
    AboutScreen = CreateFrame("Frame", "KeyMaster_AboutScreen", ContentFrame);
    AboutScreen:SetSize(ContentFrame:GetWidth(), ContentFrame:GetHeight())
    AboutScreen:SetPoint("TOPLEFT", ContentFrame, "TOPLEFT", 0, 0)
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
    MainPanel:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
    MainPanel:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", 
        edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", 
        tile = false, 
        tileSize = 0, 
        edgeSize = 16, 
        insets = {left = 4, right = 4, top = 4, bottom = 4}})

    MainPanel:SetBackdropColor(0,0,0,1);
    

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
    MainPanel.titlePanel:SetWidth(200)
    MainPanel.titlePanel:SetHeight(18)
    MainPanel.titlePanel:SetPoint("TOPRIGHT", -27,0)
    VersionText = MainPanel.titlePanel:CreateFontString(nil, "OVERLAY", "GameTooltipText")
    VersionText:SetPoint("RIGHT")
    VersionText:SetText(KM_VERSION)

    MainPanel.ratingPanel = CreateFrame("Frame", "KeyMaster_RatingFrame", MainPanel)
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
    MainPanel.ratingPanel:SetWidth(300)
    MainPanel.ratingPanel:SetHeight(32)
    MainPanel.ratingPanel:SetPoint("TOPRIGHT", -2, -50)
    MythicRatingText = MainPanel.ratingPanel:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    local Path, _, Flags = MythicRatingText:GetFont()
    MythicRatingText:SetFont(Path, 30, Flags)
    MythicRatingText:SetPoint("CENTER")
    MythicRatingText:SetTextColor(myRatingColor.r, myRatingColor.g, myRatingColor.b)
    MythicRatingText:SetText(myCurrentRating)

   --MainPanel:SetScript("OnEvent", uiEventHandler);
   --MainPanel:SetScript("OnDragStart", function(self) self:StartMoving() end);
   --MainPanel:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end);

    HeaderFrame = MainInterface.Headerframe()
    HeaderFrame:Show()
    ContentFrame = MainInterface.ContentFrame()
    ContentFrame:Show()

    mainFrameContent = MainInterface:MainScreen()
    mainFrameContent:Hide()
    configFrameContent = MainInterface:ConfigScreen()
    configFrameContent:Hide()
    aboutFrameContent = MainInterface:AboutScreen()
    aboutFrameContent:Hide()
 
    local myTabs = {
        [0] = {
            ["name"] = "Main",
            ["window"] = "MainScreen"
        },
        [1] = {
            ["name"] = "Config",
            ["window"] = "ConfigScreen"
        },
        [2] = {
            ["name"] = "About",
            ["window"] = "AboutScreen"
        }
    }

    SetTabs(ContentFrame, myTabs)

   --[[ mainFrameContent = MainInterface:MainScreen()
    mainFrameContent:Show()
    confgFrameContent.content = MainInterface:ConfigScreen()
    confgFrameContent.content:Hide()
    aboutFrameContent.content = MainInterface:AboutScreen()
    aboutFrameContent.content:Hide()

    -- load child windows
    --HeaderFrame = MainInterface:Headerframe()
    --HeaderFrame:Show()
    --ContentFrame = MainInterface.ContentFrame()
    --ContentFrame:Show()
   
    --[ MainScreen = MainInterface.MainScreen()
    --MainScreen:Show()
    
    --ConfigScreen = MainInterface.ConfigScreen()
    --ConfigScreen:Hide()
    
    --AboutScreen = MainInterface.AboutScreen()
    --AboutScreen:Hide()]]
    MainPanel:Hide()
    return MainPanel
end

-- Main Tab Button:
--content1.mainBtn = self:CreateButton("CENTER", content1, "TOP", -70, "Main")
--------------------------------
-- Buttton_OnClick actions (template)
--------------------------------
--[[ function KeyMaster:Button_OnClick(button)
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
end ]]

-- Frame asset event handlers


function KeyMaster:Button_OnEnter(frame)
end
function KeyMaster:Button_OnLeave(frame)
end
function KeyMaster:Button_Close(frame)
    core.MainInterface.Toggle()
end