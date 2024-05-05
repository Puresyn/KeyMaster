--------------------------------
-- ChallengeCompletion.lua
-- Challenge Mode Completion Frame
--------------------------------
local _, KeyMaster = ...
local DungeonTools = KeyMaster.DungeonTools
local ChallengeCompletion = KeyMaster.ChallengeCompletion
local Theme = KeyMaster.Theme

---@param i integer - index
---@param parent string - parent name
---@return table - frame
local function createStar(i, parent)
    local starFrame = CreateFrame("Frame", "KM_Star"..i, parent)
    starFrame:SetSize(52, 50)
    starFrame.texture = starFrame:CreateTexture(nil, "ARTWORK", nil, 3)
    starFrame.texture:SetTexture("Interface/AddOns/KeyMaster/Assets/Images/KeyCompletion")
    starFrame.texture:SetAllPoints(starFrame)
    starFrame.texture:SetTexCoord(460/512, 1, 462/512, 1)
    return starFrame
end

---@param playerGUID string - Players GUID for use in member rows
local playerGUID = UnitGUID("player")

---@param data table
---@param parent table
---@return table - member frame
function ChallengeCompletion:createMemberRows(parent, data)

    local memberCount = KeyMaster:GetTableLength(data)
    if memberCount == 0 then
        KeyMaster:_ErrorMsg("createMemberRows","ChallengeCompletion","No member data.")
        return
    end

    local memberFramesUnsorted = {}
    local memberFramesSorted = {}
    local i = 1

    for row in pairs(data) do
        local guid = data[row][1]
        local name = data[row][2]
        if i > 5 then break end -- not sure why this would ever return more than 5, but just incase...
        local memberFrame = _G["KM_Member"..i] or CreateFrame("Frame", "KM_Member"..i, parent) -- recycle frames

        local classColor = {}
        --KeyMaster:TPrint(GetPlayerInfoByGUID(guid))
       if guid == playerGUID then
            local _, englishClass, _, _, _, _, realm = GetPlayerInfoByGUID(guid) -- gets player info even if offline/left party/etc
      
            if not englishClass then 
                    KeyMaster:_ErrorMsg("createMemberRows","ChallengeCompletion","Could not retrieve english class name for "..name)
                    classColor.r, classColor.g, classColor.b, _ = GetClassColor("PRIEST")
            end
            classColor.r, classColor.g, classColor.b, _ = GetClassColor(englishClass)
        else
            classColor.r, classColor.g, classColor.b = 1, 1, 1
        end

        memberFrame:SetWidth(260)

        memberFrame.playerName = memberFrame.playerName or memberFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
        if guid == playerGUID then
            local font, fontSize, flags = memberFrame.playerName:GetFont()
            memberFrame.playerName:SetFont(font, 18, flags)
            memberFrame:SetAttribute("player", true)
        else
            memberFrame:SetAttribute("player", false)
        end
        memberFrame.playerName:SetAllPoints(memberFrame)
        memberFrame.playerName:SetWidth(memberFrame:GetWidth())
        

        memberFrame.playerName:SetTextColor(classColor.r, classColor.g, classColor.b, 1)
        memberFrame.playerName:SetText(name)
        memberFrame.playerName:SetJustifyH("CENTER")
        memberFrame:SetFrameLevel(parent:GetFrameLevel()+1)
        memberFrame:SetHeight(memberFrame.playerName:GetStringHeight())

        i = i+1

        table.insert(memberFramesUnsorted, memberFrame)

    end

    local playerFrame
    for frame in pairs(memberFramesUnsorted) do -- player first
     if memberFramesUnsorted[frame]:GetAttribute("player") == true then
        playerFrame =  memberFramesUnsorted[frame]
        playerFrame:SetPoint("TOP", parent, "TOP", 0, -270)
        table.insert(memberFramesSorted, memberFramesUnsorted[frame])
        table.remove(memberFramesUnsorted, frame)
     end
    end

    local nextFrame = playerFrame
    for memberFrame in pairs(memberFramesUnsorted) do -- the rest of the members
        if nextFrame then -- if viewing on a character that wasn't in the party - future and testing use. Eventually set to who's run it was.
            memberFramesUnsorted[memberFrame]:SetPoint("TOP", nextFrame, "BOTTOM", 0, -4)
        else
            memberFramesUnsorted[memberFrame]:SetPoint("TOP", parent, "TOP", 0, -270)
        end
        table.insert(memberFramesSorted, memberFramesUnsorted[memberFrame])
        nextFrame = memberFramesUnsorted[memberFrame]
    end

    return memberFramesSorted
end

