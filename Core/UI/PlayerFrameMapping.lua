local _, KeyMaster = ...
KeyMaster.PlayerFrameMapping = {}
local CharacterInfo = KeyMaster.CharacterInfo
local DungeonTools = KeyMaster.DungeonTools
local PlayerFrameMapping = KeyMaster.PlayerFrameMapping
local Theme = KeyMaster.Theme

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

function PlayerFrameMapping:CalculateRatingGain(mapId, keyLevel)
    local scoreFrame = _G["KM_ScoreCalcScores"]
    if scoreFrame == nil then
        KeyMaster:_ErrorMsg("CalculateRatingGain", "PlayerFrameMapping.lua", "Unable to find ScoreCalcScores frame.")
        return
    end

    local mapTable = DungeonTools:GetCurrentSeasonMaps()
    local dungeonTimeLimit = mapTable[mapId].timeLimit
    local weeklyAffix = DungeonTools:GetWeeklyAffix()
    local playerData = KeyMaster.UnitData:GetUnitDataByUnitId("player")

    local ratingChange = KeyMaster.DungeonTools:CalculateRating(mapId, keyLevel, dungeonTimeLimit)
    local fortRating = playerData.DungeonRuns[mapId]["Fortified"].Rating
    local tyranRating = playerData.DungeonRuns[mapId]["Tyrannical"].Rating
    local currentOverallRating = playerData.DungeonRuns[mapId].bestOverall
    
    local totalKeyRatingChange = 0
    if (weeklyAffix == "Tyrannical") then
        if ratingChange > tyranRating then
            local newTotal = DungeonTools:CalculateDungeonTotal(ratingChange, fortRating)
            scoreFrame.ratingGain:SetText(newTotal - currentOverallRating)
            totalKeyRatingChange = newTotal - currentOverallRating
        else
            scoreFrame.ratingGain:SetText("0")
        end
    else
        if ratingChange > fortRating then
            local newTotal = DungeonTools:CalculateDungeonTotal(ratingChange, tyranRating)
            scoreFrame.ratingGain:SetText(newTotal - currentOverallRating)
            totalKeyRatingChange = newTotal - currentOverallRating
        else
            scoreFrame.ratingGain:SetText("0")
        end
    end
    
    local newOverall = playerData.mythicPlusRating + totalKeyRatingChange
    
    scoreFrame.newRating:SetText(newOverall)
    
    scoreFrame.keyLevel:SetText(keyLevel.." "..weeklyAffix)
end

function PlayerFrameMapping:RefreshData(fetchNew)
    local playerFrame = _G["KM_Player_Frame"]
    local playerMapData = _G["KM_PlayerMapInfo"]

    if fetchNew == nil then fetchNew = true end
    local playerData 
    if fetchNew then
        playerData = CharacterInfo:GetMyCharacterInfo()
        KeyMaster.UnitData:SetUnitData(playerData)
    else
        playerData = KeyMaster.UnitData:GetUnitDataByUnitId("player")
    end

    -- Player Dungeon Rating
    playerFrame.playerRating:SetText(playerData.mythicPlusRating or defaultString)

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
        if KeyMaster_DB.addonConfig.showRatingFloat then
            tyrannicalRating = KeyMaster:RoundSingleDecimal(tyrannicalRating)
        else
            tyrannicalRating = KeyMaster:RoundWholeNumber(tyrannicalRating)
        end
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
        if KeyMaster_DB.addonConfig.showRatingFloat then
            fortifiedRating = KeyMaster:RoundSingleDecimal(fortifiedRating)
        else
            fortifiedRating = KeyMaster:RoundWholeNumber(fortifiedRating)
        end
        playerMapDataFrame.fortifiedScore:SetText(fortifiedRating or defaultString)
        
        -- Fortified Run Time
        local fortifiedRunTime = KeyMaster:FormatDurationSec(playerData.DungeonRuns[mapId]["Fortified"].DurationSec)
        playerMapDataFrame.fortifiedRunTime:SetText(fortifiedRunTime)

        -- Overall Dungeon Score
        local mapOverallRating = fortifiedRating + tyrannicalRating
        if KeyMaster_DB.addonConfig.showRatingFloat then
            mapOverallRating = KeyMaster:RoundSingleDecimal(mapOverallRating)
        else
            mapOverallRating = KeyMaster:RoundWholeNumber(mapOverallRating)
        end
        playerMapDataFrame.overallScore:SetText(mapOverallRating or defaultString)
    end

    -- Player Mythic Plus Weekly Vault
    local MythicPlusEventTypeId = 1
    local thresholds = KeyMaster.WeeklyRewards:GetVaultThresholds(MythicPlusEventTypeId)
    local bestKeys = KeyMaster.WeeklyRewards:GetMythicPlusWeeklyVaultTopKeys()
    
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

                -- Set Vault Slot Image
                setVaultStatusIcon(vaultRowFrame, isCompleted)
            end
        end
    end
end