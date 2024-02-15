local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface
local DungeonTools = KeyMaster.DungeonTools
local CharacterInfo = KeyMaster.CharacterInfo
local Theme = KeyMaster.Theme

local function portalButton_buttonevent(self, event)
   MainInterface:Toggle();
end

local function portalButton_tooltipon(self, event)
end

local function portalButton_tooltipoff(self, event)
end

local function portalButton_mouseover(self, event)
    local spellNameToCheckCooldown = self:GetParent():GetAttribute("portalSpellName")
    local start, _, _ = GetSpellCooldown(spellNameToCheckCooldown);
    if (start == 0) then
        self:GetParent().textureportal:SetTexture("Interface\\AddOns\\KeyMaster\\Assets\\Images\\portal-texture1", false)
        --ActionButton_ShowOverlayGlow(self:GetParent())
    end

    --start, duration, enabled = GetSpellCooldown(spellName or spellID or slotID, "bookType");
end

local function portalButton_mouseoout(self, event, ...)
    self:GetParent().textureportal:SetTexture()
    --ActionButton_HideOverlayGlow(self:GetParent())
end

local function createPartyDungeonHeader(anchorFrame, mapId)
    --[[ name, id, timeLimit, texture, backgroundTexture = C_ChallengeMode.GetMapUIInfo(v)
       mapTable[id] = {
          ["name"] = name,
          ["timeLimit"] = timeLimit,
          ["texture"] = texture,
          ["backgroundTexture"] = backgroundTexture
       } ]]

    --DEBUG
    if not anchorFrame and mapId then 
        print("No valid refrences passed to createPartyDungeonHeader()")
    end
    if (not anchorFrame) then
        print("Invalid anchorFrame for createPartyDungeonHeader() mapId:"..mapId)
    end
    if (not mapId) then
        print("Invalid mapId for createPartyDungeonHeader() anchorFrame:"..anchorFrame:GetName())
    end
    -- END DEBUG

    local window = _G["Dungeon_"..mapId.."_Header"]
    if (window) then return window end -- if already Created, don't make another one

    local mapsTable = DungeonTools:GetCurrentSeasonMaps()
    local iconSizex = anchorFrame:GetWidth() - 10
    local iconSizey = anchorFrame:GetWidth() - 10
    local mapAbbr = DungeonTools:GetDungeonNameAbbr(mapId)

    local temp_frame = CreateFrame("Frame", "Dungeon_"..mapId.."_Header", _G["KeyMaster_Frame_Party"])

    --temp_frame:SetSize(parentFrame:GetWidth(), parentFrame:GetHeight()) --- ((_G["KM_Portrait1"]:GetWidth())/2))
    temp_frame:SetSize(iconSizex, iconSizey) -- second width refrence is just making this a square
    temp_frame:SetPoint("BOTTOM", anchorFrame, "TOP", 0, 4)

    local txtPlaceHolder = temp_frame:CreateFontString(nil, "OVERLAY", "GameTooltipText")
    Path, _, Flags = txtPlaceHolder:GetFont()
    txtPlaceHolder:SetFont(Path, 12, Flags)
    txtPlaceHolder:SetPoint("BOTTOM", 0, 2)
    txtPlaceHolder:SetTextColor(1, 1, 1)
    txtPlaceHolder:SetText(mapAbbr)

    temp_frame.texture = temp_frame:CreateTexture(nil, "BACKGROUND",nil, 3)
    --temp_frame.texture:SetAllPoints(temp_frame)
    temp_frame.texture:SetPoint("BOTTOM", temp_frame, 0, 0)
    temp_frame.texture:SetSize(temp_frame:GetWidth(), 16)
    temp_frame.texture:SetColorTexture(0, 0, 0, 0.7) -- make names more ledegible 

    temp_frame.texturemap = temp_frame:CreateTexture(nil, "BACKGROUND",nil, 1)
    temp_frame.texturemap:SetAllPoints(temp_frame)
    temp_frame.texturemap:SetTexture(mapsTable[mapId].texture)
    temp_frame:SetAttribute("dungeonMapId", mapId)
    temp_frame:SetAttribute("texture", mapsTable[mapId].texture)

    temp_frame.textureportal = temp_frame:CreateTexture(nil, "BACKGROUND",nil, 2)
    temp_frame.textureportal:SetAllPoints(temp_frame)
    --temp_frame.textureportal:SetTexture(mapsTable[mapId].texture)

    -- Add clickable portal spell casting to dungeon texture frames
    local portalSpellId, portalSpellName = DungeonTools:GetPortalSpell(mapId)
    
    if (portalSpellId) then -- if the player has the portal, make the dungeon image clickable to cast it.
    local pButton
        pButton = CreateFrame("Button","portal_button"..mapId,temp_frame,"SecureActionButtonTemplate") -- ActionButtonTemplate, 
        --pButton.cooldown = CreateFrame("Cooldown","portal_button2"..mapId.."Cooldown",pButton,"CooldownFrameTemplate")
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
end

