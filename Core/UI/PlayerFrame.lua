local _, KeyMaster = ...
local PlayerFrame = {}
KeyMaster.PlayerFrame = PlayerFrame
local CharacterInfo = KeyMaster.CharacterInfo
local Theme = KeyMaster.Theme
local DungeonTools = KeyMaster.DungeonTools
local MainInterface = KeyMaster.MainInterface
local PlayerFrameMapping = KeyMaster.PlayerFrameMapping
local CharacterData = KeyMaster.CharacterData
local Factory = KeyMaster.Factory

local function shortenDungeonName(fullDungeonName)
    local length = string.len(fullDungeonName)
    local _, e = string.find(fullDungeonName, ":")
    if (e) then
        local splice = string.sub(fullDungeonName, e+2, length)         
        return splice
    else
        return fullDungeonName
    end
end

local function getColor(strColor)
    local Color = {}
    Color.r, Color.g, Color.b, _ = Theme:GetThemeColor(strColor)
    Color.a = 1
    return Color.r, Color.g, Color.b, Color.a
end

local function mapData_onmouseover(self, event)
    local highlight = self:GetAttribute("highlight")
    local hlColor = {}
    hlColor.a = 1
    hlColor.r,hlColor.g,hlColor.b, _ = getColor("color_COMMON")
    highlight:SetVertexColor(hlColor.r,hlColor.g,hlColor.b, hlColor.a)
end
local function mapData_onmouseout(self, event)
    local highlight = self:GetAttribute("highlight")
    local defColor = self:GetAttribute("defColor")
    local defAlpha = self:GetAttribute("defAlpha")
    local hlColor = {}
    hlColor.r,hlColor.g,hlColor.b, _ = getColor(defColor)
    highlight:SetVertexColor(hlColor.r,hlColor.g,hlColor.b, defAlpha)
end
local selectedMapId
local function mapdData_OnRowClick(self, event)
    local seasonMaps = DungeonTools:GetCurrentSeasonMaps()
    selectedMapId = self:GetAttribute("mapId")
    local mapDetailsFrame = _G["KM_MapDetailView"]
    local dungeonName = shortenDungeonName(seasonMaps[selectedMapId].name)
    local mapCalcFrame = _G["KM_ScoreCalc"]
    local scoreCalcScores = _G["KM_ScoreCalcScores"]
    local scoresCalcDirection = _G["KM_ScoreCalcDirection"]
    
    if mapDetailsFrame.MapName:GetText() ~= dungeonName then        
        mapDetailsFrame.MapName:SetText(dungeonName)
        mapCalcFrame.DetailsTitle:SetText(dungeonName)
        mapDetailsFrame.InstanceBGT:SetTexture(seasonMaps[selectedMapId].backgroundTexture)
        local timers = DungeonTools:GetChestTimers(selectedMapId)
        mapDetailsFrame.TimeLimit:SetText("+"..KeyMaster:FormatDurationSec(timers["1chest"]))
        mapDetailsFrame.TwoChestTimer:SetText("++"..KeyMaster:FormatDurationSec(timers["2chest"])) 
        mapDetailsFrame.ThreeChestTimer:SetText("+++"..KeyMaster:FormatDurationSec(timers["3chest"]))
        scoreCalcScores:Hide()
        scoresCalcDirection:Show()
    end
end

function PlayerFrame:CreatePlayerContentFrame(parentFrame)
    local playerContentFrame = CreateFrame("Frame", "KM_PlayerContentFrame", parentFrame)
    playerContentFrame:SetSize(parentFrame:GetWidth(), parentFrame:GetHeight())
    playerContentFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT")
    return playerContentFrame
end

local function updateWeeklyAffixTheme()
    local cw = {} -- current weekly affix highlight
    local ow = {} -- off weekly affix highlight
    cw.r, cw.g, cw.b, _ = Theme:GetThemeColor("party_CurrentWeek")
    ow.r, ow.g, ow.b, _ = Theme:GetThemeColor("party_OffWeek")
    local weeklyAffix = DungeonTools:GetWeeklyAffix()
    local mapTable = DungeonTools:GetCurrentSeasonMaps()

    local baseFrame = _G["KM_PlayerFrameMapInfoHeader"]
    local tyrannicalSelector = _G["TyrannicalSelector"]
    local fortifiedSelector = _G["FortifiedSelector"]

    if weeklyAffix == KeyMasterLocals.TYRANNICAL then
        baseFrame.tyranText:SetTextColor(cw.r, cw.g, cw.b, 1)
        baseFrame.fortText:SetTextColor(ow.r, ow.g, ow.b, 1)
        
        tyrannicalSelector:SetChecked(true)
        fortifiedSelector:SetChecked(false)
    
    elseif weeklyAffix == KeyMasterLocals.FORTIFIED then
        baseFrame.fortText:SetTextColor(cw.r, cw.g, cw.b, 1)
        baseFrame.tyranText:SetTextColor(ow.r, ow.g, ow.b, 1)

        tyrannicalSelector:SetChecked(false)
        fortifiedSelector:SetChecked(true)
    else
        baseFrame.fortText:SetTextColor(1, 1, 1, 1)
        baseFrame.tyranText:SetTextColor(1, 1, 1, 1)
        KeyMaster:_ErrorMsg("updateWeeklyAffixTheme", "PlayerFrame", "No match for weekly affix found.")
    end
end

