local _, KeyMaster = ...
KeyMaster.Header = {}
local MainInterface = KeyMaster.MainInterface
local Header = KeyMaster.Header
local DungeonTools = KeyMaster.DungeonTools

-- Setup header region
function MainInterface:CreateHeaderRegion(parentFrame)
    local fr, mlr, mtb = MainInterface:GetFrameRegions("header", parentFrame)
    local headerRegion = CreateFrame("Frame", "KeyMaster_HeaderRegion", parentFrame);
    headerRegion:SetSize(fr.w, fr.h)
    headerRegion:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", mlr, -(mtb))
    headerRegion.texture = headerRegion:CreateTexture()
    headerRegion.texture:SetHeight(114)
    headerRegion.texture:SetWidth(headerRegion:GetWidth())
    headerRegion.texture:SetPoint("TOP", 0, 0)
    headerRegion.texture:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\KeyMaster")
    headerRegion.texture:SetTexCoord(0, 1, 398/512, 1)

    return headerRegion
end

local function AddTopBar(parentFrame)
    local topBar = CreateFrame("Frame", "KeyMaster_HeaderInfo_Wrapper",parentFrame);
    topBar:SetFrameLevel(parentFrame:GetFrameLevel()-1)
    local w = _G["KeyMaster_PlayerInfobox"]:GetWidth()
    w = w + _G["KeyMaster_MythicKeyHeader"]:GetWidth()

    topBar.bar = topBar:CreateTexture(nil, "BACKGROUND", nil, 0)
    local dynOffset = 134
    topBar:SetSize(w + dynOffset + 20, 80)
    topBar:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", -dynOffset, -4)
    
    topBar.bar:SetHeight(114)
    topBar.bar:SetWidth(topBar:GetWidth())
    topBar.bar:SetPoint("TOP", 0, 0)
    local magicNumber = 1/512
    topBar.bar:SetTexCoord(0, topBar:GetWidth()/512, 0, 112/512)
    topBar.bar:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Top-Bar")

    topBar.texture = topBar:CreateTexture(nil, "BACKGROUND", nil, -1)
    topBar.texture:SetSize(topBar:GetWidth()-100, topBar:GetHeight()-8)
    topBar.texture:SetPoint("RIGHT", topBar, "RIGHT", 0, -5)
    topBar.texture:SetColorTexture(0, 0, 0, 0.9)

end

function Header:createPlayerInfoBox(parentFrame)
    local headerPlayerInfoBox = CreateFrame("Frame", "KeyMaster_PlayerInfobox", parentFrame)
    headerPlayerInfoBox:SetSize(198, 80)
    headerPlayerInfoBox:SetPoint("BOTTOMRIGHT", parentFrame, "BOTTOMRIGHT", 0, 4)
    --[[ headerPlayerInfoBox.texture = headerPlayerInfoBox:CreateTexture()
    headerPlayerInfoBox.texture:SetAllPoints(headerPlayerInfoBox)
    headerPlayerInfoBox.texture:SetColorTexture(0, 0, 0, 0.7) ]]
    --KeyMaster:CreateHLine(headerPlayerInfoBox:GetWidth()+8, headerPlayerInfoBox, "BOTTOM", 0, 0)

    return headerPlayerInfoBox

end


