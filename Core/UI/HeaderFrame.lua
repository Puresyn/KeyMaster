local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface
local DungeonTools = KeyMaster.DungeonTools

--------------------------------
-- Create Content Frames
--------------------------------

-- Setup header region
function MainInterface:CreateHeaderFrame(parentFrame)
    if (parentFrame == nil) then 
        KeyMaster:Print("Parameter Null: No parent frame passed to CreateHeaderFrame function.")
        return
    end
    local fr, mlr, mtb = MainInterface:GetFrameRegions("header", parentFrame)
    local headerFrame = CreateFrame("Frame", "KeyMaster_HeaderFrame", parentFrame);
    headerFrame:SetSize(fr.w, fr.h)
    headerFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", mlr, -(mtb))
    headerFrame.texture = headerFrame:CreateTexture()
    headerFrame.texture:SetAllPoints(headerFrame)
    headerFrame.texture:SetColorTexture(0.231, 0.231, 0.231, 1) -- temporary bg color

    -- Contents
    local headerContent = CreateFrame("Frame", "KeyMaster_HeaderFrameContent", headerFrame);
    headerContent:SetSize(headerFrame:GetWidth(), headerFrame:GetHeight())
    headerContent:SetPoint("TOPLEFT", headerFrame, "TOPLEFT", 0, 0)
    --[[ HeaderScreen.texture = HeaderScreen:CreateTexture()
    HeaderScreen.texture:SetAllPoints(HeaderScreen)
    HeaderScreen.texture:SetTexture("Interface\\AddOns\\KeyMaster\\Imgs\\WHITE8X8")
    HeaderScreen.texture:SetColorTexture(0.231, 0.231, 0.231, 1) ]]

    local txtPlaceHolder = headerContent:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    local Path, _, Flags = txtPlaceHolder:GetFont()
    txtPlaceHolder:SetFont(Path, 30, Flags)
    txtPlaceHolder:SetPoint("BOTTOMLEFT", 10, 10)
    txtPlaceHolder:SetTextColor(1, 1, 1)
    txtPlaceHolder:SetText("Key Master")

    local VersionText = headerContent:CreateFontString(nil, "OVERLAY", "GameTooltipText")
    VersionText:SetPoint("TOPRIGHT", headerFrame, "TOPRIGHT", -24, -2)
    VersionText:SetText(KeyMaster.KM_VERSION)

    -- Create header content
    -- CreateHeaderRating() -- todo: FIXME!
    DungeonTools:GetWeekInfo(headerFrame)
    
    return headerFrame
end