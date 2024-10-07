local _, KeyMaster = ...
local WhatsNew = {}
KeyMaster.WhatsNew = WhatsNew
local Theme = KeyMaster.Theme

local function setWhatsNewContent(parent)
    local whatsNewContent = parent
    whatsNewContent.fontFace = whatsNewContent:CreateFontString(nil, "Overlay", "KeyMasterFontBig")
    local Path, _, Flags =  whatsNewContent.fontFace:GetFont()
    whatsNewContent:SetFont("h1", Path, 24, Flags)
    whatsNewContent:SetFont("h2", Path, 18, Flags)
    whatsNewContent:SetFont("h3", Path, 14, Flags)
    whatsNewContent:SetFont("p", Path, 12, Flags)
    local h1Color = select(4, Theme:GetThemeColor("color_THEMEGOLD"))
    local h2Color = select(4, Theme:GetThemeColor("color_NONPHOTOBLUE"))
    local h3Color = select(4, Theme:GetThemeColor("color_DRUID"))
    local pColor = select(4, Theme:GetThemeColor("color_COMMON"))
    local aColor = select(4, Theme:GetThemeColor("color_MAGE"))
    local bulletColor = select(4, Theme:GetThemeColor("themeFontColorGreen1"))
    local gtColor = select(4, Theme:GetThemeColor("color_MONK"))
    local textBullet = "|cff"..bulletColor.."-|r "
    local textGT = "|cff"..gtColor.."\> "
    local markupText = [[
        <html>
            <body>
                <br/>
                <h1>|cff]]..h1Color..[[News / Updates / Patch Notes|r</h1>
                <p>]]..KeyMasterLocals.DISPLAYVERSION..KM_AUTOVERSION.." "..KM_VERSION_STATUS..[[</p>
                <br/>
                <h3>|cff]]..h3Color..[[Key Master could use some more active translators!|r</h3>
                <p>[Key Master Discord]|cff]]..aColor..[[ https://discord.gg/QngbCPBP|r</p>
                <br/>
                <br/>
                <h2>|cff]]..h2Color..[[Updates:|r</h2>
                <br/>
                <p>]]..textBullet..[[Added a dungeon tools buttons row on the Player frame that simplifies access to WoW features and other addons:</p>
                <img src="Interface\AddOns\KeyMaster\Assets\Images\dungeontools_buttons" width="275" height="47"/>
                <p>]]..textGT..[[Open the dungeon journal to the selected dungeon.</p>
                <p>]]..textGT..[[Open the instance map of the selected dungeon.</p>
                <p>]]..textGT..[[Open the group finder window.</p>
                <p>]]..textGT..[[Open Mythic Dungeon Tools (MDT) (if installed).</p>
                <p>]]..textGT..[[Portal to selected dungeon if unlocked and not on cooldown.</p>
                <br/>
                <p>]]..textBullet..[[Moved weekly affixes back into the header frame.</p>
                <br/>
                <p>]]..textBullet..[[Added affix tooltip functionality.</p>
                <br/>
                <p>]]..textBullet..[[Rearranged the Player frame to be more conducive to the new M+ rating system.</p>
                <br/>
                <p>]]..textBullet..[[Changed rating calculator functionality to now keep the key level entered and re-calculate automatically for each map row being selected.</p>
                <br/>
                <p>]]..textBullet..[[Updated some vault graphics (more updates to come).</p>
                <br/>
                <p>]]..textBullet..[[Disabled rating pending verification system message.</p>
                <br/>
                <p>]]..textBullet..[[Temporarily disabled Russian translation due to lack of translator participation. (See us if interested!)</p>                
                <br/>
                <p>]]..textBullet..[[Updated a few dungeon name abbreviations to better seperate meaning.</p>                
                <br/>
                <br/>
                <h2>|cff]]..h2Color..[[Fixes:|r</h2>
                <br/>
                <p>]]..textBullet..[[Fixed M+ Vault Progression not updating upon dungeon completion if the player tab was the last tab open (Hopefully for real this time).</p>
                <br/>
                <br/>
                <h2>|cff]]..h2Color..[[Known Bugs/Issues:|r</h2>
                <br/>
                <p>]]..textBullet..[[None</p>
                <br/>
                <br/>
                <p>If you experience any other issues, please report them with as much detail as possible in the Key Master Issues GitHub.</p>
                <p>[Key Master Bug Reports - GitHub]|cff]]..aColor..[[ https://github.com/Puresyn/KeyMaster/issues|r</p>
                <p>[Key Master Discord]|cff]]..aColor..[[ https://discord.gg/QngbCPBP|r</p>
                <br/>
            </body>
        </html>
        ]]
    whatsNewContent:SetHyperlinksEnabled(true)
    whatsNewContent:SetText(markupText)

    -- doesn't work as intended at the moment.
