local _, KeyMaster = ...
KeyMaster.HeaderFrame = {}
local MainInterface = KeyMaster.MainInterface
local HeaderFrame = KeyMaster.HeaderFrame
local DungeonTools = KeyMaster.DungeonTools
local HeaderFrameMapping = KeyMaster.HeaderFrameMapping
local Theme = KeyMaster.Theme
local KMFactory = KeyMaster.Factory

-- Setup header region
function HeaderFrame:CreateHeaderRegion(parentFrame)
    local fr, mlr, mtb = MainInterface:GetFrameRegions("header", parentFrame)
    local headerRegion = CreateFrame("Frame", "KeyMaster_HeaderRegion", parentFrame);
    headerRegion:SetSize(fr.w, fr.h)
    headerRegion:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", mlr, -(mtb))
    headerRegion:SetScript("OnShow", function(self)
        HeaderFrameMapping:RefreshData(false)
    end)

    headerRegion.bgTexture = headerRegion:CreateTexture()
    headerRegion.bgTexture:SetAllPoints(headerRegion)
    headerRegion.bgTexture:SetTexture("Interface/Addons/KeyMaster/Assets/Images/"..Theme.style)
    headerRegion.bgTexture:SetTexCoord(0, 856/1024, 0, 116/1024)

    local topBar = CreateFrame("Frame", "KeyMaster_HeaderInfo_Wrapper", headerRegion)
    topBar:SetSize(headerRegion:GetWidth(), headerRegion:GetHeight())
    topBar:SetPoint("BOTTOMLEFT", headerRegion, "BOTTOMLEFT")
    

    topBar.bgTexture = topBar:CreateTexture(nil, "BACKGROUND", nil, 1)
    topBar.bgTexture:SetPoint("BOTTOMRIGHT", topBar, "BOTTOMRIGHT", 0, -6)
    topBar.bgTexture:SetSize(topBar:GetWidth(), 104)
    topBar.bgTexture:SetTexture("Interface/Addons/KeyMaster/Assets/Images/"..Theme.style)
    topBar.bgTexture:SetTexCoord(2/1024, 856/1024, 841/1024, 945/1024)

    --[[ topBar.displayBG = topBar:CreateTexture(nil, "BACKGROUND", nil, 0)
    topBar.displayBG:SetPoint("BOTTOMRIGHT", topBar, "BOTTOMRIGHT", 0, -2)
    topBar.displayBG:SetSize(320, 77)
    topBar.displayBG:SetTexture("Interface/Addons/KeyMaster/Assets/Images/"..Theme.style)
    topBar.displayBG:SetTexCoord(662/1024, 1, 946/1024, 1) ]]

    return headerRegion
end

--------------------------------
-- Out Of Date Notification
--------------------------------
function HeaderFrame:AddonVersionNotify(parentframe)
    local addonOudatedFrame = CreateFrame("FRAME", "KM_AddonOutdated", parentframe)
    addonOudatedFrame:SetHeight(32)
    addonOudatedFrame:SetPoint("BOTTOMRIGHT", parentframe, "TOPRIGHT", -2, 4)
    addonOudatedFrame.border = addonOudatedFrame:CreateTexture(nil, "BACKGROUND")
    addonOudatedFrame.border:SetAllPoints(addonOudatedFrame)
    addonOudatedFrame.border:SetColorTexture(1,0,0,1)
    addonOudatedFrame.boxBackground = addonOudatedFrame:CreateTexture(nil, "ARTWORK")
    addonOudatedFrame.boxBackground:SetPoint("CENTER", addonOudatedFrame, "CENTER")
    addonOudatedFrame.boxBackground:SetColorTexture(0,0,0,1)
    addonOudatedFrame.text = addonOudatedFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    addonOudatedFrame.text:SetPoint("CENTER", addonOudatedFrame, "CENTER")
    addonOudatedFrame.text:SetTextColor(1,1,0,1)
    addonOudatedFrame.text:SetText(KeyMasterLocals.ADDONOUTOFDATE)
    addonOudatedFrame:SetWidth(addonOudatedFrame.text:GetWidth()+8)
    addonOudatedFrame.boxBackground:SetSize(addonOudatedFrame:GetWidth()-2, addonOudatedFrame:GetHeight()-2)
    addonOudatedFrame:Hide()
