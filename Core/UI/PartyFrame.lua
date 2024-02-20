local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface
local DungeonTools = KeyMaster.DungeonTools
local CharacterInfo = KeyMaster.CharacterInfo
local Theme = KeyMaster.Theme
local UnitData = KeyMaster.UnitData
local ViewModel = KeyMaster.ViewModel

local function portalButton_buttonevent(self, event)
   -- MainInterface:Toggle(); -- commented out because it needs a unit is spell casting check
end

local function portalButton_tooltipon(self, event)
end

local function portalButton_tooltipoff(self, event)
end

local function portalButton_mouseover(self, event)
    local spellNameToCheckCooldown = self:GetParent():GetAttribute("portalSpellName")
    local start, dur, _ = GetSpellCooldown(spellNameToCheckCooldown);
    if (start == 0) then
        local animFrame = self:GetParent():GetAttribute("portalFrame")
        animFrame.textureportal:SetTexture("Interface\\AddOns\\KeyMaster\\Assets\\Images\\portal-texture1", false)
        animFrame.animg:Play()
    else
        local cdFrame = self:GetParent():GetAttribute("portalCooldownFrame")
        cdFrame:SetCooldown(start ,dur)
    end

end

local function portalButton_mouseoout(self, event, ...)
    local animFrame = self:GetParent():GetAttribute("portalFrame")
    animFrame.textureportal:SetTexture()
    animFrame.animg:Stop()
    local cdFrame = self:GetParent():GetAttribute("portalCooldownFrame")
    cdFrame:SetCooldown(0 ,0)
end