function ChallengeCompletion:ChallengeCompletionFrame()

    local completionFrame = _G["KM_Challenge_Mode_Completed"] or CreateFrame("Frame", "KM_Challenge_Mode_Completed", UIParent)
    completionFrame:SetFrameStrata("DIALOG")
    completionFrame:SetSize(800, 460)
    completionFrame:SetPoint("TOP", UIParent, "TOP", 0, -100)
    --[[ completionFrame.bg = completionFrame:CreateTexture()
    completionFrame.bg:SetColorTexture(0,0,0,0.2)
    completionFrame.bg:SetAllPoints(completionFrame) ]]
    ---------------------------------
    -- test functions
       --[[  local mapID = 403
        local seasonMaps = DungeonTools:GetCurrentSeasonMaps()
        local mapTexture = seasonMaps[mapID].backgroundTexture ]]
    --

    -- challenge complete text
    local completeColor = {}
    completeColor.r, completeColor.g, completeColor.b = Theme:GetThemeColor("color_COMMON")
    completionFrame.complete = completionFrame.complete or completionFrame:CreateFontString("KM_CompleteText", "OVERLAY", "KeyMasterFontNormal")
    local font, fontSize, flags = completionFrame.complete:GetFont()
    completionFrame.complete:SetFont(font, 30, flags)
    completionFrame.complete:SetPoint("TOP", completionFrame, "TOP", 0, -8)
    completionFrame.complete:SetText(KeyMasterLocals.CHALLENGECOMPLETE["ChallengeComplete"])
    completionFrame.complete:SetJustifyH("CENTER")
    completionFrame.complete:SetTextColor(completeColor.r, completeColor.g, completeColor.b, 1)

    -- new record text
    local recordColor = {}
    recordColor.r, recordColor.g, recordColor.b = Theme:GetThemeColor("themeFontColorGreen1")
    completionFrame.newRecord = completionFrame.newRecord or completionFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    completionFrame.newRecord:SetPoint("BOTTOM", completionFrame.complete, "TOP", 0, 0)
    completionFrame.newRecord:SetText(KeyMasterLocals.MAPNAMES[9001].name)
    completionFrame.newRecord:SetJustifyH("CENTER")
    completionFrame.newRecord:SetTextColor(recordColor.r, recordColor.g, recordColor.b, 1)

    -- shield
    --local mapImageRatio = 2.666666666666667 -- set pre-calculated aspect ratio because image data doesn't include size
    local mapImageDisplaySize = 372
    completionFrame.texture = completionFrame.texture or completionFrame:CreateTexture(nil, "BACKGROUND", nil, 1)
    completionFrame.texture:SetPoint("TOP", completionFrame, "TOP", 0, 0)
    completionFrame.texture:SetSize(411, 452)
    completionFrame.texture:SetTexture("Interface/AddOns/KeyMaster/Assets/Images/KeyCompletion")
    completionFrame.texture:SetTexCoord(0, 411/512, 0, 452/512)

    -- map mask
    completionFrame.maskTexture = completionFrame.maskTexture or completionFrame:CreateMaskTexture()
    completionFrame.maskTexture:SetPoint("TOPLEFT", completionFrame.texture, "TOPLEFT", -1, 0)
    completionFrame.maskTexture:SetSize(512, 512)
    completionFrame.maskTexture:SetTexture("Interface/AddOns/KeyMaster/Assets/Images/KeyCompletion-Mask")

    -- map texture
    completionFrame.texturemap = completionFrame.texturemap or completionFrame:CreateTexture(nil, "ARTWORK", nil, 2)
    completionFrame.texturemap:SetPoint("TOPRIGHT", completionFrame.maskTexture, "TOPRIGHT", 0, 0)
    completionFrame.texturemap:SetHeight(mapImageDisplaySize)
    --completionFrame.texturemap:SetTexture(mapTexture)
    completionFrame.texturemap:SetTexCoord(16/256, 180/256, 30/256, 140/256)
    completionFrame.texturemap:AddMaskTexture(completionFrame.maskTexture)
    completionFrame.texturemap:SetAlpha(1)

    -- clickbox
    local clickBox = _G["KM_CompleteClickBox"] or  CreateFrame("Frame", "KM_CompleteClickBox", completionFrame)
    clickBox:SetPoint("TOP", completionFrame, "TOP", 0, 0)
    clickBox:SetSize(330, 410)
    --[[ clickBox.texture = clickBox:CreateTexture()
    clickBox.texture:SetColorTexture(0,0,0,0.6)
    clickBox.texture:SetAllPoints(clickBox) ]]
    clickBox:EnableMouse(true)
    clickBox:SetScript("OnMouseUp", function() 
        if completionFrame:IsVisible() then
            completionFrame:Hide()
        end
    end)

    -- stars
    for i=1, 3, 1 do
        createStar(i,completionFrame)
    end

    local oneStarFrame = _G["KM_Star1"]
    local twoStarFrame = _G["KM_Star2"]
    local threeStarFrame = _G["KM_Star3"]

    local twoStar = {"TOP", completionFrame, "TOP", 0, -60}
    local oneStar = {"RIGHT", twoStarFrame, "LEFT", -4, -4}
    local threeStar = {"LEFT", twoStarFrame, "RIGHT", 4, -4}

    twoStarFrame:SetPoint(unpack(twoStar))
    oneStarFrame:SetPoint(unpack(oneStar))
    threeStarFrame:SetPoint(unpack(threeStar))

    -- to mapping --
   --[[  local highlightColor = {}
    local mutedColor = {}
    highlightColor.r, highlightColor.g, highlightColor.b = Theme:GetThemeColor("themeFontColorYellow")
    mutedColor.r, mutedColor.g, mutedColor.b = Theme:GetThemeColor("color_POOR")
    oneStarFrame.texture:SetVertexColor(highlightColor.r, highlightColor.g, highlightColor.b, 1)
    twoStarFrame.texture:SetVertexColor(highlightColor.r, highlightColor.g, highlightColor.b, 1)
    threeStarFrame.texture:SetVertexColor(mutedColor.r, mutedColor.g, mutedColor.b, 1) ]]
    ------

    -- affix
    completionFrame.affix = completionFrame.affix or completionFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    completionFrame.affix:SetFont(font, 24, flags)
    completionFrame.affix:SetPoint("TOP", completionFrame, "TOP", 0, -120)
    -- to mapping --
    --[[ local affixName = C_ChallengeMode.GetAffixInfo(9)
    ------]]
    local color = {}
    color.r, color.g, color.b, _ = Theme:GetThemeColor("themeFontColorGreen1") 
    completionFrame.affix:SetText(KeyMasterLocals.MAPNAMES[9001].name)
    completionFrame.affix:SetTextColor(color.r, color.g, color.b, 1)

    -- key level
    completionFrame.levelText = completionFrame.levelText or completionFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    completionFrame.levelText:SetPoint("TOP", completionFrame.affix, "BOTTOM", 0, -4)
    completionFrame.levelText:SetFont(font, 45, flags)
    completionFrame.levelText:SetText("--")

    -- map name
    completionFrame.mapName = completionFrame.mapName or completionFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    completionFrame.mapName:SetPoint("TOP", completionFrame.levelText, "BOTTOM", 0, -4)
    completionFrame.mapName:SetFont(font, 18, flags)
    completionFrame.mapName:SetText(KeyMasterLocals.MAPNAMES[9001].name)
    color.r, color.g, color.b, _ = Theme:GetThemeColor("themeFontColorYellow")
    completionFrame.mapName:SetTextColor(color.r, color.g, color.b, 1)

    -- map time
    completionFrame.mapTime = completionFrame.mapTime or completionFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    completionFrame.mapTime:SetPoint("TOP", completionFrame.mapName, "BOTTOM", 0, -4)
    --completionFrame.mapTime:SetFont(font, fontSize*1.75, flags)
    completionFrame.mapTime:SetText("-- / --")

    -- rating
    color.r, color.g, color.b, _ = Theme:GetThemeColor("color_HEIRLOOM")
    completionFrame.ratingGain = completionFrame.ratingGain or completionFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    completionFrame.ratingGain:SetPoint("TOP", completionFrame.mapTime, "BOTTOM", 0, -4)
    completionFrame.ratingGain:SetFont(font, 30, flags)
    completionFrame.ratingGain:SetTextColor(color.r, color.g, color.b, 1)
    completionFrame.ratingGain:SetText("-- (--)")

    -- to mapping --
    --local mapChallengeModeID, level, time, onTime, keystoneUpgradeLevels, practiceRun, oldOverallDungeonScore, newOverallDungeonScore, IsMapRecord, IsAffixRecord, PrimaryAffix, isEligibleForScore, members = KeyMaster.ChallengeCompletion.getDummyData()

    --local memberRows = createMemberRows(completionFrame, members)

    local soundHandle

    local function playsound()
        if KeyMaster_DB.addonConfig.completionScreen.enableSounds then
            _, soundHandle = PlaySound(47914, "SFX", true)
        end
    end

    --playsound()

    --completionFrame:SetScript("OnShow", playsound)
    completionFrame:SetScript("OnHide", function()
        if soundHandle then StopSound(soundHandle) end
    end)
    --completionFrame:HookScript("OnLoad", playsound)

    return completionFrame
end