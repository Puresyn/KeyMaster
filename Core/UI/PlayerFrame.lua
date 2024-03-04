local _, KeyMaster = ...
local PlayerFrame = {}
KeyMaster.PlayerFrame = PlayerFrame
local CharacterInfo = KeyMaster.CharacterInfo
local Theme = KeyMaster.Theme
local DungeonTools = KeyMaster.DungeonTools

function PlayerFrame:CreatePlayerFrame(parentFrame)

    local characterData = CharacterInfo:GetMyCharacterInfo()

    local playerFrame = CreateFrame("Frame", "KM_Player_Frame",parentFrame)
    playerFrame:SetAllPoints(parentFrame)
    playerFrame:SetSize(parentFrame:GetHeight(), parentFrame:GetWidth())

    local modelFrame = CreateFrame("PlayerModel", "KM_PlayerModel", playerFrame)
    modelFrame:SetPoint("BOTTOMLEFT")
    modelFrame:SetSize(250, playerFrame:GetHeight()*0.8)
    --m:SetDisplayInfo(21723) -- creature/murloccostume/murloccostume.m2
    modelFrame:SetUnit("player")
    modelFrame:SetCamera(1)
    modelFrame:SetAnimation(2)
    modelFrame:SetFacing(0.55)
    modelFrame:RefreshCamera()

    -- Player Name
    playerFrame.playerName = playerFrame:CreateFontString("KM_PLayerFramePlayerName", "OVERLAY", "KeyMasterFontBig")
    local Path, _, Flags = playerFrame.playerName:GetFont()
    playerFrame.playerName:SetFont(Path, 20, Flags)
    playerFrame.playerName:SetPoint("TOPLEFT", playerFrame, "TOPLEFT", 12, -12)
    playerFrame.playerName:SetSize(200, 20)
    local hexColor = CharacterInfo:GetMyClassColor("player")
    playerFrame.playerName:SetText("|cff"..hexColor..UnitName("player").."|r")
    playerFrame.playerName:SetJustifyH("LEFT")

    -- Player character details
    playerFrame.playerDetails = playerFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    local _, Size, _ = playerFrame.playerDetails:GetFont()
    --playerFrame.playerDetails:SetFont(Path, 20, Flags)
    playerFrame.playerDetails:SetPoint("TOPLEFT", playerFrame.playerName, "BOTTOMLEFT", 0, 0)
    playerFrame.playerDetails:SetSize(200, Size)
    --local hexColor = CharacterInfo:GetMyClassColor("player")
    playerFrame.playerDetails:SetText("("..UnitLevel("Player")..") "..UnitRace("player").." "..UnitClass("player"))
    playerFrame.playerDetails:SetJustifyH("LEFT")

    -- Player Rating
    playerFrame.playerRating = playerFrame:CreateFontString("KM_PLayerFramePlayerRating", "OVERLAY", "KeyMasterFontBig")
    local Path, _, Flags = playerFrame.playerRating:GetFont()
    playerFrame.playerRating:SetFont(Path, 30, Flags)
    playerFrame.playerRating:SetPoint("TOPLEFT", playerFrame.playerDetails, "BOTTOMLEFT", -1, -4)
    playerFrame.playerRating:SetSize(200, 20)
    local ratingColor = {}
    ratingColor.r, ratingColor.g, ratingColor.b, _ = Theme:GetThemeColor("color_HEIRLOOM")
    playerFrame.playerRating:SetTextColor(ratingColor.r, ratingColor.g, ratingColor.b, 1)
    playerFrame.playerRating:SetText("3976") -- todo: REPLACE ME WITH DYNAMIC INFO
    playerFrame.playerRating:SetJustifyH("LEFT")

    return playerFrame
end

function PlayerFrame:CreateMapData(parentFrame)

    -- Player Details Panel
    local playerInformationFrame = CreateFrame("Frame", "KM_PlayerFrameInfo", parentFrame)
    playerInformationFrame:SetSize(500, parentFrame:GetHeight())
    playerInformationFrame:SetPoint("RIGHT", parentFrame, "RIGHT", 0, 0)
    playerInformationFrame.texture = playerInformationFrame:CreateTexture()
    playerInformationFrame.texture:SetAllPoints(playerInformationFrame)
    playerInformationFrame.texture:SetColorTexture(0, 0, 0, 0.6)

    local seasonMaps = DungeonTools:GetCurrentSeasonMaps()
    local count = 1
    local prevFrame
    for mapId in pairs (seasonMaps) do
        local mapFrame = CreateFrame("Frame", "KM_PlayerFrameMapInfo"..mapId, playerInformationFrame)
        mapFrame:SetSize(playerInformationFrame:GetWidth(), playerInformationFrame:GetHeight()/(#seasonMaps))
        if count == 1 then
            mapFrame:SetPoint("TOP", playerInformationFrame, "TOP", 0, 0)
        else
            mapFrame:SetPoint("TOP", prevFrame, "TOP", 0, 0)
        end
        prevFrame = mapFrame
    end
    
    return playerInformationFrame
end
