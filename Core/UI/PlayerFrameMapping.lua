local _, KeyMaster = ...
KeyMaster.PlayerFrameMapping = {}
local CharacterInfo = KeyMaster.CharacterInfo
local DungeonTools = KeyMaster.DungeonTools
local PlayerFrameMapping = KeyMaster.PlayerFrameMapping
local Theme = KeyMaster.Theme

local defaultString = 0

function PlayerFrameMapping:RefreshData()
    local playerFrame = _G["KM_Player_Frame"]
    local playerMapData = _G["KM_PlayerMapInfo"]

    local playerData = CharacterInfo:GetMyCharacterInfo()
    --KeyMaster.UnitData:SetUnitData(playerData)

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
end