--[[local f = CreateFrame("EditBox", "KM_LinkBox", UIParent, "InputBoxTemplate")
    f:SetSize(300, 60)
    f:SetPoint("CENTER")
    --f:SetHyperlinksEnabled(true)
    f:SetText("")
    f:Hide()

    hooksecurefunc("SetItemRef", function(link)
        local linkType, addonName, linkData = strsplit(":", link)
        if linkType == "addon" and addonName == "KeyMaster" then
            f:SetText("https://"..linkData)
            f:Show()
        end
    end) ]]

    
    
    --[[ f:SetScript("OnHyperlinkEnter", function(self, link, text, region, left, bottom, width, height)
        GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
        GameTooltip:SetHyperlink(link)
        GameTooltip:Show()
    end)
    
    f:SetScript("OnHyperlinkLeave", function(self)
        GameTooltip:Hide()
    end) ]]

    return whatsNewContent
end


local function createScrollFrame(parent)
    -- Credit: https://www.wowinterface.com/forums/showthread.php?t=45982
    local frameHolder
 
    local self = frameHolder or CreateFrame("Frame", nil, parent)
    local scrollFrameHeight = parent:GetHeight()-6
    self:SetFrameLevel(parent:GetFrameLevel()-1)
    self:SetSize(parent:GetWidth()-24, scrollFrameHeight)
    self:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", 0, 3)
    
    self.scrollframe = self.scrollframe or CreateFrame("ScrollFrame", "KM_WhatsNewScrollFrame", self, "UIPanelScrollFrameTemplate")
    
    self.scrollchild = self.scrollchild or CreateFrame("SimpleHTML", "KM_WhatsNewContent")
    
    local scrollbarName = self.scrollframe:GetName()
    self.scrollbar = _G[scrollbarName.."ScrollBar"]
    self.scrollupbutton = _G[scrollbarName.."ScrollBarScrollUpButton"]
    self.scrolldownbutton = _G[scrollbarName.."ScrollBarScrollDownButton"]
    
    self.scrollupbutton:ClearAllPoints()
    self.scrollupbutton:SetPoint("TOPRIGHT", self.scrollframe, "TOPRIGHT", -2, -18)
    
    self.scrolldownbutton:ClearAllPoints()
    self.scrolldownbutton:SetPoint("BOTTOMRIGHT", self.scrollframe, "BOTTOMRIGHT", -2, 0)
    
    self.scrollbar:ClearAllPoints()
    self.scrollbar:SetPoint("TOP", self.scrollupbutton, "BOTTOM", 0, 2)
    self.scrollbar:SetPoint("BOTTOM", self.scrolldownbutton, "TOP", 0, -2)
    self.scrollframe:SetScrollChild(self.scrollchild)
    
    self.scrollframe:SetAllPoints(self);
    
    self.scrollchild:SetWidth(self.scrollframe:GetWidth()-18)

    return self
end

local function noticeViewed()
    KeyMaster_DB.addonConfig.splashViewed = true
end