end

--------------------------------
-- System Message
--------------------------------
function HeaderFrame:SystemMessage(parentframe)
    local sysMessage = CreateFrame("Frame", "KM_SystemMessage", parentframe)
    sysMessage:SetWidth(300)
    sysMessage:SetPoint("BOTTOMLEFT", parentframe, "TOPLEFT", 2, 4)
    sysMessage.border = sysMessage:CreateTexture(nil, "BACKGROUND")
    sysMessage.border:SetAllPoints(sysMessage)
    sysMessage.border:SetColorTexture(1,0,0,1)
    sysMessage.boxBackground = sysMessage:CreateTexture(nil, "ARTWORK")
    
    sysMessage.boxBackground:SetPoint("CENTER", sysMessage, "CENTER")
    sysMessage.boxBackground:SetColorTexture(0,0,0,1)
    sysMessage.text = sysMessage:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    sysMessage.text:SetPoint("CENTER", sysMessage, "CENTER")
    sysMessage.text:SetTextColor(1,1,0,1)
    sysMessage.text:SetText(KeyMasterLocals.SYSTEMMESSAGE["NOTICE"].text)
    sysMessage.text:SetWidth(sysMessage:GetWidth()-8)

    sysMessage.x = sysMessage:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    sysMessage.x:SetPoint("TOPRIGHT", sysMessage, "TOPRIGHT", -2, -3)
    sysMessage.x:SetTextColor(1,1,1,1)
    sysMessage.x:SetText("X")
    sysMessage.x:SetSize(10,10)

    sysMessage:SetHeight(sysMessage.text:GetHeight()+8)
    sysMessage.boxBackground:SetSize(sysMessage:GetWidth()-2, sysMessage:GetHeight()-2)

    --if (DungeonTools:GetCurrentSeason() == 13) then
    --    sysMessage:Show()
    --else
        sysMessage:Hide()
    --end
    
    sysMessage:SetScript("OnMouseUp", function (self)
        self:Hide()
    end)

    return sysMessage
end

function HeaderFrame:CreatePlayerInfoBox(parentFrame)
    local headerPlayerInfoBox = CreateFrame("Frame", "KeyMaster_PlayerInfobox", parentFrame)
    --headerPlayerInfoBox:SetSize(4, 80)
    headerPlayerInfoBox:SetAllPoints()
    headerPlayerInfoBox:SetWidth(headerPlayerInfoBox:GetParent():GetWidth())
    headerPlayerInfoBox:SetPoint("BOTTOMRIGHT", parentFrame, "BOTTOMRIGHT", 0, 6)

    --------------------------------
    -- todo: remove box - hide for now
    --headerPlayerInfoBox:Hide()
    --------------------------------

    return headerPlayerInfoBox

end

--------------------------------
-- Weekly Affix
--------------------------------
function HeaderFrame:CreateAffixFrames(parentFrame)
    if (parentFrame == nil) then 
        KeyMaster:_ErrorMsg("KeyMaster_AffixFrameTop", "HeaderFrame", "Parameter Null - No parent frame passed to this function.")
        return
    end
    local seasonalAffixes = KeyMaster.DungeonTools:GetAffixes()
    if (seasonalAffixes == nil) then 
        KeyMaster:_DebugMsg("KeyMaster_AffixFrameTop", "HeaderFrame", "No active weekly affix was found.")
        return 
    end

    local tooltipFrame = _G["KM_Tooltip"] or KMFactory:Create(_G["KeyMaster_MainFrame"], "Tooltip", {name ="KM_Tooltip"})
    local numAffixes = #seasonalAffixes
    local doOnce = 0
    for i=#seasonalAffixes, 1, -1 do
        local affixIconFrame = CreateFrame("Frame", "KeyMaster_AffixFrameTop"..tostring(i), parentFrame)
        affixIconFrame:SetSize(40, 40)
        if (i == numAffixes) then
            affixIconFrame:SetPoint("BOTTOMRIGHT", parentFrame, "BOTTOMRIGHT", -4, 0)
        else
            local a = i + 1
            affixIconFrame:SetPoint("TOPRIGHT", "KeyMaster_AffixFrameTop"..tostring(a), "TOPLEFT", -4, 0)
        end
        
        -- Affix Icon
        local tex = affixIconFrame:CreateTexture()
        tex:SetAllPoints(affixIconFrame)
        tex:SetTexture(seasonalAffixes[i].filedataid)

        affixIconFrame.tooltipData = {title = seasonalAffixes[i].name, desc = seasonalAffixes[i].desc}

        -- have to call this here initially for the first tooltip to work properly.
        KeyMaster:SetTooltipText(affixIconFrame, seasonalAffixes[i].name, seasonalAffixes[i].desc)

        affixIconFrame:SetScript("OnEnter", function (self) 
            local tooltipTitle = self.tooltipData["title"]
            local tooltipDesc = self.tooltipData["desc"]
            local anchor = affixIconFrame
            KeyMaster:SetTooltipText(anchor, tooltipTitle, tooltipDesc)
            tooltipFrame:Show()  
        end)
    
        affixIconFrame:SetScript("OnLeave", function (self) 
            tooltipFrame:Hide()
        end)

    end

