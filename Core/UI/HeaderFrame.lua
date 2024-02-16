local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface
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
local function createAffixFrames(parentFrame)
    if (parentFrame == nil) then 
        KeyMaster:Print("Parameter Null: No parent frame passed to CreateAffixFrames function.")
        return
    end
    
    local weekData = DungeonTools:GetAffixes()
    for i=1, #weekData, 1 do

        local affixName = weekData[i].name
        local temp_frame = CreateFrame("Frame", "KeyMaster_AffixFrame"..tostringall(i), parentFrame)
        temp_frame:SetSize(40, 40)
        if (i == 1) then
            temp_frame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 350, -30)
        else
            local a = i - 1
            temp_frame:SetPoint("TOPLEFT", "KeyMaster_AffixFrame"..tostringall(a), "TOPRIGHT", 14, 0)
        end
        
        -- Affix Icon
        local tex = temp_frame:CreateTexture()
        tex:SetAllPoints(temp_frame)
        tex:SetTexture(weekData[i].filedataid)
        
        -- Affix Name
        local myText = temp_frame:CreateFontString(nil, "OVERLAY", "GameTooltipText")
        local path, _, flags = myText:GetFont()
        myText:SetFont(path, 11, flags)
        myText:SetPoint("CENTER", 0, -30)
        myText:SetTextColor(1,1,1)
        myText:SetText(affixName)

        -- create a title and set it to the first affix's frame
        if (i == 1) then
            local temp_header = CreateFrame("Frame", "KeyMaster_AffixFrameTitle", temp_frame)
            temp_header:SetSize(168, 20)
            temp_header:SetPoint("BOTTOMLEFT", temp_frame, "TOPLEFT", -4, 0)
            local temp_headertxt = temp_header:CreateFontString(nil, "OVERLAY", "GameTooltipText")
            temp_headertxt:SetFont(path, 14, flags)
            temp_headertxt:SetPoint("LEFT", 0, 0)
            temp_headertxt:SetTextColor(1,1,1)
            temp_headertxt:SetText("This Week\'s Affixes:")
        end

    end
end

--------------------------------
-- Mythic Rating
--------------------------------
local function createHeaderRating(parentFrame)
    
    local ratingPanel = CreateFrame("Frame", "KeyMaster_RatingFrame", parentFrame)
    ratingPanel:SetWidth(300)
    ratingPanel:SetHeight(13)
    ratingPanel:SetPoint("TOPRIGHT", -2, -30)
    local mythicRatingPreText = ratingPanel:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    local Path, _, Flags = mythicRatingPreText:GetFont()
    mythicRatingPreText:SetFont(Path, 12, Flags)
    mythicRatingPreText:SetPoint("CENTER")
    mythicRatingPreText:SetText("Your Rating:")

    mythicRatingPreText = ratingPanel:CreateFontString("KeyMaster_RatingScore", "OVERLAY", "KeyMasterFontBig")
    local Path, _, Flags = mythicRatingPreText:GetFont()
    mythicRatingPreText:SetFont(Path, 30, Flags)
    mythicRatingPreText:SetPoint("CENTER", 0, -22)
    --mythicRatingPreText:SetTextColor(myRatingColor.r, myRatingColor.g, myRatingColor.b)
    --mythicRatingPreText:SetText(myCurrentRating) -- todo: Gets updated currently in partyFrame updates.

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
--[[     if (parentFrame == nil) then 
        KeyMaster:Print("Parameter Null: No parent frame passed to CreateHeaderFrame function.")
        return
    end
    local fr, mlr, mtb = MainInterface:GetFrameRegions("header", parentFrame)
    local headerFrame = CreateFrame("Frame", "KeyMaster_HeaderFrame", parentFrame);
    headerFrame:SetSize(fr.w, fr.h)
    headerFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", mlr, -(mtb))
    headerFrame.texture = headerFrame:CreateTexture()
    headerFrame.texture:SetAllPoints(headerFrame)
    headerFrame.texture:SetColorTexture(0.231, 0.231, 0.231, 1) -- temporary bg color ]]

    -- Contents
    local headerContent = CreateFrame("Frame", "KeyMaster_HeaderFrameContent", parentFrame);
    headerContent:SetSize(parentFrame:GetWidth(), parentFrame:GetHeight())
    headerContent:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 0, 0)
    
    --[[ HeaderScreen.texture = HeaderScreen:CreateTexture()
    HeaderScreen.texture:SetAllPoints(HeaderScreen)
    HeaderScreen.texture:SetTexture("Interface\\AddOns\\KeyMaster\\Imgs\\WHITE8X8")
    HeaderScreen.texture:SetColorTexture(0.231, 0.231, 0.231, 1) ]]

    local txtPlaceHolder = headerContent:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    local Path, _, Flags = txtPlaceHolder:GetFont()
    txtPlaceHolder:SetFont(Path, 30, Flags)
    txtPlaceHolder:SetPoint("BOTTOMLEFT", 10, 10)
    txtPlaceHolder:SetTextColor(1, 1, 1)
    txtPlaceHolder:SetText("Key Master")

    local VersionText = headerContent:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    VersionText:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT", -24, -2)
    VersionText:SetText(KM_VERSION)

    createAffixFrames(headerContent)
    createHeaderRating(headerContent)
    
    return headerContent
end