local _, KeyMaster = ...
KeyMaster.PlayerFrameMapping = {}
local CharacterInfo = KeyMaster.CharacterInfo
local DungeonTools = KeyMaster.DungeonTools
local PlayerFrameMapping = KeyMaster.PlayerFrameMapping
local Theme = KeyMaster.Theme
local CharacterData = KeyMaster.CharacterData

local defaultString = 0

local function setVaultStatusIcon(vaultRowFrame, isCompleted)
    local image = "Interface/Addons/KeyMaster/Assets/Images/"..Theme.style
    vaultRowFrame.vaultComplete:SetTexture(image)
    if (isCompleted) then
        vaultRowFrame.vaultComplete:SetTexCoord(992/1024 , 1, 0, 32/1024)
    else
        vaultRowFrame.vaultComplete:SetTexCoord(992/1024 , 1, 32/1024, 64/1024)
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

function PlayerFrameMapping:CalculateRatingGain(mapId, keyLevel, weeklyAffix)
    local scoreFrame = _G["KM_ScoreCalcScores"]
    if scoreFrame == nil then
        KeyMaster:_ErrorMsg("CalculateRatingGain", "PlayerFrameMapping.lua", "Unable to find ScoreCalcScores frame.")
        return
    end

    local mapTable = DungeonTools:GetCurrentSeasonMaps()
    local dungeonTimeLimit = mapTable[mapId].timeLimit

    local selectedCharacterGUID = CharacterData:GetSelectedCharacterGUID()
    if selectedCharacterGUID == nil then
        selectedCharacterGUID = UnitGUID("player")
    end
    local playerData = CharacterData:GetCharacterDataByGUID(selectedCharacterGUID)
    if playerData == nil then
        playerData = KeyMaster.UnitData:GetUnitDataByUnitId("player")
    end

    local ratingChange = KeyMaster.DungeonTools:CalculateRating(mapId, keyLevel, dungeonTimeLimit)
    local fortRating = playerData.DungeonRuns[mapId]["Fortified"].Rating
    local tyranRating = playerData.DungeonRuns[mapId]["Tyrannical"].Rating
    local currentOverallRating = playerData.DungeonRuns[mapId].bestOverall
    
    local totalKeyRatingChange = 0
    if (weeklyAffix == "Tyrannical") then
        if ratingChange > tyranRating then
            local newTotal = DungeonTools:CalculateDungeonTotal(ratingChange, fortRating)
            scoreFrame.ratingGain:SetText(getNumberPerferenceValue(newTotal - currentOverallRating))
            totalKeyRatingChange = newTotal - currentOverallRating
        else
            scoreFrame.ratingGain:SetText("0")
        end
    else
        if ratingChange > fortRating then
            local newTotal = DungeonTools:CalculateDungeonTotal(ratingChange, tyranRating)
            scoreFrame.ratingGain:SetText(getNumberPerferenceValue(newTotal - currentOverallRating))
            totalKeyRatingChange = newTotal - currentOverallRating
        else
            scoreFrame.ratingGain:SetText("0")
        end
    end
    
    local newOverall = playerData.mythicPlusRating + totalKeyRatingChange
    newOverall = getNumberPerferenceValue(newOverall)
    scoreFrame.newRating:SetText(newOverall)

    if weeklyAffix == "Tyrannical" then
        weeklyAffix = KeyMasterLocals.TYRANNICAL
    elseif weeklyAffix == "Fortified" then
        weeklyAffix = KeyMasterLocals.FORTIFIED
    else
        weeklyAffix = "Tyrannical"
        KeyMaster:_ErrorMsg("CalculateRatingGain", "PlayerFrameMapping.lua", "Unable to determine weeklyAffix. Defaulting to Tyrannical.")
    end
    
    scoreFrame.keyLevel:SetText(keyLevel.." "..weeklyAffix)
end