function PlayerFrame:CreatePlayerFrame(parentFrame)

    local playerFrame = CreateFrame("Frame", "KM_Player_Frame",parentFrame)
    playerFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 4, -4)
    playerFrame:SetSize(parentFrame:GetWidth()-8, 100)
    playerFrame.texture = playerFrame:CreateTexture(nil, "BACKGROUND", nil, 0)
    playerFrame.texture:SetAllPoints(playerFrame)
    playerFrame.texture:SetColorTexture(0, 0, 0, 1)
    playerFrame:SetScript("OnShow", function(self)
        PlayerFrameMapping:RefreshData(false)
        updateWeeklyAffixTheme()
    end)

    local modelFrame = CreateFrame("PlayerModel", "KM_PlayerModel", playerFrame)
    modelFrame:SetSize(playerFrame:GetHeight()+40, playerFrame:GetHeight()-2)
    modelFrame:ClearAllPoints()
    modelFrame:SetPoint("TOPLEFT", playerFrame, "TOPLEFT", 0, 0)
    --m:SetDisplayInfo(21723) -- creature/murloccostume/murloccostume.m2
    modelFrame:SetUnit("player")


    modelFrame:SetScript("OnShow", function(self)
        self:SetCamera(0)
        self:SetPortraitZoom(0.5)
        self:SetPosition(0, 0, -0.15)
        self:SetFacing(0.40)
        self:RefreshCamera() 
    end)

    local playerFrameHighlight = CreateFrame("Frame", "KM_PlayerFrameHighlight" ,playerFrame)
    playerFrameHighlight:SetFrameLevel(modelFrame:GetFrameLevel()+1)
    playerFrameHighlight:SetPoint("TOPLEFT")
    playerFrameHighlight:SetSize(playerFrame:GetWidth(), playerFrame:GetHeight())
    playerFrameHighlight.textureHighlight = playerFrame:CreateTexture(nil, "OVERLAY", nil)
    playerFrameHighlight.textureHighlight:SetSize(playerFrame:GetWidth(), playerFrame:GetHeight())
    playerFrameHighlight.textureHighlight:SetPoint("LEFT", playerFrame, "LEFT", 0, 0)
    playerFrameHighlight.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    
    local _, unitClassForColor, _ = UnitClass("player")
    local classRGB = {}  
    classRGB.r, classRGB.g, classRGB.b, _ = GetClassColor(unitClassForColor)
    playerFrameHighlight.textureHighlight:SetVertexColor(classRGB.r, classRGB.g, classRGB.b, 1)

    -- Player Name
    playerFrame.playerName = playerFrame:CreateFontString("KM_PLayerFramePlayerName", "OVERLAY", "KeyMasterFontBig")
    local Path, _, Flags = playerFrame.playerName:GetFont()
    playerFrame.playerName:SetFont(Path, 20, Flags)
    playerFrame.playerName:SetPoint("TOPRIGHT", playerFrame , "TOPRIGHT", -12, -12)
    local hexColor = CharacterInfo:GetMyClassColor("player")
    playerFrame.playerName:SetText("|cff"..hexColor..UnitName("player").."|r")
    playerFrame.playerName:SetJustifyH("RIGHT")

    -- Player Name Large Background
    playerFrame.playerNameLarge = playerFrame:CreateFontString("KM_PLayerFramePlayerName", "BACKGROUND", "KeyMasterFontBig")
    local Path, _, Flags = playerFrame.playerNameLarge:GetFont()
    playerFrame.playerNameLarge:SetFont(Path, 120, Flags)
    local largeNameOffset = 12
    playerFrame.playerNameLarge:SetSize(playerFrame:GetWidth(), playerFrame:GetHeight())
    playerFrame.playerNameLarge:SetPoint("BOTTOMLEFT", playerFrame, "BOTTOMLEFT", -4, -8)
    local hexColor = CharacterInfo:GetMyClassColor("player")
    playerFrame.playerNameLarge:SetText("|cff"..hexColor..UnitName("player").."|r")
    playerFrame.playerNameLarge:SetAlpha(0.06)
    playerFrame.playerNameLarge:SetJustifyH("LEFT")

    -- Player Specialization and Class
    playerFrame.playerDetails = playerFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    local _, Size, _ = playerFrame.playerDetails:GetFont()
    playerFrame.playerDetails:SetPoint("TOPRIGHT", playerFrame.playerName, "BOTTOMRIGHT", 0, 0)
    playerFrame.playerDetails:SetSize(200, Size)
    local currentSpec = GetSpecialization()
    local currentSpecName = currentSpec and select(2, GetSpecializationInfo(currentSpec)) or "None"
    if currentSpecName ~= "" then currentSpecName = "\'"..currentSpecName.."\'" end
    playerFrame.playerDetails:SetText(currentSpecName.." "..UnitClass("player"))
    playerFrame.playerDetails:SetJustifyH("RIGHT")

    -- Player Rating
    playerFrame.playerRating = playerFrame:CreateFontString("KM_PLayerFramePlayerRating", "OVERLAY", "KeyMasterFontBig")
    local Path, _, Flags = playerFrame.playerRating:GetFont()
    playerFrame.playerRating:SetFont(Path, 30, Flags)
    playerFrame.playerRating:SetPoint("TOPRIGHT", playerFrame.playerDetails, "BOTTOMRIGHT", 0, -4)
    playerFrame.playerRating:SetSize(200, 20)
    local ratingColor = {}
    ratingColor.r, ratingColor.g, ratingColor.b, _ = Theme:GetThemeColor("color_HEIRLOOM")
    playerFrame.playerRating:SetTextColor(ratingColor.r, ratingColor.g, ratingColor.b, 1)
    playerFrame.playerRating:SetText("")
    playerFrame.playerRating:SetJustifyH("RIGHT")

    -- Realm Name
    playerFrame.realmName = playerFrame:CreateFontString("KM_PlayerFrameRealmName", "OVERLAY", "KeyMasterFontSmall")
    playerFrame.realmName:SetPoint("TOPRIGHT", playerFrame.playerRating, "BOTTOMRIGHT", 0, -2)
    playerFrame.realmName:SetJustifyH("RIGHT")
    playerFrame.realmName:SetTextColor(0.3, 0.3, 0.3, 1)
    playerFrame.realmName:SetText(GetRealmName())

    return playerFrame
end

local function toggleCharactersFrame(self)
    local charactersFrame = _G["KM_CharacterSelectFrame"]
    if charactersFrame then
        if charactersFrame:IsShown() then
            charactersFrame:Hide()
            
            CharacterData:SetSelectedCharacterGUID(UnitGUID("player"))
            PlayerFrameMapping:RefreshData(false)
            
            self.text:SetText(KeyMasterLocals.PLAYERFRAME["Characters"])
            _G["KeyMaster_MainFrameTab1"]:SetText(KeyMasterLocals.TABPLAYER)
        else
            charactersFrame:Show()
            self.text:SetText(KeyMasterLocals.TABPLAYER)
            _G["KeyMaster_MainFrameTab1"]:SetText(KeyMasterLocals.PLAYERFRAME["Characters"])
            
        end
    end
end


local keyLevelOffsetx = 75
local keyLevelOffsety = 2
local affixScoreOffsetx = 135
local affixScoreOffsety = 8
local affixBonusOffsetx = 0
local affixBonusOffsety = 0
local afffixRuntimeOffsetx = 135
local afffixRuntimeOffsety = -6
local doOnce = 0

