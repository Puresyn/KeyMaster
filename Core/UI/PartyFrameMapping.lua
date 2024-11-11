local _, KeyMaster = ...
KeyMaster.PartyFrameMapping = {}
local PartyFrameMapping = KeyMaster.PartyFrameMapping
local CharacterInfo = KeyMaster.CharacterInfo
local DungeonTools = KeyMaster.DungeonTools
local Theme = KeyMaster.Theme
local UnitData = KeyMaster.UnitData

local partyFrameLookup = {
    ["player"] = "KM_PlayerRow1",
    ["party1"] = "KM_PlayerRow2",
    ["party2"] = "KM_PlayerRow3",
    ["party3"] = "KM_PlayerRow4",
    ["party4"] = "KM_PlayerRow5"
}

function PartyFrameMapping:ShowPartyRow(unitId)
    if _G["KeyMaster_MainFrame"]:IsShown() then
        if not KM_PLAYER_IN_COMBAT then
            _G[partyFrameLookup[unitId]]:Show()
        end
    end
end

function PartyFrameMapping:HidePartyRow(unitId)
    _G[partyFrameLookup[unitId]]:Hide()
end

function PartyFrameMapping:HideAllPartyFrame()
    for i=1,4,1 do
        _G[partyFrameLookup["party"..i]]:Hide()
    end
end

function PartyFrameMapping:ResetTallyFramePositioning()
    local parentFrame = KeyMaster:FindLastVisiblePlayerRow()
    local tallyFrame = _G["PartyTallyFooter"]
    if tallyFrame ~= nil then
        tallyFrame:SetPoint("TOPRIGHT", parentFrame, "BOTTOMRIGHT", 0, -4)
    end
end

local function getNumberPerferenceValue(number)
    local result = 0
    if KeyMaster_DB.addonConfig.showRatingFloat then
        result = KeyMaster:RoundSingleDecimal(number)
    else
        result = KeyMaster:RoundWholeNumber(number)
    end

    return result
end

-- fades all text data on unit frames for dungeons that do not have a keystone in the party
local function fadeNonKeystoneData()
    local mapTable = DungeonTools:GetCurrentSeasonMaps()
    local hasKeystones = false
    
    -- check if any keystone is present in the party
    local partyMembers = {"player", "party1", "party2", "party3", "party4"}
    for _,unitId in pairs(partyMembers) do
        local unitGuid = UnitGUID(unitId)
        if (unitGuid ~= nil) then
            local playerData = KeyMaster.UnitData:GetUnitDataByGUID(unitGuid)
            if playerData ~= nil and playerData.ownedKeyLevel ~= 0 then
                hasKeystones = true
                break
            end
        end
    end

    -- someone has a key, so exit early to avoid unnecessary fading
    if hasKeystones == false then
        return
    end

    -- fade non-keystone data
    for i=1,5,1 do
        for mapId,_ in pairs(mapTable) do
            local keyLevelText = _G["Dungeon_"..mapId.."_HeaderKeyLevelText"]
            local currentLevel = tonumber(keyLevelText:GetText()) -- non-parsable number will return nil
            if currentLevel == nil then
                _G["KM_MapData"..i..mapId]:SetAlpha(0.6)
            end
        end
    end
end

-- hides all highlight frames
local function resetKeystoneHighlights()
    local mapTable = DungeonTools:GetCurrentSeasonMaps()    
    for mapId,_ in pairs(mapTable) do
        -- reset all text alpha to 100%
        for i=1,5,1 do
            _G["KM_MapData"..i..mapId]:SetAlpha(1)
        end
        -- remove all text on dungeon icons
        local keyLevelText = _G["Dungeon_"..mapId.."_HeaderKeyLevelText"]
        _G["KM_GroupKeyShadow"..mapId]:Hide()
        _G["KM_MapHeaderHighlight"..mapId]:Hide()
        keyLevelText:SetText("")
    end
end