local function createPartyDungeonHeader(anchorFrame, mapId)
    if not anchorFrame and mapId then 
        KeyMaster:Print("ERROR: ", "No valid refrences passed to createPartyDungeonHeader()")
    end
    if (not anchorFrame) then
        KeyMaster:Print("Error: ", "Invalid anchorFrame for createPartyDungeonHeader() mapId:"..mapId)
    end
    if (not mapId) then
        KeyMaster:Print("ERROR: ", "Invalid mapId for createPartyDungeonHeader() anchorFrame:"..anchorFrame:GetName())
    end
    -- END DEBUG

    local window = _G["Dungeon_"..mapId.."_Header"]
    if (window) then return window end -- if already Created, don't make another one

    local mapsTable = DungeonTools:GetCurrentSeasonMaps()
    local iconSizex = anchorFrame:GetWidth() - 10
    local iconSizey = anchorFrame:GetWidth() - 10
    local mapAbbr = DungeonTools:GetDungeonNameAbbr(mapId)

    -- Dungeon Header Icon Frame
    local temp_frame = CreateFrame("Frame", "Dungeon_"..mapId.."_Header", _G["KeyMaster_Frame_Party"])
    temp_frame:SetSize(iconSizex, iconSizey)
    temp_frame:SetPoint("BOTTOM", anchorFrame, "TOP", 0, 4)

    -- Dungeon abbr text
    local txtPlaceHolder = temp_frame:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    local Path, _, Flags = txtPlaceHolder:GetFont()
    txtPlaceHolder:SetFont(Path, 12, Flags)
    txtPlaceHolder:SetPoint("BOTTOM", 0, 2)
    txtPlaceHolder:SetTextColor(1, 1, 1)
    txtPlaceHolder:SetText(mapAbbr)

    -- Dungeon Abbr background
    temp_frame.texture = temp_frame:CreateTexture(nil, "BACKGROUND",nil, 3)
    temp_frame.texture:SetPoint("BOTTOM", temp_frame, 0, 0)
    temp_frame.texture:SetSize(temp_frame:GetWidth(), 16)
    temp_frame.texture:SetColorTexture(0, 0, 0, 0.7)

    -- Dungeon image thumbnail
    temp_frame.texturemap = temp_frame:CreateTexture(nil, "BACKGROUND",nil, 1)
    temp_frame.texturemap:SetAllPoints(temp_frame)
    temp_frame.texturemap:SetTexture(mapsTable[mapId].texture)
    temp_frame:SetAttribute("dungeonMapId", mapId)
    temp_frame:SetAttribute("texture", mapsTable[mapId].texture)

    -- Portal Animation
    local anim_frame = CreateFrame("Frame", "portalTexture"..mapAbbr, temp_frame)
    anim_frame:SetSize(35, 35)
    anim_frame:SetPoint("CENTER", temp_frame, "CENTER", 0, 8)
    anim_frame.textureportal = anim_frame:CreateTexture(nil, "BACKGROUND",nil, 2)
    anim_frame.textureportal:SetAllPoints(anim_frame)
    anim_frame.textureportal:SetAlpha(0.8)
    anim_frame.animg = anim_frame:CreateAnimationGroup()
    local a1 = anim_frame.animg:CreateAnimation("Rotation")
    a1:SetDegrees(-360)
    a1:SetDuration(2)
    anim_frame.animg:SetLooping("REPEAT")
    temp_frame:SetAttribute("portalFrame", anim_frame)

    -- Portal Cooldown
    local portalCooldownFrame = CreateFrame("Cooldown", "portalCooldown", temp_frame, "CooldownFrameTemplate")
    anim_frame:SetAllPoints(temp_frame)
    temp_frame:SetAttribute("portalCooldownFrame", portalCooldownFrame)


    -- Add clickable portal spell casting to dungeon texture frames if they have the spell
    local portalSpellId, portalSpellName = DungeonTools:GetPortalSpell(mapId)
    
    if (portalSpellId) then -- if the player has the portal, make the dungeon image clickable to cast it if clicked.
    local pButton
        pButton = CreateFrame("Button","portal_button"..mapId,temp_frame,"SecureActionButtonTemplate")
        pButton:SetAttribute("type", "spell")
        pButton:SetAttribute("spell", portalSpellName)
        pButton:RegisterForClicks("AnyDown")
        pButton:SetWidth(pButton:GetParent():GetWidth())
        pButton:SetHeight(pButton:GetParent():GetWidth())
        pButton:SetPoint("TOPLEFT", temp_frame, "TOPLEFT", 0, 0)
        pButton:SetScript("OnMouseDown", portalButton_buttonevent)
        pButton:SetScript("OnEnter", portalButton_mouseover)
        pButton:SetScript("OnLeave", portalButton_mouseoout)

        temp_frame:SetAttribute("portalSpellName", portalSpellName)
    end

    -- Group Key Level Frame
    local groupKey = CreateFrame("Frame", "Dungeon_"..mapId.."_HeaderKeyLevel", temp_frame)
    groupKey:SetSize(40, 15)
    groupKey:SetPoint("TOPLEFT", temp_frame, "TOPLEFT", 0, 0)
    local keyText = groupKey:CreateFontString("Dungeon_"..mapId.."_HeaderKeyLevelText", "OVERLAY", "KeyMasterFontNormal")
    Path, _, Flags = txtPlaceHolder:GetFont()
    keyText:SetFont(Path, 12, Flags)
    keyText:SetPoint("TOPLEFT", 3, 0)
    keyText:SetJustifyH("LEFT")
    keyText:SetTextColor(1, 1, 1)
    --keyText:SetText(26) -- demonstration

end

