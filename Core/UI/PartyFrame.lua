local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface
local DungeonTools = KeyMaster.DungeonTools
local CharacterInfo = KeyMaster.CharacterInfo
local Theme = KeyMaster.Theme
local UnitData = KeyMaster.UnitData
local PartyFrameMapping = KeyMaster.PartyFrameMapping
KeyMaster.PartyFrame = {}
local PartyFrame = KeyMaster.PartyFrame

local function portalButton_buttonevent(self, event)
    local spellNameToCheckCooldown = self:GetParent():GetAttribute("portalSpellName")
    local start, dur, _ = GetSpellCooldown(spellNameToCheckCooldown);
    if (dur < 2) then
        MainInterface:Toggle()
    end
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
        KeyMaster:_ErrorMsg("createPartyDungeonHeader", "PartyFrame", "No valid parameters passed.")
    end
    if (not anchorFrame) then
        KeyMaster:_ErrorMsg("createPartyDungeonHeader", "PartyFrame", "Invalid anchorFrame for mapId: "..mapId)
    end
    if (not mapId) then
        KeyMaster:_ErrorMsg("createPartyDungeonHeader", "PartyFrame", "Invalid mapId for anchorFrame: "..anchorFrame:GetName())
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
    temp_frame:SetPoint("BOTTOM", anchorFrame, "TOP", 0, 10) -- 10, 24

    local backgroundHighlight = CreateFrame("Frame", "KM_MapHeaderHighlight"..mapId, temp_frame)
    backgroundHighlight:SetFrameLevel(temp_frame:GetFrameLevel()-1)
    backgroundHighlight:SetPoint("TOP", temp_frame, "BOTTOM", 0, -4)
    backgroundHighlight:SetSize(temp_frame:GetWidth(), 2)
    backgroundHighlight.texture = backgroundHighlight:CreateTexture()
    backgroundHighlight.texture:SetAllPoints(backgroundHighlight)
    local highlightColor = {}
    highlightColor.r, highlightColor.g,highlightColor.b, _ = Theme:GetThemeColor("color_COMMON")
    backgroundHighlight.texture:SetColorTexture(highlightColor.r,highlightColor.g,highlightColor.b, 1)
    backgroundHighlight:Hide()

    -- Dungeon abbr text
    local txtPlaceHolder = temp_frame:CreateFontString("KM_Dungeon_"..mapId.."_Abbr", "OVERLAY", "KeyMasterFontSmall")
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
    temp_frame.shadowTexture = temp_frame:CreateTexture("KM_GroupKeyShadow"..mapId, "OVERLAY")
    temp_frame.shadowTexture:SetSize(64, 64)
    temp_frame.shadowTexture:SetPoint("TOPLEFT")
    temp_frame.shadowTexture:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Key-Number-Background")
    temp_frame:SetAttribute("dungeonMapId", mapId)
    temp_frame:SetAttribute("texture", mapsTable[mapId].texture)

    -- Portal Animation
    local anim_frame = CreateFrame("Frame", "portalTexture"..mapAbbr, temp_frame)
    anim_frame:SetFrameLevel(temp_frame:GetFrameLevel()+1)
    anim_frame:SetSize(35, 35)
    anim_frame:SetPoint("CENTER", temp_frame, "CENTER", 0, 8)
    anim_frame.textureportal = anim_frame:CreateTexture(nil, "ARTWORK")
    anim_frame.textureportal:SetAllPoints(anim_frame)
    --anim_frame.textureportal:SetAlpha(0.8)
    anim_frame.animg = anim_frame:CreateAnimationGroup()
    local a1 = anim_frame.animg:CreateAnimation("Rotation")
    a1:SetDegrees(-360)
    a1:SetDuration(2)
    anim_frame.animg:SetLooping("REPEAT")
    temp_frame:SetAttribute("portalFrame", anim_frame)

    temp_frame.maskTexture = temp_frame:CreateMaskTexture()
    temp_frame.maskTexture:SetSize(64,64)
    temp_frame.maskTexture:SetPoint("CENTER")
    temp_frame.maskTexture:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Dungeon-Portal-Mask")
    anim_frame.textureportal:AddMaskTexture(temp_frame.maskTexture)

    -- Portal Cooldown
    local portalCooldownFrame = CreateFrame("Cooldown", "portalCooldown", temp_frame, "CooldownFrameTemplate")
    anim_frame:SetAllPoints(temp_frame)
    temp_frame:SetAttribute("portalCooldownFrame", portalCooldownFrame)

    -- Add clickable portal spell casting to dungeon texture frames if they have the spell
    local portalSpellId, portalSpellName = DungeonTools:GetPortalSpell(mapId)
    
    if (portalSpellId) then -- if the player has the portal, make the dungeon image clickable to cast it if clicked.
        local pButton = CreateFrame("Button","portal_button"..mapId,temp_frame,"SecureActionButtonTemplate")
        pButton:SetAttribute("type", "spell")
        pButton:SetAttribute("spell", portalSpellName)
        pButton:RegisterForClicks("LeftButtonDown")
        pButton:SetWidth(pButton:GetParent():GetWidth())
        pButton:SetHeight(pButton:GetParent():GetWidth())
        pButton:SetPoint("TOPLEFT", temp_frame, "TOPLEFT", 0, 0)
        pButton:SetScript("OnMouseUp", portalButton_buttonevent)
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
    keyText:SetPoint("TOPLEFT", 3, -3)
    keyText:SetJustifyH("LEFT")
    local groupKeyColor = {}
    groupKeyColor.r, groupKeyColor.g, groupKeyColor.b, _ = Theme:GetThemeColor("color_COMMON")
    keyText:SetTextColor(groupKeyColor.r, groupKeyColor.g, groupKeyColor.b, 1)
