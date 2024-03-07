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
    hlColor.r,hlColor.g,hlColor.b, hlColor.a = getColor("color_HEIRLOOM")
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
        --mapDetailsFrame.TwoChestTimer:SetText(KeyMaster:FormatDurationSec(timers["2chest"])) -- todo: add frame
        --mapDetailsFrame.ThreeChestTimer:SetText(KeyMaster:FormatDurationSec(timers["3chest"])) -- todo: add frame
    end
end

function PlayerFrame:CreatePlayerContentFrame(parentFrame)
    local playerContentFrame = CreateFrame("Frame", "KM_PlayerContentFrame", parentFrame)
    playerContentFrame:SetSize(parentFrame:GetWidth(), parentFrame:GetHeight())
    playerContentFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT")
    return playerContentFrame
end


function PlayerFrame:CreatePlayerFrame(parentFrame)

    local characterData = CharacterInfo:GetMyCharacterInfo()

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
    modelFrame:SetSize(playerFrame:GetHeight(), playerFrame:GetHeight()-2)
    modelFrame:ClearAllPoints()
    modelFrame:SetPoint("TOPLEFT", playerFrame, "TOPLEFT", 0, 0)
    --m:SetDisplayInfo(21723) -- creature/murloccostume/murloccostume.m2
    modelFrame:SetUnit("player")


    modelFrame:SetScript("OnShow", function(self)
        self:SetCamera(0)
        self:SetPortraitZoom(0.6)
        --self:SetPosition(-0.32, 0.05,0)
        self:SetPosition(0, 0.05, -0.1)
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
    playerFrame.playerNameLarge:SetAllPoints(playerFrame)
    local hexColor = CharacterInfo:GetMyClassColor("player")
    playerFrame.playerNameLarge:SetText("|cff"..hexColor..UnitName("player").."|r")
    playerFrame.playerNameLarge:SetAlpha(0.08)
    playerFrame.playerNameLarge:SetJustifyH("LEFT")

    -- Season ID
    local seasonID = DungeonTools:GetCurrentSeasonId()
    if seasonID then
        playerFrame.SeasonInformation = playerFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
        local Path, _, Flags = playerFrame.SeasonInformation:GetFont()
        playerFrame.SeasonInformation:SetFont(Path, 60, Flags)
        playerFrame.SeasonInformation:SetPoint("LEFT", modelFrame, "RIGHT", 45, 8)
        playerFrame.SeasonInformation:SetAlpha(0.3)
        playerFrame.SeasonInformation:SetText(KeyMasterLocals.SEASON..": "..seasonID)
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

local keyLevelOffsetx = 0
local keyLevelOffsety = 2
local affixScoreOffsetx = 34
local affixScoreOffsety = 2
local affixBonusOffsetx = 0
local affixBonusOffsety = 0
local afffixRuntimeOffsetx = 34
local afffixRuntimeOffsety = -2

local function SetupHeaederTitles(firstRowMapID)

    -- Header setup
    _G["KM_Player_Frame"].divider1 = _G["KM_Player_Frame"]:CreateTexture()
    _G["KM_Player_Frame"].divider1:SetPoint("BOTTOM", _G["KM_RowDivider"..firstRowMapID], "TOP", 0, 4)
    _G["KM_Player_Frame"].divider1:SetSize(32, 32)
    _G["KM_Player_Frame"].divider1:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Bar-Seperator-32", false)
    _G["KM_Player_Frame"].divider1:SetAlpha(0.3)

    _G["KM_Player_Frame"].tyranText = _G["KM_Player_Frame"]:CreateFontString("KM_PlayerFrame_TyranTitle", "OVERLAY", "KeyMasterFontBig")
    _G["KM_Player_Frame"].tyranText:SetPoint("RIGHT", _G["KM_Player_Frame"].divider1, "LEFT", keyLevelOffsetx-6, 2)
    local Path, _, Flags = _G["KM_Player_Frame"].tyranText:GetFont()
    _G["KM_Player_Frame"].tyranText:SetFont(Path, 18, Flags)
    _G["KM_Player_Frame"].tyranText:SetJustifyH("RIGHT")
    _G["KM_Player_Frame"].tyranText:SetText(string.upper(KeyMasterLocals.TYRANNICAL))

    _G["KM_Player_Frame"].fortText = _G["KM_Player_Frame"]:CreateFontString("KM_PlayerFrame_TyranTitle", "OVERLAY", "KeyMasterFontBig")
    _G["KM_Player_Frame"].fortText:SetPoint("LEFT", _G["KM_Player_Frame"].divider1, "RIGHT", -keyLevelOffsetx+6, 2)
    _G["KM_Player_Frame"].fortText:SetFont(_G["KM_Player_Frame"].tyranText:GetFont())
    _G["KM_Player_Frame"].fortText:SetJustifyH("LEFT")
    _G["KM_Player_Frame"].fortText:SetText(string.upper(KeyMasterLocals.FORTIFIED))
end

function PlayerFrame:CreateMapData(parentFrame)
    local mapFrameHeight = 48
    local mtb = 4 -- margin top/bottom
    local mr = 4 -- margin right

    -- Player Details Panel
    local playerInformationFrame = CreateFrame("Frame", "KM_PlayerMapInfo", parentFrame)
    playerInformationFrame:SetSize((parentFrame:GetWidth()*0.7)+mr, (mapFrameHeight*mapCount)+((mapCount+1)*mtb))
    playerInformationFrame:SetPoint("TOPLEFT", parentFrame, "BOTTOMLEFT", -4, 0)
    --[[ playerInformationFrame.texture = playerInformationFrame:CreateTexture()
    playerInformationFrame.texture:SetAllPoints(playerInformationFrame)
    playerInformationFrame.texture:SetColorTexture(1, 1, 1, 0.6) ]]

    local count = -8
    local prevFrame
    local prevRowAnchor
    local mapFrameWidth = playerInformationFrame:GetWidth() - mr
    local firstRowId

    -- Instance Cards
    for mapId in pairs (seasonMaps) do
        if not (firstRowId) then firstRowId = mapId end
        SetupHeaederTitles(firstRowId)
        local mapFrame = CreateFrame("Frame", "KM_PlayerFrameMapInfo"..mapId, playerInformationFrame)
        mapFrame:SetAttribute("mapId", mapId)
        mapFrame:SetSize(mapFrameWidth-mr, mapFrameHeight)
        if count == -8 then
            mapFrame:SetPoint("TOPLEFT", playerInformationFrame, "TOPLEFT", mr, -mtb)
            mapFrame:SetFrameLevel(playerInformationFrame:GetFrameLevel()+1)
            prevRowAnchor = mapFrame
        else
            mapFrame:SetPoint("TOP", prevFrame, "BOTTOM", 0, -mtb)
            mapFrame:SetFrameLevel(prevRowAnchor:GetFrameLevel()+1)
        end

        mapFrame.maskTexture = mapFrame:CreateMaskTexture()
        mapFrame.maskTexture:SetPoint("TOPLEFT", mapFrame, "TOPLEFT", -4, 4)
        mapFrame.maskTexture:SetSize(128, 128)
        mapFrame.maskTexture:SetTexture("Interface\\AddOns\\KeyMaster\\Assets\\Images\\Player-Frame-Map-Mask-128")
        mapFrame.texturemap = mapFrame:CreateTexture(nil, "ARTWORK",nil)
        mapFrame.texturemap:SetPoint("TOPLEFT", mapFrame, "TOPLEFT", -4, 40)
        mapFrame.texturemap:SetSize(128, 128)
        mapFrame.texturemap:SetTexture(seasonMaps[mapId].texture)
        mapFrame.texturemap:AddMaskTexture(mapFrame.maskTexture)
        mapFrame.texture = mapFrame:CreateTexture(nil, "BACKGROUND", nil, 0)
        mapFrame.texture:SetAllPoints(mapFrame)
        mapFrame.texture:SetColorTexture(0, 0, 0, 1)

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

        mapFrame.dungeonName = mapFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
        mapFrame.dungeonName:SetPoint("TOPLEFT", mapFrame, "TOPLEFT", 4, -4)
        mapFrame.dungeonName:SetWidth(mapFrame:GetWidth())
        --mapFrame.dungeonName:SetJustifyV("TOP")
        mapFrame.dungeonName:SetJustifyH("LEFT")
        local shortenBlizzardsStupidLongInstanceNames = shortenDungeonName(seasonMaps[mapId].name)
        mapFrame.dungeonName:SetText(shortenBlizzardsStupidLongInstanceNames)

        mapFrame.overallScore = mapFrame:CreateFontString("KM_PlayerFrame"..mapId.."_Overall", "OVERLAY", "KeyMasterFontNormal")
        mapFrame.overallScore:SetPoint("BOTTOMLEFT", mapFrame, "BOTTOMLEFT", 4, 4)
        local Path, _, Flags = mapFrame.overallScore:GetFont()
        mapFrame.overallScore:SetFont(Path, 24, Flags)
        local OverallColor = {}
        OverallColor.r, OverallColor.g, OverallColor.b, _ = Theme:GetThemeColor("color_HEIRLOOM")
        mapFrame.overallScore:SetTextColor(OverallColor.r, OverallColor.g, OverallColor.b, 1)
        mapFrame.overallScore:SetText("")


        --[[ mapFrame.nameBackground = mapFrame:CreateTexture()
        mapFrame.nameBackground:SetPoint("TOP", mapFrame, "TOP")
        mapFrame.nameBackground:SetSize(mapFrame:GetWidth(), 25)
        mapFrame.nameBackground:SetColorTexture(0,0,0, 0.9)
        mapFrame.texture = mapFrame:CreateTexture(nil, "OVERLAY")
        mapFrame.texture:SetSize(mapFrame:GetWidth(), mapFrame:GetHeight())
        mapFrame.texture:SetPoint("TOP")
        mapFrame.texture:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Map-Overlay")
        mapFrame.texture:SetAlpha(0.9) ]]

        local offset = 120
        local dataFrame = CreateFrame("Frame", "KM_PlayerFrame_Data"..mapId, mapFrame)
        dataFrame:SetPoint("LEFT", mapFrame, "LEFT", offset, 0)
        dataFrame:SetSize(mapFrame:GetWidth()-offset, mapFrame:GetHeight())

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

        dataFrame.divider2 = dataFrame:CreateTexture("KM_RowDivider"..mapId)
        dataFrame.divider2:SetPoint("CENTER", dataFrame, "CENTER", -portalFrame:GetWidth(), 0)
        dataFrame.divider2:SetSize(dataFrame:GetHeight(), dataFrame:GetHeight())
        dataFrame.divider2:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Bar-Seperator-32", false)
        dataFrame.divider2:SetAlpha(0.3)

        --///// TYRANNICAL /////--
        -- Tyrannical Key Level
        dataFrame.tyrannicalLevel = dataFrame:CreateFontString("KM_PlayerFrameTyranLevel"..mapId, "OVERLAY", "KeyMasterFontBig")
        dataFrame.tyrannicalLevel:SetPoint("RIGHT", dataFrame.divider2, "LEFT", keyLevelOffsetx, keyLevelOffsety)
        local Path, _, Flags = dataFrame.tyrannicalLevel:GetFont()
        dataFrame.tyrannicalLevel:SetFont(Path, 24, Flags)
        dataFrame.tyrannicalLevel:SetText("")

        -- Tyrannical Bonus Time
        dataFrame.tyrannicalBonus = dataFrame:CreateFontString("KM_PlayerFrameTyranBonus"..mapId, "OVERLAY", "KeyMasterFontBig")
        dataFrame.tyrannicalBonus:SetPoint("RIGHT", dataFrame.tyrannicalLevel, "LEFT", affixBonusOffsetx, affixBonusOffsety)
        dataFrame.tyrannicalBonus:SetText("")

        -- Tyrannical Score
        dataFrame.tyrannicalScore = dataFrame:CreateFontString("KM_PlayerFrameTyranScore"..mapId, "OVERLAY", "KeyMasterFontBig")
        dataFrame.tyrannicalScore:SetPoint("TOPRIGHT", dataFrame.tyrannicalLevel, "TOPLEFT", -affixScoreOffsetx, affixScoreOffsety)
        dataFrame.tyrannicalScore:SetJustifyH("RIGHT")
        dataFrame.tyrannicalScore:SetText("")

        -- Tyrannical RunTime
        dataFrame.tyrannicalRunTime = dataFrame:CreateFontString("KM_PlayerFrameTyranRunTime"..mapId, "OVERLAY", "KeyMasterFontBig")
        dataFrame.tyrannicalRunTime:SetPoint("BOTTOMRIGHT", dataFrame.tyrannicalLevel, "BOTTOMLEFT", -afffixRuntimeOffsetx, afffixRuntimeOffsety)
        dataFrame.tyrannicalScore:SetJustifyH("RIGHT")
        dataFrame.tyrannicalRunTime:SetText("") 

        --///// FORTIFIED /////--
        -- Fortified Key Level
        dataFrame.fortifiedLevel = dataFrame:CreateFontString("KM_PlayerFrameFortLevel"..mapId, "OVERLAY", "KeyMasterFontBig")
        dataFrame.fortifiedLevel:SetPoint("LEFT", dataFrame.divider2, "RIGHT", keyLevelOffsetx, keyLevelOffsety)
        local Path, _, Flags = dataFrame.fortifiedLevel:GetFont()
        dataFrame.fortifiedLevel:SetFont(Path, 24, Flags)
        dataFrame.fortifiedLevel:SetText("")

        -- Fortified Bonus Time
        dataFrame.fortifiedBonus = dataFrame:CreateFontString("KM_PlayerFrameFortBonus"..mapId, "OVERLAY", "KeyMasterFontBig")
        dataFrame.fortifiedBonus:SetPoint("LEFT", dataFrame.fortifiedLevel, "RIGHT", affixBonusOffsetx, affixBonusOffsety)
        dataFrame.fortifiedBonus:SetText("") 

        -- Fortified Score
        dataFrame.fortifiedScore = dataFrame:CreateFontString("KM_PlayerFrameFortScore"..mapId, "OVERLAY", "KeyMasterFontBig")
        dataFrame.fortifiedScore:SetPoint("TOPLEFT", dataFrame.fortifiedLevel, "TOPRIGHT", affixScoreOffsetx, affixScoreOffsety)
        dataFrame.fortifiedScore:SetJustifyH("LEFT")
        dataFrame.fortifiedScore:SetText("")

        -- Tyrannical RunTime
        dataFrame.fortifiedRunTime = dataFrame:CreateFontString("KM_PlayerFrameFortRunTime"..mapId, "OVERLAY", "KeyMasterFontBig")
        dataFrame.fortifiedRunTime:SetPoint("BOTTOMLEFT", dataFrame.fortifiedLevel, "BOTTOMRIGHT", afffixRuntimeOffsetx, afffixRuntimeOffsety)
        dataFrame.fortifiedRunTime:SetJustifyH("LEFT")
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
            anim_frame.textureportal:SetRotation(math.random(0,1) + math.random())
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

function PlayerFrame:CreateMapDetailsFrame(parentFrame)
    local detailsFrame = CreateFrame("Frame", "KM_PlayerFrame_MapDetails", parentFrame)
    detailsFrame:SetPoint("TOPRIGHT", parentFrame, "BOTTOMRIGHT", 0, -4)
    detailsFrame:SetSize(parentFrame:GetWidth() - _G["KM_PlayerMapInfo"]:GetWidth()+4, _G["KM_PlayerMapInfo"]:GetHeight() + _G["KM_PLayerExtraInfo"]:GetHeight()-4)

    detailsFrame.texture = detailsFrame:CreateTexture(nil, "BACKGROUND", nil, 1)
    detailsFrame.texture:SetPoint("CENTER", detailsFrame, "CENTER")
    detailsFrame.texture:SetSize(detailsFrame:GetWidth()-1, detailsFrame:GetHeight()-1)
    detailsFrame.texture:SetColorTexture(0, 0, 0, 1)

    detailsFrame.border = detailsFrame:CreateTexture(nil, "BACKGROUND", nil, 0)
    detailsFrame.border:SetAllPoints(detailsFrame)
    local borderColor = {}
    borderColor.r, borderColor.g, borderColor.b, _ = Theme:GetThemeColor("color_DARKGREY")
    detailsFrame.border:SetColorTexture(borderColor.r, borderColor.g, borderColor.b, 1)

    detailsFrame.divider1 = detailsFrame:CreateTexture(nil, "OVERLAY")
    detailsFrame.divider1:SetPoint("CENTER", detailsFrame, "CENTER", 0, 0)
    detailsFrame.divider1:SetSize(32, detailsFrame:GetWidth()-10)
    detailsFrame.divider1:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Bar-Seperator-32", false)
    detailsFrame.divider1:SetRotation(math.pi/2)
    detailsFrame.divider1:SetAlpha(0.3)

    -- seasonMaps[mapId].texture
    -- Map Details Frame
    local mapDetails = CreateFrame("Frame", "KM_MapDetailView", detailsFrame)
    mapDetails:SetPoint("TOP", detailsFrame, "TOP", 0, -4)
    mapDetails:SetSize(detailsFrame:GetWidth()-8, (detailsFrame:GetHeight()/2)-10)


    mapDetails.DetailsTitle = mapDetails:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    mapDetails.DetailsTitle:SetPoint("TOP", detailsFrame, "TOP", 4, -4)
    mapDetails.DetailsTitle:SetText(".:: "..KeyMasterLocals.INSTANCEINFORMATION.." ::.")

    mapDetails.InstanceBGT = mapDetails:CreateTexture(nil, "ARTWORK", nil, 0)
    mapDetails.InstanceBGT:SetSize(mapDetails:GetWidth(), mapDetails:GetWidth())
    mapDetails.InstanceBGT:SetPoint("TOP", mapDetails.DetailsTitle, "BOTTOM", 22, -8)
    mapDetails.InstanceBGT:SetTexture() -- todo: dynamic first map image

    mapDetails.MapName = mapDetails:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    mapDetails.MapName:SetPoint("TOP", mapDetails.InstanceBGT, "TOP", -22, -40)
    local hlColor = {}
    hlColor.r,hlColor.g,hlColor.b, _ = getColor("themeFontColorYellow")
    mapDetails.MapName:SetTextColor(hlColor.r,hlColor.g,hlColor.b, 1)
    local Path, _, Flags = mapDetails.MapName:GetFont()
    mapDetails.MapName:SetFont(Path, 16, Flags)
    mapDetails.MapName:SetText("")-- todo: dynamic first map name

    mapDetails.TimeLimit = mapDetails:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    mapDetails.TimeLimit:SetPoint("TOP", mapDetails.MapName, "BOTTOM", 0, -8)
    --[[ local hlColor = {}
    hlColor.r,hlColor.g,hlColor.b, _ = getColor("themeFontColorYellow")
    mapDetails.TimeLimit:SetTextColor(hlColor.r,hlColor.g,hlColor.b, 1) ]]
    mapDetails.TimeLimit:SetText("")
    -- KeyMasterLocals.TIMELIMIT..": ".."29:00"


    local vaultDetails = CreateFrame("Frame", "KM_VaultDetailView", detailsFrame)
    vaultDetails:SetPoint("BOTTOM", detailsFrame, "BOTTOM", 0, 4)
    vaultDetails:SetSize(detailsFrame:GetWidth()-8, (detailsFrame:GetHeight()/2)-10)

    vaultDetails.DetailsTitle = vaultDetails:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    vaultDetails.DetailsTitle:SetPoint("TOP", vaultDetails, "TOP", 4, -4)
    vaultDetails.DetailsTitle:SetText(".:: "..KeyMasterLocals.VAULTINFORMATION.." ::.")

    local currentWeekBestLevel, weeklyRewardLevel, nextDifficultyWeeklyRewardLevel, nextBestLevel
    currentWeekBestLevel, weeklyRewardLevel, nextDifficultyWeeklyRewardLevel, nextBestLevel = C_MythicPlus.GetWeeklyChestRewardLevel()

    vaultDetails.CurrentBestLevel = mapDetails:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    vaultDetails.CurrentBestLevel:SetPoint("TOP", vaultDetails.DetailsTitle, "BOTTOM", 0, -8)
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
