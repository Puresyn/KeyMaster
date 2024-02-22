local _, KeyMaster = ...
KeyMaster.KeyScoreCalc = {}
local KeyScoreCalc = KeyMaster.KeyScoreCalc
local DungeonTools = KeyMaster.DungeonTools
local UnitData = KeyMaster.UnitData

-- Original code pulled from https://wowpedia.fandom.com/wiki/Mythic_Plus_Score_Computation

-- Data
local DungeonAbbreviations = DungeonTools:instanceAbbrs()

 local DungeonBaseScores = { 0, 40, 45, 55, 60, 65, 75, 80, 85, 100 };
 local TimerConstants = {
    ---@type number bonus and malus are capped at 40% faster or slower than par time
    Threshold = 0.4,
    ---@type number maximum bonus/malus points for being faster/slower than the par time
    MaxModifier = 5,
    ---@type number maximum bonus/malus points for being faster/slower than the par time
    DepletionPunishment = 5,
 }
 -- Math Functions
 local function round(num)
    return num >= 0 and math.floor(num + 0.5) or math.ceil(num - 0.5)
 end
 ---@param num number
 ---@param precision number
 ---@param num boolean
 local function formatNumber(num, precision, noPrefix)
    if num == nil then
       return "nil"
    end
    local formatString = "%." .. precision .. "f"
    local absolutValueString = string.format(formatString, num)
    if noPrefix then
       return num < 0 and strsub(absolutValueString, 1) or absolutValueString
    else
       return (num > 0 and "+" or "") .. absolutValueString
    end
 end
 local function padString(str, length)
    local result = str .. ""
    while strlen(result) < length do
       result = " " .. result
    end
    return result
 end
 -- WoW Functions
 local function computeTimeModifier(parTimePercentage)
    ---@type number if we took 130% time this is -30% (30% too slow)
    local percentageOffset = (1 - parTimePercentage)
    if percentageOffset > TimerConstants.Threshold then
       -- bonus is capped at 40% faster than par time
       return TimerConstants.MaxModifier;
    elseif percentageOffset > 0 then
       -- bonus is interpolated linear between 60% and 100% par time
       return percentageOffset * TimerConstants.MaxModifier / TimerConstants.Threshold;
    elseif percentageOffset == 0 then
       -- redundant special case
       return 0;
    elseif percentageOffset > -TimerConstants.Threshold then
       -- bonus is interpolated linear between 100% and 140% par time
       return percentageOffset * TimerConstants.MaxModifier / TimerConstants.Threshold - TimerConstants.DepletionPunishment;
    else
       -- key is hard set to 0 points, `nil` indicates this
       return nil;
    end
 end
 local function computeScores(dungeonId, level, timeInSeconds)
    local mapTable = DungeonTools:GetCurrentSeasonMaps()
    local parTime = mapTable[dungeonId].timeLimit
    --local _, _, parTime, _, _ = C_ChallengeMode.GetMapUIInfo(dungeonId)
    
    local baseScore = DungeonBaseScores[math.min(level, 10)] + max(0, level - 10) * 5;
    local parTimeFraction = timeInSeconds / parTime;
    local timeScore = computeTimeModifier(parTimeFraction);
    formatNumber(parTimeFraction * 100, 2)
    return {
       baseScore = baseScore,
       -- 0 if critically over timed
       timeScore ~= nil and baseScore + timeScore or 0,
       timeBonus = timeScore,
       parTimePercentageString = padString(formatNumber(parTimeFraction * 100, 2, true), 7) .. "%"
    }
 end
 
 local function computeKeyBaseScore(affixScoreData)
    return affixScoreData.baseScore + affixScoreData.timeBonus;
 end
 
 local function computeAffixScoreSum(score1, score2)
    return max(score1, score2) * 1.5 + min(score1, score2) * 0.5;
 end
 
 local totalScore = 0
 local function buildKeyDataString(blizzardScores, affixScoreData)
    local blizzardTyrannical = blizzardScores.Tyrannical.baseScore;
    local computedTyrannical = computeKeyBaseScore(affixScoreData.Tyrannical);
    local blizzardFortified = blizzardScores.Fortified.baseScore;
    local computedFortified = computeKeyBaseScore(affixScoreData.Fortified);
    local computedKeyScore = computeAffixScoreSum(computedTyrannical, computedFortified);
    totalScore = totalScore + computedKeyScore;
    return "Tyrannical  " ..
    " " .. padString(blizzardTyrannical, 3) .. " | " .. padString(round(computedTyrannical), 3) .. " = " ..
    padString(affixScoreData.Tyrannical.baseScore, 3) .. padString(formatNumber(affixScoreData.Tyrannical.timeBonus, 2), 6) ..
    affixScoreData.Tyrannical.parTimePercentageString ..
    "\n" ..
    "Fortified   " .. " " .. padString(blizzardFortified, 3) .. " | " .. padString(round(computedFortified), 3) .. " = " ..
    padString(affixScoreData.Fortified.baseScore, 3) .. padString(formatNumber(affixScoreData.Fortified.timeBonus, 2), 6) ..
    affixScoreData.Fortified.parTimePercentageString ..
    "\n" ..
    "complete     " ..
    padString(blizzardScores.Complete, 3) .. " | " .. padString(round(computedKeyScore), 3)
 end

 -- Clean up how Key Master stores cached member run data
 local function CleanRunData(runInfo)

   local cleanMapData = {}
   local cleanOverallScoreData
   local tempTable = {}
   tempTable = {}

   if runInfo["bestOverall"] > 0 then
      cleanOverallScoreData = runInfo.bestOverall
   end

   if runInfo["Fortified"].DurationSec > 0 then
      tempTable = {
            name =  "Fortified",
            score = runInfo["Fortified"].Score,
            level = runInfo["Fortified"].Level,
            durationSec = runInfo["Fortified"].DurationSec,
            overTime = runInfo["Fortified"].IsOverTime
      }
      tinsert(cleanMapData, tempTable)
   end

   if runInfo["Tyrannical"].DurationSec > 0 then
      tempTable = {
         name =  "Tyrannical",
         score = runInfo["Tyrannical"].Score,
         level = runInfo["Tyrannical"].Level,
         durationSec = runInfo["Tyrannical"].DurationSec,
         overTime = runInfo["Tyrannical"].IsOverTime
      }
      tinsert(cleanMapData, tempTable)
   end
   return cleanMapData, cleanOverallScoreData
 end
 
  local function computeTTEnhancement(dungeonId, unitId)
    local computedAffixScoreData = {
       Tyrannical = { baseScore = 0, timeScore = 0, timeBonus = 0, parTimePercentageString = "   0.00%" },
       Fortified = { baseScore = 0, timeScore = 0, timeBonus = 0, parTimePercentageString = "   0.00%" },
    }
    local blizzardScores = {
       Tyrannical = { baseScore = 0 },
       Fortified = { baseScore = 0 },
       Complete = 0
    }
    --local blizzardAffixScoreData, blizzardTotalScore = C_MythicPlus.GetSeasonBestAffixScoreInfoForMap(dungeonId)
    local UnitInfo = UnitData:GetUnitDataByUnitId(unitId)
    local mapTable = DungeonTools:GetCurrentSeasonMaps()
    local runInfo = UnitInfo.DungeonRuns[dungeonId]
    local blizzardAffixScoreData, blizzardTotalScore = CleanRunData(runInfo)

    if (blizzardAffixScoreData ~= nil) then
       for _, info in pairs(blizzardAffixScoreData) do
          computedAffixScoreData[info.name] = computeScores(dungeonId, info.level, info.durationSec)
          blizzardScores[info.name] = { baseScore = info.score }
       end
    end
    if blizzardTotalScore ~= nil then
       blizzardScores.Complete = blizzardTotalScore
    end
    return buildKeyDataString(blizzardScores, computedAffixScoreData)
 end

 function KeyScoreCalc:PrintScores(unitId)
   
   local mapTable = DungeonTools:GetCurrentSeasonMaps()
   for dungeonId, abbreviation in pairs(DungeonAbbreviations) do
      print(abbreviation .. " - " .. mapTable[dungeonId].name)
      print("        Blizzard | Computed")
      print(computeTTEnhancement(dungeonId, unitId))
   end
   local unitInfo = UnitData:GetUnitDataByUnitId(unitId)
   local currentScore = unitInfo.mythicPlusRating
      print("========================================")
      print("Total        " .. padString(currentScore, 3) .. " | " .. padString(round(totalScore), 3))
      print("========================================")
end