end

-- Set the font and color of the party frames map data.
function PartyFrame:SetPartyWeeklyDataTheme()
    local mapTable = DungeonTools:GetCurrentSeasonMaps()
    if (not mapTable) then return end

    local tyranFont = CreateFont("tempFont1")
    local fortFont = CreateFont("tempFont2")
    tyranFont:SetFontObject(DungeonTools:GetWeekFont(KeyMasterLocals.TYRANNICAL))
    fortFont:SetFontObject(DungeonTools:GetWeekFont(KeyMasterLocals.FORTIFIED))
    local tfPath, tfSize, tfFlags = tyranFont:GetFont()
    local ffPath, ffSize, ffFlags = fortFont:GetFont()

    local tyrannicalRGB = {}
    tyrannicalRGB.r, tyrannicalRGB.g, tyrannicalRGB.b = DungeonTools:GetWeekColor(KeyMasterLocals.TYRANNICAL)
    local fortifiedRGB = {}
    fortifiedRGB.r, fortifiedRGB.g, fortifiedRGB.b = DungeonTools:GetWeekColor(KeyMasterLocals.FORTIFIED)

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

function PartyFrame:CreatePartyDataFrame(parentFrame)
    local playerNumber
    if (parentFrame:GetName() == "KM_PlayerRow1") then playerNumber = 1
    elseif (parentFrame:GetName() == "KM_PlayerRow2") then playerNumber = 2
    elseif (parentFrame:GetName() == "KM_PlayerRow3") then playerNumber = 3
    elseif (parentFrame:GetName() == "KM_PlayerRow4") then playerNumber = 4
    elseif (parentFrame:GetName() == "KM_PlayerRow5") then playerNumber = 5
    else
        KeyMaster:_ErrorMsg("CreatePartyDataFrame", "PartyFrame", "Supports only 5 party members...invalid parentFrame")
        return
    end

    if (not playerNumber) then
        KeyMaster:_ErrorMsg("CreatePartyDataFrame", "PartyFrame","Invalid party row reference for data frame: "..playerNumber)
    end

    -- Data frame
    local dataFrame = CreateFrame("Frame", "KM_PlayerDataFrame"..playerNumber, parentFrame)
    dataFrame:ClearAllPoints()
    dataFrame:SetPoint("TOPRIGHT",  _G["KM_PlayerRow"..playerNumber], "TOPRIGHT", 0, 0)
    dataFrame:SetSize((parentFrame:GetWidth() - ((_G["KM_Portrait"..playerNumber]:GetWidth())/2)), parentFrame:GetHeight())

    -- Player's Name
    local PlayerNameText = dataFrame:CreateFontString("KM_PlayerName"..playerNumber, "OVERLAY", "KeyMasterFontBig")
    PlayerNameText:SetPoint("TOPLEFT", dataFrame, "TOPLEFT", 18, -3)

    -- Player class
    local PlayerClassText = dataFrame:CreateFontString("KM_Player"..playerNumber.."Class", "OVERLAY", "KeyMasterFontSmall")
    PlayerClassText:SetPoint("TOPLEFT", _G["KM_PlayerName"..playerNumber], "BOTTOMLEFT", 0, 0)

    -- Player does not have the addon
    local noAddonIcon = dataFrame:CreateTexture("KM_NoAddon"..playerNumber, "OVERLAY")
    noAddonIcon:SetSize(32, 32)
    noAddonIcon:SetPoint("LEFT", dataFrame, "LEFT", 160, 0)
    noAddonIcon:SetTexture("Interface/Addons/KeyMaster/Assets/Images/No-KM-Icon")
    noAddonIcon:SetAlpha(0.2)
    noAddonIcon:Hide()

    -- Player is offline
    local OfflineText = dataFrame:CreateFontString("KM_Player"..playerNumber.."Offline", "OVERLAY", "KeyMasterFontBig")
    local font, fontSize, flags = OfflineText:GetFont()
    OfflineText:SetTextColor(0.6, 0.6, 0.6, 1)
    OfflineText:SetPoint("BOTTOMLEFT", dataFrame, "BOTTOMLEFT", 10, 4)
    OfflineText:SetText(KeyMasterLocals.PARTYFRAME["PlayerOffline"].text)
    OfflineText:Hide()

    -- Player's Owned Key
    local OwnedKeyText = dataFrame:CreateFontString("KM_OwnedKeyInfo"..playerNumber, "OVERLAY", "KeyMasterFontBig")
    OwnedKeyText:SetPoint("BOTTOMLEFT", dataFrame, "BOTTOMLEFT", 18, 4)

    -- Player Rating
    local OverallRatingText = dataFrame:CreateFontString("KM_Player"..playerNumber.."OverallRating", "OVERLAY", "KeyMasterFontBig")
    OverallRatingText:SetPoint("TOPLEFT", "KM_Player"..playerNumber.."Class", "BOTTOMLEFT", 0, -1)
    font, fontSize, flags = OverallRatingText:GetFont()
    OverallRatingText:SetFont(font, 20, flags)
    local RatingColor = {}
    RatingColor.r, RatingColor.g, RatingColor.b, _ = Theme:GetThemeColor("color_HEIRLOOM")
    OverallRatingText:SetTextColor(RatingColor.r, RatingColor.g, RatingColor.b, 1)
    
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

        temp_Frame:SetSize((parentFrame:GetWidth() / 12.5), parentFrame:GetHeight())

        if (not bolColHighlight) then
            temp_Frame.texture = temp_Frame:CreateTexture()
            temp_Frame.texture:SetAllPoints(temp_Frame)
            temp_Frame.texture:SetColorTexture(partyColColor.r, partyColColor.g, partyColColor.b, 0.2)
        end

        -- Tyrannical Scores
        local tempText1 = temp_Frame:CreateFontString("KM_MapLevelT"..playerNumber..mapid, "OVERLAY", "KeyMasterFontNormal")
        tempText1:SetPoint("CENTER", temp_Frame, "TOP", 0, -10)
        prevAnchor = tempText1

        -- Fortified Scores
        local tempText4 = temp_Frame:CreateFontString("KM_MapLevelF"..playerNumber..mapid, "OVERLAY", "KeyMasterFontNormal")
        tempText4:SetPoint("CENTER", prevAnchor, "BOTTOM", 0, -8)
        prevAnchor = tempText4

        -- Member Point Gain From Key
        local tempText5 = temp_Frame:CreateFontString("KM_PointGain"..playerNumber..mapid, "OVERLAY", "KeyMasterFontSmall")
        tempText5:SetPoint("CENTER", prevAnchor, "BOTTOM", 0, -10)
        local PointGainColor = {}
        PointGainColor.r, PointGainColor.g, PointGainColor.b, _ = Theme:GetThemeColor("color_TAUPE")
        tempText5:SetTextColor(PointGainColor.r, PointGainColor.g, PointGainColor.b, 1)
        prevAnchor = tempText5

        -- Map Total Score
        local tempText6 = temp_Frame:CreateFontString("KM_MapTotalScore"..playerNumber..mapid, "OVERLAY", "KeyMasterFontBig")
        tempText6:SetPoint("CENTER", temp_Frame, "BOTTOM", 0, 10)
        local MapScoreTotalColor = {}
        MapScoreTotalColor.r, MapScoreTotalColor.g, MapScoreTotalColor.b, _ = Theme:GetThemeColor("color_HEIRLOOM")
        tempText6:SetTextColor(MapScoreTotalColor.r, MapScoreTotalColor.g, MapScoreTotalColor.b, 1)

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

    local PartyTitleText = temp_Frame:CreateFontString("KM_TyranTitle"..playerNumber, "OVERLAY", "KeyMasterFontNormal")
    PartyTitleText:SetPoint("RIGHT", _G["KM_MapLevelT"..playerNumber..prevMapId], "CENTER", xOffset, 0)
    PartyTitleText:SetText(KeyMasterLocals.TYRANNICAL..":")
    
    local FortTitleText = temp_Frame:CreateFontString("KM_FortTitle"..playerNumber, "OVERLAY", "KeyMasterFontNormal")
    FortTitleText:SetPoint("RIGHT", _G["KM_MapLevelF"..playerNumber..prevMapId], "CENTER", xOffset, 0)
    FortTitleText:SetText(KeyMasterLocals.FORTIFIED..":")

    local PointGainTitleText = temp_Frame:CreateFontString("KM_PiontGainTitle"..playerNumber, "OVERLAY", "KeyMasterFontSmall")
    PointGainTitleText:SetPoint("RIGHT", _G["KM_PointGain"..playerNumber..prevMapId], "CENTER", xOffset, 0)
    local PointGainTitleColor = {}
    PointGainTitleColor.r, PointGainTitleColor.g, PointGainTitleColor.b = Theme:GetThemeColor("color_TAUPE")
    PointGainTitleText:SetTextColor(PointGainTitleColor.r, PointGainTitleColor.g, PointGainTitleColor.b, 1)
    PointGainTitleText:SetText(KeyMasterLocals.PARTYFRAME["MemberPointsGain"].name..":")

    local OverallRatingTitleText = temp_Frame:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    OverallRatingTitleText:SetPoint("RIGHT",  _G["KM_MapTotalScore"..playerNumber..prevMapId], "CENTER", xOffset, 0)
    OverallRatingTitleText:SetText(KeyMasterLocals.PARTYFRAME["OverallRating"].name..":")