--------------------------------
-- Weekly Affix
--------------------------------
function Header:createAffixFrames(parentFrame, seasonalAffixes)
    if (parentFrame == nil) then 
        KeyMaster:_ErrorMsg("createAffixFrames", "HeaderFrame", "Parameter Null - No parent frame passed to this function.")
        return
    end
    
    if (seasonalAffixes == nil) then 
        KeyMaster:_ErrorMsg("createAffixFrames", "HeaderFrame", "No mythic plus season affixes found!")
        return 
    end
    
    for i=1, #seasonalAffixes, 1 do

        local affixName = seasonalAffixes[i].name
        local temp_frame = CreateFrame("Frame", "KeyMaster_AffixFrame"..tostring(i), parentFrame)
        temp_frame:SetSize(50, 50)
        if (i == 1) then
            temp_frame:SetPoint("BOTTOMLEFT", parentFrame, "BOTTOMLEFT", 0, 0)
        else
            local a = i - 1
            temp_frame:SetPoint("TOPLEFT", "KeyMaster_AffixFrame"..tostring(a), "TOPRIGHT", 20, 0)
        end
        
        -- Affix Icon
        local tex = temp_frame:CreateTexture()
        tex:SetAllPoints(temp_frame)
        tex:SetTexture(seasonalAffixes[i].filedataid)
        
        -- Affix Name
        local affixNameFrame = CreateFrame("Frame", nil, temp_frame)
        affixNameFrame:SetSize(60, 15)
        affixNameFrame:SetPoint("BOTTOMLEFT", temp_frame, "BOTTOMLEFT")
        local myText = affixNameFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
        local path, _, flags = myText:GetFont()
        myText:SetFont(path, 9, flags)
        myText:SetPoint("LEFT", -12, -9)
        myText:SetTextColor(1,1,1)
        myText:SetJustifyH("LEFT")
        myText:SetText(affixName)
        myText:SetRotation(math.pi/2)

        -- Affix name background
        local affixBGFrame = CreateFrame("Frame", nil, temp_frame)
        affixBGFrame:SetFrameLevel(affixBGFrame:GetParent():GetFrameLevel()-1)
        affixBGFrame:SetSize(26, temp_frame:GetHeight())
        affixBGFrame:SetPoint("BOTTOMRIGHT", temp_frame, "BOTTOMLEFT", 10, 0)
        affixBGFrame.texture = affixBGFrame:CreateTexture(nil, "BACKGROUND",nil)
        affixBGFrame.texture:SetAllPoints(affixBGFrame)
        affixBGFrame.texture:SetColorTexture(0, 0, 0, 0.7)

        -- create a title and set it to the first affix's frame
        --[[ if (i == 1) then
            local temp_header = CreateFrame("Frame", "KeyMaster_AffixFrameTitle", temp_frame)
            temp_header:SetSize(168, 20)
            temp_header:SetPoint("BOTTOMLEFT", temp_frame, "TOPLEFT", -16, 0)
            local temp_headertxt = temp_header:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
            temp_headertxt:SetFont(path, 14, flags)
            temp_headertxt:SetPoint("LEFT", 0, 0)
            temp_headertxt:SetTextColor(1,1,1,1)
            temp_headertxt:SetText(KeyMasterLocals.THISWEEKSAFFIXES)
        end ]]

    end

end

--------------------------------
-- Mythic Key
--------------------------------
function Header:createHeaderKeyFrame(parentFrame, anchorFrame)
    local key_frame = CreateFrame("Frame", "KeyMaster_MythicKeyHeader", parentFrame)
    key_frame:SetSize(anchorFrame:GetHeight(), anchorFrame:GetHeight())
    key_frame:SetPoint("RIGHT", anchorFrame, "LEFT", -20, 0)

    key_frame.keyLevelText = key_frame:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    local path, _, flags = key_frame.keyLevelText:GetFont()
    key_frame.keyLevelText:SetFont(path, 26, flags)
    key_frame.keyLevelText:SetPoint("BOTTOM", 0, 28)
    key_frame.keyLevelText:SetTextColor(1,1,1,1)
    key_frame.keyLevelText:SetText("")
    key_frame:SetAttribute("keyLevel", key_frame.keyLevelText)

    key_frame.keyAbbrText = key_frame:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    key_frame.keyAbbrText:SetFont(path, 26, flags)
    key_frame.keyAbbrText:SetPoint("BOTTOM", 0, 0)
    key_frame.keyAbbrText:SetTextColor(1,1,1,1)
    key_frame.keyAbbrText:SetText("")
    key_frame:SetAttribute("keyAbbr", key_frame.keyAbbrText)

    key_frame.titleText = key_frame:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    key_frame.titleText:SetPoint("LEFT", key_frame.keyAbbrText, "BOTTOMLEFT", -18, -2)
    key_frame.titleText:SetFont(path, 10, flags)
    key_frame.titleText:SetTextColor(1,1,1,1)
    key_frame.titleText:SetText(KeyMasterLocals.YOURCURRENTKEY)
    key_frame.titleText:SetJustifyH("LEFT")
    key_frame.titleText:SetRotation(math.pi/2)
    key_frame:SetAttribute("title", key_frame.titleText)

    local line_frame = CreateFrame("Frame", nil, key_frame)
    line_frame:SetSize(40, 1)
    line_frame:SetPoint("BOTTOM", key_frame, "BOTTOM", 0, 26)
    line_frame.texture = line_frame:CreateTexture(nil, "BACKGROUND",nil)
    line_frame.texture:SetAllPoints(line_frame)
    line_frame.texture:SetColorTexture(1, 1, 1, 1)

    AddTopBar(key_frame)

    return key_frame
