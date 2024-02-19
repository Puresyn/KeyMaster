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
    headerRegion.texture:SetAllPoints(headerRegion)
    headerRegion.texture:SetColorTexture(0.231, 0.231, 0.231, 1) -- temporary bg color
    return headerRegion
end


--------------------------------
-- Weekly Affix
--------------------------------
function Header:createAffixFrames(parentFrame)
    if (parentFrame == nil) then 
        KeyMaster:Print("Error: Parameter Null - No parent frame passed to CreateAffixFrames function.")
        return
    end
    
    local weekData = DungeonTools:GetAffixes()
    if (weekData == nil) then 
        KeyMaster:Print("Error: No mythic plus season affixes found!")
        return 
    end
    for i=1, #weekData, 1 do

        local affixName = weekData[i].name
        local temp_frame = CreateFrame("Frame", "KeyMaster_AffixFrame"..tostringall(i), parentFrame)
        temp_frame:SetSize(50, 50)
        if (i == 1) then
            temp_frame:SetPoint("BOTTOMLEFT", parentFrame, "BOTTOMLEFT", 270, 4)
        else
            local a = i - 1
            temp_frame:SetPoint("TOPLEFT", "KeyMaster_AffixFrame"..tostringall(a), "TOPRIGHT", 20, 0)
        end
        
        -- Affix Icon
        local tex = temp_frame:CreateTexture()
        tex:SetAllPoints(temp_frame)
        tex:SetTexture(weekData[i].filedataid)
        
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
        --affixBGFrame.texture:SetPoint("LEFT", -20, -10)

        -- create a title and set it to the first affix's frame
        if (i == 1) then
            local temp_header = CreateFrame("Frame", "KeyMaster_AffixFrameTitle", temp_frame)
            temp_header:SetSize(168, 20)
            temp_header:SetPoint("BOTTOMLEFT", temp_frame, "TOPLEFT", -16, 0)
            local temp_headertxt = temp_header:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
            temp_headertxt:SetFont(path, 14, flags)
            temp_headertxt:SetPoint("LEFT", 0, 0)
            temp_headertxt:SetTextColor(1,1,1)
            temp_headertxt:SetText(KeyMasterLocals.THISWEEKSAFFIXES..":")
        end

    end
end

--------------------------------
-- Mythic Rating
--------------------------------
function Header:createHeaderRating(parentFrame)
    
    local ratingPanel = CreateFrame("Frame", "KeyMaster_RatingFrame", parentFrame)
    ratingPanel:SetWidth(150)
    ratingPanel:SetHeight(13)
    ratingPanel:SetPoint("TOPRIGHT", -4, -50)
    local mythicRatingPreText = ratingPanel:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    local Path, _, Flags = mythicRatingPreText:GetFont()
    mythicRatingPreText:SetFont(Path, 12, Flags)
    mythicRatingPreText:SetPoint("CENTER")
    mythicRatingPreText:SetText(KeyMasterLocals.YOURRATING..":")

    mythicRatingPreText = ratingPanel:CreateFontString("KeyMaster_RatingScore", "OVERLAY", "KeyMasterFontBig")
    local Path, _, Flags = mythicRatingPreText:GetFont()
    mythicRatingPreText:SetFont(Path, 30, Flags)
    mythicRatingPreText:SetPoint("CENTER", 0, -22)

    return ratingPanel
end

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

    local txtPlaceHolder = headerContent:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    local Path, _, Flags = txtPlaceHolder:GetFont()
    txtPlaceHolder:SetFont(Path, 30, Flags)
    txtPlaceHolder:SetPoint("BOTTOMLEFT", 10, 10)
    txtPlaceHolder:SetTextColor(1, 1, 1)
    txtPlaceHolder:SetText(KM_ADDON_NAME)

    local VersionText = headerContent:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    VersionText:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT", -24, -2)
    VersionText:SetText(KM_VERSION)
    
    return headerContent
end