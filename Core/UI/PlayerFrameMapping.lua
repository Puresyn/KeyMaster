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
        if playerData == nil then
            PlayerFrameMapping:RefreshData(true)
        end
    end

    -- Player Dungeon Rating
    playerFrame.playerRating:SetText(playerData.mythicPlusRating or defaultString)

    local mapTable = DungeonTools:GetCurrentSeasonMaps()
    for mapId, _ in pairs(mapTable) do
        local mapFrame = _G["KM_PlayerFrameMapInfo"..mapId]

        local playerMapDataFrame = _G["KM_PlayerFrame_Data"..mapId]

        -- Overall Dungeon Score
        local mapScore = playerData.DungeonRuns[mapId].bestOverall
        playerMapDataFrame.overallScore:SetText(mapScore or defaultString)

        ------------ Tyrannical ------------

        -- Tyrannical Dungeon Level
        local tyrannicalLevel = playerData.DungeonRuns[mapId]["Tyrannical"].Level
        playerMapDataFrame.tyrannicalLevel:SetText(tyrannicalLevel or defaultString)

        -- Tyrannical Bonus Time
        local tyrannicalBonusTime = DungeonTools:CalculateChest(mapId, playerData.DungeonRuns[mapId]["Tyrannical"].DurationSec)
        playerMapDataFrame.tyrannicalBonus:SetText(tyrannicalBonusTime)

        -- Tyrannical Dungeon Score
        local tyrannicalScore = playerData.DungeonRuns[mapId]["Tyrannical"].Score
        playerMapDataFrame.tyrannicalScore:SetText(tyrannicalScore or defaultString)
        
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
        local fortifiedScore = playerData.DungeonRuns[mapId]["Fortified"].Score
        playerMapDataFrame.fortifiedScore:SetText(fortifiedScore or defaultString)
        
        -- Fortified Run Time
        local fortifiedRunTime = KeyMaster:FormatDurationSec(playerData.DungeonRuns[mapId]["Fortified"].DurationSec)
        playerMapDataFrame.fortifiedRunTime:SetText(fortifiedRunTime)
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