-- updates the keystone highlights for each party member for known keys
-- highlights include vertical bars and the dungeon level text in dungeon icon row
function PartyFrameMapping:UpdateKeystoneHighlights()
    -- resets all highlights and text to default
    resetKeystoneHighlights()

    local partyMembers = {"player", "party1", "party2", "party3", "party4"}
    for _,unitId in pairs(partyMembers) do
        local unitGuid = UnitGUID(unitId)
        if (unitGuid ~= nil) then
            local unitData = KeyMaster.UnitData:GetUnitDataByGUID(unitGuid)
            if unitData ~= nil and unitData.ownedKeyLevel ~= 0 then

                -- insert key level into dungeon icon
                local keyLevelText = _G["Dungeon_"..unitData.ownedKeyId.."_HeaderKeyLevelText"]
                local currentLevel = tonumber(keyLevelText:GetText())
                if currentLevel == nil or currentLevel == "" then currentLevel = 0 end
                if unitData.ownedKeyLevel >= currentLevel then
                    keyLevelText:SetText(unitData.ownedKeyLevel)
                    _G["KM_GroupKeyShadow"..unitData.ownedKeyId]:Show()
                    _G["KM_MapHeaderHighlight"..unitData.ownedKeyId]:Show()
                end
                keyLevelText:Show()
            end         
        end
    end

    -- fade non-active keystone data
    fadeNonKeystoneData()
end

-- Party member data assign
function PartyFrameMapping:UpdateUnitFrameData(unitId, playerData)
    if(unitId == nil) then 
        KeyMaster:_ErrorMsg("UpdateUnitFrameData", "PartyFrameMapping", "Parameter unitId cannot be empty.")
        return
    end

    --local playerData = UnitData:GetUnitDataByUnitId(unitId)
    if(playerData == nil) then 
        KeyMaster:_ErrorMsg("UpdateUnitFrameData", "PartyFrameMapping", "\"playerData\" cannot be empty.")
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
    
    -- Set Player Portrait
    if UnitIsConnected(unitId) then
        SetPortraitTexture(_G["KM_Portrait"..partyPlayer], unitId)
    else
        _G["KM_Portrait"..partyPlayer]:SetTexture("interface/Addons/KeyMaster/Assets/Images/portrait_x")
    end    
          
    -- Spec & Class
    local unitClassSpec
    local unitClass, _ = UnitClass(unitId)
    local unitSpecialization
    local clientLang = GetLocale()
    if (clientLang == "enUS" or clientLang == "zhTW") then -- Filter on enUS because many other languages seems to have length issues in the current layout
        unitSpecialization = CharacterInfo:GetPlayerSpecialization(unitId)
    end
    if unitSpecialization ~= nil then
        unitClassSpec = unitSpecialization.." "..unitClass
    else
        unitClassSpec = unitClass
    end
    local unitClassForColor
    _, unitClassForColor, _ = UnitClass(unitId)
    local classRGB = {}  
    classRGB.r, classRGB.g, classRGB.b, _ = GetClassColor(unitClassForColor)
    _G["KM_Player_Row_Class_Bios"..partyPlayer]:SetVertexColor(classRGB.r, classRGB.g, classRGB.b, 1)
    _G["KM_Player"..partyPlayer.."Class"]:SetText(unitClassSpec)
        
    -- Player Name
    _G["KM_PlayerName"..partyPlayer]:SetText("|cff"..CharacterInfo:GetMyClassColor(unitId)..playerData.name.."|r")

    -- Player Rating
    _G["KM_Player"..partyPlayer.."OverallRating"]:SetText(playerData.mythicPlusRating)

    -- Dungeon Key Information
    local keyInfoFrame = _G["KM_OwnedKeyInfo"..partyPlayer]    
    if (not playerData.ownedKeyLevel or playerData.ownedKeyLevel == 0) then
        keyInfoFrame:SetText("")
        if (playerData.hasAddon == true) then
            keyInfoFrame:SetText(KeyMasterLocals.PARTYFRAME["NoKey"].name)
        end
    else 
        local ownedKeyLevel = "("..playerData.ownedKeyLevel..") "
        keyInfoFrame:SetText(ownedKeyLevel..DungeonTools:GetDungeonNameAbbr(playerData.ownedKeyId))
    end
    
    -- Dungeon Scores
    local mapTable = DungeonTools:GetCurrentSeasonMaps()
    if KeyMaster:GetTableLength(playerData.DungeonRuns) ~= 0 then        
        for mapid, v in pairs(mapTable) do
            local chestCount = DungeonTools:CalculateChest(mapid, playerData.ownedKeyLevel, playerData.DungeonRuns[mapid]["DungeonData"].DurationSec)
            local keyLevel = "0"
            if playerData.DungeonRuns[mapid]["DungeonData"].Level ~= nil then
                keyLevel = chestCount .. playerData.DungeonRuns[mapid]["DungeonData"].Level    
            end
            
            _G["KM_MapLevelT"..partyPlayer..mapid]:SetText(keyLevel)
            
            local overallRating = playerData.DungeonRuns[mapid]["DungeonData"].Rating
            if KeyMaster_DB.addonConfig.showRatingFloat then
                overallRating = KeyMaster:RoundSingleDecimal(overallRating)
            else
                overallRating = KeyMaster:RoundWholeNumber(overallRating)
            end

            -- Overall Score
            _G["KM_MapTotalScore"..partyPlayer..mapid]:SetText(overallRating)
        end
        _G["KM_MapDataLegend"..partyPlayer]:Show()
    else
        for n, v in pairs(mapTable) do
            _G["KM_MapLevelT"..partyPlayer..n]:SetText("")
            _G["KM_MapLevelF"..partyPlayer..n]:SetText("")
            _G["KM_MapTotalScore"..partyPlayer..n]:SetText("")
        end
        _G["KM_MapDataLegend"..partyPlayer]:Hide()
    end

    -- check player online/offline status and addon
    if UnitIsConnected(unitId) then
        -- hide offline text
        _G["KM_Player"..partyPlayer.."Offline"]:Hide()

        if playerData.hasAddon then
            -- hide no addon text
            _G["KM_NoAddon"..partyPlayer]:Hide()
        else
            -- show the unit frame for this unit
            _G["KM_NoAddon"..partyPlayer]:Show()
        end
    else
        -- show offline text and hide no addon text
        _G["KM_NoAddon"..partyPlayer]:Hide()
        _G["KM_Player"..partyPlayer.."Offline"]:Hide()
    end  