function WhatsNew:Init()
    local noticeFrame = CreateFrame("Frame", "KM_WhatsNewFrame", UIParent, "WhatsNewTemplate")
    --[[ noticeFrame:SetScript("OnLoad", nil)
    noticeFrame:SetScript("OnShow", nil)
    noticeFrame:SetScript("OnHide", nil) ]]
    noticeFrame:ClearAllPoints()
    noticeFrame:SetPoint("CENTER")
    
    noticeFrame:SetMovable("true")
    noticeFrame:SetFrameStrata("HIGH")
    noticeFrame:SetClampedToScreen(true)

    noticeFrame:SetBackdrop({bgFile="", 
        edgeFile="Interface\\AddOns\\KeyMaster\\Assets\\Images\\UI-Border", 
        tile = false, 
        tileSize = 0, 
        edgeSize = 16, 
        insets = {left = 4, right = 4, top = 4, bottom = 4}})

    noticeFrame.logo = noticeFrame:CreateTexture()
    noticeFrame.logo:SetPoint("BOTTOMLEFT", noticeFrame, "TOPLEFT", 0, 0) -- 48, 34
    noticeFrame.logo:SetSize(280, 34)
    noticeFrame.logo:SetTexture("Interface/Addons/KeyMaster/Assets/Images/"..Theme.style)
    noticeFrame.logo:SetTexCoord(20/1024, 353/1024, 970/1024, 1010/1024)

    local brandColor = {}
    brandColor = select(4, Theme:GetThemeColor("themeFontColorMain"))
    noticeFrame.closeBtn = CreateFrame("Button", "KM_NoticeCloseButton", noticeFrame, "UIPanelCloseButton")
    noticeFrame.closeBtn:SetPoint("TOPRIGHT")
    noticeFrame.closeBtn:SetSize(20, 20)
    noticeFrame.closeBtn:SetNormalFontObject("GameFontNormalLarge")
    noticeFrame.closeBtn:SetHighlightFontObject("GameFontHighlightLarge") 
    noticeFrame.closeBtn:HookScript("OnClick", noticeViewed)


    noticeFrame.dragFrame = CreateFrame('Button', "$parent_DragFrame", noticeFrame)
    noticeFrame.dragFrame:SetSize(noticeFrame:GetWidth()-20, noticeFrame:GetHeight()) -- 22
    noticeFrame.dragFrame:SetPoint("TOPLEFT", noticeFrame, "TOPLEFT")
    noticeFrame.dragFrame:SetScript("OnMouseDown", function()
            if noticeFrame:IsMovable() then
                noticeFrame:StartMoving()
            end
        end)
    noticeFrame.dragFrame:SetScript("OnMOuseUp", function()
        noticeFrame:StopMovingOrSizing()
    end)

    noticeFrame.titleFrame = CreateFrame("Frame", nil, noticeFrame)
    noticeFrame.titleFrame:SetPoint("BOTTOMLEFT", noticeFrame, "TOPLEFT", 0, 0)

    --noticeFrame:HookScript("OnShow", function() PlaySound(122630, "Dialog", true) end)

    local bgHOffset = 150
    local bgWidth = noticeFrame:GetWidth()-7
    local bgHeight = noticeFrame:GetHeight() - 8
    local contentFrame = createScrollFrame(noticeFrame)
    contentFrame.bgTexture = contentFrame:CreateTexture(nil, "BACKGROUND")
    contentFrame.bgTexture:SetPoint("CENTER", noticeFrame, "CENTER", 0, 0)
    contentFrame.bgTexture:SetSize(bgWidth, noticeFrame:GetHeight())
    contentFrame.bgTexture:SetTexture("Interface/Addons/KeyMaster/Assets/Images/"..Theme.style)
    contentFrame.bgTexture:SetTexCoord(bgHOffset/1024, (bgWidth+bgHOffset)/1024, 175/1024, bgHeight/1024)

    local scrollContentParent = _G["KM_WhatsNewContent"]
    local HTMLcontent = setWhatsNewContent(scrollContentParent)
    HTMLcontent:SetHyperlinksEnabled(true)
    HTMLcontent:SetFrameLevel(contentFrame:GetFrameLevel()+1)
    HTMLcontent:SetHeight(HTMLcontent:GetContentHeight()+12)

    return noticeFrame
end