end

function PartyFrame:CreatePartyMemberFrame(unitId, parentFrame)
    local partyNumber
    if (unitId == "player") then partyNumber = 1
    elseif (unitId == "party1") then partyNumber = 2
    elseif (unitId == "party2") then partyNumber = 3
    elseif (unitId == "party3") then partyNumber = 4
    elseif (unitId == "party4") then partyNumber = 5
    else
        KeyMaster:_ErrorMsg("CreatePartyMemberFrame", "PartyFrame", "Invalid paramater value for unitId, expected 'player' or 'party1-4'")
        return
    end

    local frameHeight = 0
    local mtb = 2 -- top and bottom margin of each frame in pixels

    local temp_RowFrame = CreateFrame("Frame", "KM_PlayerRow"..partyNumber, parentFrame)
    temp_RowFrame:ClearAllPoints()

    if (unitId == "player") then -- first spot
        temp_RowFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 0, -4)
        frameHeight = (parentFrame:GetHeight()/5) - (mtb*2)
    else
        temp_RowFrame:SetPoint("TOPLEFT", _G["KM_PlayerRow"..partyNumber - 1], "BOTTOMLEFT", 0, -4)
        frameHeight = parentFrame:GetHeight()
    end

    temp_RowFrame:SetSize(parentFrame:GetWidth(), frameHeight)
    temp_RowFrame.texture = temp_RowFrame:CreateTexture("KM_Player_Row_Class_Bios"..partyNumber)
    temp_RowFrame.texture:SetSize(temp_RowFrame:GetWidth(), temp_RowFrame:GetHeight())
    temp_RowFrame.texture:SetPoint("LEFT")
    temp_RowFrame.texture:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)

    local temp_frame = CreateFrame("Frame", "KM_PortraitFrame"..partyNumber, _G["KM_PlayerRow"..partyNumber])
    temp_frame:SetSize(temp_RowFrame:GetHeight(), temp_RowFrame:GetHeight())
    temp_frame:ClearAllPoints()
    temp_frame:SetPoint("CENTER", temp_RowFrame, "LEFT", 0, 0)

    local img1 = temp_frame:CreateTexture("KM_Portrait"..partyNumber, "BACKGROUND")
    img1:SetHeight(temp_RowFrame:GetHeight()-30)
    img1:SetWidth(temp_RowFrame:GetHeight()-30)
    img1:ClearAllPoints()
    img1:SetPoint("CENTER", temp_frame, "CENTER", 0, 0)

    -- the ring around the portrait
    local img2 = temp_frame:CreateTexture("KM_PortraitFrame"..partyNumber, "ARTWORK")
    img2:SetHeight(temp_RowFrame:GetHeight()+5)
    img2:SetWidth(temp_RowFrame:GetHeight()+5)
    img2:SetTexture("Interface\\AddOns\\KeyMaster\\Assets\\Images\\KeyMaster-Interface-Clean",false)
    img2:ClearAllPoints()
    img2:SetTexCoord(916/1024, 1, 100/1024, 206/1024)
    img2:SetPoint("CENTER", img1, "CENTER", 0, 0)

    KeyMaster:CreateHLine(temp_RowFrame:GetWidth()+8, temp_RowFrame, "TOP", 0, 0)

    return temp_RowFrame