function PlayerFrame:CreateMapData(parentFrame, contentFrame)
    local mtb = 4 -- margin top/bottom
    local mr = 4 -- margin right
    local mapFrameHeaderHeight = 25
    local mapFrameWIdthPercent = 0.7

    -- Maps Panel
    local playerInformationFrame = CreateFrame("Frame", "KM_PlayerMapInfo", parentFrame)
    playerInformationFrame:SetSize((parentFrame:GetWidth()*mapFrameWIdthPercent)+mr, (contentFrame:GetHeight() - parentFrame:GetHeight()) - (mtb*2))
    playerInformationFrame:SetPoint("TOPLEFT", parentFrame, "BOTTOMLEFT", 0, 0)

    local count = -8
    local prevFrame
    local prevRowAnchor
    local mapFrameWidth = playerInformationFrame:GetWidth() - mr
    local firstRowId

    -- Header row
    local mapHeaderFrame = CreateFrame("Frame", "KM_PlayerFrameMapInfoHeader", playerInformationFrame)
    mapHeaderFrame:SetPoint("TOPLEFT", playerInformationFrame, "TOPLEFT", 0,-mtb)
    mapHeaderFrame:SetSize(mapFrameWidth-mr, mapFrameHeaderHeight-mtb)
    mapHeaderFrame:SetFrameLevel(playerInformationFrame:GetFrameLevel()+1)
    mapHeaderFrame.divider1 = mapHeaderFrame:CreateTexture()
    mapHeaderFrame.divider1:SetSize(32, 18)
    mapHeaderFrame.divider1:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Bar-Seperator-32", false)
    mapHeaderFrame.divider1:SetAlpha(0.3)

    mapHeaderFrame.texture = mapHeaderFrame:CreateTexture(nil, "BACKGROUND", nil, 0)
    mapHeaderFrame.texture:SetAllPoints(mapHeaderFrame)
    mapHeaderFrame.texture:SetColorTexture(0, 0, 0, 1)

    mapHeaderFrame.textureHighlight = mapHeaderFrame:CreateTexture(nil, "OVERLAY", nil)
    mapHeaderFrame.textureHighlight:SetPoint("TOPLEFT", mapHeaderFrame, "TOPLEFT")
    mapHeaderFrame.textureHighlight:SetSize(mapHeaderFrame:GetWidth(), 64)
    mapHeaderFrame.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    local headerColor = {}  
    headerColor.r, headerColor.g, headerColor.b, _ = getColor("color_NONPHOTOBLUE")
    mapHeaderFrame.textureHighlight:SetVertexColor(headerColor.r, headerColor.g, headerColor.b, 0.6)
    mapHeaderFrame.textureHighlight:SetRotation(math.pi)

    mapHeaderFrame.tyranText = mapHeaderFrame:CreateFontString("KM_PlayerFrame_TyranTitle", "OVERLAY", "KeyMasterFontBig")
    local Path, _, Flags = mapHeaderFrame.tyranText:GetFont()
    mapHeaderFrame.tyranText:SetJustifyH("RIGHT")
    mapHeaderFrame.tyranText:SetText(KeyMasterLocals.TYRANNICAL)

    mapHeaderFrame.fortText = mapHeaderFrame:CreateFontString("KM_PlayerFrame_FortTitle", "OVERLAY", "KeyMasterFontBig")
    mapHeaderFrame.fortText:SetJustifyH("LEFT")
    mapHeaderFrame.fortText:SetText(KeyMasterLocals.FORTIFIED)

    if KeyMaster:GetTableLength(KeyMaster_C_DB) > 0 then
        local btnOptions = {}
        btnOptions.name = "KM_CharactersButton"
        btnOptions.text = KeyMasterLocals.PLAYERFRAME["Characters"]

        local charactersButton = Factory:Create(mapHeaderFrame,"Button", btnOptions)

        charactersButton:SetPoint("LEFT", mapHeaderFrame, "LEFT", 4, 0)
        charactersButton:SetScript("OnClick", toggleCharactersFrame)
    end

    local seasonMaps = DungeonTools:GetCurrentSeasonMaps()
    local mapCount = KeyMaster:GetTableLength(seasonMaps)
    local mapRowHeight = (((playerInformationFrame:GetHeight() - (mapHeaderFrame:GetHeight() + mtb))/ mapCount)) - mtb    

    -- Instance Cards
    for mapId in pairs (seasonMaps) do
        local mapFrame = CreateFrame("Frame", "KM_PlayerFrameMapInfo"..mapId, mapHeaderFrame)
        mapFrame:SetAttribute("mapId", mapId)
        mapFrame:SetSize(mapFrameWidth-mr, mapRowHeight)
        if count == -8 then
            mapFrame:SetPoint("TOPLEFT", mapHeaderFrame, "BOTTOMLEFT", 0, -mtb)
            mapFrame:SetFrameLevel(playerInformationFrame:GetFrameLevel()+1)
            prevRowAnchor = mapFrame
        else
            mapFrame:SetPoint("TOP", prevFrame, "BOTTOM", 0, -mtb)
            mapFrame:SetFrameLevel(prevRowAnchor:GetFrameLevel()+1)
        end

        local Hline = KeyMaster:CreateHLine(mapFrame:GetWidth()+8, mapFrame, "TOP", 0, 0)
        Hline:SetAlpha(0.5)

        local highlightAlpha = 0.5
        mapFrame.textureHighlight = mapFrame:CreateTexture(nil, "BACKGROUND", nil, 1)
        mapFrame.textureHighlight:SetSize(mapFrame:GetWidth(), mapFrame:GetHeight())
        mapFrame.textureHighlight:SetPoint("LEFT", mapFrame, "LEFT", 0, 0)
        mapFrame.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
        mapFrame.textureHighlight:SetAlpha(highlightAlpha)
        local hlColor = {}
        local hlColorString = "color_COMMON"
        hlColor.r, hlColor.g, hlColor.b, _ = Theme:GetThemeColor(hlColorString)
        mapFrame.textureHighlight:SetVertexColor(hlColor.r,hlColor.g,hlColor.b, highlightAlpha)
        mapFrame:SetAttribute("highlight", mapFrame.textureHighlight)
        mapFrame:SetAttribute("defColor", hlColorString)
        mapFrame:SetAttribute("defAlpha", highlightAlpha)

        local dataFrame = CreateFrame("Frame", "KM_PlayerFrame_Data"..mapId, mapFrame)
        dataFrame:SetPoint("LEFT", mapFrame, "LEFT", 0, 0)
        dataFrame:SetSize(mapFrame:GetWidth(), mapFrame:GetHeight())

        -- map image base size 128x128
        local mapImageRatio = 2.666666666666667 -- set pre-calculated aspect ratio because image data doesn't include size
        local mapImageDisplaySize = mapImageRatio * mapRowHeight
        dataFrame.maskTexture = dataFrame:CreateMaskTexture()
        dataFrame.maskTexture:SetPoint("TOPLEFT", dataFrame, "TOPLEFT", -4, 4)
        dataFrame.maskTexture:SetSize(mapImageDisplaySize, mapImageDisplaySize)
        dataFrame.maskTexture:SetTexture("Interface\\AddOns\\KeyMaster\\Assets\\Images\\Player-Frame-Map-Mask2-128")
        dataFrame.texturemap = dataFrame:CreateTexture(nil, "ARTWORK", nil, 0)
        dataFrame.texturemap:SetPoint("TOPLEFT", dataFrame, "TOPLEFT", -4, 30)
        dataFrame.texturemap:SetSize(mapImageDisplaySize, mapImageDisplaySize)
        dataFrame.texturemap:SetTexture(seasonMaps[mapId].texture)
        dataFrame.texturemap:AddMaskTexture(dataFrame.maskTexture)
        dataFrame.texturemap:SetAlpha(1)

        dataFrame.dungeonName = dataFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
        dataFrame.dungeonName:SetPoint("TOPLEFT", dataFrame, "TOPLEFT", 4, -4)
        dataFrame.dungeonName:SetSize(140, 22)
        dataFrame.dungeonName:SetJustifyV("TOP")
        dataFrame.dungeonName:SetJustifyH("LEFT")
        local shortenBlizzardsStupidLongInstanceNames = shortenDungeonName(seasonMaps[mapId].name)
        dataFrame.dungeonName:SetText(shortenBlizzardsStupidLongInstanceNames)
        dataFrame.dungeonNametexture = dataFrame:CreateTexture(nil, "OVERLAY", nil, 0)
        dataFrame.dungeonNametexture:SetPoint("TOPLEFT", dataFrame, "TOPLEFT", 0, 0)
        dataFrame.dungeonNametexture:SetSize(140, 21)
        dataFrame.dungeonNametexture:SetTexture("Interface\\AddOns\\KeyMaster\\Assets\\Images\\Title-BG2")
        dataFrame.dungeonNametexture:SetTexCoord(0, 1, 22/64, 1 )
        dataFrame.dungeonNametexture:SetAlpha(1)

        dataFrame.overallScore = dataFrame:CreateFontString("KM_PlayerFrame"..mapId.."_Overall", "OVERLAY", "KeyMasterFontNormal")
        dataFrame.overallScore:SetPoint("CENTER", dataFrame, "CENTER", 65, 0)
        dataFrame.overallScore:SetJustifyV("CENTER")
        local Path, _, Flags = dataFrame.overallScore:GetFont()
        dataFrame.overallScore:SetFont(Path, 24, Flags)
        local OverallColor = {}
        OverallColor.r, OverallColor.g, OverallColor.b, _ = Theme:GetThemeColor("color_HEIRLOOM")
        dataFrame.overallScore:SetTextColor(OverallColor.r, OverallColor.g, OverallColor.b, 1)
        dataFrame.overallScore:SetText("")

        --dataFrame:Events
        mapFrame:SetScript("OnMouseUp", mapdData_OnRowClick)
        mapFrame:SetScript("OnEnter", mapData_onmouseover)
        mapFrame:SetScript("OnLeave", mapData_onmouseout)

        local scoreColor = {}
        scoreColor.r, scoreColor.g, scoreColor.b, _ = Theme:GetThemeColor("color_TAUPE")

        --///// TYRANNICAL /////--
        -- Tyrannical Key Level
        dataFrame.tyrannicalLevel = dataFrame:CreateFontString("KM_PlayerFrameTyranLevel"..mapId, "OVERLAY", "KeyMasterFontBig")
        dataFrame.tyrannicalLevel:SetPoint("RIGHT",dataFrame.overallScore, "CENTER", -keyLevelOffsetx, keyLevelOffsety)
        local Path, _, Flags = dataFrame.tyrannicalLevel:GetFont()
        dataFrame.tyrannicalLevel:SetFont(Path, 24, Flags)
        dataFrame.tyrannicalLevel:SetJustifyH("RIGHT")
        dataFrame.tyrannicalLevel:SetText("")

        -- Tyrannical Bonus Time
        dataFrame.tyrannicalBonus = dataFrame:CreateFontString("KM_PlayerFrameTyranBonus"..mapId, "OVERLAY", "KeyMasterFontBig")
        dataFrame.tyrannicalBonus:SetPoint("RIGHT", dataFrame.tyrannicalLevel, "LEFT", affixBonusOffsetx, affixBonusOffsety)
        dataFrame.tyrannicalBonus:SetJustifyH("RIGHT")
        dataFrame.tyrannicalBonus:SetText("")

        -- Tyrannical Score
        dataFrame.tyrannicalScore = dataFrame:CreateFontString("KM_PlayerFrameTyranScore"..mapId, "OVERLAY", "KeyMasterFontBig")
        dataFrame.tyrannicalScore:SetPoint("RIGHT", dataFrame.overallScore, "CENTER", -affixScoreOffsetx, affixScoreOffsety)
        dataFrame.tyrannicalScore:SetJustifyH("RIGHT")
        dataFrame.tyrannicalScore:SetJustifyV("BOTTOM")
        dataFrame.tyrannicalScore:SetTextColor(scoreColor.r, scoreColor.g, scoreColor.b, 1)
        dataFrame.tyrannicalScore:SetText("")

        -- Tyrannical RunTime
        dataFrame.tyrannicalRunTime = dataFrame:CreateFontString("KM_PlayerFrameTyranRunTime"..mapId, "OVERLAY", "KeyMasterFontBig")
        dataFrame.tyrannicalRunTime:SetPoint("RIGHT", dataFrame.overallScore, "CENTER", -afffixRuntimeOffsetx, afffixRuntimeOffsety)
        dataFrame.tyrannicalScore:SetJustifyH("RIGHT")
        dataFrame.tyrannicalScore:SetJustifyV("TOP")
        dataFrame.tyrannicalRunTime:SetText("") 

        --///// FORTIFIED /////--
        -- Fortified Key Level
        dataFrame.fortifiedLevel = dataFrame:CreateFontString("KM_PlayerFrameFortLevel"..mapId, "OVERLAY", "KeyMasterFontBig")
        dataFrame.fortifiedLevel:SetPoint("LEFT", dataFrame.overallScore, "CENTER", keyLevelOffsetx, keyLevelOffsety)
        local Path, _, Flags = dataFrame.fortifiedLevel:GetFont()
        dataFrame.fortifiedLevel:SetFont(Path, 24, Flags)
        dataFrame.fortifiedLevel:SetJustifyH("LEFT")
        dataFrame.fortifiedLevel:SetText("")

        -- Fortified Bonus Time
        dataFrame.fortifiedBonus = dataFrame:CreateFontString("KM_PlayerFrameFortBonus"..mapId, "OVERLAY", "KeyMasterFontBig")
        dataFrame.fortifiedBonus:SetPoint("LEFT", dataFrame.fortifiedLevel, "RIGHT", affixBonusOffsetx, affixBonusOffsety)
        dataFrame.fortifiedBonus:SetJustifyH("LEFT")
        dataFrame.fortifiedBonus:SetText("") 

        -- Fortified Score
        dataFrame.fortifiedScore = dataFrame:CreateFontString("KM_PlayerFrameFortScore"..mapId, "OVERLAY", "KeyMasterFontBig")
        dataFrame.fortifiedScore:SetPoint("LEFT", dataFrame.overallScore, "CENTER", affixScoreOffsetx, affixScoreOffsety)
        dataFrame.fortifiedScore:SetJustifyH("LEFT")
        dataFrame.fortifiedScore:SetTextColor(scoreColor.r, scoreColor.g, scoreColor.b, 1)
        dataFrame.fortifiedScore:SetText("")

        -- Tyrannical RunTime
        dataFrame.fortifiedRunTime = dataFrame:CreateFontString("KM_PlayerFrameFortRunTime"..mapId, "OVERLAY", "KeyMasterFontBig")
        dataFrame.fortifiedRunTime:SetPoint("LEFT",dataFrame.overallScore, "CENTER", afffixRuntimeOffsetx, afffixRuntimeOffsety)
        dataFrame.fortifiedRunTime:SetJustifyH("LEFT")
        dataFrame.fortifiedRunTime:SetJustifyV("TOP")
        dataFrame.fortifiedRunTime:SetText("")

        if (doOnce == 0) then
            local point, relativeTo, relativePoint, xOfs, yOfs = dataFrame.overallScore:GetPoint()
            mapHeaderFrame.divider1:SetPoint("CENTER", mapHeaderFrame, "CENTER", xOfs, 0)
            point, relativeTo, relativePoint, xOfs, yOfs = dataFrame.tyrannicalLevel:GetPoint()
            mapHeaderFrame.tyranText:SetPoint("RIGHT",  mapHeaderFrame.divider1, relativePoint, xOfs, 0)
            point, relativeTo, relativePoint, xOfs, yOfs = dataFrame.fortifiedLevel:GetPoint()
            mapHeaderFrame.fortText:SetPoint("LEFT", mapHeaderFrame.divider1, relativePoint, xOfs, 0)
            doOnce = 1
        end
        prevFrame = mapFrame
        count = count + 1
    end
    
    return playerInformationFrame
