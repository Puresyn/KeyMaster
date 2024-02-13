local _, KeyMaster = ...
KeyMaster.MainInterface = {}
local MainInterface = KeyMaster.MainInterface

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
    return true
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