end

-- Party Frame Score Tally Footer
function PartyFrame:CreatePartyScoreTallyFooter()
    local parentFrame = KeyMaster:FindLastVisiblePlayerRow()
    if (not parentFrame) then
        KeyMaster:_DebugMsg("CreatePartyScoreTallyFooter", "PartyFrame", "Tally footer could not find a valid parent. [Skipped Creation]")
        return
    end

    local partyTallyFrame = CreateFrame("Frame", "PartyTallyFooter", parentFrame)
    partyTallyFrame:SetWidth(parentFrame:GetWidth())
    partyTallyFrame:SetHeight(25)
    partyTallyFrame:SetPoint("TOPRIGHT", parentFrame, "BOTTOMRIGHT", 0, -4)

    local mapTable = DungeonTools:GetCurrentSeasonMaps()
    local prevMapId, prevAnchor, lastPointsFrame
    local firstItem = true
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

        temp_Frame:SetSize((partyTallyFrame:GetWidth() / 12.5), partyTallyFrame:GetHeight())

        temp_Frame.bgTexture = temp_Frame:CreateTexture()
        temp_Frame.bgTexture:SetSize(temp_Frame:GetWidth(), temp_Frame:GetHeight())
        temp_Frame.bgTexture:SetPoint("LEFT")
        temp_Frame.bgTexture:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight-Inverted")
        local r, g, b, _ = Theme:GetThemeColor("themeFontColorGreen2")

        if (not bolColHighlight) then
            temp_Frame.texture = temp_Frame:CreateTexture("OVERLAY")
            temp_Frame.texture:SetAllPoints(temp_Frame)
            temp_Frame.texture:SetColorTexture(partyColColor.r, partyColColor.g, partyColColor.b, 0.15)
        end

        -- Map Total Tally
        local tempText6 = temp_Frame:CreateFontString("KM_MapTallyScore"..mapid, "OVERLAY", "KeyMasterFontBig")
        tempText6:SetAllPoints(temp_Frame)
        local r, g, b, _ = Theme:GetThemeColor("color_TAUPE")
        tempText6:SetTextColor(r, g, b, 1)
        tempText6:SetJustifyV("CENTER")

        firstItem = false
        prevMapId = mapid
        lastPointsFrame = temp_Frame
    end

    local tallyDescTextBox = CreateFrame("Frame", "KM_TallyDesc", lastPointsFrame)
    tallyDescTextBox:SetPoint("RIGHT", lastPointsFrame, "LEFT", -4, 0)
    tallyDescTextBox:SetSize(240, partyTallyFrame:GetHeight())
    tallyDescTextBox.text = tallyDescTextBox:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    tallyDescTextBox.text:SetAllPoints(tallyDescTextBox)
    tallyDescTextBox.text:SetJustifyH("RIGHT")
    tallyDescTextBox.text:SetJustifyV("CENTER")
    tallyDescTextBox.text:SetText(KeyMasterLocals.PARTYFRAME.TeamRatingGain.name..":")
