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
local DungeonJournal = KeyMaster.DungeonJournal
local PartyFrame = KeyMaster.PartyFrame

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

local function closeEncounterJournal()
    if (_G["EncounterJournal"]) then 
        if (_G["EncounterJournal"]:IsVisible() == true) then
            ToggleEncounterJournal()
        end
    end
end

local function toggleLFGPanel()
    if (_G["GroupFinderFrame"]) then
        if (_G["GroupFinderFrame"]:IsVisible() == false) then
                PVEFrame_ShowFrame("GroupFinderFrame")
        else
            PVEFrame_ToggleFrame()
        end
    end
    
end

local function updateRatingCalculatorMap(self, selectedMapId)
    self:ClearFocus() -- clears focus from editbox, (unlocks key bindings, so pressing W makes your character go forward.

    local scores = _G["KM_ScoreCalcScores"]
    local directions =  _G["KM_ScoreCalcDirection"]
    
    local keyLevel = tonumber(self:GetText())
    if keyLevel ~= nil and keyLevel >= 2 then

        local mapId = selectedMapId -- set from row click
        
        PlayerFrameMapping:CalculateRatingGain(mapId, keyLevel)
        
        directions:Hide()
        scores:Show()
    else
        self:SetText("")
        directions:Show()
        scores:Hide()
    end
    --self:SetText("") -- Empties the box, duh! ;)
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
    local dungeonJournalFrame = _G["KM_Journal"]
    dungeonJournalFrame.mapId = selectedMapId
    local dungeonMapFrame = _G["KM_Map"]
    dungeonMapFrame.mapId = selectedMapId

    local validInstanceID = DungeonJournal:getInstanceId(seasonMaps[selectedMapId].name)

    if (validInstanceID) then
        dungeonJournalFrame:Enable()
        dungeonMapFrame:Enable()
    else
        dungeonJournalFrame:Disable()
        dungeonMapFrame:Disable()        
    end

    local portalButton = _G["KM_Playerportal_button"]
    local portalSpellId, portalSpellName = DungeonTools:GetPortalSpell(selectedMapId)
    if portalButton then 

        local cooldown 
        if portalSpellName then cooldown = C_Spell.GetSpellCooldown(portalSpellName) end
        if (portalSpellId ~= nil and cooldown ~= nil and cooldown["startTime"] == 0) then
            portalButton:SetAttribute("spell", portalSpellId)
            portalButton:Enable()
            portalButton:Show()

        else

            portalButton:Disable()
            portalButton:Hide()

        end
    end


    local mapDetailsFrame = _G["KM_MapDetailView"]
    local dungeonName = shortenDungeonName(seasonMaps[selectedMapId].name)
    local mapCalcFrame = _G["KM_ScoreCalc"]
    local scoreCalcScores = _G["KM_ScoreCalcScores"]
    local scoresCalcDirection = _G["KM_ScoreCalcDirection"]

    closeEncounterJournal()
    
    if mapDetailsFrame.MapName:GetText() ~= dungeonName then        
        mapDetailsFrame.MapName:SetText(dungeonName)
        mapCalcFrame.DetailsTitle:SetText(dungeonName)
        mapDetailsFrame.InstanceBGT:SetTexture(seasonMaps[selectedMapId].backgroundTexture)
        local timers = DungeonTools:GetChestTimers(selectedMapId)
        mapDetailsFrame.TimeLimit:SetText("+"..KeyMaster:FormatDurationSec(timers["1chest"]))
        mapDetailsFrame.TwoChestTimer:SetText("++"..KeyMaster:FormatDurationSec(timers["2chest"])) 
        mapDetailsFrame.ThreeChestTimer:SetText("+++"..KeyMaster:FormatDurationSec(timers["3chest"]))
        updateRatingCalculatorMap(_G["KM_CalcKeyLevel"], selectedMapId)
        --scoreCalcScores:Hide()
        --scoresCalcDirection:Show()
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
    playerFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 4, -4)
    playerFrame:SetSize(parentFrame:GetWidth()-8, 100)
    playerFrame.texture = playerFrame:CreateTexture(nil, "BACKGROUND", nil, 0)
    playerFrame.texture:SetAllPoints(playerFrame)
    playerFrame.texture:SetColorTexture(0, 0, 0, 1)
    playerFrame:SetScript("OnShow", function(self)
        PlayerFrameMapping:RefreshData(false)
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

    local characterIconFrame = CreateFrame("Frame", "KM_CharacterIcon", playerFrame)
    characterIconFrame:SetPoint("LEFT", playerFrame, "LEFT", 0, 0)
    characterIconFrame:SetSize(playerFrame:GetHeight()+20, playerFrame:GetHeight())
    characterIconFrame.icon = characterIconFrame:CreateTexture(nil, "ARTWORK")
    characterIconFrame.icon:SetAllPoints(characterIconFrame)
    characterIconFrame.icon:SetTexture("Interface/Addons/KeyMaster/Assets/Images/"..Theme.style)
    characterIconFrame.icon:SetTexCoord(961/1024, 1, 332/1024,  399/1024)
    characterIconFrame:Hide()

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


local keyLevelOffsetx = 90
local keyLevelOffsety = -2
local affixScoreOffsetx = 135
local affixScoreOffsety = 8
local affixBonusOffsetx = 0
local affixBonusOffsety = 0
local afffixRuntimeOffsetx = 160
local afffixRuntimeOffsety = -2
local doOnce = 0

local function journalButton_OnMouseDown(self, event)
    if (not self:IsEnabled()) then return end
    if _G["EncounterJournal"] and _G["EncounterJournal"]:IsVisible() == true then closeEncounterJournal() return end
    local seasonMaps = DungeonTools:GetCurrentSeasonMaps()
    local mapName = seasonMaps[self.mapId].name
    
    DungeonJournal:ShowDungeonJournal(mapName)
end

local function journalButton_OnMouseUp(self, event)
end

local function journalButton_onmouseover(self, event)
end

local function journalButton_onmouseout(self, event)
end


local function createJournalButton(parent)
    
    if not parent then print("Journal Error") return end

    local journalButton = CreateFrame("Button", "KM_Journal", parent, UIPanelButtonTemplate)
    journalButton:SetSize(32, 41)
    journalButton:SetNormalAtlas("UI-HUD-MicroMenu-AdventureGuide-Up")
    journalButton:SetHighlightAtlas("UI-HUD-MicroMenu-AdventureGuide-Up")
    journalButton:SetPushedAtlas("UI-HUD-MicroMenu-AdventureGuide-Down")
    journalButton:SetDisabledAtlas("UI-HUD-MicroMenu-AdventureGuide-Disabled")

    journalButton:SetScript("OnMouseDown", journalButton_OnMouseDown)
    return journalButton
end


local function instanceMapButton_OnMouseDown(self, event)
    if (not self:IsEnabled()) then return end
    local seasonMaps = DungeonTools:GetCurrentSeasonMaps()
    local mapName = seasonMaps[self.mapId].name

    DungeonJournal:ShowDungeonMap(mapName)
end

local function createInstanceMapButton(parent)

    local instanceMapButton = CreateFrame("Button", "KM_Map", parent, UIPanelButtonTemplate)
    instanceMapButton:SetSize(24, 24)
    instanceMapButton:SetNormalAtlas("poi-islands-table")
    instanceMapButton:SetHighlightAtlas("poi-islands-table")
    instanceMapButton:SetPushedAtlas("poi-islands-table")
    instanceMapButton:SetDisabledTexture("Interface/Addons/KeyMaster/Assets/Images/poi-islands-table-disabled")
    instanceMapButton:SetScript("OnMouseDown", instanceMapButton_OnMouseDown)
    return instanceMapButton
end

local function portalButton_mouseover(self, event)
end

local function portalButton_mouseoout(self, event)
end

local function createPortalButton(parent)
    local pButton, portalSpellId, portalSpellName, mapId
    mapId = DungeonTools:GetFirstSeasonMapId()
    if not mapId then
        KeyMaster:_ErrorMsg("createPortalButton", "PlayerFrame", "Invalid map ID: "..tostring(mapId))
        return
    end

    pButton = _G["KM_Playerportal_button"]        

    local function createButton(mapId)
        if not parent or not mapId then return end

        portalSpellId, portalSpellName = DungeonTools:GetPortalSpell(mapId)
        local portalButton = _G["KM_Playerportal_button"]
        if portalButton then 
            portalButton:SetAttribute("spell", portalSpellId)
            return
        end
        
        if (portalSpellId) then -- if the player has the portal, make the dungeon image clickable to cast it if clicked.

            pButton = CreateFrame("Button","KM_Playerportal_button",parent,"SecureActionButtonTemplate")
            pButton:SetFrameLevel(10)
            pButton:SetAttribute("type", "spell")
            pButton:SetAttribute("spell", portalSpellId)
            pButton:SetAttribute("portalSpellName", portalSpellName)
            pButton:RegisterForClicks("AnyUp", "AnyDown") -- OPie rewrites the CVAR that handles mouse clicks. Added "AnyUp" to conditional.
            pButton:SetSize(34, 34)
            pButton:SetNormalAtlas("WarlockPortalAlliance")
            pButton:SetHighlightAtlas("WarlockPortal-Yellow-32x32")
            pButton:SetPushedAtlas("WarlockPortalAlliance")
            pButton:SetDisabledAtlas("WarlockPortalHorde")
            pButton:SetScript("OnEnter", portalButton_mouseover)
            pButton:SetScript("OnLeave", portalButton_mouseoout)
        
            return pButton
        end
        
    end

    if not pButton then
        pButton = createButton(mapId)
    end

    if pButton then
        pButton:SetAttribute("spell", portalSpellId)
        return pButton
    else
        return
    end
end

local function lfgButton_OnMouseDown(self, event)
    if (not self:IsEnabled()) then return end
    toggleLFGPanel()
end

local function createLFGButton(parent)
    
    local lfgButton = CreateFrame("Button", "KM_LFG", parent, UIPanelButtonTemplate)
    lfgButton:SetSize(24, 24)
    lfgButton:SetNormalAtlas("groupfinder-eye-single")
    lfgButton:SetHighlightAtlas("groupfinder-eye-single")
    lfgButton:SetPushedAtlas("groupfinder-eye-single")
    lfgButton:SetDisabledAtlas("groupfinder-eye-single")

    lfgButton:SetScript("OnMouseDown", lfgButton_OnMouseDown)
    return lfgButton
end

local function vaultButton_OnMouseDown(self, event)
    if (not self:IsEnabled()) then return end
    local vaultFrame = _G["WeeklyRewardsFrame"]
    if vaultFrame and vaultFrame:IsVisible() == true then
        vaultFrame:Hide()
    else
        vaultFrame:Show()
    end
end

local function createVaultButton(parent)

    if not C_AddOns.IsAddOnLoaded("Blizzard_WeeklyRewards") then
        C_AddOns.LoadAddOn("Blizzard_WeeklyRewards")
    end
    local vaultButton = CreateFrame("Button", "KM_Vault", parent, UIPanelButtonTemplate)
    vaultButton:SetSize(32, 32)
    vaultButton:SetNormalAtlas("GreatVault-32x32")
    vaultButton:SetHighlightAtlas("GreatVault-32x32")
    vaultButton:SetPushedAtlas("GreatVault-32x32")
    vaultButton:SetDisabledAtlas("GreatVault-32x32")

    vaultButton:SetScript("OnMouseDown", vaultButton_OnMouseDown)
    return vaultButton
end

local function createMDTButton(parent)

    local mdtButton = CreateFrame("Button","KM_MDT",parent,"SecureActionButtonTemplate")
    mdtButton:SetFrameLevel(10)
    mdtButton:SetAttribute("type", "macro")
    mdtButton:SetAttribute("macrotext", "/mdt") -- /mdt\n/run MDT:UpdateToDungeon(113) works with MDT lua errors
    mdtButton:RegisterForClicks("AnyUp", "AnyDown") -- OPie rewrites the CVAR that handles mouse clicks. Added "AnyUp" to conditional.
    mdtButton:SetSize(20, 28)
    mdtButton:SetNormalTexture("Interface/Addons/KeyMaster/Assets/Images/MDT-N")
    mdtButton:SetHighlightTexture("Interface/Addons/KeyMaster/Assets/Images/MDT-N")
    mdtButton:SetPushedTexture("Interface/Addons/KeyMaster/Assets/Images/MDT-N")
    mdtButton:SetDisabledTexture("Interface/Addons/KeyMaster/Assets/Images/MDT-D")

    return mdtButton
end

function PlayerFrame:CreateMapData(parentFrame, contentFrame)
    local mtb = 4 -- margin top/bottom
    local mr = 4 -- margin right
    local mapFrameHeaderHeight = 25
    local mapFrameWIdthPercent = 0.5

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

    local btnOptions = {}
    btnOptions.name = "KM_CharactersButton"
    btnOptions.text = KeyMasterLocals.PLAYERFRAME["Characters"]

    local charactersButton = Factory:Create(mapHeaderFrame,"Button", btnOptions)
    charactersButton:SetPoint("LEFT", mapHeaderFrame, "LEFT", 10, 0)
    charactersButton:SetScript("OnClick", toggleCharactersFrame)
    charactersButton:Hide()

    if KeyMaster:GetTableLength(KeyMaster_C_DB) > 0 then
        charactersButton:Show()
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
        dataFrame.dungeonName:SetSize(200, 22)
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
        dataFrame.overallScore:SetPoint("RIGHT", dataFrame, "RIGHT", -16, -2)
        dataFrame.overallScore:SetJustifyV("MIDDLE")
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
        dataFrame.tyrannicalLevel:SetPoint("RIGHT", dataFrame, "RIGHT", -keyLevelOffsetx, keyLevelOffsety)
        local Path, _, Flags = dataFrame.tyrannicalLevel:GetFont()
        dataFrame.tyrannicalLevel:SetFont(Path, 24, Flags)
        dataFrame.tyrannicalLevel:SetJustifyH("RIGHT")
        dataFrame.tyrannicalLevel:SetText("")

        -- Tyrannical Bonus Time
        dataFrame.tyrannicalBonus = dataFrame:CreateFontString("KM_PlayerFrameTyranBonus"..mapId, "OVERLAY", "KeyMasterFontBig")
        dataFrame.tyrannicalBonus:SetPoint("RIGHT", dataFrame.tyrannicalLevel, "LEFT", affixBonusOffsetx, affixBonusOffsety)
        dataFrame.tyrannicalBonus:SetJustifyH("RIGHT")
        dataFrame.tyrannicalBonus:SetText("")

        -- Tyrannical RunTime
        dataFrame.tyrannicalRunTime = dataFrame:CreateFontString("KM_PlayerFrameTyranRunTime"..mapId, "OVERLAY", "KeyMasterFontBig")
        dataFrame.tyrannicalRunTime:SetPoint("RIGHT", dataFrame, "RIGHT", -afffixRuntimeOffsetx, afffixRuntimeOffsety)
        dataFrame.tyrannicalRunTime:SetJustifyH("CENTER")
        dataFrame.tyrannicalRunTime:SetJustifyV("MIDDLE")
        dataFrame.tyrannicalRunTime:SetText("") 

        if (doOnce == 0) then
            local point, relativeTo, relativePoint, xOfs, yOfs = dataFrame.overallScore:GetPoint()
            point, relativeTo, relativePoint, xOfs, yOfs = dataFrame.tyrannicalLevel:GetPoint()
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
    --detailsFrame:SetPoint("TOPLEFT", contentFrame, "TOPRIGHT", -4, 0)
    detailsFrame:SetPoint("TOPLEFT", _G["KM_PlayerMapInfo"], "TOPRIGHT", -4, 0)
    --detailsFrame:SetPoint("TOPRIGHT", parentFrame, "BOTTOMRIGHT", 0, 0)
    --detailsFrame:SetSize((parentFrame:GetWidth() - _G["KM_PlayerMapInfo"]:GetWidth()+4), contentFrame:GetHeight())
    detailsFrame:SetSize(parentFrame:GetWidth()*0.3, contentFrame:GetHeight())

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

    -- Dungeon Tools Box
    local dungeonToolsFrame = CreateFrame("Frame", "KM_DungeonInfoBox", detailsFrame)
    dungeonToolsFrame:SetPoint("TOP", mapDetails, "BOTTOM", 0, -4)
    dungeonToolsFrame:SetSize(detailsFrame:GetWidth(), (detailsFrame:GetHeight()*0.08)-4)

    dungeonToolsFrame.texture = dungeonToolsFrame:CreateTexture(nil, "BACKGROUND", nil, 0)
    dungeonToolsFrame.texture:SetAllPoints(dungeonToolsFrame)
    dungeonToolsFrame.texture:SetSize(dungeonToolsFrame:GetWidth(), dungeonToolsFrame:GetHeight())
    dungeonToolsFrame.texture:SetColorTexture(0,0,0,1)

    dungeonToolsFrame.textureHighlight = dungeonToolsFrame:CreateTexture(nil, "BACKGROUND", nil, 1)
    dungeonToolsFrame.textureHighlight:SetSize(dungeonToolsFrame:GetWidth(), 64)
    dungeonToolsFrame.textureHighlight:SetPoint("BOTTOMLEFT", dungeonToolsFrame, "BOTTOMLEFT", 0, 0)
    dungeonToolsFrame.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    dungeonToolsFrame.textureHighlight:SetAlpha(highlightAlpha)
    dungeonToolsFrame.textureHighlight:SetVertexColor(hlColor.r,hlColor.g,hlColor.b, highlightAlpha)

    local Hline = KeyMaster:CreateHLine(dungeonToolsFrame:GetWidth()+8, dungeonToolsFrame, "TOP", 0, 0)
    Hline:SetAlpha(0.5)

    -- Dungeon Tools Buton Panel
    local lastDTButton
    -- Dungeon Tools box title
    --[[ dungeonToolsFrame.DetailsTitleDesc = dungeonToolsFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    dungeonToolsFrame.DetailsTitleDesc:SetPoint("TOPLEFT", dungeonToolsFrame, "TOPLEFT", 4, -4)
    dungeonToolsFrame.DetailsTitleDesc:SetText(KeyMasterLocals.PLAYERFRAME.DungeonTools.name)
    dungeonToolsFrame.DetailsTitleDesc:SetTextColor(boxTitler, boxTitleg, boxTitleb, 1)
    dungeonToolsFrame.DetailsTitleDesc:SetJustifyH("LEFT") ]]

    local journalButton = createJournalButton(dungeonToolsFrame)
    journalButton:SetPoint("LEFT", dungeonToolsFrame, "LEFT", 4, 0)

    local instanceMapButton = createInstanceMapButton(dungeonToolsFrame)
    instanceMapButton:SetPoint("LEFT", journalButton, "RIGHT", 0, 0)

    local lfgButton = createLFGButton(dungeonToolsFrame)
    lfgButton:SetPoint("LEFT", instanceMapButton, "RIGHT", 4, 0)
    lastDTButton = lfgButton

    local vaultButton = createVaultButton(dungeonToolsFrame)
    vaultButton:SetPoint("LEFT", lfgButton, "RIGHT", 0, 0)
    lastDTButton = vaultButton

    -- External Addon dependant buttons
    if (C_AddOns.IsAddOnLoaded("MythicDungeonTools")) then
        local mdtButton = createMDTButton(dungeonToolsFrame)
        mdtButton:SetPoint("LEFT", lastDTButton, "RIGHT", 0, 0)
        lastDTButton = mdtButton
    end
    -----------------

    local portalButton = createPortalButton(dungeonToolsFrame)
    if portalButton then
        portalButton:SetPoint("RIGHT", dungeonToolsFrame, "RIGHT", -4, 0)
    end

    -- Score Calc
    local scoreCalc = CreateFrame("Frame", "KM_ScoreCalc", detailsFrame)
    scoreCalc:SetPoint("TOP", dungeonToolsFrame, "BOTTOM", 0, -4)
    scoreCalc:SetSize(detailsFrame:GetWidth(), (detailsFrame:GetHeight()*0.23)-4)
    
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
    
    local scoreCalcBox = CreateFrame("EditBox", "KM_CalcKeyLevel", scoreCalc, "InputBoxTemplate");
    scoreCalcBox:SetPoint("TOPRIGHT", scoreCalc, "TOPRIGHT", -4, -(scoreCalc.DetailsTitleDesc:GetHeight()+2));
    scoreCalcBox:SetWidth(24);
    scoreCalcBox:SetHeight(28);
    scoreCalcBox:SetMovable(false);
    scoreCalcBox:SetAutoFocus(false);
    scoreCalcBox:SetMaxLetters(2);
    scoreCalcBox:SetScript("OnEnterPressed", function(self)
        updateRatingCalculatorMap(self, selectedMapId)
        self:ClearFocus()
    end)
    scoreCalcBox:SetScript("OnMouseDown", function(self)
        self:SetText("")
    end)
    
    scoreCalc.keyLevelTitle = scoreCalc:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    scoreCalc.keyLevelTitle:SetPoint("RIGHT", scoreCalcBox, "LEFT", -8, 0)
    scoreCalc.keyLevelTitle:SetJustifyH("CENTER")
    scoreCalc.keyLevelTitle:SetText(KeyMasterLocals.PLAYERFRAME.KeyLevel.name..":")

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
    vaultDetails:SetSize(detailsFrame:GetWidth(), (detailsFrame:GetHeight()*0.34)-4)

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
    vaultDetails.divider1:SetPoint("RIGHT", vaultDetails, "RIGHT", -80, -10)
    vaultDetails.divider1:SetAlpha(0.3)

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

function PlayerFrame:CreateMythicPlusDetailsFrame(parentFrame, contentFrame)
    local highlightAlpha = 0.5
    local hlColor = {}
    local hlColorString = "color_NONPHOTOBLUE"
    hlColor.r, hlColor.g, hlColor.b, _ = Theme:GetThemeColor(hlColorString)
    local mythicPlusDetailsFrame = CreateFrame("Frame", "KM_MythicPlusDetailsFrame", parentFrame)
    mythicPlusDetailsFrame:SetPoint("BOTTOMRIGHT", parentFrame, "BOTTOMRIGHT", -4, 4)
    mythicPlusDetailsFrame:SetSize(parentFrame:GetWidth() - (_G["KM_PlayerMapInfo"]:GetWidth()) - (_G["KM_PlayerFrame_MapDetails"]:GetWidth()) - 8, _G["KM_PlayerMapInfo"]:GetHeight()-4)

    mythicPlusDetailsFrame.texture = mythicPlusDetailsFrame:CreateTexture(nil, "BACKGROUND", nil, 0)
    mythicPlusDetailsFrame.texture:SetAllPoints(mythicPlusDetailsFrame)
    mythicPlusDetailsFrame.texture:SetSize(mythicPlusDetailsFrame:GetWidth(), mythicPlusDetailsFrame:GetHeight())
    mythicPlusDetailsFrame.texture:SetColorTexture(0,0,0,1)

    mythicPlusDetailsFrame.texture.overlay = mythicPlusDetailsFrame:CreateTexture(nil, "ARTWORK", nil, 0)
    mythicPlusDetailsFrame.texture.overlay:SetAllPoints(mythicPlusDetailsFrame)
    mythicPlusDetailsFrame.texture.overlay:SetSize(mythicPlusDetailsFrame:GetWidth(), mythicPlusDetailsFrame:GetHeight())
    mythicPlusDetailsFrame.texture.overlay:SetAtlas("groupfinder-background")
    mythicPlusDetailsFrame.texture.overlay:SetTexCoord(0.55, 0.85, 0, 1)

    mythicPlusDetailsFrame.textureHighlight = mythicPlusDetailsFrame:CreateTexture(nil, "ARTWORK", nil, 1)
    mythicPlusDetailsFrame.textureHighlight:SetSize(mythicPlusDetailsFrame:GetWidth(), 64)
    mythicPlusDetailsFrame.textureHighlight:SetPoint("BOTTOMLEFT", mythicPlusDetailsFrame, "BOTTOMLEFT", 0, 0)
    mythicPlusDetailsFrame.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    mythicPlusDetailsFrame.textureHighlight:SetAlpha(highlightAlpha)
    mythicPlusDetailsFrame.textureHighlight:SetVertexColor(hlColor.r,hlColor.g,hlColor.b, highlightAlpha)

    local Hline = KeyMaster:CreateHLine(mythicPlusDetailsFrame:GetWidth()+8, mythicPlusDetailsFrame, "TOP", 0, 0)
    Hline:SetAlpha(0.5)

    return mythicPlusDetailsFrame

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
    vaultRowFrame.vaultComplete:SetSize(42,38)

    vaultRowFrame:SetSize(parentFrame:GetWidth(), vaultRowHeight)
    vaultRowFrame.vaultTotals = vaultRowFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    vaultRowFrame.vaultTotals:SetPoint("RIGHT", vaultRowFrame.vaultComplete, "LEFT", 0, -1)
    vaultRowFrame.vaultTotals:SetSize(parentFrame:GetWidth()*0.15, vaultRowFrame:GetHeight())
    vaultRowFrame.vaultTotals:SetJustifyV("MIDDLE")
    vaultRowFrame:SetAttribute("vaultTotals", vaultRowFrame.vaultRuns)
    
    vaultRowFrame.vaultRuns = vaultRowFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    vaultRowFrame.vaultRuns:SetPoint("LEFT", vaultRowFrame, "LEFT", 8, -1)
    vaultRowFrame.vaultRuns:SetSize(vaultRowFrame:GetWidth()*0.54, vaultRowFrame:GetHeight()-4)
    local Path, _, Flags = vaultRowFrame.vaultRuns:GetFont()
    vaultRowFrame.vaultRuns:SetFont(Path, 16, Flags)
    vaultRowFrame.vaultRuns:SetJustifyH("CENTER")
    vaultRowFrame.vaultRuns:SetJustifyV("MIDDLE")
    vaultRowFrame:SetAttribute("vaultRuns", vaultRowFrame.vaultRuns)

    -- WIP
    vaultRowFrame.bgTexture = vaultRowFrame:CreateTexture(nil, "ARTWORK")
    vaultRowFrame.bgTexture:SetTexture("interface/weeklyreward/evergreenweeklyrewardui")
    vaultRowFrame.bgTexture:SetTexCoord(0.42529296875, 0.642578125, 0.6728515625, 0.697265625)
    vaultRowFrame.bgTexture:SetPoint("CENTER", vaultRowFrame.vaultRuns, "CENTER", 0, -1)
    vaultRowFrame.bgTexture:SetSize(vaultRowFrame.vaultRuns:GetWidth(), 25) -- 442/47
    vaultRowFrame.bgTexture:SetVertexColor(1,1,1, 0.3)

    -- todo: for testing - delete after addressing new vault look
    --[[ vaultRowFrame.vaultRuns.texture = vaultRowFrame:CreateTexture(nil, "BACKGROUND", nil)
    vaultRowFrame.vaultRuns.texture:SetAllPoints(vaultRowFrame.vaultRuns)
    vaultRowFrame.vaultRuns.texture:SetSize(vaultRowFrame.vaultRuns:GetWidth(), vaultRowFrame.vaultRuns:GetHeight())
    vaultRowFrame.vaultRuns.texture:SetColorTexture(1,0,0,0.5) ]]
    -----------------

    parentFrame:SetAttribute("vault"..vaultRowNumber,  vaultRowFrame)

    return vaultRowFrame
end

-- creates the entire player frame and sub-frames
function PlayerFrame:Initialize(parentFrame)
    -- Player Tab
    local playerContent = _G["KM_PlayerContentFrame"] or PlayerFrame:CreatePlayerContentFrame(parentFrame)
    local playerFrame = _G["KM_Player_Frame"] or PlayerFrame:CreatePlayerFrame(playerContent)
    local playerMapFrame = _G["KM_PlayerMapInfo"] or PlayerFrame:CreateMapData(playerFrame, playerContent)
    local PlayerFrameMapDetails = _G["KM_PlayerFrame_MapDetails"] or PlayerFrame:CreateMapDetailsFrame(playerFrame, playerMapFrame)
    local mythicPlusDetailsFrame = _G["KM_MythicPlusDetailsFrame"] or PlayerFrame:CreateMythicPlusDetailsFrame(playerContent, playerContent)

    -- Mythic Vault Progress
    local vaultDetails = _G["KM_VaultDetailView"]
    local MythicPlusEventTypeId = 1
    for i=1,3 do
        local vaultRow = createVaultRow(i, vaultDetails)
    end
    
    return playerContent
end