-- Set the font and color of the party frames map data.
function MainInterface:SetPartyWeeklyDataTheme()
    local mapTable = DungeonTools:GetCurrentSeasonMaps()
    if (not mapTable) then return end

    local tyranFont = CreateFont("tempFont1")
    local fortFont = CreateFont("tempFont2")
    tyranFont:SetFontObject(DungeonTools:GetWeekFont("Tyrannical"))
    fortFont:SetFontObject(DungeonTools:GetWeekFont("Fortified"))
    local tfPath, tfSize, tfFlags = tyranFont:GetFont()
    local ffPath, ffSize, ffFlags = fortFont:GetFont()

    local tyrannicalRGB = {}
    tyrannicalRGB.r, tyrannicalRGB.g, tyrannicalRGB.b = DungeonTools:GetWeekColor("Tyrannical")
    local fortifiedRGB = {}
    fortifiedRGB.r, fortifiedRGB.g, fortifiedRGB.b = DungeonTools:GetWeekColor("Fortified")

    for i=1, 5, 1 do
        local tyranTitleFontString = _G["KM_TyranTitle"..i]
        tyranTitleFontString:SetFont(tfPath, tfSize, tfFlags)
        tyranTitleFontString:SetTextColor(tyrannicalRGB.r, tyrannicalRGB.g, tyrannicalRGB.b, 1)
        local fortTitleFontString = _G["KM_FortTitle"..i]
        fortTitleFontString:SetFont(ffPath, ffSize, ffFlags)
        fortTitleFontString:SetTextColor(fortifiedRGB.r, fortifiedRGB.g, fortifiedRGB.b, 1)

        for mapid, _ in pairs(mapTable) do

            local tyranFontstring =  _G["KM_MapLevelT"..i..mapid]
            tyranFontstring:SetTextColor(tyrannicalRGB.r, tyrannicalRGB.g, tyrannicalRGB.b, 1)
            local fortFontString = _G["KM_MapLevelF"..i..mapid]
            fortFontString:SetTextColor(fortifiedRGB.r, fortifiedRGB.g, fortifiedRGB.b, 1)

            if (tyranFontstring) then
                tyranFontstring:SetFont(tfPath, tfSize, tfFlags)
                tyranFontstring:SetTextColor(tyrannicalRGB.r, tyrannicalRGB.g, tyrannicalRGB.b, 1)
            end
            if (fortFontString) then
                fortFontString:SetFont(ffPath, ffSize, ffFlags)
                fortFontString:SetTextColor(fortifiedRGB.r, fortifiedRGB.g, fortifiedRGB.b, 1)
            end

        end
    end

end