end

function PartyFrame:CreatePartyRowsFrame(parentFrame)    
    -- if it already exists, don't make another one
    if _G["KeyMaster_Frame_Party"] then
        return 
    end

    local gfm = 4 -- group frame margin

    local temp_frame =  CreateFrame("Frame", "KeyMaster_Frame_Party", parentFrame)
    temp_frame:SetSize(parentFrame:GetWidth()-(gfm*2), 440)
    temp_frame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", gfm, -108)
    timeSinceLastUpdate = 0
    
    --[[ local txtPlaceHolder = temp_frame:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    local Path, _, Flags = txtPlaceHolder:GetFont()
    txtPlaceHolder:SetFont(Path, 20, Flags)
    txtPlaceHolder:SetPoint("TOPLEFT", 0, 30)
    txtPlaceHolder:SetTextColor(1, 1, 1)
    txtPlaceHolder:SetText(KeyMasterLocals.PARTYFRAME["PartyInformation"].name..":") ]]

    return temp_frame
end

function PartyFrame:CreatePartyFrame(parentFrame)

    local partyScreen = CreateFrame("Frame", "KeyMaster_PartyScreen", parentFrame);
    partyScreen:SetSize(parentFrame:GetWidth(), parentFrame:GetHeight())
    partyScreen:SetAllPoints(true)
    partyScreen:SetScript("OnLoad", function(self) 
        
    end)
    partyScreen:SetScript("OnShow", function(self) 
        -- Get player data
        local playerData = KeyMaster.UnitData:GetUnitDataByUnitId("player")
        
        -- Changes colors on weekly affixes on unit rows based on current affix week (tyran vs fort)
        PartyFrame:SetPartyWeeklyDataTheme() 

        -- reprocess party1-4 units
        KeyMaster.PartyFrameMapping:UpdatePartyFrameData()
    end)

    partyScreen:Hide()

    return partyScreen