end

--------------------------------
-- Mythic Key
--------------------------------
function HeaderFrame:CreateHeaderKeyFrame(parentFrame, anchorFrame)
    local key_frame = CreateFrame("Frame", "KeyMaster_MythicKeyHeader", parentFrame)
    --key_frame:SetSize(anchorFrame:GetHeight(), anchorFrame:GetHeight())
    key_frame:SetPoint("TOPRIGHT", anchorFrame, "TOPRIGHT", 0, 0)

    key_frame.keyAbbrText = key_frame:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    local path, _, flags = key_frame.keyAbbrText:GetFont()
    key_frame.keyAbbrText:SetFont(path, 26, flags)
    local keyAbbrTextAnchor = anchorFrame:GetHeight()
    key_frame.keyAbbrText:SetPoint("RIGHT", anchorFrame, "RIGHT", -4, 9)
    key_frame.keyAbbrText:SetTextColor(1,1,1,1)
    key_frame.keyAbbrText:SetText("")
    key_frame:SetAttribute("keyAbbr", key_frame.keyAbbrText)

    key_frame.keyLevelText = key_frame:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    key_frame.keyLevelText:SetFont(path, 26, flags)
    key_frame.keyLevelText:SetPoint("RIGHT", key_frame.keyAbbrText, "LEFT", -4, 0)
    key_frame.keyLevelText:SetTextColor(1,1,1,1)
    key_frame.keyLevelText:SetText("")
    key_frame:SetAttribute("keyLevel", key_frame.keyLevelText)

    key_frame.titleText = key_frame:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    key_frame.titleText:SetPoint("RIGHT", key_frame.keyLevelText, "LEFT", -4, 0)
    key_frame.titleText:SetFont(path, 10, flags)
    key_frame.titleText:SetTextColor(1,1,1,1)
    key_frame.titleText:SetText(KeyMasterLocals.YOURCURRENTKEY..":")
    key_frame.titleText:SetJustifyH("RIGHT")
    --key_frame.titleText:SetRotation(math.pi/2)
    key_frame:SetAttribute("title", key_frame.titleText)

    local line_frame = CreateFrame("Frame", nil, key_frame)
    line_frame:SetSize(214, 1)
    line_frame:SetPoint("BOTTOMRIGHT", key_frame.keyAbbrText, "TOPRIGHT", 0, 0)
    line_frame.texture = line_frame:CreateTexture(nil, "BACKGROUND",nil)
    line_frame.texture:SetAllPoints(line_frame)
    line_frame.texture:SetColorTexture(1, 1, 1, 1)

    local line_frame2 = CreateFrame("Frame", nil, key_frame)
    line_frame2:SetSize(214, 1)
    line_frame2:SetPoint("TOPRIGHT", key_frame.keyAbbrText, "BOTTOMRIGHT", 0, 0)
    line_frame2.texture = line_frame2:CreateTexture(nil, "BACKGROUND",nil)
    line_frame2.texture:SetAllPoints(line_frame2)
    line_frame2.texture:SetColorTexture(1, 1, 1, 1)

    key_frame:SetHeight(key_frame.titleText:GetStringWidth())
    key_frame:SetWidth(key_frame.titleText:GetStringWidth())

    return key_frame
