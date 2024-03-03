local _, KeyMaster = ...
KeyMaster.ViewModel = {}
local ViewModel = KeyMaster.ViewModel
local CharacterInfo = KeyMaster.CharacterInfo
local DungeonTools = KeyMaster.DungeonTools
local Theme = KeyMaster.Theme

local partyFrameLookup = {
    ["player"] = "KM_PlayerRow1",
    ["party1"] = "KM_PlayerRow2",
    ["party2"] = "KM_PlayerRow3",
    ["party3"] = "KM_PlayerRow4",
    ["party4"] = "KM_PlayerRow5"
}

function ViewModel:ShowPartyRow(unitId)
    _G[partyFrameLookup[unitId]]:Show()    
end

function ViewModel:HidePartyRow(unitId)
    _G[partyFrameLookup[unitId]]:Hide()
end

function ViewModel:HideAllPartyFrame()
    for i=1,4,1 do
        _G[partyFrameLookup["party"..i]]:Hide()
    end
end

-- hides all highlight frames
local function resetKeystoneHighlights()
    local mapTable = DungeonTools:GetCurrentSeasonMaps()    
    for mapId,_ in pairs(mapTable) do
        -- hide all highlight frames
        for i=1,5,1 do
            local leftHighlightFrame = _G["KM_MapData"..i..mapId.."_lColHighlight"] 
            local rightHighlightFrame = _G["KM_MapData"..i..mapId.."_rColHighlight"]
            leftHighlightFrame:Hide()
            rightHighlightFrame:Hide()
            _G["KM_MapData"..i..mapId]:SetAlpha(1)
        end
        -- reset text on dungeon icons
        local keyLevelText = _G["Dungeon_"..mapId.."_HeaderKeyLevelText"]
        _G["KM_GroupKeyShadow"..mapId]:Hide()
        _G["KM_MapHeaderHighlight"..mapId]:Hide()
        keyLevelText:SetText("")
    end
end

-- updates the keystone highlights for each party member for known keys
-- highlights include vertical bars and the dungeon level text in dungeon icon row
function ViewModel:UpdateKeystoneHighlights()
    -- resets all highlights and text to default
    resetKeystoneHighlights()

    local partyMembers = {"player", "party1", "party2", "party3", "party4"}
    local counter = 1
    for _,unitId in pairs(partyMembers) do
        local unitGuid = UnitGUID(unitId)
        if (unitGuid ~= nil) then
            local unitData = KeyMaster.UnitData:GetUnitDataByGUID(unitGuid)
            if unitData ~= nil and unitData.ownedKeyLevel ~= 0 then

                -- Highlight the header if the player has a higher key
                local keyLevelText = _G["Dungeon_"..unitData.ownedKeyId.."_HeaderKeyLevelText"]
                local currentLevel = tonumber(keyLevelText:GetText())
                if (currentLevel == nil or unitData.ownedKeyLevel > currentLevel) then
                keyLevelText:SetText(unitData.ownedKeyLevel)
                _G["KM_GroupKeyShadow"..unitData.ownedKeyId]:Show()
                _G["KM_MapHeaderHighlight"..unitData.ownedKeyId]:Show()
                elseif currentLevel ~= "" then
                    -- do nothing
                else
                    keyLevelText:SetText("")
                end
                keyLevelText:Show()    
                
                 -- loop through each unit frame to turn on the highlight
                 for i=1,5,1 do
                    --[[ local leftHighlightFrame = _G["KM_MapData"..i..unitData.ownedKeyId.."_lColHighlight"] 
                    local rightHighlightFrame = _G["KM_MapData"..i..unitData.ownedKeyId.."_rColHighlight"]
                    leftHighlightFrame:Show()
                    rightHighlightFrame:Show() ]]
                end
            end         
        end
        counter = counter + 1
    end
end

--[[ local currentLevel = tonumber(keyLevelText:GetText())
print(currentLevel)
if (currentLevel == nil) then
    _G["KM_MapData"..i..unitData.ownedKeyId]:SetAlpha(0.6)
end ]]