end

function PartyFrame:CreatePartyHeader(parentFrame)
     -- Header Frame
     local partyFrameHeader = CreateFrame("Frame", "KM_PartyHeader_Frame", parentFrame)
     partyFrameHeader:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 4, -8)
     partyFrameHeader:SetSize(parentFrame:GetWidth()-8, 100)
     partyFrameHeader.texture = partyFrameHeader:CreateTexture(nil, "BACKGROUND", nil, 0)
     partyFrameHeader.texture:SetAllPoints(partyFrameHeader)
     partyFrameHeader.texture:SetColorTexture(0, 0, 0, 1)
 
     partyFrameHeader.textureHighlight = partyFrameHeader:CreateTexture(nil, "BACKGROUND", nil)
     partyFrameHeader.textureHighlight:SetSize(partyFrameHeader:GetWidth(), partyFrameHeader:GetHeight())
     partyFrameHeader.textureHighlight:SetPoint("LEFT", partyFrameHeader, "LEFT", 0, 0)
     partyFrameHeader.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
     local headerColor = {}
     headerColor.r, headerColor.g, headerColor.b, _ = Theme:GetThemeColor("color_COMMON")
     partyFrameHeader.textureHighlight:SetVertexColor(headerColor.r, headerColor.g, headerColor.b, 1)
 
     -- Page Header Title Large Background
     partyFrameHeader.titleBG = partyFrameHeader:CreateFontString(nil, "ARTWORK", "KeyMasterFontBig")
     local Path, _, Flags = partyFrameHeader.titleBG:GetFont()
     partyFrameHeader.titleBG:SetFont(Path, 120, Flags)
     partyFrameHeader.titleBG:SetSize(partyFrameHeader:GetWidth(), partyFrameHeader:GetHeight())
     partyFrameHeader.titleBG:SetPoint("BOTTOMLEFT", partyFrameHeader, "BOTTOMLEFT", -4, -8)
     local headerBGTextColor = {}
     headerBGTextColor.r, headerBGTextColor.g, headerBGTextColor.b, _ = Theme:GetThemeColor("color_COMMON")
     partyFrameHeader.titleBG:SetTextColor(headerBGTextColor.r, headerBGTextColor.g, headerBGTextColor.b, 1)
     partyFrameHeader.titleBG:SetText(KeyMasterLocals.TABPARTY)
     partyFrameHeader.titleBG:SetAlpha(0.04)
     partyFrameHeader.titleBG:SetJustifyH("LEFT")
 
     -- Page Header Title
     partyFrameHeader.title = partyFrameHeader:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
     partyFrameHeader.title:SetPoint("BOTTOMLEFT", partyFrameHeader, "BOTTOMLEFT", 4, 4)
     local Path, _, Flags = partyFrameHeader.title:GetFont()
     partyFrameHeader.title:SetFont(Path, 40, Flags)
     local headerTextColor = {}
     headerTextColor.r, headerTextColor.g, headerTextColor.b, _ = Theme:GetThemeColor("color_COMMON")
     partyFrameHeader.title:SetTextColor(headerTextColor.r, headerTextColor.g, headerTextColor.b, 1)
     partyFrameHeader.title:SetText(KeyMasterLocals.TABPARTY)

     return partyFrameHeader