end

function PlayerFrame:CreateExtraInfoFrame(parentFrame)
    local mtb = 4
    local mrl = 4
    local topMargin = _G["KM_Player_Frame"]:GetHeight() +  _G["KM_PlayerMapInfo"]:GetHeight() + 4
    local totalHeight = _G["KM_PlayerContentFrame"]:GetHeight() - topMargin
    local extraInfoHeight = totalHeight - mtb
    local extraInfoFrame = CreateFrame("Frame", "KM_PLayerExtraInfo", parentFrame)
    extraInfoFrame:SetPoint("TOPLEFT", parentFrame, "BOTTOMLEFT",mrl,0)
    extraInfoFrame:SetSize(parentFrame:GetWidth()-(mrl*2), extraInfoHeight)

    extraInfoFrame.texture = extraInfoFrame:CreateTexture(nil, "BACKGROUND", nil, 1)
    extraInfoFrame.texture:SetPoint("CENTER", extraInfoFrame, "CENTER")
    extraInfoFrame.texture:SetSize(extraInfoFrame:GetWidth()-1, extraInfoFrame:GetHeight()-1)
    extraInfoFrame.texture:SetColorTexture(0, 0, 0, 1)

    extraInfoFrame.border = extraInfoFrame:CreateTexture(nil, "BACKGROUND", nil, 0)
    extraInfoFrame.border:SetAllPoints(extraInfoFrame)
    local borderColor = {}
    borderColor.r, borderColor.g, borderColor.b, _ = Theme:GetThemeColor("color_DARKGREY")
    extraInfoFrame.border:SetColorTexture(borderColor.r, borderColor.g, borderColor.b, 1)

    return extraInfoFrame
