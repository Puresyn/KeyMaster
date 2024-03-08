local _, KeyMaster = ...
KeyMaster.MainInterface = {}
local MainInterface = KeyMaster.MainInterface

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
    -- todo: Needs pulled from saved variables or some other file instead of hard-coded.
    local hh = 100 -- header height
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
            h = mh - hh - (mtb*3)
        }
    else return
    end

    return myRegionInfo, mlr, mtb
end