end

-- Creates the entire party frame and its sub-frames
-- parentFrame: the parent frame to attach the party frame to
function PartyFrame:Initialize(parentFrame)
    
    -- Party Tab    
    local partyContent = _G["KeyMaster_PartyScreen"] or PartyFrame:CreatePartyFrame(parentFrame);
    local partyHeader = _G["KM_PartyHeader_Frame"] or PartyFrame:CreatePartyHeader(partyContent)
    local partyRowsFrame = _G["KeyMaster_Frame_Party"] or PartyFrame:CreatePartyRowsFrame(partyContent)

    -- create player row frame
    local playerRow = _G["KM_PlayerRow1"] or PartyFrame:CreatePartyMemberFrame("player", partyRowsFrame)
    local playerRowData = _G["KM_PlayerDataFrame1"] or PartyFrame:CreatePartyDataFrame(playerRow)

    -- create party row frames
    local maxPartySize = 4
    for i=1,maxPartySize,1 do
        local partyRow = PartyFrame:CreatePartyMemberFrame("party"..i, _G["KM_PlayerRow"..i])
        local partyRowDataFrames = PartyFrame:CreatePartyDataFrame(partyRow)
        partyRow:Hide()
    end

    -- create io score tally frames
    local partyScoreTally = _G["PartyTallyFooter"] or PartyFrame:CreatePartyScoreTallyFooter()  
    
    return partyContent
end