function MainInterface:CreatePartyDataFrame(parentFrame)
    local playerNumber
    if (parentFrame:GetName() == "KM_PlayerRow1") then playerNumber = 1
    elseif (parentFrame:GetName() == "KM_PlayerRow2") then playerNumber = 2
    elseif (parentFrame:GetName() == "KM_PlayerRow3") then playerNumber = 3
    elseif (parentFrame:GetName() == "KM_PlayerRow4") then playerNumber = 4
    elseif (parentFrame:GetName() == "KM_PlayerRow5") then playerNumber = 5
    else
        KeyMaster:Print("Error: Only support for 5 party rows is allowed...invalid parentFrame")
        return
    end

    if (not playerNumber) then
        KeyMaster:Print("Error: ", "Invalid party row reference for data frame: "..playerNumber) -- Debug
    end

    -- Data frame
    local dataFrame = CreateFrame("Frame", "KM_PlayerDataFrame"..playerNumber, parentFrame)
    dataFrame:ClearAllPoints()
    dataFrame:SetPoint("TOPRIGHT",  _G["KM_PlayerRow"..playerNumber], "TOPRIGHT", 0, 0)
    dataFrame:SetSize((parentFrame:GetWidth() - ((_G["KM_Portrait"..playerNumber]:GetWidth())/2)), parentFrame:GetHeight())

    -- Player's Name
    local tempText = dataFrame:CreateFontString("KM_PlayerName"..playerNumber, "OVERLAY", "KeyMasterFontBig")
    tempText:SetPoint("TOPLEFT", dataFrame, "TOPLEFT", 6, -3)

    -- Player class
    tempText = dataFrame:CreateFontString("KM_Player"..playerNumber.."Class", "OVERLAY", "KeyMasterFontSmall")
    tempText:SetPoint("TOPLEFT", _G["KM_PlayerName"..playerNumber], "BOTTOMLEFT", 0, 0)

    -- Player does not have the addon
    tempText = dataFrame:CreateFontString("KM_NoAddon"..playerNumber, "OVERLAY", "KeyMasterFontBig")
    local font, fontSize, flags = tempText:GetFont()
    tempText:SetFont(font, 20, flags)
    tempText:SetTextColor(0.6, 0.6, 0.6, 1)
    tempText:SetPoint("CENTER", dataFrame, "CENTER", 105, 0)
    tempText:SetText(KM_ADDON_NAME.." "..KeyMasterLocals.PARTYFRAME["NoAddon"].text)
    tempText:Hide()

    -- Player is offline
    tempText = dataFrame:CreateFontString("KM_Player"..playerNumber.."Offline", "OVERLAY", "KeyMasterFontBig")
    font, fontSize, flags = tempText:GetFont()
    tempText:SetFont(font, 20, flags)
    tempText:SetTextColor(0.6, 0.6, 0.6, 1)
    tempText:SetPoint("CENTER", dataFrame, "CENTER", 105, 0)
    tempText:SetText(KeyMasterLocals.PARTYFRAME["PlayerOffline"].text)
    tempText:Hide()

    -- Player's Owned Key
    tempText = dataFrame:CreateFontString("KM_OwnedKeyInfo"..playerNumber, "OVERLAY", "KeyMasterFontBig")
    tempText:SetPoint("BOTTOMLEFT", dataFrame, "BOTTOMLEFT", 8, 4)

    -- Player Rating
    tempText = dataFrame:CreateFontString("KM_Player"..playerNumber.."OverallRating", "OVERLAY", "KeyMasterFontBig")
    tempText:SetPoint("TOPLEFT", "KM_Player"..playerNumber.."Class", "BOTTOMLEFT", 0, -1)
    font, fontSize, flags = tempText:GetFont()
    tempText:SetFont(font, 20, flags)
    local r, g, b, _ = Theme:GetThemeColor("color_HEIRLOOM")
    tempText:SetTextColor(r, g, b, 1)
    
    -- Create frames for map scores
    local prevMapId, prevAnchor
    local firstItem = true
    local mapTable = DungeonTools:GetCurrentSeasonMaps()
    local bolColHighlight = false
    local partyColColor = {}
    partyColColor.r,  partyColColor.g, partyColColor.b, _ = Theme:GetThemeColor("party_colHighlight")

    for mapid, mapData in pairs(mapTable) do
        bolColHighlight = not bolColHighlight -- alternate row highlighting
        
        local temp_Frame = CreateFrame("Frame", "KM_MapData"..playerNumber..mapid, parentFrame)
        temp_Frame:ClearAllPoints()

        -- Dynamicly set map data frame anchors
        if (firstItem) then
            temp_Frame:SetPoint("TOPRIGHT", dataFrame, "TOPRIGHT", 0, 0)
        else
            temp_Frame:SetPoint("TOPRIGHT", _G["KM_MapData"..playerNumber..prevMapId], "TOPLEFT", 0, 0)
        end

        temp_Frame:SetSize((parentFrame:GetWidth() / 12), parentFrame:GetHeight())

        if (not bolColHighlight) then
            temp_Frame.texture = temp_Frame:CreateTexture()
            temp_Frame.texture:SetAllPoints(temp_Frame)
            temp_Frame.texture:SetColorTexture(partyColColor.r, partyColColor.g, partyColColor.b, 0.2)
        end

        -- Tyrannical Scores
        local tempText1 = temp_Frame:CreateFontString("KM_MapLevelT"..playerNumber..mapid, "OVERLAY", "KeyMasterFontNormal")
        tempText1:SetPoint("CENTER", temp_Frame, "TOP", 0, -10)
        prevAnchor = tempText1

        --[[ local tempText2 = temp_Frame:CreateFontString("KM_MapScoreT"..playerNumber..mapid, "OVERLAY", "KeyMasterFontBig")
        tempText2:SetPoint("CENTER", tempText1, "BOTTOM", 0, -8)
        tempText2::SetTextColor(DungeonTools:GetWeekColor("Tyrannical")))
        prevAnchor = tempText2 ]]


        -- Fortified Scores
        local tempText4 = temp_Frame:CreateFontString("KM_MapLevelF"..playerNumber..mapid, "OVERLAY", "KeyMasterFontNormal")
        tempText4:SetPoint("CENTER", prevAnchor, "BOTTOM", 0, -8)
        prevAnchor = tempText4

        --[[ local tempText5 = temp_Frame:CreateFontString("KM_MapScoreF"..playerNumber..mapid, "OVERLAY", "KeyMasterFontBig")
        tempText5:SetPoint("CENTER", tempText4, "BOTTOM", 0, -8)
        tempText5:SetAlpha(KeyMaster:GetWeekAlpha("Fortified")) 
        prevAnchor = tempText5]]

        -- Map Total Score
        local tempText6 = temp_Frame:CreateFontString("KM_MapTotalScore"..playerNumber..mapid, "OVERLAY", "KeyMasterFontBig")
        tempText6:SetPoint("CENTER", temp_Frame, "BOTTOM", 0, 10)
        local r, g, b, _ = Theme:GetThemeColor("color_HEIRLOOM")
        tempText6:SetTextColor(r, g, b, 1)

        --KeyMaster:CreateHLine(temp_Frame:GetWidth(), temp_Frame, "BOTTOM", 0, 18)

        -- create dungeon identity header if this is the clinets row (the first row)
        if (playerNumber == 1) then
            local anchorFrame = temp_Frame
            local id = mapid
            createPartyDungeonHeader(anchorFrame, id)
        end

        firstItem = false
        prevMapId = mapid

    end

    -- LEGEND FRAME

    -- Get dynamic legend offset
    local legendRightMargin = 4
    local xOffset = (-(_G["KM_MapLevelT"..playerNumber..prevMapId]:GetParent():GetWidth())/2)-legendRightMargin

    local temp_Frame = CreateFrame("Frame", "KM_MapDataLegend"..playerNumber, parentFrame)
    temp_Frame:ClearAllPoints()
    temp_Frame:SetSize((parentFrame:GetWidth() / 12), parentFrame:GetHeight())
    temp_Frame:SetPoint("TOPRIGHT", "KM_MapData"..playerNumber..prevMapId, "TOPLEFT", -4, 0)

    --point, relativeTo, relativePoint, xOfs, yOfs = MyRegion:GetPoint(n)
    --local yOfs = select(5, _G["KM_MapLevelT"..playerNumber..prevMapId]:GetPoint())
    local tempText1 = temp_Frame:CreateFontString("KM_TyranTitle"..playerNumber, "OVERLAY", "KeyMasterFontNormal")
    tempText1:SetPoint("RIGHT", _G["KM_MapLevelT"..playerNumber..prevMapId], "CENTER", xOffset, 0)
    tempText1:SetText(KeyMasterLocals.TYRANNICAL..":")
    

    --yOfs = select(5, _G["KM_MapScoreT"..playerNumber..prevMapId]:GetPoint())
    --[[ local tempText2 = temp_Frame:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    tempText2:SetPoint("RIGHT", _G["KM_MapScoreT"..playerNumber..prevMapId], "CENTER", xOffset, 0)
    tempText2:SetText("Tyrannical:")
    tempText2:SetAlpha(KeyMaster:GetWeekAlpha("Tyrannical")) ]]

    --yOfs = select(5, _G["KM_MapLevelF"..playerNumber..prevMapId]:GetPoint())
    local tempText3 = temp_Frame:CreateFontString("KM_FortTitle"..playerNumber, "OVERLAY", "KeyMasterFontNormal")
    tempText3:SetPoint("RIGHT", _G["KM_MapLevelF"..playerNumber..prevMapId], "CENTER", xOffset, 0)
    tempText3:SetText(KeyMasterLocals.FORTIFIED..":")

    --yOfs = select(5, _G["KM_MapScoreF"..playerNumber..prevMapId]:GetPoint())
    --[[ local tempText4 = temp_Frame:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    tempText4:SetPoint("RIGHT", _G["KM_MapScoreF"..playerNumber..prevMapId], "CENTER", xOffset, 0)
    tempText4:SetText("Fortified:")
    tempText4:SetAlpha(KeyMaster:GetWeekAlpha("Fortified")) ]]

    --yOfs = select(5, _G["KM_MapTotalScore"..playerNumber..prevMapId]:GetPoint())
    local tempText5 = temp_Frame:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    tempText5:SetPoint("RIGHT",  _G["KM_MapTotalScore"..playerNumber..prevMapId], "CENTER", xOffset, 0)
    tempText5:SetText(KeyMasterLocals.PARTYFRAME["OverallScore"].name..":")
    
    _G["KM_MapDataLegend"..playerNumber]:Show()


