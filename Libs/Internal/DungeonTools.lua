local _, KeyMaster = ...
KeyMaster.DungeonTools = {}
local DungeonTools = KeyMaster.DungeonTools

function DungeonTools:GetAffixes()
    local i = 0
    local a, id, name, desc, filedataid
    local affixData = {}
    local affixes = C_MythicPlus.GetCurrentAffixes()
    for i=1, #affixes, i+1 do
        id = affixes[i].id
        name, desc, filedataid = C_ChallengeMode.GetAffixInfo(id)
        affixData[i] = {
            ["id"] = id,
            ["name"] = name,
            ["desc"] = description,
            ["filedataid"] = filedataid
        }
    end
    return affixData
end

function DungeonTools:GetWeekInfo(parentFrame)
    if (parentFrame == nil) then 
        KeyMaster:Print("Parameter Null: No parent frame passed to GetWeekInfo function.")
        return
    end
    local str = ""
    local i = 0
    local temp_frame, temp_header,temp_headertxt
    local weekData = DungeonTools:GetAffixes()
    for i=1, #weekData, i+1 do

        str = weekData[i].name
        temp_frame = CreateFrame("Frame", "KeyMaster_AffixFrame"..tostringall(i), parentFrame)
        temp_frame:SetSize(40, 40)
        if (i == 1) then
            temp_frame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 350, -30)
        else
            local a = i - 1
            temp_frame:SetPoint("TOPLEFT", "KeyMaster_AffixFrame"..tostringall(a), "TOPRIGHT", 14, 0)
        end
        
        temp_frame.texture = temp_frame:CreateTexture()
        temp_frame.texture:SetAllPoints(temp_frame)
        temp_frame.texture:SetTexture(weekData[i].filedataid)
        local myText = temp_frame:CreateFontString(nil, "OVERLAY", "GameTooltipText")
        local path, _, flags = myText:GetFont()
        myText:SetFont(path, 11, flags)
        myText:SetPoint("CENTER", 0, -30)
        myText:SetTextColor(1,1,1)
        myText:SetText(str)

        -- create a title and set it to the first affix's frame
        if (i == 1) then
            temp_header = CreateFrame("Frame", "KeyMaster_AffixFrameTitle", temp_frame)
            temp_header:SetSize(168, 20)
            temp_header:SetPoint("BOTTOMLEFT", temp_frame, "TOPLEFT", -4, 0)
            temp_headertxt = temp_header:CreateFontString(nil, "OVERLAY", "GameTooltipText")
            temp_headertxt:SetFont(path, 14, flags)
            temp_headertxt:SetPoint("LEFT", 0, 0)
            temp_headertxt:SetTextColor(1,1,1)
            temp_headertxt:SetText("This Week\'s Affixes:")
        end

    end
end

function DungeonTools:GetMapName(mapid)
    local name,_,_,_,_ = C_ChallengeMode.GetMapUIInfo(mapid)

    if (name == nil) then
        print("Unable to find mapname for id " .. mapid)   
        return nil   
    end

    return name
end

function DungeonTools:GetCurrentSeasonMaps()
    local maps = C_ChallengeMode.GetMapTable();
    
    local mapTable = {}
    for i,v in ipairs(maps) do
       local name, id, timeLimit, texture, backgroundTexture = C_ChallengeMode.GetMapUIInfo(v)
       mapTable[id] = {
          ["name"] = name,
          ["timeLimit"] = timeLimit,
          ["texture"] = texture,
          ["backgroundTexture"] = backgroundTexture
       }
    end
    
    return mapTable  
end