end

function PlayerFrame:CreateMapDetailsFrame(parentFrame, contentFrame)
    local detailsFrame = CreateFrame("Frame", "KM_PlayerFrame_MapDetails", parentFrame)
    detailsFrame:SetPoint("TOPRIGHT", parentFrame, "BOTTOMRIGHT", 0, 0)
    detailsFrame:SetSize(parentFrame:GetWidth() - _G["KM_PlayerMapInfo"]:GetWidth()+4, contentFrame:GetHeight() - parentFrame:GetHeight()-8)

    -- Map Details Frame
    local highlightAlpha = 0.5
    local hlColor = {}
    local hlColorString = "color_NONPHOTOBLUE"
    hlColor.r, hlColor.g, hlColor.b, _ = Theme:GetThemeColor(hlColorString)
    local boxTitler, boxTitleg, boxTitleb, _ = Theme:GetThemeColor("color_NONPHOTOBLUE")

    local mapDetails = CreateFrame("Frame", "KM_MapDetailView", detailsFrame)
    mapDetails:SetPoint("TOP", detailsFrame, "TOP", 0, -4)
    mapDetails:SetSize(detailsFrame:GetWidth(), (detailsFrame:GetHeight()*0.33)-4)

    mapDetails.texture = mapDetails:CreateTexture(nil, "BACKGROUND", nil, 0)
    mapDetails.texture:SetAllPoints(mapDetails)
    mapDetails.texture:SetSize(mapDetails:GetWidth(), mapDetails:GetHeight())
    mapDetails.texture:SetColorTexture(0,0,0,1)

    mapDetails.textureHighlight = mapDetails:CreateTexture(nil, "BACKGROUND", nil, 1)
    mapDetails.textureHighlight:SetSize(mapDetails:GetWidth(), 64)
    mapDetails.textureHighlight:SetPoint("BOTTOMLEFT", mapDetails, "BOTTOMLEFT", 0, 0)
    mapDetails.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    mapDetails.textureHighlight:SetAlpha(highlightAlpha)
    mapDetails.textureHighlight:SetVertexColor(hlColor.r,hlColor.g,hlColor.b, highlightAlpha)

    local Hline = KeyMaster:CreateHLine(mapDetails:GetWidth()+8, mapDetails, "TOP", 0, 0)
    Hline:SetAlpha(0.5)

    mapDetails.InstanceBGMask = mapDetails:CreateMaskTexture()
    mapDetails.InstanceBGMask:SetPoint("TOP", mapDetails, "TOP")
    mapDetails.InstanceBGMask:SetSize(mapDetails:GetWidth(), mapDetails:GetHeight()*0.95)
    mapDetails.InstanceBGMask:SetTexture("Interface/Addons/KeyMaster/Assets/Images/Mask-Grade-128")
    mapDetails.InstanceBGT = mapDetails:CreateTexture(nil, "BACKGROUND", nil, 0)
    local aspect = mapDetails:GetWidth()/mapDetails:GetHeight()
    mapDetails.InstanceBGT:SetSize(mapDetails:GetWidth(), mapDetails:GetHeight()*aspect)
    mapDetails.InstanceBGT:SetPoint("TOP", mapDetails, "TOP", 0, 0)
    mapDetails.InstanceBGT:SetTexture() -- todo: dynamic first map image
    mapDetails.InstanceBGT:SetTexCoord(16/256, 180/256, 20/256, 180/256)
    mapDetails.InstanceBGT:AddMaskTexture(mapDetails.InstanceBGMask)

    mapDetails.MapName = mapDetails:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    mapDetails.MapName:SetPoint("TOP", mapDetails, "TOP", 0, -4)
    local Path, _, Flags = mapDetails.MapName:GetFont()
    mapDetails.MapName:SetFont(Path, 16, Flags)
    mapDetails.MapName:SetText("")-- todo: dynamic first map name

    mapDetails.dungeonNametexture = mapDetails:CreateTexture(nil, "OVERLAY", nil, 0)
    mapDetails.dungeonNametexture:SetPoint("TOP", mapDetails, "TOP", 0, 0)
    mapDetails.dungeonNametexture:SetSize(mapDetails:GetWidth(), 26)
    mapDetails.dungeonNametexture:SetTexture("Interface\\AddOns\\KeyMaster\\Assets\\Images\\Title-BG1")
    mapDetails.dungeonNametexture:SetTexCoord(0, 1, 22/64, 1 )

    local timerOffsetY = 14

    mapDetails.TimeLimit = mapDetails:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    mapDetails.TimeLimit:SetPoint("BOTTOMLEFT", mapDetails, "BOTTOMLEFT", 8, timerOffsetY)
    mapDetails.TimeLimit:SetText("")
    local parr, parg, parb, _ = Theme:GetThemeColor("themeFontColorYellow")
    mapDetails.TimeLimit:SetTextColor(parr, parg, parb, 1)
    mapDetails.TimeLimit:SetJustifyH("LEFT")

    mapDetails.TwoChestTimer = mapDetails:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    mapDetails.TwoChestTimer:SetPoint("BOTTOM", mapDetails, "BOTTOM", 0, timerOffsetY)
    mapDetails.TwoChestTimer:SetText("")
    local twocr, twocg, twocb, _ = Theme:GetThemeColor("themeFontColorGreen1")
    mapDetails.TwoChestTimer:SetTextColor(twocr, twocg, twocb, 1)
    mapDetails.TwoChestTimer:SetJustifyH("LEFT")

    mapDetails.ThreeChestTimer = mapDetails:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    mapDetails.ThreeChestTimer:SetPoint("BOTTOMRIGHT",  mapDetails, "BOTTOMRIGHT", -8, timerOffsetY)
    mapDetails.ThreeChestTimer:SetText("")
    local threecr, threecg,threecb, _ = Theme:GetThemeColor("themeFontColorGreen2")
    mapDetails.ThreeChestTimer:SetTextColor(threecr, threecg, threecb, 1)
    mapDetails.ThreeChestTimer:SetJustifyH("LEFT")

    -- Score Calc
    local scoreCalc = CreateFrame("Frame", "KM_ScoreCalc", detailsFrame)
    scoreCalc:SetPoint("TOP", mapDetails, "BOTTOM", 0, -4)
    scoreCalc:SetSize(detailsFrame:GetWidth(), (detailsFrame:GetHeight()*0.25)-4)
    
    scoreCalc.texture = scoreCalc:CreateTexture(nil, "BACKGROUND", nil, 0)
    scoreCalc.texture:SetAllPoints(scoreCalc)
    scoreCalc.texture:SetSize(scoreCalc:GetWidth(), scoreCalc:GetHeight())
    scoreCalc.texture:SetColorTexture(0,0,0,1)

    scoreCalc.textureHighlight = scoreCalc:CreateTexture(nil, "BACKGROUND", nil, 1)
    scoreCalc.textureHighlight:SetSize(scoreCalc:GetWidth(), 64)
    scoreCalc.textureHighlight:SetPoint("BOTTOMLEFT", scoreCalc, "BOTTOMLEFT", 0, 0)
    scoreCalc.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    scoreCalc.textureHighlight:SetAlpha(highlightAlpha)
    scoreCalc.textureHighlight:SetVertexColor(hlColor.r,hlColor.g,hlColor.b, highlightAlpha)

    local Hline = KeyMaster:CreateHLine(scoreCalc:GetWidth()+8, scoreCalc, "TOP", 0, 0)
    Hline:SetAlpha(0.5)

    scoreCalc.DetailsTitleDesc = scoreCalc:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    scoreCalc.DetailsTitleDesc:SetPoint("TOPLEFT", scoreCalc, "TOPLEFT", 4, -4)
    scoreCalc.DetailsTitleDesc:SetText(KeyMasterLocals.PLAYERFRAME.RatingCalculator.name)
    scoreCalc.DetailsTitleDesc:SetTextColor(boxTitler, boxTitleg, boxTitleb, 1)
    scoreCalc.DetailsTitleDesc:SetJustifyH("LEFT")

    -- ScoreCalc Dungeon Name   
    scoreCalc.DetailsTitle = scoreCalc:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    scoreCalc.DetailsTitle:SetPoint("CENTER", scoreCalc, "TOP", 4, -42)
    scoreCalc.DetailsTitle:SetWidth(scoreCalc:GetWidth())
    scoreCalc.DetailsTitle:SetText("")
    scoreCalc.DetailsTitle:SetJustifyH("LEFT")
    scoreCalc.DetailsTitle:Hide()
    

    local scoreCalcDirection = CreateFrame("Frame", "KM_ScoreCalcDirection", scoreCalc)
    scoreCalcDirection:SetAllPoints(scoreCalc)
    scoreCalcDirection.text = scoreCalcDirection:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    scoreCalcDirection.text:SetPoint("CENTER", scoreCalc, "CENTER", 0, -20)
    scoreCalcDirection.text:SetSize(scoreCalcDirection:GetWidth()-8, scoreCalcDirection:GetHeight()-8)
    local dirColor = {}
    dirColor.r, dirColor.g, dirColor.b, _ = Theme:GetThemeColor("color_POOR")
    scoreCalcDirection.text:SetTextColor(dirColor.r, dirColor.g, dirColor.b, 1)
    scoreCalcDirection.text:SetWordWrap(true)
    scoreCalcDirection.text:SetText(KeyMasterLocals.PLAYERFRAME.EnterKeyLevel.text.." "..KeyMasterLocals.PLAYERFRAME.YourBaseRating.text)

    local scoreCalcScores = CreateFrame("Frame", "KM_ScoreCalcScores", scoreCalc) -- Show/Hide frame for scores
    scoreCalcScores:SetAllPoints(scoreCalc)
   
    local scoreCalcBox = CreateFrame("EditBox", nil, scoreCalc, "InputBoxTemplate");
    scoreCalcBox:SetPoint("TOPRIGHT", scoreCalc, "TOPRIGHT", -4, -(scoreCalc.DetailsTitleDesc:GetHeight()+2));
    scoreCalcBox:SetWidth(24);
    scoreCalcBox:SetHeight(28);
    scoreCalcBox:SetMovable(false);
    scoreCalcBox:SetAutoFocus(false);
    scoreCalcBox:SetMaxLetters(2);
    scoreCalcBox:SetScript("OnEnterPressed", function(self)
        self:ClearFocus() -- clears focus from editbox, (unlocks key bindings, so pressing W makes your character go forward.
        
        local keyLevel = tonumber(self:GetText())
        if keyLevel ~= nil then
            local tyrannicalSelector = _G["TyrannicalSelector"]
            local fortifiedSelector = _G["FortifiedSelector"]
            local selectedWeeklyAffix = nil
            if fortifiedSelector:GetChecked() == true then
                selectedWeeklyAffix = "Fortified"
            elseif tyrannicalSelector:GetChecked() == true then
                selectedWeeklyAffix = "Tyrannical"
            else
                KeyMaster:_ErrorMsg("CalculateRatingGain", "PlayerFrameMapping.lua", "Unable to find ScoreCalcScores frame.")
                selectedWeeklyAffix = DungeonTools:GetWeeklyAffix()
            end
            local mapId = selectedMapId -- set from row click
            
            PlayerFrameMapping:CalculateRatingGain(mapId, keyLevel, selectedWeeklyAffix)
            
            scoreCalcDirection:Hide()
            scoreCalcScores:Show()
        end
        self:SetText("") -- Empties the box, duh! ;)
    end)
    
    scoreCalc.keyLevelTitle = scoreCalc:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    scoreCalc.keyLevelTitle:SetPoint("RIGHT", scoreCalcBox, "LEFT", -8, 0)
    scoreCalc.keyLevelTitle:SetJustifyH("CENTER")
    scoreCalc.keyLevelTitle:SetText(KeyMasterLocals.PLAYERFRAME.KeyLevel.name..":")

    -- Affix Selector
    local affixSelectorFrame = CreateFrame("Frame", nil, scoreCalc)
    affixSelectorFrame:SetPoint("TOPLEFT", scoreCalc.DetailsTitleDesc, "BOTTOMLEFT", 0, -4)
    affixSelectorFrame:SetSize(scoreCalc:GetWidth()/2, 40)

    local tyrannicalSelector = CreateFrame("CheckButton", "TyrannicalSelector", affixSelectorFrame, "UIRadioButtonTemplate")
    local fortifiedSelector = CreateFrame("CheckButton", "FortifiedSelector", affixSelectorFrame, "UIRadioButtonTemplate")

    local function selectTyrannical()
        if (tyrannicalSelector:GetChecked()) == true then
            fortifiedSelector:SetChecked(false)
        else
            fortifiedSelector:SetChecked(true)
        end
    end

    local function selectFortified()
        if (fortifiedSelector:GetChecked()) == true then
            tyrannicalSelector:SetChecked(false)
        else
            tyrannicalSelector:SetChecked(true)
        end
    end

    tyrannicalSelector:SetPoint("TOPLEFT", affixSelectorFrame, "TOPLEFT")
    tyrannicalSelector:SetScript("PostClick", selectTyrannical)

    tyrannicalSelector.text = scoreCalc:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    tyrannicalSelector.text:SetPoint("LEFT", tyrannicalSelector, "RIGHT", 0, 0)
    tyrannicalSelector.text:SetJustifyH("LEFT")
    tyrannicalSelector.text:SetText(KeyMasterLocals.TYRANNICAL)

    fortifiedSelector:SetPoint("TOPLEFT", tyrannicalSelector, "BOTTOMLEFT")
    fortifiedSelector:SetScript("PostClick", selectFortified)


    fortifiedSelector.text = scoreCalc:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    fortifiedSelector.text:SetPoint("LEFT", fortifiedSelector, "RIGHT", 0, 0)
    fortifiedSelector.text:SetJustifyH("LEFT")
    fortifiedSelector.text:SetText(KeyMasterLocals.FORTIFIED)

    -----------------
    scoreCalcScores.divider1 = scoreCalcScores:CreateTexture()
    scoreCalcScores.divider1:SetSize(16, 36)
    scoreCalcScores.divider1:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Bar-Seperator-32", false)
    scoreCalcScores.divider1:SetPoint("BOTTOM", scoreCalcScores, "BOTTOM", 0, 4)
    scoreCalcScores.divider1:SetAlpha(highlightAlpha)

    scoreCalcScores.keyLevel = scoreCalcScores:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    scoreCalcScores.keyLevel:SetPoint("BOTTOM", scoreCalcScores.divider1, "TOP", 0, 4)
    scoreCalcScores.keyLevel:SetJustifyH("CENTER")
    scoreCalcScores.keyLevel:SetText("")

    scoreCalcScores.fortTitleBGBorder = scoreCalcScores:CreateTexture(nil, "BACKGROUND", nil, 1)
    scoreCalcScores.fortTitleBGBorder:SetSize(scoreCalcScores:GetWidth()-6, 20)
    scoreCalcScores.fortTitleBGBorder:SetPoint("CENTER", scoreCalcScores.keyLevel, "CENTER")

    local sclc = {}
    sclc.r, sclc.g, sclc.b, _ = Theme:GetThemeColor("color_HEIRLOOM")
    scoreCalcScores.fortTitleBGBorder:SetColorTexture(1, 1, 1, 0.1)

    scoreCalcScores.ratingGain = scoreCalcScores:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    scoreCalcScores.ratingGain:SetPoint("RIGHT", scoreCalcScores.divider1, "LEFT", 0, -6)
    scoreCalcScores.ratingGain:SetWidth((scoreCalcScores:GetWidth()/2)-scoreCalcScores.divider1:GetWidth())
    local Path, _, Flags = scoreCalcScores.ratingGain:GetFont()
    scoreCalcScores.ratingGain:SetFont(Path, 18, Flags)
    scoreCalcScores.ratingGain:SetJustifyH("CENTER")
    local ratingGainColor = {}
    ratingGainColor.r, ratingGainColor.g, ratingGainColor.b, _ = Theme:GetThemeColor("color_TAUPE")
    scoreCalcScores.ratingGain:SetTextColor(ratingGainColor.r, ratingGainColor.g, ratingGainColor.b, 1)
    scoreCalcScores.ratingGain:SetText("999")

    scoreCalcScores.ratingGainTitle = scoreCalcScores:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    scoreCalcScores.ratingGainTitle:SetPoint("BOTTOM", scoreCalcScores.ratingGain, "TOP", 0, 0)
    scoreCalcScores.ratingGainTitle:SetJustifyH("RIGHT")
    scoreCalcScores.ratingGainTitle:SetText(KeyMasterLocals.PLAYERFRAME.Gain.name)

    scoreCalcScores.newRating = scoreCalcScores:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    scoreCalcScores.newRating:SetPoint("LEFT", scoreCalcScores.divider1, "RIGHT", 0, -6)
    scoreCalcScores.newRating:SetWidth((scoreCalcScores:GetWidth()/2)-scoreCalcScores.divider1:GetWidth())
    local Path, _, Flags = scoreCalcScores.newRating:GetFont()
    scoreCalcScores.newRating:SetFont(Path, 18, Flags)
    scoreCalcScores.newRating:SetJustifyH("CENTER")
    local ratingColor = {}
    ratingColor.r, ratingColor.g, ratingColor.b, _ = Theme:GetThemeColor("color_HEIRLOOM")
    scoreCalcScores.newRating:SetTextColor(ratingColor.r, ratingColor.g, ratingColor.b, 1)
    scoreCalcScores.newRating:SetText("3999")

    scoreCalcScores.newRatingTitle = scoreCalcScores:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    scoreCalcScores.newRatingTitle:SetPoint("BOTTOM", scoreCalcScores.newRating, "TOP", 0, 0)
    scoreCalcScores.newRatingTitle:SetJustifyH("CENTER")
    scoreCalcScores.newRatingTitle:SetText(KeyMasterLocals.PLAYERFRAME.New.name)

    -- Divider box
    local divider = CreateFrame("Frame", nil, detailsFrame)
    divider:SetPoint("TOP", scoreCalc, "BOTTOM", 0, -4)
    divider:SetSize(detailsFrame:GetWidth(), (detailsFrame:GetHeight()*0.02)-4)
    
    divider.texture = divider:CreateTexture(nil, "BACKGROUND", nil, 0)
    divider.texture:SetAllPoints(divider)
    divider.texture:SetSize(divider:GetWidth(), divider:GetHeight())
    divider.texture:SetColorTexture(1, 1, 1, 0.1)

    local Hline = KeyMaster:CreateHLine(divider:GetWidth()+8, divider, "TOP", 0, 0)
    Hline:SetAlpha(0.5)

    -- Vault Details
    local vaultDetails = CreateFrame("Frame", "KM_VaultDetailView", detailsFrame)
    vaultDetails:SetPoint("TOP", divider, "BOTTOM", 0, -4)
    vaultDetails:SetSize(detailsFrame:GetWidth(), (detailsFrame:GetHeight()*0.25)-4)

    vaultDetails.texture = vaultDetails:CreateTexture(nil, "BACKGROUND", nil, 0)
    vaultDetails.texture:SetAllPoints(vaultDetails)
    vaultDetails.texture:SetSize(vaultDetails:GetWidth(), vaultDetails:GetHeight())
    vaultDetails.texture:SetColorTexture(0,0,0,1)

    local Hline = KeyMaster:CreateHLine(vaultDetails:GetWidth()+8, vaultDetails, "TOP", 0, 0)
    Hline:SetAlpha(0.5)

    vaultDetails.textureHighlight = vaultDetails:CreateTexture(nil, "BACKGROUND", nil, 1)
    vaultDetails.textureHighlight:SetSize(vaultDetails:GetWidth(), 64)
    vaultDetails.textureHighlight:SetPoint("BOTTOMLEFT", vaultDetails, "BOTTOMLEFT", 0, 0)
    vaultDetails.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    vaultDetails.textureHighlight:SetAlpha(highlightAlpha)
    vaultDetails.textureHighlight:SetVertexColor(hlColor.r,hlColor.g,hlColor.b, highlightAlpha)


    vaultDetails.DetailsTitle = scoreCalc:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    vaultDetails.DetailsTitle:SetPoint("TOPLEFT", vaultDetails, "TOPLEFT", 4, -4)
    vaultDetails.DetailsTitle:SetTextColor(boxTitler, boxTitleg, boxTitleb, 1)
    vaultDetails.DetailsTitle:SetText(KeyMasterLocals.VAULTINFORMATION)
    vaultDetails.DetailsTitle:SetJustifyH("LEFT")

    vaultDetails.divider1 = vaultDetails:CreateTexture()
    vaultDetails.divider1:SetSize(18, vaultDetails:GetHeight()*0.8)
    vaultDetails.divider1:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Bar-Seperator-32", false)
    vaultDetails.divider1:SetPoint("RIGHT", vaultDetails, "RIGHT", -60, -10)
    vaultDetails.divider1:SetAlpha(0.3)

     -- Empty Box
     local ebox = CreateFrame("Frame", nil, detailsFrame)
     ebox:SetPoint("TOP", vaultDetails, "BOTTOM", 0, -4)
     ebox:SetSize(detailsFrame:GetWidth(), (detailsFrame:GetHeight()*0.15)-4)
     
     ebox.texture = ebox:CreateTexture(nil, "BACKGROUND", nil, 0)
     ebox.texture:SetAllPoints(ebox)
     ebox.texture:SetSize(ebox:GetWidth(), ebox:GetHeight())
     ebox.texture:SetColorTexture(0,0,0,1)
 
     ebox.textureHighlight = ebox:CreateTexture(nil, "BACKGROUND", nil, 1)
     ebox.textureHighlight:SetSize(ebox:GetWidth(), 64)
     ebox.textureHighlight:SetPoint("BOTTOMLEFT", ebox, "BOTTOMLEFT", 0, 0)
     ebox.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
     ebox.textureHighlight:SetAlpha(highlightAlpha)
     ebox.textureHighlight:SetVertexColor(hlColor.r,hlColor.g,hlColor.b, highlightAlpha)
 
     local Hline = KeyMaster:CreateHLine(ebox:GetWidth()+8, ebox, "TOP", 0, 0)
     Hline:SetAlpha(0.5)

    -- setup the initial map details to the first map
    local seasonMaps = DungeonTools:GetCurrentSeasonMaps()
    local mapCount = KeyMaster:GetTableLength(seasonMaps)
    if (mapCount ~= nil and mapCount > 0) then
        local firstMap
        for mapId in pairs(seasonMaps) do
            if (not firstMap) then firstMap = mapId end
        end
        mapdData_OnRowClick(_G["KM_PlayerFrameMapInfo"..firstMap])
    else
        KeyMaster:_ErrorMsg("CreateMapDetailsFrame", "PlayerFrame", "Current season maps is nil.")
    end

    scoreCalcScores:Hide()

