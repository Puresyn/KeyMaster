local _, KeyMaster = ...
local InfoFrame = {}
KeyMaster.InfoFrame = InfoFrame
local Theme = KeyMaster.Theme
local KMFactory = KeyMaster.Factory

function InfoFrame:CreateInfoFrame(parentFrame)

    local mtb = 4 -- margin top/bottom
    local mlr = 4 -- margin left/right
    local indent = 8 -- copy indent
    local infoFrame = CreateFrame("Frame", "KM_InfoTab_Frame",parentFrame)
    infoFrame:SetPoint("CENTER", parentFrame, "CENTER", 0, 0)
    infoFrame:SetSize(parentFrame:GetWidth(), parentFrame:GetHeight())

    -- Header Frame
    local infoFrameHeader = CreateFrame("Frame", "KM_InfoTabHeader_Frame",infoFrame)
    infoFrameHeader:SetPoint("TOPLEFT", infoFrame, "TOPLEFT", 4, -8)
    infoFrameHeader:SetSize(infoFrame:GetWidth()-8, 100)
    infoFrameHeader.texture = infoFrameHeader:CreateTexture(nil, "BACKGROUND", nil, 0)
    infoFrameHeader.texture:SetAllPoints(infoFrameHeader)
    infoFrameHeader.texture:SetColorTexture(0, 0, 0, 1)

    infoFrameHeader.textureHighlight = infoFrameHeader:CreateTexture(nil, "BACKGROUND", nil)
    infoFrameHeader.textureHighlight:SetSize(infoFrameHeader:GetWidth(), infoFrameHeader:GetHeight())
    infoFrameHeader.textureHighlight:SetPoint("LEFT", infoFrameHeader, "LEFT", 0, 0)
    infoFrameHeader.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    local headerColor = {}
    headerColor.r, headerColor.g, headerColor.b, _ = Theme:GetThemeColor("color_COMMON")
    infoFrameHeader.textureHighlight:SetVertexColor(headerColor.r, headerColor.g, headerColor.b, 1)

    -- Page Header Title Large Background
    infoFrameHeader.titleBG = infoFrameHeader:CreateFontString(nil, "ARTWORK", "KeyMasterFontBig")
    local Path, _, Flags = infoFrameHeader.titleBG:GetFont()
    infoFrameHeader.titleBG:SetFont(Path, 120, Flags)
    infoFrameHeader.titleBG:SetSize(infoFrameHeader:GetWidth(), infoFrameHeader:GetHeight())
    infoFrameHeader.titleBG:SetPoint("BOTTOMLEFT", infoFrameHeader, "BOTTOMLEFT", -4, -8)
    local headerBGTextColor = {}
    headerBGTextColor.r, headerBGTextColor.g, headerBGTextColor.b, _ = Theme:GetThemeColor("color_COMMON")
    infoFrameHeader.titleBG:SetTextColor(headerBGTextColor.r, headerBGTextColor.g, headerBGTextColor.b, 1)
    infoFrameHeader.titleBG:SetText(KeyMasterLocals.TABABOUT)
    infoFrameHeader.titleBG:SetAlpha(0.04)
    infoFrameHeader.titleBG:SetJustifyH("LEFT")

    -- Page Header Title
    infoFrameHeader.title = infoFrameHeader:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    infoFrameHeader.title:SetPoint("BOTTOMLEFT", infoFrameHeader, "BOTTOMLEFT", 4, 4)
    local Path, _, Flags = infoFrameHeader.title:GetFont()
    infoFrameHeader.title:SetFont(Path, 40, Flags)
    local headerTextColor = {}
    headerTextColor.r, headerTextColor.g, headerTextColor.b, _ = Theme:GetThemeColor("color_COMMON")
    infoFrameHeader.title:SetTextColor(headerTextColor.r, headerTextColor.g, headerTextColor.b, 1)
    infoFrameHeader.title:SetText(KeyMasterLocals.TABABOUT)

    local btnOptions = {}
    btnOptions.text = KeyMasterLocals.ABOUTFRAME["WhatsNew"].text
    infoFrameHeader.whatsNew = KMFactory:Create(infoFrameHeader, "Button", btnOptions)
    infoFrameHeader.whatsNew:SetPoint("BOTTOMRIGHT", infoFrameHeader, "BOTTOMRIGHT", -4, 4)
    infoFrameHeader.whatsNew:SetScript("OnClick", function()
        local whatsNewFrame = _G["KM_WhatsNewFrame"] or KeyMaster.WhatsNew:Init()
        whatsNewFrame:Show()
    end)

   --/////////////////////////// 
    --About Panels Colors
    --///////////////////////////
    -- Gradient highlight
    local highlightAlpha = 0.5
    local hlColor = {}
    local hlColorString = "color_NONPHOTOBLUE"
    hlColor.r, hlColor.g, hlColor.b, _ = Theme:GetThemeColor(hlColorString)

    -- Title Color
    local titleColor = {}
    local titleColorString = "color_THEMEGOLD"
    titleColor.r, titleColor.g, titleColor.b, _ = Theme:GetThemeColor(titleColorString)

    -- Options color
    local optionsColor = {}
    local optionsColorString = "color_COMMON"
    optionsColor.r, optionsColor.g, optionsColor.b, _ = Theme:GetThemeColor(optionsColorString)

    -- Note color
    local noteColor = {}
    local noteColorString = "color_DEBUGMSG"
    noteColor.r, noteColor.g, noteColor.b, _ = Theme:GetThemeColor(noteColorString)

    --////////////////////
    --About Panels
    --////////////////////
    local aboutPanelBaseHeight = infoFrame:GetHeight()-infoFrameHeader:GetHeight()-12

    -- About - General
    local aboutGeneral = CreateFrame("Frame", nil, infoFrame)
    aboutGeneral:SetPoint("TOPLEFT", infoFrameHeader, "BOTTOMLEFT", 0, -4)
    aboutGeneral:SetSize((((infoFrame:GetWidth()-mlr)/4)*2.25)-mlr, aboutPanelBaseHeight-mtb)
    aboutGeneral.title = aboutGeneral:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    aboutGeneral.title:SetTextColor(titleColor.r, titleColor.g, titleColor.b, 1)
    aboutGeneral.title:SetPoint("TOPLEFT", aboutGeneral, "TOPLEFT", 4, -4)
    aboutGeneral.title:SetText(KeyMasterLocals.ABOUTFRAME["AboutGeneral"].name)

    local generalText = [[(c) 2024 - Released under the GNU General Public License
        
    Key Master is an addon developed for World of Warcraft players who are actively involved in Mythic Plus content. The goal of the addon is to provide a single location to display detailed Mythic Plus content information about you and/or your party.
    
    While there are many future features in-mind for Key Master to expand its usefulness, how far it may go and when that will happen is largely dependent on its user base. So, if you find Key Master useful, please tell your friends!

Visit us at:
https://www.curseforge.com/wow/addons/key-master
https://discord.gg/bbMaUpfgn8

    We are actively seeking volunteer translators and proofreaders for ALL supported languages - but specifically for the following languages:

-简体中文 (CN)
-한국어 (Korea)
-Chinese (China) (simplified) implemented LTR
-Spanish (Spain)
-Spanish (Mexico)]]
    aboutGeneral.text = aboutGeneral:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    aboutGeneral.text:SetPoint("TOPLEFT", aboutGeneral.title, "BOTTOMLEFT", 8, -4)
    aboutGeneral.text:SetJustifyH("LEFT")
    aboutGeneral.text:SetJustifyV("TOP")
    aboutGeneral.text:SetSize(aboutGeneral:GetWidth()-(indent*3)-mlr, aboutGeneral:GetHeight()-aboutGeneral.title:GetHeight()-25)
    aboutGeneral.text:SetText(generalText)
    aboutGeneral.text:CanWordWrap(true)

    local Hline = KeyMaster:CreateHLine(aboutGeneral:GetWidth()+8, aboutGeneral, "TOP", 0, 0)
    Hline:SetAlpha(0.5)

    aboutGeneral.texture = aboutGeneral:CreateTexture(nil, "BACKGROUND", nil, 0)
    aboutGeneral.texture:SetAllPoints(aboutGeneral)
    aboutGeneral.texture:SetColorTexture(0, 0, 0, 0.3)

    aboutGeneral.textureHighlight = aboutGeneral:CreateTexture(nil, "BACKGROUND", nil, 1)
    aboutGeneral.textureHighlight:SetSize(aboutGeneral:GetWidth(), aboutGeneral:GetHeight()/6)
    aboutGeneral.textureHighlight:SetPoint("BOTTOMLEFT", aboutGeneral, "BOTTOMLEFT", 0, 0)
    aboutGeneral.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    aboutGeneral.textureHighlight:SetAlpha(highlightAlpha)
    aboutGeneral.textureHighlight:SetVertexColor(hlColor.r,hlColor.g,hlColor.b, highlightAlpha)

    -- About - Authors
    local aboutAuthors = CreateFrame("Frame", nil, infoFrame)
    aboutAuthors:SetPoint("TOPLEFT", aboutGeneral, "TOPRIGHT", 4, 0)
    aboutAuthors:SetSize((((infoFrame:GetWidth()-mlr)/4)*1.75)-mlr, (aboutPanelBaseHeight*0.25-mtb))
    aboutAuthors.title = aboutAuthors:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    aboutAuthors.title:SetTextColor(titleColor.r, titleColor.g, titleColor.b, 1)
    aboutAuthors.title:SetPoint("TOPLEFT", aboutAuthors, "TOPLEFT", 4, -4)
    aboutAuthors.title:SetText(KeyMasterLocals.ABOUTFRAME["AboutAuthors"].name)

    local strylorColor, shantisocColor
    _, _, _, strylorColor = Theme:GetThemeColor("color_ROGUE")
    _, _, _, shantisocColor = Theme:GetThemeColor("color_MONK")
    local authorsText = "|cff"..strylorColor.."Strylor|r-Proudmoore\n|cff"..shantisocColor.."Shantisoc|r-Proudmoore"
    aboutAuthors.text = aboutAuthors:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    aboutAuthors.text:SetPoint("TOPLEFT", aboutAuthors.title, "BOTTOMLEFT", 8, -4)
    aboutAuthors.text:SetSize(aboutAuthors:GetWidth()-indent-mlr, aboutAuthors:GetHeight()-aboutAuthors.title:GetHeight()-25)
    aboutAuthors.text:SetText(authorsText)

    local Hline = KeyMaster:CreateHLine(aboutAuthors:GetWidth()+8, aboutAuthors, "TOP", 0, 0)
    Hline:SetAlpha(0.5)

    aboutAuthors.texture = aboutAuthors:CreateTexture(nil, "BACKGROUND", nil, 0)
    aboutAuthors.texture:SetAllPoints(aboutAuthors)
    aboutAuthors.texture:SetColorTexture(0, 0, 0, 1)

    aboutAuthors.textureHighlight = aboutAuthors:CreateTexture(nil, "BACKGROUND", nil, 1)
    aboutAuthors.textureHighlight:SetSize(aboutAuthors:GetWidth(), aboutAuthors:GetHeight()/6)
    aboutAuthors.textureHighlight:SetPoint("BOTTOMLEFT", aboutAuthors, "BOTTOMLEFT", 0, 0)
    aboutAuthors.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    aboutAuthors.textureHighlight:SetAlpha(highlightAlpha)
    aboutAuthors.textureHighlight:SetVertexColor(hlColor.r,hlColor.g,hlColor.b, highlightAlpha)

    -- About - Contributors
    local aboutContributors = CreateFrame("Frame", nil, infoFrame)
    aboutContributors:SetPoint("TOPLEFT", aboutAuthors, "BOTTOMLEFT", 0, -4)
    aboutContributors:SetSize((((infoFrame:GetWidth()-mlr)/4)*1.75)-mlr, (aboutPanelBaseHeight*0.375-mtb))
    aboutContributors.title = aboutContributors:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    aboutContributors.title:SetTextColor(titleColor.r, titleColor.g, titleColor.b, 1)
    aboutContributors.title:SetPoint("TOPLEFT", aboutContributors, "TOPLEFT", 4, -4)
    aboutContributors.title:SetText(KeyMasterLocals.ABOUTFRAME["AboutContributors"].name)

    local textContributors = "Rex, Ithoro, Xanat, Doc, Sunnie, Charlie, Faethor, Tanzen, Omgtotem, Quanfu, Linaori\n\n"
    textContributors = textContributors .. "|cffA3E7FC" .. KeyMasterLocals.ABOUTFRAME["Translators"].text .. "|r\n"
    textContributors = textContributors .. "Cyph, BNS3388, Feedy88, Rumorix, Salty, Kereru, 와우하는아저씨, Ragnarork, Hizgret"

    aboutContributors.text = aboutContributors:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    aboutContributors.text:SetPoint("TOPLEFT", aboutContributors.title, "BOTTOMLEFT", 8, -4)
    aboutContributors.text:SetSize(aboutContributors:GetWidth()-indent-mlr, aboutContributors:GetHeight()-aboutContributors.title:GetHeight()-25)
    aboutContributors.text:SetText(textContributors)

    local Hline = KeyMaster:CreateHLine(aboutContributors:GetWidth()+8, aboutContributors, "TOP", 0, 0)
    Hline:SetAlpha(0.5)

    aboutContributors.texture = aboutContributors:CreateTexture(nil, "BACKGROUND", nil, 0)
    aboutContributors.texture:SetAllPoints(aboutContributors)
    aboutContributors.texture:SetColorTexture(0, 0, 0, 1)

    aboutContributors.textureHighlight = aboutContributors:CreateTexture(nil, "BACKGROUND", nil, 1)
    aboutContributors.textureHighlight:SetSize(aboutContributors:GetWidth(), aboutContributors:GetHeight()/6)
    aboutContributors.textureHighlight:SetPoint("BOTTOMLEFT", aboutContributors, "BOTTOMLEFT", 0, 0)
    aboutContributors.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    aboutContributors.textureHighlight:SetAlpha(highlightAlpha)
    aboutContributors.textureHighlight:SetVertexColor(hlColor.r,hlColor.g,hlColor.b, highlightAlpha)

    -- About - Special Thanks
    local aboutSpecialThanks = CreateFrame("Frame", nil, infoFrame)
    aboutSpecialThanks:SetPoint("TOPLEFT", aboutContributors, "BOTTOMLEFT", 0, -4)
    aboutSpecialThanks:SetSize((((infoFrame:GetWidth()-mlr)/4)*1.75)-mlr, (aboutPanelBaseHeight*0.375-mtb))
    aboutSpecialThanks.title = aboutSpecialThanks:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    aboutSpecialThanks.title:SetTextColor(titleColor.r, titleColor.g, titleColor.b, 1)
    aboutSpecialThanks.title:SetPoint("TOPLEFT", aboutSpecialThanks, "TOPLEFT", 4, -4)
    aboutSpecialThanks.title:SetText(KeyMasterLocals.ABOUTFRAME["AboutSpecialThanks"].name)

    local redditColor, twitchColor
    _, _, _, redditColor = Theme:GetThemeColor("color_REDDIT")
    _, _, _, twitchColor = Theme:GetThemeColor("color_TWITCH")
    local textSpecialThanks = "\"The Last Pull\"\nGuild on Proudmoore\n"
    aboutSpecialThanks.text = aboutSpecialThanks:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    aboutSpecialThanks.text:SetPoint("TOPLEFT", aboutSpecialThanks.title, "BOTTOMLEFT", 8, -4)
    aboutSpecialThanks.text:SetSize(aboutSpecialThanks:GetWidth()-indent-mlr, aboutSpecialThanks:GetHeight()-aboutSpecialThanks.title:GetHeight()-25)
    aboutSpecialThanks.text:SetText(textSpecialThanks)

    local Hline = KeyMaster:CreateHLine(aboutSpecialThanks:GetWidth()+8, aboutSpecialThanks, "TOP", 0, 0)
    Hline:SetAlpha(0.5)

    aboutSpecialThanks.texture = aboutSpecialThanks:CreateTexture(nil, "BACKGROUND", nil, 0)
    aboutSpecialThanks.texture:SetAllPoints(aboutSpecialThanks)
    aboutSpecialThanks.texture:SetColorTexture(0, 0, 0, 1)

    aboutSpecialThanks.textureHighlight = aboutSpecialThanks:CreateTexture(nil, "BACKGROUND", nil, 1)
    aboutSpecialThanks.textureHighlight:SetSize(aboutSpecialThanks:GetWidth(), aboutSpecialThanks:GetHeight()/6)
    aboutSpecialThanks.textureHighlight:SetPoint("BOTTOMLEFT", aboutSpecialThanks, "BOTTOMLEFT", 0, 0)
    aboutSpecialThanks.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    aboutSpecialThanks.textureHighlight:SetAlpha(highlightAlpha)
    aboutSpecialThanks.textureHighlight:SetVertexColor(hlColor.r,hlColor.g,hlColor.b, highlightAlpha)


    return infoFrame
end