end

function MainInterface:CreatePartyMemberFrame(unitId, parentFrame)
    local partyNumber
    if (unitId == "player") then partyNumber = 1
    elseif (unitId == "party1") then partyNumber = 2
    elseif (unitId == "party2") then partyNumber = 3
    elseif (unitId == "party3") then partyNumber = 4
    elseif (unitId == "party4") then partyNumber = 5
    else
        KeyMaster:Print("Invalid paramater value for unitId, expected 'player' or 'party1-4'")
        return
    end

    local frameHeight = 0
    local mtb = 2 -- top and bottom margin of each frame in pixels

    local temp_RowFrame = CreateFrame("Frame", "KM_PlayerRow"..partyNumber, parentFrame)
    temp_RowFrame:ClearAllPoints()

    if (unitId == "player") then -- first spot
        temp_RowFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 0, -2)
        frameHeight = (parentFrame:GetHeight()/5) - (mtb*2)
    else
        temp_RowFrame:SetPoint("TOPLEFT", _G["KM_PlayerRow"..partyNumber - 1], "BOTTOMLEFT", 0, -4)
        frameHeight = parentFrame:GetHeight()
    end

    temp_RowFrame:SetSize(parentFrame:GetWidth(), frameHeight)
    temp_RowFrame.texture = temp_RowFrame:CreateTexture()
    temp_RowFrame.texture:SetAllPoints(temp_RowFrame)
    temp_RowFrame.texture:SetColorTexture(0.531, 0.531, 0.531, 0.3) -- todo: temporary bg color 

    local temp_frame = CreateFrame("Frame", "KM_PortraitFrame"..partyNumber, _G["KM_PlayerRow"..partyNumber])
    temp_frame:SetSize(parentFrame:GetWidth()+(temp_RowFrame:GetHeight()/2), temp_RowFrame:GetHeight())
    temp_frame:ClearAllPoints()
    temp_frame:SetPoint("RIGHT", temp_frame:GetParent(), "RIGHT", 0, 0)

    local img1 = temp_frame:CreateTexture("KM_Portrait"..partyNumber, "BACKGROUND")
    img1:SetHeight(temp_RowFrame:GetHeight())
    img1:SetWidth(temp_RowFrame:GetHeight())
    img1:ClearAllPoints()
    img1:SetPoint("LEFT", 0, 0)

    -- the ring around the portrait
    local img2 = temp_frame:CreateTexture("KM_PortraitFrame"..partyNumber, "OVERLAY")
    img2:SetHeight(temp_RowFrame:GetHeight()+12)
    img2:SetWidth(temp_RowFrame:GetHeight()+12)
    img2:SetTexture("Interface\\AddOns\\KeyMaster\\Assets\\Images\\portrait_frame2",false)
    local r, g, b, _ = Theme:GetThemeColor("color_PORTRAITFRAME")
    img2:SetVertexColor(r, g, b, 1)
    img2:ClearAllPoints()
    img2:SetPoint("LEFT", -6, 0)

    KeyMaster:CreateHLine(temp_RowFrame:GetWidth()+8, temp_RowFrame, "TOP", 0, 0)

    return temp_RowFrame