end

local function createVaultRow(vaultRowNumber, parentFrame)
    if vaultRowNumber > 3 then
        KeyMaster:_ErrorMsg("CreateVaultRow","PlayerFrame","Too many vault rows! Max of 3!")
        local emptyFrame = CreateFrame("Frame") -- stops hard errors
        return emptyFrame
    end

    local vaultRow = {}
    local vaultRowFrame = parentFrame.vaultRow
    local vaultTitlePadding = 18
    local vaultRowHeight = (parentFrame:GetHeight() - vaultTitlePadding) / 3

    vaultRowFrame = CreateFrame("FRAME", "KM_VaultRow"..vaultRowNumber, parentFrame)
    if (vaultRowNumber == 1) then
        vaultRowFrame:SetPoint("TOP", parentFrame, "TOP", 0, -(vaultTitlePadding))
    else
        vaultRowFrame:SetPoint("TOP", _G[parentFrame:GetAttribute("vault"..(vaultRowNumber-1)):GetName()], "BOTTOM", 0, 0)
    end
    
    vaultRowFrame.vaultComplete = vaultRowFrame:CreateTexture(nil, "OVERLAY")
    vaultRowFrame.vaultComplete:SetPoint("RIGHT", vaultRowFrame, "RIGHT", -2, 0)
    vaultRowFrame.vaultComplete:SetSize(24,24)

    vaultRowFrame:SetSize(parentFrame:GetWidth(), vaultRowHeight)
    vaultRowFrame.vaultTotals = vaultRowFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    vaultRowFrame.vaultTotals:SetPoint("RIGHT", vaultRowFrame.vaultComplete, "LEFT", 0, -1)
    vaultRowFrame.vaultTotals:SetSize(parentFrame:GetWidth()*0.15, vaultRowFrame:GetHeight())
    vaultRowFrame.vaultTotals:SetJustifyV("CENTER")
    vaultRowFrame:SetAttribute("vaultTotals", vaultRowFrame.vaultRuns)
    
    vaultRowFrame.vaultRuns = vaultRowFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    vaultRowFrame.vaultRuns:SetPoint("LEFT", vaultRowFrame, "LEFT", 4, -1)
    vaultRowFrame.vaultRuns:SetSize(vaultRowFrame:GetWidth()*0.62, vaultRowFrame:GetHeight()-4)
    local Path, _, Flags = vaultRowFrame.vaultRuns:GetFont()
    vaultRowFrame.vaultRuns:SetFont(Path, 16, Flags)
    vaultRowFrame.vaultRuns:SetJustifyH("RIGHT")
    vaultRowFrame.vaultRuns:SetJustifyV("CENTER")
    vaultRowFrame:SetAttribute("vaultRuns", vaultRowFrame.vaultRuns)

    parentFrame:SetAttribute("vault"..vaultRowNumber,  vaultRowFrame)

    return vaultRowFrame
end

-- creates the entire player frame and sub-frames
function PlayerFrame:Initialize(parentFrame)
    -- Player Tab
    local playerContent = _G["KM_PlayerContentFrame"] or PlayerFrame:CreatePlayerContentFrame(parentFrame)
    local playerFrame = _G["KM_Player_Frame"] or PlayerFrame:CreatePlayerFrame(playerContent)
    local playerMapFrame = _G["KM_PlayerMapInfo"] or PlayerFrame:CreateMapData(playerFrame, playerContent)
    local PlayerFrameMapDetails = _G["KM_PlayerFrame_MapDetails"] or PlayerFrame:CreateMapDetailsFrame(playerFrame, playerContent)

    -- Mythic Vault Progress
    local vaultDetails = _G["KM_VaultDetailView"]
    local MythicPlusEventTypeId = 1
    for i=1,3 do
        local vaultRow = createVaultRow(i, vaultDetails)
    end
    
    return playerContent
end