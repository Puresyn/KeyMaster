local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface
local DungeonTools = KeyMaster.DungeonTools
local Theme = KeyMaster.Theme

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
function MainInterface:createPartyRows(parentFrame, partyPosition)
    -- partyPosition = player, party1, party2, party3, party4
    local partyPlayer
    if (partyPosition == "player") then
        partyPlayer = 1
    elseif (partyPosition == "party1") then
        partyPlayer = 2
    elseif (partyPosition == "party2") then
        partyPlayer = 3
    elseif (partyPosition == "party3") then
        partyPlayer = 4
    elseif (partyPosition == "party4") then
        partyPlayer = 5
    end
    
    local playerData = PartyPlayerData[UnitGUID(partyPosition)]
    if (playerData) then
        local mapTable = DungeonTools:GetCurrentSeasonMaps()
        local r, g, b, colorWeekHex = Theme:GetWeekScoreColor()
    
        local specClass = GetPlayerSpecAndClass(partyPosition)
    
        -- populate UI frames
        _G["KM_Player"..partyPlayer.."Class"]:SetText(specClass)
    
    
        _G["KM_PlayerName"..partyPlayer]:SetText("|cff"..PlayerInfo:GetMyClassColor(partyPosition)..playerData.name.."|r")
        --_G["KM_OwnedKeyInfo"..partyNumber]:SetText("("..playerData.ownedKeyLevel..") "..mapTable[playerData.ownedKeyId].name)
        _G["KM_OwnedKeyInfo"..partyPlayer]:SetText("("..playerData.ownedKeyLevel..") "..InstanceTools:GetAbbr(playerData.ownedKeyId))
    
        for n, v in pairs(mapTable) do
            -- TODO: Determine if the current week is Fortified or Tyrannical and ask for the relating data.
            _G["KM_MapLevelT"..partyPlayer..n]:SetText("("..playerData.keyRuns[n]["Fortified"].Level..")")
            _G["KM_MapScoreT"..partyPlayer..n]:SetText("|cff"..colorWeekHex..playerData.keyRuns[n]["Fortified"].Score.."|r")
            _G["KM_MapTimeT"..partyPlayer..n]:SetText(formatDurationSec(playerData.keyRuns[n]["Fortified"].DurationSec))
        end
        _G["KM_NoAddon"..partyPlayer]:Hide()
    else
        print("No data")
        local myClass, _, _ = UnitClass(partyPosition)
        local _, _, _, classHex = GetClassColor(myClass)
        _G["KM_PlayerName"..partyPlayer]:SetText("|c"..classHex..UnitName(partyPosition).."|r")

        local classText = GetPlayerSpecAndClass(partyPosition)
        _G["KM_Player"..partyPlayer.."Class"]:SetText(classText)
        _G["KM_MapDataLegend"..partyPlayer]:Hide()
        _G["KM_NoAddon"..partyPlayer]:Show()
    end

    SetPortraitTexture(_G["KM_Portrait"..partyPlayer], partyPosition)        
    _G["KM_PlayerRow"..partyPlayer]:Show()
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