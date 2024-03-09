local _, KeyMaster = ...
local PlayerFrame = {}
KeyMaster.PlayerFrame = PlayerFrame
local CharacterInfo = KeyMaster.CharacterInfo
local Theme = KeyMaster.Theme
local DungeonTools = KeyMaster.DungeonTools
local MainInterface = KeyMaster.MainInterface
local PlayerFrameMapping = KeyMaster.PlayerFrameMapping

local seasonMaps = DungeonTools:GetCurrentSeasonMaps()
local mapCount = KeyMaster:GetTableLength(seasonMaps)

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

-- NOT SURE IF THIS WORKS
local function getInstances(tier)
    EJ_SelectTier(tier); -- sets dungeon journal data to current tier data
    local instances = {}
    local dataIndex = 1;
	local instanceID, name, description, _, buttonImage, _, _, _, link, _, mapID = EJ_GetInstanceByIndex(dataIndex, false);

	while instanceID ~= nil do
		tinsert(instances,
        {
			instanceID = instanceID,
			name = name,
			description = description,
			buttonImage = buttonImage,
			link = link,
			mapID = mapID,
		});

		dataIndex = dataIndex + 1;
		instanceID, name, description, _, buttonImage, _, _, _, link, _, mapID = EJ_GetInstanceByIndex(dataIndex, false);
	end

    return instances
end

-- NOT SURE IF THIS WORKS
local function showDungeonJournal()
    local mythicPlusDifficultiyId = 8
    local currentTier = EJ_GetCurrentTier()
    local instances = getInstances(currentTier)
    if (not EncounterJournal_OpenJournal) then
        UIParentLoadAddOn('Blizzard_EncounterJournal')
    end
    EncounterJournal_OpenJournal(mythicPlusDifficultiyId, instances[1].instanceID) -- Throws blizzard only action error   
end

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
        animFrame.textureportal:SetAlpha(1)
        animFrame.animg:Play()
    else
        local cdFrame = self:GetParent():GetAttribute("portalCooldownFrame")
        cdFrame:SetCooldown(start ,dur)
    end

end

local function portalButton_mouseoout(self, event, ...)
    local animFrame = self:GetParent():GetAttribute("portalFrame")
    animFrame.textureportal:SetTexture("Interface\\AddOns\\KeyMaster\\Assets\\Images\\Dungeon-Portal-Active", false)
    animFrame.textureportal:SetAlpha(0.6)
    animFrame.animg:Stop()
    local cdFrame = self:GetParent():GetAttribute("portalCooldownFrame")
    cdFrame:SetCooldown(0 ,0)
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
    hlColor.r,hlColor.g,hlColor.b, _ = getColor("color_HEIRLOOM")
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
local function mapdData_OnRowClick(self, event)
    local selectedMapId = self:GetAttribute("mapId")
    local mapDetailsFrame = _G["KM_MapDetailView"]
    local dungeonName = shortenDungeonName(seasonMaps[selectedMapId].name)
    
    if mapDetailsFrame.MapName:GetText() ~= dungeonName then        
        mapDetailsFrame.MapName:SetText(dungeonName) 
        mapDetailsFrame.InstanceBGT:SetTexture(seasonMaps[selectedMapId].backgroundTexture)

        local timers = DungeonTools:GetChestTimers(selectedMapId)
        mapDetailsFrame.TimeLimit:SetText(KeyMaster:FormatDurationSec(timers["1chest"]))
        mapDetailsFrame.TwoChestTimer:SetText(KeyMaster:FormatDurationSec(timers["2chest"])) -- todo: add frame
        mapDetailsFrame.ThreeChestTimer:SetText(KeyMaster:FormatDurationSec(timers["3chest"])) -- todo: add frame
    end
end

function PlayerFrame:CreatePlayerContentFrame(parentFrame)
    local playerContentFrame = CreateFrame("Frame", "KM_PlayerContentFrame", parentFrame)
    playerContentFrame:SetSize(parentFrame:GetWidth(), parentFrame:GetHeight())
    playerContentFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT")
    return playerContentFrame
end

