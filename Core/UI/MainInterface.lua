local _, KeyMaster = ...
KeyMaster.MainInterface = {}
local MainInterface = KeyMaster.MainInterface
local Theme = KeyMaster.Theme

--------------------------------
-- Tab Functions
--------------------------------
local tabContentFrames = {} -- used to show/hide content frames from tabs in Tab_OnClick
function Tab_OnClick(self)
    PanelTemplates_SetTab(self:GetParent(), self:GetID())

    for i=1,#tabContentFrames,1 do
        local contentFrame = _G[tabContentFrames[i]]
        contentFrame:Hide()
    end

    self.content:Show()
    PlaySound(SOUNDKIT.IG_QUEST_LIST_SELECT)
end

function MainInterface:CreateTab(parentFrame, id, tabText, contentFrame, isActive)
    if (id == nil) then id = 1 end
    parentFrame.numTabs = id
    local frameName = parentFrame:GetName()
    local tabFrame = CreateFrame("Button", frameName.."Tab"..id, parentFrame, "TabSystemButtonTemplate") -- TabSystemButtonArtTemplate, MinimalTabTemplate
    tabFrame:SetID(id)
    tabFrame:SetText(tabText)
    tabFrame:SetScript("OnClick", Tab_OnClick)
    tabFrame.content = contentFrame
    tabFrame.content:Hide()
    
    -- Creates an table of contentFrame names so we can hide/show them in OnClick
    tinsert(tabContentFrames, contentFrame:GetName())
    
    if (id == 1) then
        tabFrame:SetPoint("TOPLEFT", parentFrame, "BOTTOMLEFT", 5, 2)
    else        
        tabFrame:SetPoint("TOPLEFT", _G[frameName.."Tab"..(id-1)], "TOPRIGHT", 0, 0) -- appends to previous tab
    end
    tabFrame:SetWidth(100)

--[[     if (isActive) then
        Tab_OnClick(_G[tabFrame:GetName()])
    end ]]
    
    return tabFrame
end

-- Content Regions
function MainInterface:GetFrameRegions(myRegion, parentFrame)
    local w, h, myRegionInfo
    if (not myRegion) then return end

    local mh = parentFrame:GetHeight()
    local mw = parentFrame:GetWidth()

    -- desired region heights and margins in pixels.
    local hh = 110 -- header height
    local mtb = 4 -- top/bottom margin
    local mlr = 4 -- left/right margin

    if (myRegion == "header") then
    -- w = width, h = height
        myRegionInfo = {
            w = mw - (mlr*2),
            h = hh
    } 
    elseif (myRegion == "content") then
        myRegionInfo = {
            w = mw - (mlr*2),
            h = mh - hh - (mtb*2)
        }
    else return
    end

    return myRegionInfo, mlr, mtb
end

-- Setup content region
function MainInterface:CreateContentRegion(parentFrame, headerRegion)
    local fr, mlr, mtb = MainInterface:GetFrameRegions("content", parentFrame)
    local contentRegion = CreateFrame("Frame", "KeyMaster_ContentRegion", parentFrame);
    contentRegion:SetSize(fr.w, fr.h)
    contentRegion:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", mtb, -(headerRegion:GetHeight() + (mtb)))
    contentRegion.bgTexture = contentRegion:CreateTexture()
    contentRegion.bgTexture:SetAllPoints(contentRegion)
    contentRegion.bgTexture:SetTexture("Interface/Addons/KeyMaster/Assets/Images/"..Theme.style)
    contentRegion.bgTexture:SetTexCoord(0, 856/1024, 175/1024, 840/1024)

    return contentRegion
end

--------------------------------
-- Key Master Icon
--------------------------------
function MainInterface:CreateAddonIcon(parentFrame)
    
    local addonIconFrame = CreateFrame("Frame", "KeyMaster_Icon", parentFrame)
    addonIconFrame:SetSize(32, 32)
    addonIconFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 8, -8)

    local addonIcon = addonIconFrame:CreateTexture("KM_Icon", "OVERLAY")
    addonIcon:SetSize(32, 32)
    addonIcon:SetTexture("Interface/AddOns/KeyMaster/Assets/Images/KM-Icon-32")
    addonIcon:ClearAllPoints()
    addonIcon:SetPoint("CENTER", 0, 0)
    addonIcon:SetAlpha(0.8)

    return addonIcon
end