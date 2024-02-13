local _, KeyMaster = ...
local DungeonTools = KeyMaster.DungeonTools

function DungeonTools:GetWeekInfo()
    local str = ""
    local i = 0
    local temp_frame, temp_header,temp_headertxt
    weekData = core.PlayerInfo:GetAffixes()
    for i=1, #weekData, i+1 do

        str = weekData[i].name
        temp_frame = CreateFrame("Frame", "KeyMaster_Affix"..tostringall(i), HeaderFrame)
        temp_frame:SetSize(40, 40)
        if (i == 1) then
            temp_frame:SetPoint("TOPLEFT", HeaderFrame, "TOPLEFT", 350, -30)
        else
            local a = i - 1
            temp_frame:SetPoint("TOPLEFT", "KeyMaster_Affix"..tostringall(a), "TOPRIGHT", 14, 0)
        end
        
        temp_frame.texture = temp_frame:CreateTexture()
        temp_frame.texture:SetAllPoints(temp_frame)
        temp_frame.texture:SetTexture(weekData[i].filedataid)
        myText = temp_frame:CreateFontString(nil, "OVERLAY", "GameTooltipText")
        Path, _, Flags = myText:GetFont()
        myText:SetFont(Path, 11, Flags)
        myText:SetPoint("CENTER", 0, -30)
        myText:SetTextColor(1,1,1)
        myText:SetText(str)

        -- create a title and set it to the first affix's frame
        if (i == 1) then
            temp_header = CreateFrame("Frame", "KeyMaster_Affix_Header", temp_frame)
            temp_header:SetSize(168, 20)
            temp_header:SetPoint("BOTTOMLEFT", temp_frame, "TOPLEFT", -4, 0)
            temp_headertxt = temp_header:CreateFontString(nil, "OVERLAY", "GameTooltipText")
            temp_headertxt:SetFont(Path, 14, Flags)
            temp_headertxt:SetPoint("LEFT", 0, 0)
            temp_headertxt:SetTextColor(1,1,1)
            temp_headertxt:SetText("This Week\'s Affixes:")
        end

    end
    return temp_frame
end