end

-- Party Frame Score Tally Footer
function MainInterface:CreatePartyScoreTallyFooter()
    local parentFrame = KeyMaster:FindLastVisiblePlayerRow()
    if (not parentFrame) then
        KeyMaster:Print("Error: Tally footer could not find a valid parent.")
        KeyMaster:Print("--Action: [Skipped Creation]")
        return
    end

    local partyTallyFrame = CreateFrame("Frame", "PartyTallyFooter", parentFrame)
    partyTallyFrame:SetWidth(parentFrame:GetWidth())
    partyTallyFrame:SetHeight(25)
    partyTallyFrame:SetPoint("TOPRIGHT", parentFrame, "BOTTOMRIGHT", 0, -4)
    --[[ partyTallyFrame.texture = partyTallyFrame:CreateTexture()
    partyTallyFrame.texture:SetAllPoints(partyTallyFrame)
    partyTallyFrame.texture:SetColorTexture(0.431, 0.431, 0.431, 0.3) -- temporary bg color ]]

    local mapTable = DungeonTools:GetCurrentSeasonMaps()
    local prevMapId, prevAnchor, lastPointsFrame
    local firstItem = true
    local mapTable = DungeonTools:GetCurrentSeasonMaps()
    local bolColHighlight = false
    local partyColColor = {}
    partyColColor.r,  partyColColor.g, partyColColor.b, _ = Theme:GetThemeColor("party_colHighlight")

    for mapid, mapData in pairs(mapTable) do
        bolColHighlight = not bolColHighlight -- alternate row highlighting
        
        local temp_Frame = CreateFrame("Frame", "KM_MapTally"..mapid, parentFrame)
        temp_Frame:ClearAllPoints()

        -- Dynamicly set map data frame anchors
        if (firstItem) then
            temp_Frame:SetPoint("TOPRIGHT", partyTallyFrame, "TOPRIGHT", 0, 0)
        else
            temp_Frame:SetPoint("TOPRIGHT", _G["KM_MapTally"..prevMapId], "TOPLEFT", 0, 0)
        end

        temp_Frame:SetSize((partyTallyFrame:GetWidth() / 12), partyTallyFrame:GetHeight())

        if (not bolColHighlight) then
            temp_Frame.texture = temp_Frame:CreateTexture()
            temp_Frame.texture:SetAllPoints(temp_Frame)
            temp_Frame.texture:SetColorTexture(partyColColor.r, partyColColor.g, partyColColor.b, 0.2)
        else
            temp_Frame.texture = temp_Frame:CreateTexture()
            temp_Frame.texture:SetAllPoints(temp_Frame)
            temp_Frame.texture:SetColorTexture(0.431, 0.431, 0.431, 0.3)
        end

        -- Map Total Tally
        local tempText6 = temp_Frame:CreateFontString("KM_MapTallyScore"..mapid, "OVERLAY", "KeyMasterFontBig")
        --tempText6:SetPoint("CENTER", temp_Frame, "BOTTOM")
        tempText6:SetAllPoints(temp_Frame)
        local r, g, b, _ = Theme:GetThemeColor("color_TAUPE")
        tempText6:SetTextColor(r, g, b, 1)
        tempText6:SetJustifyV("CENTER")
        --tempText6:SetText(2344)

        firstItem = false
        prevMapId = mapid
        lastPointsFrame = temp_Frame
    end
    KeyMaster:CreateHLine(partyTallyFrame:GetWidth(), partyTallyFrame, "TOP", 4, 0)

    local tallyDescTextBox = CreateFrame("Frame", "KM_TallyDesc", lastPointsFrame)
    tallyDescTextBox:SetPoint("RIGHT", lastPointsFrame, "LEFT", -4, 0)
    tallyDescTextBox:SetSize(180, partyTallyFrame:GetHeight())
    tallyDescTextBox.text = tallyDescTextBox:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    tallyDescTextBox.text:SetAllPoints(tallyDescTextBox)
    tallyDescTextBox.text:SetJustifyH("RIGHT")
    tallyDescTextBox.text:SetJustifyV("CENTER")
    tallyDescTextBox.text:SetText(KeyMasterLocals.ASTERISK..KeyMasterLocals.PARTYFRAME.TeamRatingGain.name..":")