end

-- resets each unit's "Gain Potential" text for each dungeon to empty
local function resetRatingGains()
    local mapTable = DungeonTools:GetCurrentSeasonMaps()

    for mapId,_ in pairs(mapTable) do
        for i=1,5,1 do
            _G["KM_PointGain"..i..mapId]:SetText("")
        end
        _G["KM_MapTallyScore"..mapId]:SetText("")
    end
end

-- calculates the total rating gain potential for each player in the party
function PartyFrameMapping:CalculateTotalRatingGainPotential()
    resetRatingGains()

    local keystoneInformation = {}
    local mapTable = DungeonTools:GetCurrentSeasonMaps()
    local currentWeeklyAffix = DungeonTools:GetWeeklyAffix()

    local partyMembers = {"player", "party1", "party2", "party3", "party4"}
    for _,unitId in pairs(partyMembers) do
        local unitGuid = UnitGUID(unitId)
        if (unitGuid ~= nil) then
            local playerData = KeyMaster.UnitData:GetUnitDataByGUID(unitGuid)
            if playerData ~= nil then
                if (playerData.ownedKeyLevel ~= 0) then
                    local keyData = {}
                    keyData.ownedKeyId = playerData.ownedKeyId
                    keyData.ownedKeyLevel = playerData.ownedKeyLevel
                    tinsert(keystoneInformation, keyData)
                end    
            end            
        end
    end
    
    -- sort keystone information by level
    table.sort(keystoneInformation, function(a, b) return a.ownedKeyLevel < b.ownedKeyLevel end)

    -- cycle through keystone information to calculate rating gained for EACH unitid (who has the addon installed)
    for _, keyData in pairs(keystoneInformation) do
        local dungeonTimer = mapTable[keyData.ownedKeyId].timeLimit
        local totalKeyRatingChange = 0
        local playerNumber = 1
        for _, unitid in pairs(partyMembers) do
            local unitGuid = UnitGUID(unitid)
            if (unitGuid ~= nil) then
                local playerData = KeyMaster.UnitData:GetUnitDataByGUID(unitGuid)
                if playerData ~= nil and playerData.DungeonRuns ~= nil then
                    --print("Checking rating gain for "..playerData.name.." on key "..keyData.ownedKeyId.." level "..keyData.ownedKeyLevel..".")
                    local ratingChange = KeyMaster.DungeonTools:CalculateRating(keyData.ownedKeyId, keyData.ownedKeyLevel, dungeonTimer)
                    local currentRating = playerData.DungeonRuns[keyData.ownedKeyId]["DungeonData"].Rating
                    local currentOverallRating = playerData.DungeonRuns[keyData.ownedKeyId].bestOverall
                    
                    if ratingChange > currentRating then
                        local gainedRating = ratingChange - currentRating
                        _G["KM_PointGain"..playerNumber..keyData.ownedKeyId]:SetText(getNumberPerferenceValue(gainedRating))
                        totalKeyRatingChange = totalKeyRatingChange + gainedRating
                    else
                        _G["KM_PointGain"..playerNumber..keyData.ownedKeyId]:SetText("0")
                    end
                else
                    --KeyMaster:_DebugMsg("CalculateTotalRatingGainPotential", "PartyFrameMapping", "Player data not found for "..unitid)
                end                               
            end
            playerNumber = playerNumber + 1
        end
        
        local mapTallyFrame = _G["KM_MapTallyScore"..keyData.ownedKeyId]
        mapTallyFrame:SetText(getNumberPerferenceValue(totalKeyRatingChange))
    end