end

--------------------------------
-- Mythic Rating
--------------------------------
--[[ function Header:createHeaderRating(parentFrame)
    
    local ratingPanel = CreateFrame("Frame", "KeyMaster_RatingFrame", parentFrame)
    ratingPanel:SetWidth(40)
    ratingPanel:SetHeight(42)
    ratingPanel:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT", -4, -(((ratingPanel:GetParent():GetHeight() - ratingPanel:GetHeight())/2)))
    local mythicRatingPreText = ratingPanel:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    local Path, _, Flags = mythicRatingPreText:GetFont()
    mythicRatingPreText:SetFont(Path, 12, Flags)
    mythicRatingPreText:SetPoint("TOP")
    mythicRatingPreText:SetText(KeyMasterLocals.YOURRATING..":")

    mythicRatingPreText = ratingPanel:CreateFontString("KeyMaster_RatingScore", "OVERLAY", "KeyMasterFontBig")
    local Path, _, Flags = mythicRatingPreText:GetFont()
    mythicRatingPreText:SetFont(Path, 30, Flags)
    mythicRatingPreText:SetPoint("BOTTOM", 0, 0)

    return ratingPanel
end ]]

--------------------------------
-- Key Master Icon
--------------------------------
function MainInterface:createAddonIcon(parentFrame)
    
    local addonIconFrame = CreateFrame("Frame", "KeyMaster_Icon", parentFrame)
    addonIconFrame:SetSize(100, 100)
    addonIconFrame:SetPoint("CENTER", parentFrame, "TOPLEFT", 0, 0)

    local addonIcon = addonIconFrame:CreateTexture("KM_Icon", "OVERLAY")
    addonIcon:SetHeight(addonIconFrame:GetHeight())
    addonIcon:SetWidth(addonIconFrame:GetHeight())
    addonIcon:SetTexture("Interface\\AddOns\\KeyMaster\\Assets\\Images\\KeyMaster-Icon2",false)
    addonIcon:ClearAllPoints()
    addonIcon:SetPoint("LEFT", 15, -15)

    return addonIcon
end

--------------------------------
-- Create Content Frames
--------------------------------
function MainInterface:CreateHeaderContent(parentFrame)

    -- Contents
    local headerContent = CreateFrame("Frame", "KeyMaster_HeaderFrameContent", parentFrame);
    headerContent:SetSize(parentFrame:GetWidth(), parentFrame:GetHeight())
    headerContent:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 0, 0)
    
    headerContent.logo = headerContent:CreateTexture(nil, "OVERLAY")
    headerContent.logo:SetSize(300, 38)
    headerContent.logo:SetPoint("BOTTOMLEFT", headerContent, "BOTTOMLEFT", 4, 0)
    headerContent.logo:SetTexCoord(0, 1, 15/512, 79/512)
    headerContent.logo:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\KeyMaster")

    --[[ local txtPlaceHolder = headerContent:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    local Path, _, Flags = txtPlaceHolder:GetFont()
    txtPlaceHolder:SetFont(Path, 30, Flags)
    txtPlaceHolder:SetPoint("BOTTOMLEFT", 10, 10)
    txtPlaceHolder:SetTextColor(1, 1, 1)
    txtPlaceHolder:SetText(KM_ADDON_NAME) ]]

    local VersionText = headerContent:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    VersionText:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT", -24, -2)
    VersionText:SetText(KM_VERSION)
    
    return headerContent
end