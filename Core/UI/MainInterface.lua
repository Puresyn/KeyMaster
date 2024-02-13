local _, KeyMaster = ...
KeyMaster.MainInterface = {}
local MainInterface = KeyMaster.MainInterface
local mainPanel = KeyMaster.MainInterface.mainpanel



function MainInterface:Toggle()
    -- Shows/Hides the main interface - will only create the window once, otherwise it holds the window pointer
    local mainUI = mainPanel or MainInterface.CreateMainInterface()
    mainUI:SetShown(not mainUI:IsShown())
end

function MainInterface:CreateMainInterface()
    mainPanel = CreateFrame("Frame", "KeyMaster_mainPanel", UIParent, "KeyMasterFrame");
    mainPanel:ClearAllPoints(); -- Fixes SetPoint bug thus far.
    mainPanel:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
    mainPanel:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", 
        edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", 
        tile = false, 
        tileSize = 0, 
        edgeSize = 16, 
        insets = {left = 4, right = 4, top = 4, bottom = 4}})

    mainPanel:SetBackdropColor(0,0,0,1);

    mainPanel.closeBtn = CreateFrame("Button", "CloseButton", mainPanel, "UIPanelCloseButton")
    mainPanel.closeBtn:SetPoint("TOPRIGHT")
    mainPanel.closeBtn:SetSize(20, 20)
    mainPanel.closeBtn:SetNormalFontObject("GameFontNormalLarge")
    mainPanel.closeBtn:SetHighlightFontObject("GameFontHighlightLarge")
    mainPanel.closeBtn:SetScript("OnClick", KeyMaster.MainInterface.Toggle)
    mainPanel:Hide()

    return mainPanel
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
    PlaySound(SOUNDKIT.IG_QUEST_LIST_SELECT)
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

    -- set first active tab
    -- todo: change this so it can be customized?
    if (GetNumGroupMembers() == 0 or GetNumGroupMembers() > 5) then
        -- Open main tab
        Tab_OnClick(_G[frameName.."Tab1"])
    else
        -- Open party tab
        Tab_OnClick(_G[frameName.."Tab2"])
    end

    return unpack(contents)
end

function MainInterface:CreateTabs()
-- Create tabs
    -- name = tab text, window = the frame's name suffix (i.e. KeyMaster_BigScreen  would be "BigScreen")
    local myTabs = {
        [0] = {
            ["name"] = "Party",
            ["window"] = "partyScreen"
        }
    }

    -- Create the tabs (content region, Tab table)
    SetTabs(ContentFrame, myTabs)

    mainPanel:Hide()
    return mainPanel
end

-- Content Regions
local function GetFrameRegions(myRegion)
    local p, w, h, mh, mw, hh, mtb, mlr, myRegionInfo
    local r = myRegion
    if (not r) then return end

    mh = mainPanel:GetHeight()
    mw = mainPanel:GetWidth()

    -- desired region heights and margins in pixels.
    -- todo: Needs pulled from saved variables or some other file instead of hard-coded.
    hh = 100 -- header height
    mtb = 4 -- top/bottom margin
    mlr = 4 -- left/right margin

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



-- Setup content region
function MainInterface:ContentFrame()
    local fr, mlr, mtb = GetFrameRegions("content")
    ContentFrame = CreateFrame("Frame", "KeyMaster_ContentRegion", MainPanel);
    ContentFrame:SetSize(fr.w, fr.h)
    ContentFrame:SetPoint("TOPLEFT", MainPanel, "TOPLEFT", mtb, -(HeaderFrame:GetHeight() + (mtb*2)))
    ContentFrame.texture = ContentFrame:CreateTexture()
    ContentFrame.texture:SetAllPoints(ContentFrame)
    --ContentFrame.texture:SetTexture("Interface\\AddOns\\KeyMaster\\Imgs\\WHITE8X8")
    ContentFrame.texture:SetColorTexture(0, 0, 0, 1)

    return ContentFrame
end