end

function MainInterface:CreatePartyRowsFrame(parentFrame)    
    -- if it already exists, don't make another one
    if _G["KeyMaster_Frame_Party"] then
        return 
    end

    local gfm = 10 -- group frame margin

    local temp_frame =  CreateFrame("Frame", "KeyMaster_Frame_Party", parentFrame)
    temp_frame:SetSize(parentFrame:GetWidth()-(gfm*2), 400)
    temp_frame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", gfm, -55)
    --temp_frame:SetScript("OnUpdate", keyMaster_Frame_Party_OnUpdate)
    timeSinceLastUpdate = 0
    
    local txtPlaceHolder = temp_frame:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    local Path, _, Flags = txtPlaceHolder:GetFont()
    txtPlaceHolder:SetFont(Path, 20, Flags)
    txtPlaceHolder:SetPoint("TOPLEFT", 0, 30)
    txtPlaceHolder:SetTextColor(1, 1, 1)
    txtPlaceHolder:SetText(KeyMasterLocals.PARTYFRAME["PartyInformation"].name..":")

    temp_frame.texture = temp_frame:CreateTexture()
    temp_frame.texture:SetAllPoints(temp_frame)
    temp_frame.texture:SetColorTexture(0.531, 0.531, 0.531, 0.3) -- temporary bg color 

    return temp_frame
end