function PlayerFrameMapping:RefreshData(fetchNew)
    local playerFrame = _G["KM_Player_Frame"]
    local playerMapData = _G["KM_PlayerMapInfo"]

    if fetchNew == nil then fetchNew = true end     
    if fetchNew then
        local playerData = CharacterInfo:GetMyCharacterInfo()
        KeyMaster.UnitData:SetUnitData(playerData)
        CharacterData:SetCharacterData(UnitGUID("player"), playerData)
    end

    -- reset score calculation state
    local scoreCalcScores = _G["KM_ScoreCalcScores"]
    local scoreCalcDirection = _G["KM_ScoreCalcDirection"]
    scoreCalcDirection:Show()
    scoreCalcScores:Hide()

    local playerFrame = _G["KM_Player_Frame"]

    local selectedCharacterGUID = CharacterData:GetSelectedCharacterGUID()
    if selectedCharacterGUID == nil then
        selectedCharacterGUID = UnitGUID("player")
    end
    
    local selectedCharacterClass
    local selectedCharacterName
    local selectedCharacterRealm
    if KeyMaster_C_DB[selectedCharacterGUID] == nil then
        _, selectedCharacterClass = UnitClassBase("PLAYER")  
        selectedCharacterName = UnitName("player")
        selectedCharacterRealm = GetRealmName()
    else
        selectedCharacterClass = KeyMaster_C_DB[selectedCharacterGUID].class
        selectedCharacterName = KeyMaster_C_DB[selectedCharacterGUID].name
        selectedCharacterRealm = KeyMaster_C_DB[selectedCharacterGUID].realm
    end
    
    -- character class    
    local localizedClassName, className, _ = GetClassInfo(selectedCharacterClass)
    local classRGB = {}  
    local hexColor
    classRGB.r, classRGB.g, classRGB.b, hexColor = GetClassColor(className)
    playerFrame.playerDetails:SetText(localizedClassName)

    -- character row highlight
    local highlightFrame = _G["KM_PlayerFrameHighlight"]
    highlightFrame.textureHighlight:SetVertexColor(classRGB.r, classRGB.g, classRGB.b, 1)

    -- character name            
    playerFrame.playerName:SetText("|c"..hexColor..selectedCharacterName.."|r")
    playerFrame.playerNameLarge:SetText("|c"..hexColor..selectedCharacterName.."|r")

    -- character realm    
    playerFrame.realmName:SetText(selectedCharacterRealm)

    -- character icon/modelFrame    
    local characterIconFrame = _G["KM_CharacterIcon"]
    local playerModelFrame = _G["KM_PlayerModel"]
    if UnitGUID("player") == selectedCharacterGUID then
        playerModelFrame:Show()
        characterIconFrame:Hide()
    else
        playerModelFrame:Hide()
        characterIconFrame.icon:SetVertexColor(classRGB.r, classRGB.g, classRGB.b, 0.15)
        --local coords = CLASS_ICON_TCOORDS[className]
        --characterIconFrame.icon:SetTexCoord(unpack(coords))
        --characterIconFrame.icon:SetTexture("")
        characterIconFrame:Show()
    end    

    -- character data
    local playerData = CharacterData:GetCharacterDataByGUID(selectedCharacterGUID) --or KeyMaster.UnitData:GetUnitDataByUnitId("player")
    --KeyMaster:TPrint(playerData)

    -- Player Dungeon Rating
    playerFrame.playerRating:SetText(playerData.mythicPlusRating or defaultString)

    -- Player Dungeon Runs
    local mapTable = DungeonTools:GetCurrentSeasonMaps()
    for mapId, _ in pairs(mapTable) do
        local mapFrame = _G["KM_PlayerFrameMapInfo"..mapId]

        local playerMapDataFrame = _G["KM_PlayerFrame_Data"..mapId]

        -- Find highest affix for rating calculation
        local highestAffix = "Fortified"
        if playerData.DungeonRuns[mapId]["Tyrannical"].Rating > playerData.DungeonRuns[mapId]["Fortified"].Rating then
            highestAffix = "Tyrannical"
        end

        ------------ Tyrannical ------------

        -- Tyrannical Dungeon Level
        local tyrannicalLevel = playerData.DungeonRuns[mapId]["Tyrannical"].Level
        playerMapDataFrame.tyrannicalLevel:SetText(tyrannicalLevel or defaultString)

        -- Tyrannical Bonus Time
        local tyrannicalBonusTime = DungeonTools:CalculateChest(mapId, playerData.DungeonRuns[mapId]["Tyrannical"].DurationSec)
        playerMapDataFrame.tyrannicalBonus:SetText(tyrannicalBonusTime)

        -- Dungeon Ratings
        local tyrannicalRating = playerData.DungeonRuns[mapId]["Tyrannical"].Rating
        if highestAffix == "Tyrannical" then
            tyrannicalRating = tyrannicalRating * 1.5
        else
            tyrannicalRating = tyrannicalRating * 0.5
        end
        tyrannicalRating = getNumberPerferenceValue(tyrannicalRating)        
        playerMapDataFrame.tyrannicalScore:SetText(tyrannicalRating or defaultString)        
                
        -- Tyrannical Run Time
        local tyrannicalRunTime = KeyMaster:FormatDurationSec(playerData.DungeonRuns[mapId]["Tyrannical"].DurationSec)
        playerMapDataFrame.tyrannicalRunTime:SetText(tyrannicalRunTime or "--:--") 

        ------------ FORTIFIED ------------

        -- Fortified Dungeon Level
        local fortifiedLevel = playerData.DungeonRuns[mapId]["Fortified"].Level
        playerMapDataFrame.fortifiedLevel:SetText(fortifiedLevel or defaultString)

        -- Fortified Bonus Time
        local fortifiedBonusTime = DungeonTools:CalculateChest(mapId, playerData.DungeonRuns[mapId]["Fortified"].DurationSec)
        playerMapDataFrame.fortifiedBonus:SetText(fortifiedBonusTime)

        -- Fortified Dungeon Score
        local fortifiedRating = playerData.DungeonRuns[mapId]["Fortified"].Rating
        if highestAffix == "Fortified" then
            fortifiedRating = fortifiedRating * 1.5
        else
            fortifiedRating = fortifiedRating * 0.5
        end
        fortifiedRating = getNumberPerferenceValue(fortifiedRating)
        playerMapDataFrame.fortifiedScore:SetText(fortifiedRating or defaultString)
        
        -- Fortified Run Time
        local fortifiedRunTime = KeyMaster:FormatDurationSec(playerData.DungeonRuns[mapId]["Fortified"].DurationSec)
        playerMapDataFrame.fortifiedRunTime:SetText(fortifiedRunTime)

        -- Overall Dungeon Score
        local mapOverallRating = fortifiedRating + tyrannicalRating
        mapOverallRating = getNumberPerferenceValue(mapOverallRating)
        playerMapDataFrame.overallScore:SetText(mapOverallRating or defaultString)
    end

    -- Player Mythic Plus Weekly Vault
    local MythicPlusEventTypeId = 1
    local thresholds = KeyMaster.WeeklyRewards:GetVaultThresholds(MythicPlusEventTypeId)
    --local bestKeys = KeyMaster.WeeklyRewards:GetMythicPlusWeeklyVaultTopKeys() -- TODO: Get this from characterdata
    local bestKeys
    if KeyMaster_C_DB[selectedCharacterGUID] ~= nil then
        bestKeys = KeyMaster_C_DB[selectedCharacterGUID].vault
    end    
    if bestKeys == nil then
        bestKeys = {}
    end
    local numKeysCompleted = #bestKeys
    if numKeysCompleted > 0 then
        local numKeysCompleted = #bestKeys
        local previousThreshold = 1
        for index=1,#thresholds, 1 do         
            local vaultKeysOutput = ""
            local firstKey = true
            for keyIndex = previousThreshold, thresholds[index], 1 do
                if bestKeys[keyIndex] ~= nil then
                    if firstKey then
                        vaultKeysOutput = bestKeys[keyIndex]
                        firstKey = false
                    else
                        vaultKeysOutput = vaultKeysOutput..", "..bestKeys[keyIndex]
                    end
                end
                previousThreshold = thresholds[index] + 1
            end

            local isCompleted = false
            local vaultThreshhold
            if numKeysCompleted >= thresholds[index] then
                vaultThreshhold = thresholds[index].."/"..thresholds[index]
                isCompleted = true
            else
                vaultThreshhold = numKeysCompleted.."/"..thresholds[index]
            end

            local vaultRowFrame = _G["KM_VaultRow"..index]
            if vaultRowFrame ~= nil then
                -- Set Vault Threshold
                vaultRowFrame.vaultTotals:SetText(vaultThreshhold)

                -- Set Vault Runs
                vaultRowFrame.vaultRuns:SetText(vaultKeysOutput)

                -- Set Vault Slot Image
                setVaultStatusIcon(vaultRowFrame, isCompleted)
            end
        end      
    else
        for index=1,#thresholds, 1 do
            local vaultThreshhold = numKeysCompleted.."/"..thresholds[index]
            local vaultRowFrame = _G["KM_VaultRow"..index]
            if vaultRowFrame ~= nil then
                -- Set Vault Threshold
                vaultRowFrame.vaultTotals:SetText(vaultThreshhold)

                -- Set Vault Runs
                vaultRowFrame.vaultRuns:SetText("")

                -- Set Vault Slot Image
                setVaultStatusIcon(vaultRowFrame, false)
            end
        end
    end
end