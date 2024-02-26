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

function ViewModel:HighlightKeystones(mapId, level)
    if (mapId == nil or mapId == 0) then
        KeyMaster:_DebugMsg("HighlightKeystones", "ViewModel", "Parameter mapId cannot be empty.")
        return
    end
    -- Highlight column for mapid for each row member
    local rows = {"player", "party1", "party2", "party3", "party4"}
    local counter = 1
    for _,unitid in pairs(rows) do
        local visible = false
        if (UnitGUID(unitid) ~= nil) then
            visible = true
        end
        KeyMaster.MainInterface:PartyColHighlight("KM_MapData"..counter..mapId, visible)
        counter = counter + 1
    end

    -- Highlight the header if the player has a higher key
    local keyLevelText = _G["Dungeon_"..mapId.."_HeaderKeyLevelText"]
    local currentLevel = tonumber(keyLevelText:GetText())
    if (currentLevel == nil or level > currentLevel) then
        keyLevelText:SetText(level)
        keyLevelText:Show()
    else
        keyLevelText:Hide()
    end    
end
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
    --_G["KM_Portrait"..partyPlayer]:SetTexture("Interface\\AddOns\\KeyMaster\\Assets\\Images\\portrait_default")
    -- local tex = _G["KM_Portrait"..partyPlayer]:GetTexture()
    -- print(tex) 
    
    --_G["KM_Portrait"..partyPlayer]:SetTexture("Interface\\AddOns\\KeyMaster\\Assets\\Images\\portrait_default")
    
        
    -- Spec & Class
    local unitClassSpec
    local unitClass, _ = UnitClass(unitId)
    local unitSpecialization = CharacterInfo:GetPlayerSpecialization(unitId)
    if unitSpecialization ~= nil then
        unitClassSpec = unitSpecialization.." "..unitClass
    else
        unitClassSpec = unitClass
    end
    _G["KM_Player"..partyPlayer.."Class"]:SetText(unitClassSpec)
        
    -- Player Name
    _G["KM_PlayerName"..partyPlayer]:SetText("|cff"..CharacterInfo:GetMyClassColor(unitId)..playerData.name.."|r")

    -- Player Rating
    _G["KM_Player"..partyPlayer.."OverallRating"]:SetText(playerData.mythicPlusRating)

    -- if unitId == "player" then
    --     local myRatingColor = C_ChallengeMode.GetDungeonScoreRarityColor(playerData.mythicPlusRating) -- todo: cache this? but it is relevant to the client rating.
    --     _G["KeyMaster_RatingScore"]:SetTextColor(myRatingColor.r, myRatingColor.g, myRatingColor.b)
    --     _G["KeyMaster_RatingScore"]:SetText((playerData.mythicPlusRating)) -- todo: This doesn't belong here. Refreshes rating in header.    
    -- end

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

function ViewModel:GetKeystoneRating(keyLevel, mapid)
    local mapTable = DungeonTools:GetCurrentSeasonMaps()
    local dungeonTimer = mapTable[mapid].timeLimit
    
    local keyRating = KeyMaster.DungeonTools:CalculateRating(playerData.ownedKeyId, playerData.ownedKeyLevel, dungeonTimer)
    local fortRating = playerData.DungeonRuns[playerData.ownedKeyId]["Fortified"].Score
    local tyranRating = playerData.DungeonRuns[playerData.ownedKeyId]["Tyrannical"].Score
    local currentOverallRating = playerData.DungeonRuns[playerData.ownedKeyId].bestOverall
    local currentWeeklyAffix = DungeonTools:GetWeeklyAffix()
    if (currentWeeklyAffix == "Tyrannical") then
        if keyRating > tyranRating then
            print("You have a higher rating on Tyrannical than your key.")
        else
            print("You have a lower rating on Tyrannical than your key.")
        end
    else
        if keyRating > fortRating then
            local newTotal = DungeonTools:CalculateDungeonTotal(keyRating, tyranRating)
            local mapTallyFrame = _G["KM_MapTallyScore"..playerData.ownedKeyId]
            mapTallyFrame:SetText(newTotal-currentOverallRating)

        else
            print("You CANNOT gain fortified score from your key.")
        end
    end
end

function ViewModel:CalculateTotalRatingGainPotential()
    local keystoneInformation = {}

    local partyMembers = {"player", "party1", "party2", "party3", "party4"}
    for _,unitId in pairs(partyMembers) do
        local unitGuid = UnitGUID(unitId)
        if (unitGuid ~= nil) then
            local playerData = KeyMaster.UnitData:GetUnitDataByGUID(unitGuid)
            if playerData ~= nil then
                if (playerData.ownedKeyId ~= nil and playerData.ownedKeyLevel ~= nil) then
                    local keyData = {}
                    keyData.ownedKeyId = playerData.ownedKeyId
                    keyData.ownedKeyLevel = playerData.ownedKeyLevel
                    tinsert(keystoneInformation, keyData)
                end    
            end            
        end
    end

    local mapTable = DungeonTools:GetCurrentSeasonMaps()
    local currentWeeklyAffix = DungeonTools:GetWeeklyAffix()
    
    for _, keyData in pairs(keystoneInformation) do
        local dungeonTimer = mapTable[keyData.ownedKeyId].timeLimit
        local totalKeyRatingChange = 0
        for _, unitid in pairs(partyMembers) do
            local unitGuid = UnitGUID(unitid)
            if (unitGuid ~= nil) then
                local playerData = KeyMaster.UnitData:GetUnitDataByGUID(unitGuid)
                local ratingChange = KeyMaster.DungeonTools:CalculateRating(playerData.ownedKeyId, playerData.ownedKeyLevel, dungeonTimer)
                local fortRating = playerData.DungeonRuns[playerData.ownedKeyId]["Fortified"].Score
                local tyranRating = playerData.DungeonRuns[playerData.ownedKeyId]["Tyrannical"].Score
                local currentOverallRating = playerData.DungeonRuns[playerData.ownedKeyId].bestOverall
                
                if (currentWeeklyAffix == "Tyrannical") then
                    if ratingChange > tyranRating then
                        local newTotal = DungeonTools:CalculateDungeonTotal(ratingChange, fortRating)
                        totalKeyRatingChange = totalKeyRatingChange + (newTotal - currentOverallRating)
                    end
                else
                    if ratingChange > fortRating then
                        local newTotal = DungeonTools:CalculateDungeonTotal(ratingChange, tyranRating)
                        totalKeyRatingChange = totalKeyRatingChange + (newTotal - currentOverallRating)
                    end
                end                
            end
        end
        local mapTallyFrame = _G["KM_MapTallyScore"..keyData.ownedKeyId]
        mapTallyFrame:SetText(KeyMaster:RoundToOneDecimal(totalKeyRatingChange))
    end
end