function MainInterface:CreatePartyFrame(parentFrame)
    local partyScreen = CreateFrame("Frame", "KeyMaster_PartyScreen", parentFrame);
    partyScreen:SetSize(parentFrame:GetWidth(), parentFrame:GetHeight())
    partyScreen:SetAllPoints(true)
    partyScreen:Hide()
    --[[ PartyScreen:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", 
        edgeFile="", 
        tile = false, 
        tileSize = 0, 
        edgeSize = 0, 
        insets = {left = 0, right = 0, top = 0, bottom = 0}})
    PartyScreen:SetBackdropColor(160,160,160,1); -- color for testing ]]
    --[[ txtPlaceHolder = PartyScreen:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    local Path, _, Flags = txtPlaceHolder:GetFont()
    txtPlaceHolder:SetFont(Path, 30, Flags)
    txtPlaceHolder:SetPoint("BOTTOMLEFT", 50, 50)
    txtPlaceHolder:SetTextColor(1, 1, 1)
    txtPlaceHolder:SetText("Party Screen") ]]

    --[[ PartyScreen.texture = PartyScreen:CreateTexture()
    PartyScreen.texture:SetAllPoints(PartyScreen)
    PartyScreen.texture:SetColorTexture(0.531, 0.531, 0.531, 1) -- temporary bg color ]]

    --[[ local txtPlaceHolder = partyScreen:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    local Path, _, Flags = txtPlaceHolder:GetFont()
    txtPlaceHolder:SetFont(Path, 30, Flags)
    txtPlaceHolder:SetPoint("BOTTOMLEFT", 50, 50)
    txtPlaceHolder:SetTextColor(1, 1, 1)
    txtPlaceHolder:SetText("Party Screen") ]]

    return partyScreen
end

function MainInterface:PartyColHighlight(parentFrame, visible)
    if (visible ~= nil and _G[parentFrame]) then
        local phc = {}
        local parentFrame = _G[parentFrame]
        local pFrameName = parentFrame:GetName()
        local rightFrameName = pFrameName .. "_rColHighlight"
        local leftFrameName = pFrameName .. "_rColHighlight"
        if (not _G[rightFrameName]) then
            local frameHeight = parentFrame:GetHeight()
            local parentLevel = parentFrame:GetFrameLevel()
            phc.r, phc.g, phc.b, _ = Theme:GetThemeColor("color_COMMON") -- color_NONPHOTOBLUE

            local rightHighlight = CreateFrame("Frame", rightFrameName, parentFrame)
            rightHighlight:SetHeight(frameHeight)
            rightHighlight:SetWidth(2)
            rightHighlight:SetFrameLevel(parentLevel + 1)
            rightHighlight:SetPoint("CENTER", parentFrame, "RIGHT", 1, 0)
            rightHighlight.texture = rightHighlight:CreateTexture()
            rightHighlight.shadowTexture = rightHighlight:CreateTexture()
            rightHighlight.texture:SetPoint("LEFT", 0, 0)
            rightHighlight.texture:SetSize(1, frameHeight)
            rightHighlight.shadowTexture:SetPoint("RIGHT", 1, 0)
            rightHighlight.shadowTexture:SetSize(1, frameHeight)
            rightHighlight.texture:SetColorTexture(phc.r, phc.g, phc.b, 1)
            rightHighlight.shadowTexture:SetColorTexture(0, 0, 0, 0.6)

            
            local leftHighlight = CreateFrame("Frame", leftFrameName, parentFrame)
            leftHighlight:SetHeight(frameHeight)
            leftHighlight:SetWidth(2)
            leftHighlight:SetFrameLevel(parentLevel + 1)
            leftHighlight:SetPoint("CENTER", parentFrame, "LEFT", 1, 0)
            leftHighlight.texture = leftHighlight:CreateTexture()
            leftHighlight.shadowTexture = leftHighlight:CreateTexture()
            leftHighlight.texture:SetPoint("LEFT", 0, 0)
            leftHighlight.texture:SetSize(1, frameHeight)
            leftHighlight.shadowTexture:SetPoint("RIGHT", 1, 0)
            leftHighlight.shadowTexture:SetSize(1, frameHeight)
            leftHighlight.texture:SetColorTexture(phc.r, phc.g, phc.b, 1)
            leftHighlight.shadowTexture:SetColorTexture(0, 0, 0, 0.6)

        end
        if (visible == true) then
            _G[rightFrameName]:Show()
            _G[leftFrameName]:Show()
        else
            _G[rightFrameName]:Hide()
            _G[leftFrameName]:Hide()
        end
    else
        --print(_G[parentFrame]:GetName())
        KeyMaster:Print("Error: PartyColHighlight - invalid parameters: " .. parentFrame .. ", " .. tostring(visible))
    end
end