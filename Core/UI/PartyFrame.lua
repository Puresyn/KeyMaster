local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface

local function createPartyRowsFrame(parentFrame)
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


    --return temp_frame
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

    createPartyRowsFrame(partyScreen)

    return partyScreen
end