function MainInterface:CreatePartyDataFrame(parentFrame)

    local playerNumber

    if (parentFrame:GetName() == "KM_PlayerRow1") then playerNumber = 1
        elseif (parentFrame:GetName() == "KM_PlayerRow2") then playerNumber = 2
        elseif (parentFrame:GetName() == "KM_PlayerRow3") then playerNumber = 3
        elseif (parentFrame:GetName() == "KM_PlayerRow4") then playerNumber = 4
        elseif (parentFrame:GetName() == "KM_PlayerRow5") then playerNumber = 5
    end

    if (not playerNumber or playerNumber < 0 or playerNumber > 5) then
        print("Invalid party row reference for data frame: "..tostringall(rowNumber)) -- Debug
    end

    --local temp_frameStack = GetPartyMembersFrameStack()
    local parentFrame =  _G["KM_PlayerRow"..playerNumber]
    
    local tempText

    local dataFrame = CreateFrame("Frame", "KM_PlayerDataFrame"..playerNumber, parentFrame)
    dataFrame:ClearAllPoints()
    dataFrame:SetPoint("TOPRIGHT",  _G["KM_PlayerRow"..playerNumber], "TOPRIGHT", 0, 0)
    dataFrame:SetSize((parentFrame:GetWidth() - ((_G["KM_Portrait"..playerNumber]:GetWidth())/2)), parentFrame:GetHeight())
    --[[  dataFrame.texture = dataFrame:CreateTexture()
    dataFrame.texture:SetAllPoints(dataFrame)
    dataFrame.texture:SetColorTexture(0.831, 0.831, 0.831, 0.5) -- todo: temporary bg color  ]]


    --local temp_Frame = temp_frameStack[rowNumber]:GetValue()
    --local player_Frame = temp_frameStack["p"..playerNumber.."Frame"]
    local player_Frame = _G["p"..playerNumber.."Frame"]

    -- Player's Name
    tempText = dataFrame:CreateFontString("KM_PlayerName"..playerNumber, "OVERLAY", "GameFontHighlightLarge")
    tempText:SetPoint("TOPLEFT", dataFrame, "TOPLEFT", 4, -4)

    -- TODO: get the unit's reference so we can set their class color... somehow...
    -- todo" make if/then for if 1 then party1 etc. for class color.
    --tempText:SetText("|cff"..PlayerInfo:GetMyClassColor("player")..thisPlayer.name.."|r")

    --- Player Class
    tempText = dataFrame:CreateFontString("KM_Player"..playerNumber.."Class", "OVERLAY", "GameTooltipText")
    tempText:SetPoint("TOPLEFT", _G["KM_PlayerName"..playerNumber], "BOTTOMLEFT", 0, 0)

    -- Player does not have the addon
    tempText = dataFrame:CreateFontString("KM_NoAddon"..playerNumber, "OVERLAY", "GameFontHighlightLarge")
    local font, fontSize, flags = tempText:GetFont()
    tempText:SetFont(font, 25, flags)
    tempText:SetTextColor(0.4, 0.4, 0.4, 1)
    tempText:SetPoint("CENTER", dataFrame, "CENTER", 0, 0)
    tempText:SetText("This player does not have "..KM_ADDON_NAME.." installed. :(")
    tempText:Hide()

    -- Player is offline
    tempText = dataFrame:CreateFontString("KM_Player"..playerNumber.."Offline", "OVERLAY", "GameFontHighlightLarge")
    local font, fontSize, flags = tempText:GetFont()
    tempText:SetFont(font, 25, flags)
    tempText:SetTextColor(0.4, 0.4, 0.4, 1)
    tempText:SetPoint("CENTER", dataFrame, "CENTER", 0, 0)
    tempText:SetText("This player is offline.")
    tempText:Hide()

    -- Player's Owned Key
    tempText = dataFrame:CreateFontString("KM_OwnedKeyInfo"..playerNumber, "OVERLAY", "GameFontHighlightLarge")
    local _, fontSize, _ = tempText:GetFont()
    tempText:SetPoint("BOTTOMLEFT", dataFrame, "BOTTOMLEFT", 4, 4)
    --[[  if (thisPlayer.ownedKeyLevel == 0) then
        tempText:SetText("No Key Found")
    else
        tempText:SetText("("..thisPlayer.ownedKeyLevel..") "..mapTable[thisPlayer.ownedKeyId].name)
    end ]]

    

    --print(#mapTable)
    local prevMapId
    local firstItem = true
    local mapTable = DungeonTools:GetCurrentSeasonMaps()
    local bolColHighlight = false
    local partyColColor = {}
    partyColColor.r,  partyColColor.g, partyColColor.b, _ = Theme:GetThemeColor("party_colHighlight")

    for mapid, mapData in pairs(mapTable) do
        bolColHighlight = not bolColHighlight -- alternate row highlighting
        
        local temp_Frame = CreateFrame("Frame", "KM_MapData"..playerNumber..mapid, parentFrame)
        temp_Frame:ClearAllPoints()

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

        local tempText1 = temp_Frame:CreateFontString("KM_MapLevelT"..playerNumber..mapid, "OVERLAY", "GameToolTipText")
        local _, fontSize, _ = tempText:GetFont()
        tempText1:SetPoint("CENTER", temp_Frame, "TOP", 0, -10)

        local tempText2 = temp_Frame:CreateFontString("KM_MapScoreT"..playerNumber..mapid, "OVERLAY", "GameFontHighlightLarge")
        local _, fontSize, _ = tempText:GetFont()
        tempText2:SetPoint("CENTER", tempText1, "BOTTOM", 0, -8)

        local tempText3 = temp_Frame:CreateFontString("KM_MapTimeT"..playerNumber..mapid, "OVERLAY", "GameToolTipText")
        local _, fontSize, _ = tempText:GetFont()
        tempText3:SetPoint("CENTER", temp_Frame, "BOTTOM", 0, 10)

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
    local temp_Frame = CreateFrame("Frame", "KM_MapDataLegend"..playerNumber, parentFrame)
    temp_Frame:ClearAllPoints()
    temp_Frame:SetSize((parentFrame:GetWidth() / 12), parentFrame:GetHeight())
    temp_Frame:SetPoint("TOPRIGHT", "KM_MapData"..playerNumber..prevMapId, "TOPLEFT", 0, 0)

    --point, relativeTo, relativePoint, xOfs, yOfs = MyRegion:GetPoint(n)
    local _, _, _, xOfs, yOfs = _G["KM_MapLevelT"..playerNumber..prevMapId]:GetPoint()
    local tempText1 = temp_Frame:CreateFontString(nil, "OVERLAY", "GameToolTipText")
    local _, fontSize, _ = tempText1:GetFont()
    tempText1:SetPoint("RIGHT", temp_Frame, "TOPRIGHT", 0, yOfs)
    tempText1:SetText("Level:")

    _, _, _, xOfs, yOfs = _G["KM_MapScoreT"..playerNumber..prevMapId]:GetPoint()
    local tempText2 = temp_Frame:CreateFontString(nil, "OVERLAY", "GameToolTipText")
    local _, fontSize, _ = tempText2:GetFont()
    tempText2:SetPoint("TOPRIGHT", tempText1, "BOTTOMRIGHT", 0, (yOfs + 6)) -- todo: this yOfs is screwy.. FIX IT
    tempText2:SetText("Weekly:")

    _, _, _, xOfs, yOfs = _G["KM_MapTimeT"..playerNumber..prevMapId]:GetPoint()
    local tempText2 = temp_Frame:CreateFontString(nil, "OVERLAY", "GameToolTipText")
    local _, fontSize, _ = tempText2:GetFont()
    tempText2:SetPoint("BOTTOMRIGHT", temp_Frame, "BOTTOMRIGHT", 0, (yOfs - 5)) -- todo: this yOfs is screwy.. FIX IT
    tempText2:SetText("Time:")
    
    _G["KM_MapDataLegend"..playerNumber]:Show()


end

function MainInterface:CreatePartyMemberFrame(frameName, parentFrame)
    local frameAnchor, frameHeight, partyNumber
    local mtb = 2 -- top and bottom margin of each frame in pixels

    -- DEBUG
    if (not parentFrame) then
        print("Can not find row reference \"Nil\" while trying to make "..frameName.."'s row.")
    end

    --print("Creating "..frameName.." and setting its parent to "..parentFrame:GetName()..".") -- debug

    if (frameName == "KM_PlayerRow1") then partyNumber = 1
    elseif (frameName == "KM_PlayerRow2") then partyNumber = 2
    elseif (frameName == "KM_PlayerRow3") then partyNumber = 3
    elseif (frameName == "KM_PlayerRow4") then partyNumber = 4
    elseif (frameName == "KM_PlayerRow5") then partyNumber = 5
    end

   --[[  local window = _G[frameName]
    if (window) then return window end -- frame exists, don't create another ]]

    local temp_RowFrame = CreateFrame("Frame", frameName, parentFrame)
    temp_RowFrame:ClearAllPoints()

    --temp_RowFrame:SetPoint(frameAnchor)
    if (frameName == "KM_PlayerRow1") then 
        --frameAnchor = "TOPLEFT", parentFrame, "TOPLEFT", 0, -20
        temp_RowFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 0, -2)

         -- get the frame's group container and set this row frame height to 1/5th the group container height minus margins
        frameHeight = (parentFrame:GetHeight()/5) - (mtb*2)

    else
        --frameAnchor = "TOPLEFT", parentFrame, "BOTTOMLEFT", 0, -2
        temp_RowFrame:SetPoint("TOPLEFT", parentFrame, "BOTTOMLEFT", 0, -4)

        -- get the frame parent and set this row frame height the parent's height
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
    img2:SetHeight(temp_RowFrame:GetHeight())
    img2:SetWidth(temp_RowFrame:GetHeight())
    img2:SetTexture("Interface\\AddOns\\KeyMaster\\Assets\\Images\\portrait_frame",false)
    img2:ClearAllPoints()
    img2:SetPoint("LEFT", 0, 0)

    return temp_RowFrame
end

-- Party member data assign
function MainInterface:UpdateUnitFrameData(unitId, playerData)
    if(playerData == nil) then 
        print("ERROR: parameter playerData in function createPartyRows cannot be empty.")
        return
    end
    
    local partyPlayer
    if (unitId == "player") then
        partyPlayer = 1
    elseif (unitId == "party1") then
        partyPlayer = 2
    elseif (unitId == "party2") then
        partyPlayer = 3
    elseif (unitId == "party3") then
        partyPlayer = 4
    elseif (unitId == "party4") then
        partyPlayer = 5
    end
    
    local mapTable = DungeonTools:GetCurrentSeasonMaps()
    local r, g, b, colorWeekHex = Theme:GetWeekScoreColor()

    local unitSpecialization = CharacterInfo:GetPlayerSpecialization(unitId)
    local unitClass, _ = UnitClass(unitId)
    --[[ local map = C_Map.GetBestMapForUnit("player")
    local position = C_Map.GetPlayerMapPosition(map, "player")
    local specClass = position:GetXY() ]]

    -- Set Player Portrait
    SetPortraitTexture(_G["KM_Portrait"..partyPlayer], unitId)
    
    -- Spec & Class
    _G["KM_Player"..partyPlayer.."Class"]:SetText(unitSpecialization.." "..unitClass)
    
    -- Player Name
    _G["KM_PlayerName"..partyPlayer]:SetText("|cff"..CharacterInfo:GetMyClassColor(unitId)..playerData.name.."|r")
    
    -- Dungeon Key Information
    _G["KM_OwnedKeyInfo"..partyPlayer]:SetText("("..playerData.ownedKeyLevel..") "..DungeonTools:GetDungeonNameAbbr(playerData.ownedKeyId))

    -- Dungeon Scores
    for n, v in pairs(mapTable) do
        -- TODO: Determine if the current week is Fortified or Tyrannical and ask for the relating data.
        _G["KM_MapLevelT"..partyPlayer..n]:SetText("("..playerData.DungeonRuns[n]["Fortified"].Level..")")
        _G["KM_MapScoreT"..partyPlayer..n]:SetText("|cff"..colorWeekHex..playerData.DungeonRuns[n]["Fortified"].Score.."|r")
        _G["KM_MapTimeT"..partyPlayer..n]:SetText(KeyMaster:FormatDurationSec(playerData.DungeonRuns[n]["Fortified"].DurationSec))
    end
    
    if (not playerData.hasAddon) then
        _G["KM_MapDataLegend"..partyPlayer]:Hide()
        _G["KM_NoAddon"..partyPlayer]:Show()
        _G["KM_PlayerRow"..partyPlayer]:Show()
    end
end

function MainInterface:CreatePartyRowsFrame(parentFrame)
    local a, window, gfm, frameTitle, txtPlaceHolder, temp_frame
    frameTitle = "Party Information:" -- set title

    -- relative parent frame of this frame
    -- todo: the next 2 lines may be reduntant?
    a = parentFrame
    window = _G["KeyMaster_Frame_Party"]

    gfm = 10 -- group frame margin

    if window then return window end -- if it already exists, don't make another one

    temp_frame =  CreateFrame("Frame", "KeyMaster_Frame_Party", a)
    temp_frame:SetSize(a:GetWidth()-(gfm*2), 400)
    temp_frame:SetPoint("TOPLEFT", a, "TOPLEFT", gfm, -55)

    txtPlaceHolder = temp_frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    Path, _, Flags = txtPlaceHolder:GetFont()
    txtPlaceHolder:SetFont(Path, 20, Flags)
    txtPlaceHolder:SetPoint("TOPLEFT", 0, 30)
    txtPlaceHolder:SetTextColor(1, 1, 1)
    txtPlaceHolder:SetText(frameTitle)

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
    --[[ txtPlaceHolder = PartyScreen:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    local Path, _, Flags = txtPlaceHolder:GetFont()
    txtPlaceHolder:SetFont(Path, 30, Flags)
    txtPlaceHolder:SetPoint("BOTTOMLEFT", 50, 50)
    txtPlaceHolder:SetTextColor(1, 1, 1)
    txtPlaceHolder:SetText("Party Screen") ]]

    --[[ PartyScreen.texture = PartyScreen:CreateTexture()
    PartyScreen.texture:SetAllPoints(PartyScreen)
    PartyScreen.texture:SetColorTexture(0.531, 0.531, 0.531, 1) -- temporary bg color ]]

    local txtPlaceHolder = partyScreen:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    local Path, _, Flags = txtPlaceHolder:GetFont()
    txtPlaceHolder:SetFont(Path, 30, Flags)
    txtPlaceHolder:SetPoint("BOTTOMLEFT", 50, 50)
    txtPlaceHolder:SetTextColor(1, 1, 1)
    txtPlaceHolder:SetText("Party Screen")

    return partyScreen
end