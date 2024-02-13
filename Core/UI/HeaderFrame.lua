local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface
local headerRegion = KeyMaster.MainInterface.headerRegion
local headerContent = KeyMaster.MainInterface.headerContent
local DungeonTools = KeyMaster.DungeonTools

--------------------------------
-- Create Content Frames
--------------------------------

-- Setup header region
function MainInterface:Headerframe()
    local fr, mlr, mtb = GetFrameRegions("header")
    headerRegion = CreateFrame("Frame", "KeyMaster_HeaderRegion", MainInterface.mainPanel);
    headerRegion:SetSize(fr.w, fr.h)
    headerRegion:SetPoint("TOPLEFT", MainPanel, "TOPLEFT", mlr, -(mtb))
    headerRegion.texture = headerRegion:CreateTexture()
    headerRegion.texture:SetAllPoints(headerRegion)
    headerRegion.texture:SetColorTexture(0.231, 0.231, 0.231, 1) -- temporary bg color
    return headerRegion
end

-- Header content
function MainInterface:HeaderScreen()
    local txtPlaceHolder, VersionText
    headerContent = CreateFrame("Frame", "KeyMaster_HeaderScreen", HeaderFrame);
    headerContent:SetSize(HeaderFrame:GetWidth(), HeaderFrame:GetHeight())
    headerContent:SetPoint("TOPLEFT", HeaderFrame, "TOPLEFT", 0, 0)
    --[[ HeaderScreen.texture = HeaderScreen:CreateTexture()
    HeaderScreen.texture:SetAllPoints(HeaderScreen)
    HeaderScreen.texture:SetTexture("Interface\\AddOns\\KeyMaster\\Imgs\\WHITE8X8")
    HeaderScreen.texture:SetColorTexture(0.231, 0.231, 0.231, 1) ]]

    txtPlaceHolder = headerContent:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    local Path, _, Flags = txtPlaceHolder:GetFont()
    txtPlaceHolder:SetFont(Path, 30, Flags)
    txtPlaceHolder:SetPoint("BOTTOMLEFT", 10, 10)
    txtPlaceHolder:SetTextColor(1, 1, 1)
    txtPlaceHolder:SetText("Key Master")

    VersionText = headerContent:CreateFontString(nil, "OVERLAY", "GameTooltipText")
    VersionText:SetPoint("TOPRIGHT", HeaderFrame, "TOPRIGHT", -24, -2)
    VersionText:SetText(KM_VERSION)

    -- Create header content
    -- CreateHeaderRating() -- todo: FIXME!
    DungeonTools:GetWeekInfo()

    return headerContent
end