-- Party member data assign
function ViewModel:UpdateUnitFrameData(unitId, playerData)
    if(unitId == nil) then 
        KeyMaster:_ErrorMsg("UpdateUnitFrameData", "ViewModel", "Parameter unitId cannot be empty.")
        return
    end

    --local playerData = UnitData:GetUnitDataByUnitId(unitId)
    if(playerData == nil) then 
        KeyMaster:_ErrorMsg("UpdateUnitFrameData", "ViewModel", "\"playerData\" cannot be empty.")
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
    SetPortraitTexture(_G["KM_Portrait"..partyPlayer], unitId)
          
    -- Spec & Class
    local unitClassSpec
    local unitClass, _ = UnitClass(unitId)
    local unitSpecialization = CharacterInfo:GetPlayerSpecialization(unitId)
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
            keyInfoFrame:SetText("No Key")
        end
    else 
        local ownedKeyLevel = "("..playerData.ownedKeyLevel..") "
        keyInfoFrame:SetText(ownedKeyLevel..DungeonTools:GetDungeonNameAbbr(playerData.ownedKeyId))
    end
    

    -- Dungeon Scores
    local mapTable = DungeonTools:GetCurrentSeasonMaps()
    if KeyMaster:GetTableLength(playerData.DungeonRuns) ~= 0 then        
        for mapid, v in pairs(mapTable) do
            -- Tyrannical
            local tyranChestCount = DungeonTools:CalculateChest(mapid, playerData.DungeonRuns[mapid]["Tyrannical"].DurationSec)
            local tyranScore = tyranChestCount .. playerData.DungeonRuns[mapid]["Tyrannical"].Level
            _G["KM_MapLevelT"..partyPlayer..mapid]:SetText(tyranScore)
            -- Fortified
            local fortChestCount = DungeonTools:CalculateChest(mapid, playerData.DungeonRuns[mapid]["Fortified"].DurationSec)
            local fortScore = fortChestCount .. playerData.DungeonRuns[mapid]["Fortified"].Level
            _G["KM_MapLevelF"..partyPlayer..mapid]:SetText(fortScore)
            -- Overall Score
            _G["KM_MapTotalScore"..partyPlayer..mapid]:SetText(playerData.DungeonRuns[mapid]["bestOverall"])
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

    if (not playerData.hasAddon) then
        _G["KM_NoAddon"..partyPlayer]:Show()        
    else
        _G["KM_NoAddon"..partyPlayer]:Hide()
    end    
end

-- resets each unit's "Gain Potential" text for each dungeon to empty
local function resetPersonalGains()
    local mapTable = DungeonTools:GetCurrentSeasonMaps()

    for i=1,5,1 do
        for mapId,_ in pairs(mapTable) do
            _G["KM_PointGain"..i..mapId]:SetText("")
        end
    end
end

-- calculates the total rating gain potential for each player in the party
function ViewModel:CalculateTotalRatingGainPotential()
    resetPersonalGains()

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
    
    -- cycle through keystone information to calculate rating gained for EACH unitid (who has the addon installed)
    for _, keyData in pairs(keystoneInformation) do
        local dungeonTimer = mapTable[keyData.ownedKeyId].timeLimit
        local totalKeyRatingChange = 0
        local playerNumber = 1
        for _, unitid in pairs(partyMembers) do
            local unitGuid = UnitGUID(unitid)
            if (unitGuid ~= nil) then
                local playerData = KeyMaster.UnitData:GetUnitDataByGUID(unitGuid)
                if playerData ~= nil then
                    --print("Checking rating gain for "..playerData.name.." on key "..keyData.ownedKeyId.." level "..keyData.ownedKeyLevel..".")
                    local ratingChange = KeyMaster.DungeonTools:CalculateRating(keyData.ownedKeyId, keyData.ownedKeyLevel, dungeonTimer)
                    local fortRating = playerData.DungeonRuns[keyData.ownedKeyId]["Fortified"].Score
                    local tyranRating = playerData.DungeonRuns[keyData.ownedKeyId]["Tyrannical"].Score
                    local currentOverallRating = playerData.DungeonRuns[keyData.ownedKeyId].bestOverall
                    
                    if (currentWeeklyAffix == "Tyrannical") then
                        if ratingChange > tyranRating then
                            local newTotal = DungeonTools:CalculateDungeonTotal(ratingChange, fortRating)
                            _G["KM_PointGain"..playerNumber..keyData.ownedKeyId]:SetText(newTotal - currentOverallRating)
                            totalKeyRatingChange = totalKeyRatingChange + (newTotal - currentOverallRating)
                        else
                            _G["KM_PointGain"..playerNumber..keyData.ownedKeyId]:SetText("0")
                        end
                    else
                        if ratingChange > fortRating then
                            local newTotal = DungeonTools:CalculateDungeonTotal(ratingChange, tyranRating)
                            _G["KM_PointGain"..playerNumber..keyData.ownedKeyId]:SetText(newTotal - currentOverallRating)
                            totalKeyRatingChange = totalKeyRatingChange + (newTotal - currentOverallRating)
                        else
                            _G["KM_PointGain"..playerNumber..keyData.ownedKeyId]:SetText("0")
                        end
                    end
                else
                    --KeyMaster:_DebugMsg("CalculateTotalRatingGainPotential", "ViewModel", "Player data not found for "..unitid)
                end                               
            end
            playerNumber = playerNumber + 1
        end
        
        local mapTallyFrame = _G["KM_MapTallyScore"..keyData.ownedKeyId]
        mapTallyFrame:SetText(KeyMaster:RoundToOneDecimal(totalKeyRatingChange))
    end
end

function ViewModel:SetPlayerHeaderKeyInfo()
    local playerData = KeyMaster.UnitData:GetUnitDataByUnitId("player")
    local playerKeyHeader = _G["KeyMaster_MythicKeyHeader"]
    playerKeyHeader.keyLevelText:SetText("--")
    playerKeyHeader.keyAbbrText:SetText("---")
    if (playerData) then
        if (playerData.ownedKeyLevel > 0) then
            playerKeyHeader.keyLevelText:SetText(playerData.ownedKeyLevel)
            playerKeyHeader.keyAbbrText:SetText(DungeonTools:GetDungeonNameAbbr(playerData.ownedKeyId))
        end
    end
end