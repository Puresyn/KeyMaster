local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface
local DungeonTools = KeyMaster.DungeonTools

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
-- Create Content Frames
--------------------------------
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

    createAffixFrames(headerContent)
    
    return headerFrame
end