end

function PartyFrameMapping:UpdateSingleUnitData(unitGUID)
    if unitGUID == nil then
        KeyMaster:_ErrorMsg("MapPartyUnitData", "PartyFrameMapping", "Parameter unitGUID cannot be empty.")
        return
    end
    local unitId = UnitData:GetUnitId(unitGUID)
    if unitId == nil then
        KeyMaster:_ErrorMsg("MapPartyUnitData", "PartyFrame Mapping", "UnitId is nil.  Cannot map data for "..unitGUID)
        return
    end
    -- find if we have data for this player, if not get a set of default data from blizzard
    local unitData = UnitData:GetUnitDataByGUID(unitGUID)
    if unitData == nil then
        unitData = CharacterInfo:GetUnitInfo(unitId)    
    end
    -- remap and display data for this unitid
    PartyFrameMapping:UpdateUnitFrameData(unitId, unitData)
    PartyFrameMapping:ShowPartyRow(unitId)
end

function PartyFrameMapping:UpdatePartyFrameData()
    if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
        PartyFrameMapping:HideAllPartyFrame()  
        PartyFrameMapping:UpdateSingleUnitData(UnitGUID("player"))
        PartyFrameMapping:UpdateKeystoneHighlights()
        PartyFrameMapping:CalculateTotalRatingGainPotential()    
        PartyFrameMapping:ResetTallyFramePositioning()
        if _G["KM_NoPartyInfo"] then _G["KM_NoPartyInfo"]:Show() end
        -- Show explination frame
        return
    end

    if _G["KM_NoPartyInfo"] then _G["KM_NoPartyInfo"]:Hide() end   
    local partyMembers = {"player", "party1", "party2", "party3", "party4"}
    for _,unitId in pairs(partyMembers) do
        local unitGuid = UnitGUID(unitId)
        if (unitGuid ~= nil) then
            PartyFrameMapping:UpdateSingleUnitData(unitGuid)
        else
            PartyFrameMapping:HidePartyRow(unitId)
        end
    end
    PartyFrameMapping:UpdateKeystoneHighlights()
    PartyFrameMapping:CalculateTotalRatingGainPotential()    
    PartyFrameMapping:ResetTallyFramePositioning()    
end
