local _, KeyMaster = ...
KeyMaster.PlayerFrameMapping = {}
local CharacterInfo = KeyMaster.CharacterInfo
local DungeonTools = KeyMaster.DungeonTools
local PlayerFrameMapping = KeyMaster.PlayerFrameMapping
local Theme = KeyMaster.Theme
local CharacterData = KeyMaster.CharacterData

local defaultString = 0

local function setVaultStatusIcon(vaultRowFrame, isCompleted)
    local image = "interface/weeklyreward/evergreenweeklyrewardui"
    vaultRowFrame.vaultComplete:SetTexture(image)
    if (isCompleted) then
        vaultRowFrame.vaultComplete:SetTexCoord(0.806640625 , 0.93212890625, 0.00048828125, 0.11083984375)
    else
        vaultRowFrame.vaultComplete:SetTexCoord(0.806640625 , 0.93212890625, 0.22314453125, 0.33349609375)
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

function PlayerFrameMapping:CalculateRatingGain(mapId, keyLevel)
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

    local keyBaseScore = KeyMaster.DungeonTools:CalculateRating(mapId, keyLevel, dungeonTimeLimit)
    local currentOverallRating = playerData.DungeonRuns[mapId].bestOverall
    
    local totalKeyRatingChange = 0
    
    if(keyBaseScore < currentOverallRating) then keyBaseScore = currentOverallRating end
    scoreFrame.ratingGain:SetText(getNumberPerferenceValue(keyBaseScore - currentOverallRating))
    totalKeyRatingChange = keyBaseScore - currentOverallRating
    
    local newOverall = playerData.mythicPlusRating + totalKeyRatingChange
    newOverall = getNumberPerferenceValue(newOverall)
    scoreFrame.newRating:SetText(newOverall)
    
    scoreFrame.keyLevel:SetText("("..keyLevel .. ") "..DungeonTools:GetDungeonNameAbbr(mapId)) --.." "..weeklyAffix)
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
    local playerData = CharacterData:GetCharacterDataByGUID(selectedCharacterGUID) or KeyMaster.UnitData:GetUnitDataByUnitId("player")
    --KeyMaster:TPrint(playerData)

    -- Player Dungeon Rating
    playerFrame.playerRating:SetText(playerData.mythicPlusRating or defaultString)

    -- Player Dungeon Runs
    local mapTable = DungeonTools:GetCurrentSeasonMaps()
    for mapId, _ in pairs(mapTable) do
        local mapFrame = _G["KM_PlayerFrameMapInfo"..mapId]

        local playerMapDataFrame = _G["KM_PlayerFrame_Data"..mapId]

        -- Dungeon Level
        local tyrannicalLevel = playerData.DungeonRuns[mapId]["DungeonData"].Level
        playerMapDataFrame.tyrannicalLevel:SetText(tyrannicalLevel or defaultString)

        -- Dungeon Bonus Time
        local tyrannicalBonusTime = DungeonTools:CalculateChest(mapId, playerData.DungeonRuns[mapId]["DungeonData"].Level, playerData.DungeonRuns[mapId]["DungeonData"].DurationSec)
        playerMapDataFrame.tyrannicalBonus:SetText(tyrannicalBonusTime)
     
        -- Dungeon Run Time
        local tyrannicalRunTime = KeyMaster:FormatDurationSec(playerData.DungeonRuns[mapId]["DungeonData"].DurationSec)
        playerMapDataFrame.tyrannicalRunTime:SetText(tyrannicalRunTime or "--:--") 

        -- Overall Dungeon Score
        local mapOverallRating = getNumberPerferenceValue(playerData.DungeonRuns[mapId]["DungeonData"].Rating)
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
                vaultRowFrame.vaultRuns:SetText("--")
                --vaultRowFrame.vaultRuns:SetText("10, 12, 13, 14, 15") -- debug

                -- Set Vault Slot Image
                setVaultStatusIcon(vaultRowFrame, false)
            end
        end
    end
end