function PlayerFrame:CreatePlayerFrame(parentFrame)

    local playerFrame = CreateFrame("Frame", "KM_Player_Frame",parentFrame)
    --playerFrame:SetAllPoints(parentFrame)
    playerFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 4, -4)
    playerFrame:SetSize(parentFrame:GetWidth()-8, 100)
    playerFrame.texture = playerFrame:CreateTexture(nil, "BACKGROUND", nil, 0)
    playerFrame.texture:SetAllPoints(playerFrame)
    playerFrame.texture:SetColorTexture(0, 0, 0, 1)
    playerFrame:SetScript("OnShow", function(self)
        PlayerFrameMapping:RefreshData()
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

    local playerFrameHighlight = CreateFrame("Frame", nil ,playerFrame)
    playerFrameHighlight:SetFrameLevel(modelFrame:GetFrameLevel()+1)
    playerFrameHighlight:SetPoint("TOPLEFT")
    playerFrameHighlight:SetSize(playerFrame:GetWidth(), playerFrame:GetHeight())
    playerFrameHighlight.textureHighlight = playerFrame:CreateTexture(nil, "OVERLAY", nil)
    playerFrameHighlight.textureHighlight:SetSize(playerFrame:GetWidth(), playerFrame:GetHeight())
    playerFrameHighlight.textureHighlight:SetPoint("LEFT", playerFrame, "LEFT", 0, 0)
    playerFrameHighlight.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    local unitClassForColor
    _, unitClassForColor, _ = UnitClass("player")
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
    playerFrame.playerNameLarge:SetAlpha(0.08)
    playerFrame.playerNameLarge:SetJustifyH("LEFT")

    -- Season ID
    local seasonNum = DungeonTools:GetCurrentSeason()
    if (seasonNum ~= nil and seasonNum > 0) then
        playerFrame.SeasonInformation = playerFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontDieDieDieBig")
        local Path, _, Flags = playerFrame.SeasonInformation:GetFont()
        playerFrame.SeasonInformation:SetFont(Path, 60, Flags)
        playerFrame.SeasonInformation:SetPoint("CENTER", playerFrame, "CENTER", -20, -12)
        playerFrame.SeasonInformation:SetAlpha(0.3)
        playerFrame.SeasonInformation:SetText(KeyMasterLocals.SEASON.." "..seasonNum)
    end

    -- Player Specialization and Class
    playerFrame.playerDetails = playerFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    local _, Size, _ = playerFrame.playerDetails:GetFont()
    --playerFrame.playerDetails:SetFont(Path, 20, Flags)
    playerFrame.playerDetails:SetPoint("TOPRIGHT", playerFrame.playerName, "BOTTOMRIGHT", 0, 0)
    playerFrame.playerDetails:SetSize(200, Size)
    --local hexColor = CharacterInfo:GetMyClassColor("player")
    local currentSpec = GetSpecialization()
    local currentSpecName = currentSpec and select(2, GetSpecializationInfo(currentSpec)) or "None"
    playerFrame.playerDetails:SetText("\'"..currentSpecName.."\'".." "..UnitClass("player"))
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
    --[[ playerInformationFrame.texture = playerInformationFrame:CreateTexture()
    playerInformationFrame.texture:SetAllPoints(playerInformationFrame)
    playerInformationFrame.texture:SetColorTexture(1, 1, 1, 0.6) ]]

    local count = -8
    local prevFrame
    local prevRowAnchor
    local mapFrameWidth = playerInformationFrame:GetWidth() - mr
    local firstRowId

    -- Header row
    local mapHeaderFrame = CreateFrame("Frame", "KM_PlayerFrameMapInfoHeader", playerInformationFrame)
    mapHeaderFrame:SetPoint("TOPLEFT", playerInformationFrame, "TOPLEFT", 0,-mtb)
    mapHeaderFrame:SetSize(mapFrameWidth-mr, mapFrameHeaderHeight)
    mapHeaderFrame:SetFrameLevel(playerInformationFrame:GetFrameLevel()+1)
    --[[ mapHeaderFrame.divider1 = mapHeaderFrame:CreateTexture()
    mapHeaderFrame.divider1:SetPoint("CENTER", mapHeaderFrame, "CENTER", 0, 0)
    mapHeaderFrame.divider1:SetSize(32, 32)
    mapHeaderFrame.divider1:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Bar-Seperator-32", false)
    mapHeaderFrame.divider1:SetAlpha(0.3) ]]

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
    --mapHeaderFrame.tyranText:SetPoint("LEFT", mapHeaderFrame, "LEFT", 8, 0)
    local Path, _, Flags = mapHeaderFrame.tyranText:GetFont()
    mapHeaderFrame.tyranText:SetFont(Path, 18, Flags)
    mapHeaderFrame.tyranText:SetJustifyH("RIGHT")
    mapHeaderFrame.tyranText:SetText(string.upper(KeyMasterLocals.TYRANNICAL))

    mapHeaderFrame.fortText = mapHeaderFrame:CreateFontString("KM_PlayerFrame_TyranTitle", "OVERLAY", "KeyMasterFontBig")
    --mapHeaderFrame.fortText:SetPoint("RIGHT", mapHeaderFrame, "RIGHT", -64, 0)
    mapHeaderFrame.fortText:SetFont(mapHeaderFrame.tyranText:GetFont())
    mapHeaderFrame.fortText:SetJustifyH("LEFT")
    mapHeaderFrame.fortText:SetText(string.upper(KeyMasterLocals.FORTIFIED))


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

        KeyMaster:CreateHLine(mapFrame:GetWidth()+8, mapFrame, "TOP", 0, 0)

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
        mapFrame.texture = mapFrame:CreateTexture(nil, "BACKGROUND", nil, 0)
        mapFrame.texture:SetAllPoints(mapFrame)
        mapFrame.texture:SetColorTexture(0, 0, 0, 1)


        --[[ mapFrame.nameBackground = mapFrame:CreateTexture()
        mapFrame.nameBackground:SetPoint("TOP", mapFrame, "TOP")
        mapFrame.nameBackground:SetSize(mapFrame:GetWidth(), 25)
        mapFrame.nameBackground:SetColorTexture(0,0,0, 0.9)
        mapFrame.texture = mapFrame:CreateTexture(nil, "OVERLAY")
        mapFrame.texture:SetSize(mapFrame:GetWidth(), mapFrame:GetHeight())
        mapFrame.texture:SetPoint("TOP")
        mapFrame.texture:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Map-Overlay")
        mapFrame.texture:SetAlpha(0.9) ]]

        local dataFrame = CreateFrame("Frame", "KM_PlayerFrame_Data"..mapId, mapFrame)
        dataFrame:SetPoint("LEFT", mapFrame, "LEFT", 0, 0)
        dataFrame:SetSize(mapFrame:GetWidth()-mapFrame:GetHeight()-5, mapFrame:GetHeight())

        -- map image base size 128x128
        local mapImageRatio = 2.666666666666667 -- set pre-calculated aspect ratio because image data doesn't include size
        local mapImageDisplaySize = mapImageRatio * mapRowHeight
        dataFrame.maskTexture = dataFrame:CreateMaskTexture()
        dataFrame.maskTexture:SetPoint("TOP", dataFrame, "TOP", -4, 4)
        dataFrame.maskTexture:SetSize(mapImageDisplaySize, mapImageDisplaySize)
        dataFrame.maskTexture:SetTexture("Interface\\AddOns\\KeyMaster\\Assets\\Images\\Player-Frame-Map-Mask2-128")
        dataFrame.texturemap = dataFrame:CreateTexture(nil, "ARTWORK", nil, 0)
        dataFrame.texturemap:SetPoint("TOP", dataFrame, "TOP", -4, 40)
        dataFrame.texturemap:SetSize(mapImageDisplaySize, mapImageDisplaySize)
        dataFrame.texturemap:SetTexture(seasonMaps[mapId].texture)
        dataFrame.texturemap:AddMaskTexture(dataFrame.maskTexture)
        dataFrame.texturemap:SetAlpha(1)

        dataFrame.dungeonName = dataFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
        dataFrame.dungeonName:SetPoint("TOP", dataFrame, "TOP", 0, -4)
        dataFrame.dungeonName:SetSize(140, 22)
        dataFrame.dungeonName:SetJustifyV("TOP")
        --mapFrame.dungeonName:SetJustifyH("LEFT")
        local shortenBlizzardsStupidLongInstanceNames = shortenDungeonName(seasonMaps[mapId].name)
        dataFrame.dungeonName:SetText(shortenBlizzardsStupidLongInstanceNames)
        dataFrame.dungeonNametexture = dataFrame:CreateTexture(nil, "OVERLAY", nil, 0)
        dataFrame.dungeonNametexture:SetPoint("TOP", dataFrame, "TOP", 0, 0)
        --dataFrame.dungeonNametexture:SetAllPoints(dataFrame.dungeonName)
        dataFrame.dungeonNametexture:SetSize(140, 21)
        dataFrame.dungeonNametexture:SetTexture("Interface\\AddOns\\KeyMaster\\Assets\\Images\\Title-BG1")
        dataFrame.dungeonNametexture:SetTexCoord(0, 1, 22/64, 1 )
        --dataFrame.dungeonNametexture:SetColorTexture(0, 0, 0, 0.6)

        --KeyMaster:CreateHLine(140, dataFrame, "CENTER", 0, 2)

        dataFrame.overallScore = dataFrame:CreateFontString("KM_PlayerFrame"..mapId.."_Overall", "OVERLAY", "KeyMasterFontNormal")
        dataFrame.overallScore:SetPoint("BOTTOM", dataFrame, "BOTTOM", 0, 0)
        dataFrame.overallScore:SetJustifyV("BOTTOM")
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
            
        --[[ dataFrame.texture = dataFrame:CreateTexture()
        dataFrame.texture:SetAllPoints(dataFrame)
        dataFrame.texture:SetColorTexture(1, 1, 1, 0.3) ]]

        -- Portal Frame
        local portalFrameSquare = mapFrame:GetHeight()
        local portalFrame = CreateFrame("Frame", nil, mapFrame)
        portalFrame:SetFrameLevel(dataFrame:GetFrameLevel()+1)
        portalFrame:SetPoint("TOPRIGHT", mapFrame, "TOPRIGHT", -4, 0)
        portalFrame:SetSize(portalFrameSquare, portalFrameSquare)
        
        --[[ portalFrame.texture = portalFrame:CreateTexture()
        portalFrame.texture:SetAllPoints(portalFrame)
        portalFrame.texture:SetColorTexture(1, 1, 1, 0.6) ]]

        dataFrame.divider1 = dataFrame:CreateTexture()
        dataFrame.divider1:SetPoint("CENTER", portalFrame, "LEFT", -4, 0)
        dataFrame.divider1:SetSize(dataFrame:GetHeight(), dataFrame:GetHeight())
        dataFrame.divider1:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Bar-Seperator-32", false)
        dataFrame.divider1:SetAlpha(0.3)

        --[[ dataFrame.divider2 = dataFrame:CreateTexture("KM_RowDivider"..mapId)
        dataFrame.divider2:SetPoint("CENTER", dataFrame, "CENTER", -portalFrame:GetWidth(), 0)
        dataFrame.divider2:SetSize(dataFrame:GetHeight(), dataFrame:GetHeight())
        dataFrame.divider2:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Bar-Seperator-32", false)
        dataFrame.divider2:SetAlpha(0.3) ]]

        --///// TYRANNICAL /////--
        -- Tyrannical Key Level
        dataFrame.tyrannicalLevel = dataFrame:CreateFontString("KM_PlayerFrameTyranLevel"..mapId, "OVERLAY", "KeyMasterFontBig")
        dataFrame.tyrannicalLevel:SetPoint("RIGHT",dataFrame.texturemap, "CENTER", -keyLevelOffsetx, keyLevelOffsety)
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
        dataFrame.tyrannicalScore:SetPoint("RIGHT", dataFrame.texturemap, "CENTER", -affixScoreOffsetx, affixScoreOffsety)
        dataFrame.tyrannicalScore:SetJustifyH("RIGHT")
        dataFrame.tyrannicalScore:SetJustifyV("BOTTOM")
        dataFrame.tyrannicalScore:SetText("")

        -- Tyrannical RunTime
        dataFrame.tyrannicalRunTime = dataFrame:CreateFontString("KM_PlayerFrameTyranRunTime"..mapId, "OVERLAY", "KeyMasterFontBig")
        dataFrame.tyrannicalRunTime:SetPoint("RIGHT", dataFrame.texturemap, "CENTER", -afffixRuntimeOffsetx, afffixRuntimeOffsety)
        dataFrame.tyrannicalScore:SetJustifyH("RIGHT")
        dataFrame.tyrannicalScore:SetJustifyV("TOP")
        dataFrame.tyrannicalRunTime:SetText("") 

        --///// FORTIFIED /////--
        -- Fortified Key Level
        dataFrame.fortifiedLevel = dataFrame:CreateFontString("KM_PlayerFrameFortLevel"..mapId, "OVERLAY", "KeyMasterFontBig")
        dataFrame.fortifiedLevel:SetPoint("LEFT", dataFrame.texturemap, "CENTER", keyLevelOffsetx, keyLevelOffsety)
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
        dataFrame.fortifiedScore:SetPoint("LEFT", dataFrame.texturemap, "CENTER", affixScoreOffsetx, affixScoreOffsety)
        dataFrame.fortifiedScore:SetJustifyH("LEFT")
        dataFrame.fortifiedScore:SetText("")

        -- Tyrannical RunTime
        dataFrame.fortifiedRunTime = dataFrame:CreateFontString("KM_PlayerFrameFortRunTime"..mapId, "OVERLAY", "KeyMasterFontBig")
        dataFrame.fortifiedRunTime:SetPoint("LEFT",dataFrame.texturemap, "CENTER", afffixRuntimeOffsetx, afffixRuntimeOffsety)
        dataFrame.fortifiedRunTime:SetJustifyH("LEFT")
        dataFrame.fortifiedRunTime:SetJustifyV("TOP")
        dataFrame.fortifiedRunTime:SetText("")

        --[[ currentWeekBestLevel, weeklyRewardLevel, nextDifficultyWeeklyRewardLevel, nextBestLevel = C_MythicPlus.GetWeeklyChestRewardLevel()
        print("currentWeekBestLevel: "..currentWeekBestLevel)
        print("weeklyRewardLevel: " ..weeklyRewardLevel)
        print("nextDifficultyWeeklyRewardLevel: ".. nextDifficultyWeeklyRewardLevel)
        print("nextBestLevel: ".. nextBestLevel)
        --print("RewardRequest: " .. C_MythicPlus.RequestRewards())
        print("===============")
        weeklyRewardLevel, endOfRunRewardLevel = C_MythicPlus.GetRewardLevelForDifficultyLevel(18)
        print("weeklyRewardLevel: ".. weeklyRewardLevel)
        print("endOfRunRewardLevel: " ..endOfRunRewardLevel)
        print("===============") ]]



        -- Portal Animation
        local anim_frame = CreateFrame("Frame", "portalTexture"..mapId, portalFrame)
        anim_frame:SetFrameLevel(portalFrame:GetFrameLevel()+1)
        anim_frame:SetSize(40, 40)
        anim_frame:SetPoint("CENTER", portalFrame, "CENTER", 0, 0)
        anim_frame.textureportal = anim_frame:CreateTexture(nil, "ARTWORK")
        anim_frame.textureportal:SetAllPoints(anim_frame)
        --anim_frame.textureportal:SetAlpha(0.8)
        anim_frame.animg = anim_frame:CreateAnimationGroup()
        local a1 = anim_frame.animg:CreateAnimation("Rotation")
        a1:SetDegrees(-360)
        a1:SetDuration(2)
        anim_frame.animg:SetLooping("REPEAT")
        portalFrame:SetAttribute("portalFrame", anim_frame)

        portalFrame.maskTexture = portalFrame:CreateMaskTexture()
        portalFrame.maskTexture:SetSize(portalFrame:GetWidth(),portalFrame:GetHeight())
        portalFrame.maskTexture:SetPoint("CENTER")
        portalFrame.maskTexture:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Dungeon-Portal-Mask-PlayerFame")
        anim_frame.textureportal:AddMaskTexture(portalFrame.maskTexture)

        -- Portal Cooldown
        local portalCooldownFrame = CreateFrame("Cooldown", "portalCooldown", portalFrame, "CooldownFrameTemplate")
        portalCooldownFrame:SetAllPoints(portalFrame)
        portalFrame:SetAttribute("portalCooldownFrame", portalCooldownFrame)

        -- Add clickable portal spell casting to dungeon portal frame if they have the spell
        local portalSpellId, portalSpellName = DungeonTools:GetPortalSpell(mapId)
        
        if (portalSpellId) then -- if the player has the portal, make the portal image clickable to cast it if clicked.
            --portalFrame.textureportal = portalFrame:CreateTexture()
            --portalFrame.textureportal:SetSize(40, 40)
            --portalFrame.textureportal:SetPoint("CENTER", portalFrame, "CENTER", 0, 0)
            anim_frame.textureportal:SetTexture("Interface\\AddOns\\KeyMaster\\Assets\\Images\\Dungeon-Portal-Active")
            anim_frame.textureportal:SetRotation(math.random(0,2) + math.random())
            anim_frame.textureportal:SetAlpha(0.6)

            local pButton
            pButton = CreateFrame("Button","portal_button"..mapId,portalFrame,"SecureActionButtonTemplate")
            pButton:SetAttribute("type", "spell")
            pButton:SetAttribute("spell", portalSpellName)
            pButton:RegisterForClicks("LeftButtonDown")
            pButton:SetWidth(pButton:GetParent():GetWidth())
            pButton:SetHeight(pButton:GetParent():GetWidth())
            pButton:SetPoint("TOPLEFT", portalFrame, "TOPLEFT", 0, 0)
            pButton:SetScript("OnMouseUp", portalButton_buttonevent)
            pButton:SetScript("OnEnter", portalButton_mouseover)
            pButton:SetScript("OnLeave", portalButton_mouseoout)

            portalFrame:SetAttribute("portalSpellName", portalSpellName)
        else
            --portalFrame.textureportal = portalFrame:CreateTexture()
            --portalFrame.textureportal:SetSize(40, 40)
            --portalFrame.textureportal:SetPoint("CENTER", portalFrame, "CENTER", 0, 0)
            anim_frame.textureportal:SetTexture("Interface\\AddOns\\KeyMaster\\Assets\\Images\\Dungeon-Portal-Inactive")
            anim_frame.textureportal:SetRotation(math.random(0,1) + math.random())
            anim_frame.textureportal:SetAlpha(0.6)
        end

        if (doOnce == 0) then
            local point, relativeTo, relativePoint, xOfs, yOfs = dataFrame.tyrannicalLevel:GetPoint()
            mapHeaderFrame.tyranText:SetPoint("RIGHT", mapHeaderFrame, "CENTER", xOfs, 0)
            point, relativeTo, relativePoint, xOfs, yOfs = dataFrame.fortifiedLevel:GetPoint()
            mapHeaderFrame.fortText:SetPoint("LEFT", mapHeaderFrame, "CENTER", xOfs, 0)
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
    --local bottomMargin = _G["KM_PlayerMapInfo"]:GetHeight()
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

    --[[ extraInfoFrame.textureHighlight = extraInfoFrame:CreateTexture(nil, "BACKGROUND", nil, 1)
    extraInfoFrame.textureHighlight:SetSize(extraInfoFrame:GetWidth(), extraInfoFrame:GetHeight())
    extraInfoFrame.textureHighlight:SetPoint("LEFT", extraInfoFrame, "LEFT", 0, 0)
    extraInfoFrame.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true) ]]

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

    local mapDetails = CreateFrame("Frame", "KM_MapDetailView", detailsFrame)
    mapDetails:SetPoint("TOP", detailsFrame, "TOP", 0, -4)
    mapDetails:SetSize(detailsFrame:GetWidth(), (detailsFrame:GetHeight()/2)-4)

    mapDetails.texture = mapDetails:CreateTexture(nil, "BACKGROUND", nil, 0)
    mapDetails.texture:SetAllPoints(mapDetails)
    mapDetails.texture:SetSize(mapDetails:GetWidth(), mapDetails:GetHeight())
    mapDetails.texture:SetColorTexture(0,0,0,1)

    mapDetails.textureHighlight = mapDetails:CreateTexture(nil, "BACKGROUND", nil, 1)
    mapDetails.textureHighlight:SetSize(mapDetails:GetWidth(), 64)
    mapDetails.textureHighlight:SetPoint("TOPLEFT", mapDetails, "TOPLEFT", 0, 0)
    mapDetails.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    mapDetails.textureHighlight:SetAlpha(highlightAlpha)
    mapDetails.textureHighlight:SetVertexColor(hlColor.r,hlColor.g,hlColor.b, highlightAlpha)
    mapDetails.textureHighlight:SetRotation(math.pi)

    mapDetails.DetailsTitle = mapDetails:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    mapDetails.DetailsTitle:SetPoint("TOP", detailsFrame, "TOP", 0, -8)
    mapDetails.DetailsTitle:SetJustifyV("TOP")
    mapDetails.DetailsTitle:SetText(KeyMasterLocals.INSTANCETIMER)

    mapDetails.InstanceBGT = mapDetails:CreateTexture(nil, "ARTWORK", nil, 0)
    mapDetails.InstanceBGT:SetSize(mapDetails:GetWidth(), mapDetails:GetWidth())
    mapDetails.InstanceBGT:SetPoint("TOP", mapDetails.DetailsTitle, "BOTTOM", 28, -8)
    mapDetails.InstanceBGT:SetTexture() -- todo: dynamic first map image

    mapDetails.MapName = mapDetails:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    mapDetails.MapName:SetPoint("TOP", mapDetails, "TOP", 0, -50)
    local mapNameColor = {}
    mapNameColor.r,mapNameColor.g,mapNameColor.b, _ = getColor("themeFontColorYellow")
    mapDetails.MapName:SetTextColor(mapNameColor.r,mapNameColor.g,mapNameColor.b, 1)
    local Path, _, Flags = mapDetails.MapName:GetFont()
    mapDetails.MapName:SetFont(Path, 16, Flags)
    mapDetails.MapName:SetText("")-- todo: dynamic first map name

    mapDetails.TimeLimit = mapDetails:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    mapDetails.TimeLimit:SetPoint("TOP", mapDetails.MapName, "BOTTOM", 0, -12)
    --[[ local hlColor = {}
    hlColor.r,hlColor.g,hlColor.b, _ = getColor("themeFontColorYellow")
    mapDetails.TimeLimit:SetTextColor(hlColor.r,hlColor.g,hlColor.b, 1) ]]
    mapDetails.TimeLimit:SetText("")
    -- KeyMasterLocals.TIMELIMIT..": ".."29:00"

    mapDetails.TwoChestTimer = mapDetails:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    mapDetails.TwoChestTimer:SetPoint("TOP", mapDetails.TimeLimit, "BOTTOM", 0, -4)
    mapDetails.TwoChestTimer:SetText("")

    mapDetails.ThreeChestTimer = mapDetails:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    mapDetails.ThreeChestTimer:SetPoint("TOP",  mapDetails.TwoChestTimer, "BOTTOM", 0, -4)
    mapDetails.ThreeChestTimer:SetText("")



    -- Vault Details
    local vaultDetails = CreateFrame("Frame", "KM_VaultDetailView", detailsFrame)
    vaultDetails:SetPoint("BOTTOM", detailsFrame, "BOTTOM", 0, 0)
    vaultDetails:SetSize(detailsFrame:GetWidth(), (detailsFrame:GetHeight()/2)-4)

    vaultDetails.texture = vaultDetails:CreateTexture(nil, "BACKGROUND", nil, 0)
    vaultDetails.texture:SetAllPoints(vaultDetails)
    vaultDetails.texture:SetSize(vaultDetails:GetWidth(), vaultDetails:GetHeight())
    vaultDetails.texture:SetColorTexture(0,0,0,1)

    vaultDetails.textureHighlight = vaultDetails:CreateTexture(nil, "BACKGROUND", nil, 1)
    vaultDetails.textureHighlight:SetSize(vaultDetails:GetWidth(), 64)
    vaultDetails.textureHighlight:SetPoint("BOTTOMLEFT", vaultDetails, "BOTTOMLEFT", 0, 0)
    vaultDetails.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    vaultDetails.textureHighlight:SetAlpha(highlightAlpha)
    vaultDetails.textureHighlight:SetVertexColor(hlColor.r,hlColor.g,hlColor.b, highlightAlpha)

    vaultDetails.DetailsTitle = vaultDetails:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    vaultDetails.DetailsTitle:SetPoint("TOP", vaultDetails, "TOP", 4, -4)
    vaultDetails.DetailsTitle:SetText(KeyMasterLocals.VAULTINFORMATION)

    local currentWeekBestLevel, weeklyRewardLevel, nextDifficultyWeeklyRewardLevel, nextBestLevel
    currentWeekBestLevel, weeklyRewardLevel, nextDifficultyWeeklyRewardLevel, nextBestLevel = C_MythicPlus.GetWeeklyChestRewardLevel()

    vaultDetails.CurrentBestLevel = mapDetails:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    vaultDetails.CurrentBestLevel:SetPoint("TOP", vaultDetails.DetailsTitle, "BOTTOM", 0, -18)
    vaultDetails.CurrentBestLevel:SetText("Current Best Level: "..currentWeekBestLevel)

    vaultDetails.RewardLevel = mapDetails:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    vaultDetails.RewardLevel:SetPoint("TOP", vaultDetails.CurrentBestLevel, "BOTTOM", 0, 0)
    vaultDetails.RewardLevel:SetText("Reward Level: "..weeklyRewardLevel)

    vaultDetails.NextLevel = mapDetails:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    vaultDetails.NextLevel:SetPoint("TOP", vaultDetails.RewardLevel, "BOTTOM", 0, -8)
    vaultDetails.NextLevel:SetText("Next Best Level: "..nextBestLevel)
    
    vaultDetails.NextRewardLevel = mapDetails:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    vaultDetails.NextRewardLevel:SetPoint("TOP", vaultDetails.NextLevel, "BOTTOM", 0, 0)
    vaultDetails.NextRewardLevel:SetText("Next Reward Level: "..nextDifficultyWeeklyRewardLevel)

    --[[ vaultDetails.textureHighlight = vaultDetails:CreateTexture(nil, "BACKGROUND", nil, 1)
    vaultDetails.textureHighlight:SetSize(vaultDetails:GetWidth(), vaultDetails:GetHeight())
    vaultDetails.textureHighlight:SetPoint("LEFT", vaultDetails, "LEFT", 0, 0)
    vaultDetails.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    vaultDetails.textureHighlight:SetAlpha(0.5) ]]

end

-- creates the entire player frame and sub-frames
function PlayerFrame:Initialize(parentFrame)
    -- Player Tab
    local playerContent = _G["KM_PlayerContentFrame"] or PlayerFrame:CreatePlayerContentFrame(parentFrame)
    local playerFrame = _G["KM_Player_Frame"] or PlayerFrame:CreatePlayerFrame(playerContent)
    local playerMapFrame = _G["KM_PlayerMapInfo"] or PlayerFrame:CreateMapData(playerFrame, playerContent)
    --local playerExtraFrame = _G["KM_PLayerExtraInfo"] or PlayerFrame:CreateExtraInfoFrame(playerMapFrame)
    local PlayerFrameMapDetails = _G["KM_PlayerFrame_MapDetails"] or PlayerFrame:CreateMapDetailsFrame(playerFrame, playerContent)

    return playerContent
end