end

--------------------------------
-- Create Content Frames
--------------------------------
function HeaderFrame:CreateHeaderContent(parentFrame)

    -- Contents
    local headerContent = CreateFrame("Frame", "KeyMaster_HeaderFrameContent", parentFrame);
    headerContent:SetSize(parentFrame:GetWidth(), parentFrame:GetHeight())
    headerContent:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 0, 0)
    
    headerContent.logo = headerContent:CreateTexture()
    headerContent.logo:SetPoint("BOTTOMLEFT", headerContent, "BOTTOMLEFT", 48, 34)
    headerContent.logo:SetSize(280, 34)
    headerContent.logo:SetTexture("Interface/Addons/KeyMaster/Assets/Images/"..Theme.style)
    headerContent.logo:SetTexCoord(20/1024, 353/1024, 970/1024, 1010/1024)

    local xpacNum = GetServerExpansionLevel()
    local xpacDesc
    local seasonNum = DungeonTools:GetCurrentSeason()
    if (xpacNum ~= nil) then -- check the expansion number was returned
        xpacDesc = KeyMasterLocals.MPLUSSEASON[seasonNum].name
        -- xpacDesc = KeyMasterLocals.XPAC[xpacNum].desc
        -- if (xpacDesc ~= nil and seasonNum ~= nil and seasonNum > 0) then
            -- xpacDesc = xpacDesc.." "..KeyMasterLocals.MPLUSSEASON[seasonNum].name
        -- end
    end
    if (xpacDesc ~= nil) then -- if no desciption found, skip this
        headerContent.xpacInformation = headerContent:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
        headerContent.xpacInformation:SetPoint("BOTTOMLEFT", headerContent.logo, "TOPLEFT", 10, -2)
        headerContent.xpacInformation:SetAlpha(0.3)
        headerContent.xpacInformation:SetText(xpacDesc)
    end

    local displayVersion
    if (KM_VERSION_STATUS ~= KeyMasterLocals.BUILDBETA) then
        displayVersion = KeyMasterLocals.DISPLAYVERSION..KM_AUTOVERSION
    else
        displayVersion = KeyMasterLocals.DISPLAYVERSION..KM_AUTOVERSION.. " "..KM_VERSION_STATUS
    end

    local VersionText = headerContent:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    VersionText:SetPoint("TOPRIGHT",  headerContent.logo, "BOTTOMRIGHT", -8, 3)
    local path, _, flags = VersionText:GetFont()
    VersionText:SetFont(path, 9, flags)
    VersionText:SetJustifyH("RIGHT")
    VersionText:SetJustifyV("TOP")
    VersionText:SetText(displayVersion)
    VersionText:SetAlpha(0.6)

    local Localization = headerContent:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    Localization:SetPoint("TOPRIGHT",  headerContent, "TOPRIGHT", -18, -3)
    local path, _, flags = VersionText:GetFont()
    Localization:SetFont(path, 9, flags)
    Localization:SetJustifyH("RIGHT")
    Localization:SetJustifyV("TOP")
    Localization:SetText(KeyMasterLocals.LANGUAGE)
    Localization:SetAlpha(0.4)
    
    return headerContent
end

function HeaderFrame:Initialize(parentFrame)
    
    local headerRegion = _G["KeyMaster_HeaderRegion"] or HeaderFrame:CreateHeaderRegion(parentFrame)
    local addonVersionNotify = _G["KM_AddonOutdated"] or HeaderFrame:AddonVersionNotify(parentFrame)
    local headerContent = _G["KeyMaster_HeaderFrame"] or HeaderFrame:CreateHeaderContent(headerRegion)    
    local headerInfoBox = _G["KeyMaster_PlayerInfobox"] or HeaderFrame:CreatePlayerInfoBox(headerContent)
    local headerAffixFrame = HeaderFrame:CreateAffixFrames(headerInfoBox)
    local headerKey = _G["KeyMaster_MythicKeyHeader"] or HeaderFrame:CreateHeaderKeyFrame(headerContent, headerInfoBox)

    -- System Message
    local sysMessage = _G["KM_SystemMessage"] or HeaderFrame:SystemMessage(parentFrame)
    
    return headerRegion
end