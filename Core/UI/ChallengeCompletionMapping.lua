--------------------------------
-- ChallengeCompletionMapping.lua
-- Challenge Mode Completion Data Mapping
--------------------------------
local _, KeyMaster = ...
KeyMaster.ChallengeCompletion = {}
local ChallengeCompletion = KeyMaster.ChallengeCompletion
local DungeonTools = KeyMaster.DungeonTools
local Theme = KeyMaster.Theme

function ChallengeCompletion:getDummyData()
    local dummyCharacters = {}
        table.insert(dummyCharacters, {"Player-5-0AC6183B", "Háste"})
        table.insert(dummyCharacters, {"Player-5-0AB1C900", "Hastè"})
        table.insert(dummyCharacters, {"Player-5-0E4C039F", "Stryylor"})
        table.insert(dummyCharacters, {"Player-5-0E70D88E", "Bravestorm"})
        table.insert(dummyCharacters, {"Player-5-0E231E02", "Strys"})

    local mapChallengeModeID  = 405
    local level = 10
    local time = 1494052 --5400003
    local onTime = true
    local keystoneUpgradeLevels = 2
    local practiceRun = false
    local oldOverallDungeonScore = 120
    local newOverallDungeonScore = 140
    local IsMapRecord = true
    local IsAffixRecord = true
    local PrimaryAffix = 9 -- 9 = tyrannical, 10 = fortified
    local isEligibleForScore = true
    local members = dummyCharacters

    local dummyData = {mapChallengeModeID, level, time, onTime, keystoneUpgradeLevels, practiceRun, oldOverallDungeonScore, newOverallDungeonScore, IsMapRecord, IsAffixRecord, PrimaryAffix, isEligibleForScore, members}
    return dummyData -- mapChallengeModeID, level, time, onTime, keystoneUpgradeLevels, practiceRun, oldOverallDungeonScore, newOverallDungeonScore, IsMapRecord, IsAffixRecord, PrimaryAffix, isEligibleForScore, members
end

--[[ local function challengeComplete()
    table.insert(EventHooks.combatEventQueue,function() C_Timer.After(5, function() KeyMaster.ChallengeCompletion:ChallengeCompletionFrame()end) end)
end ]]

--[[ ---@return table - Challenge Mode Completion Information
local function getChallengeModeCompletionInfo()
    ---@param mapChallengeModeID number
    local mapChallengeModeID
    ---@param level number
    local level
    ---@param time number - Time in milliseconds
    local time
    ---@param onTime boolean
    local onTime
    ---@param keystoneUpgradeLevels number
    local keystoneUpgradeLevels
    ---@param practiceRun boolean
    local practiceRun
    ---@param oldOverallDungeonScore number
    local oldOverallDungeonScore
    ---@param newOverallDungeonScore number
    local newOverallDungeonScore
    ---@param IsMapRecord boolean
    local IsMapRecord
    ---@param IsAffixRecord boolean
    local IsAffixRecord
    ---@param PrimaryAffix number
    local PrimaryAffix
    ---@param isEligibleForScore boolean
    local isEligibleForScore
    ---@param members table - [#]{(string) memberGUID, (string) name}
    local members

    mapChallengeModeID, level, time, onTime, keystoneUpgradeLevels, practiceRun, oldOverallDungeonScore, newOverallDungeonScore, IsMapRecord, IsAffixRecord, PrimaryAffix, isEligibleForScore, members = C_ChallengeMode.GetCompletionInfo()
    return mapChallengeModeID, level, time, onTime, keystoneUpgradeLevels, practiceRun, oldOverallDungeonScore, newOverallDungeonScore, IsMapRecord, IsAffixRecord, PrimaryAffix, isEligibleForScore, members
end ]]

--// reducing function calls  //--
-- star colors
local highlightColor = {}
local mutedColor = {}
highlightColor.r, highlightColor.g, highlightColor.b, _ = Theme:GetThemeColor("themeFontColorYellow")
mutedColor.r, mutedColor.g, mutedColor.b, _ = Theme:GetThemeColor("color_POOR")
--//-------------------------//--

local function setStarColor(texturePointer, highlight)
    if not type(texturePointer) == "table" then
        KeyMaster:_ErrorMsg("setStarColor","ChallengeCompletionMapping", "Star texture pointer is invald.")
        return
    end

    local color
    if highlight then
        color = {highlightColor.r, highlightColor.g, highlightColor.b, 1}
    else
        color = {mutedColor.r, mutedColor.g, mutedColor.b, 1}
    end
    texturePointer:SetVertexColor(unpack(color))

end

--[[ Name = "ChallengeModeCompletionMemberInfo",
Type = "Structure",
Fields =
{
    { Name = "memberGUID", Type = "WOWGUID", Nilable = false },
    { Name = "name", Type = "string", Nilable = false },
}, ]]

local function setCompletionInfo(challengeInfo)
    print(type(challengeInfo))
    if not challengeInfo then return end

    ---@param mapChallengeModeID number
    local mapChallengeModeID
    ---@param level number
    local level
    ---@param time number - Time in milliseconds
    local time
    ---@param onTime boolean
    local onTime
    ---@param keystoneUpgradeLevels number
    local keystoneUpgradeLevels
    ---@param practiceRun boolean
    local practiceRun
    ---@param oldOverallDungeonScore number
    local oldOverallDungeonScore
    ---@param newOverallDungeonScore number
    local newOverallDungeonScore
    ---@param IsMapRecord boolean
    local IsMapRecord
    ---@param IsAffixRecord boolean
    local IsAffixRecord
    ---@param PrimaryAffix number
    local PrimaryAffix
    ---@param isEligibleForScore boolean
    local isEligibleForScore
    ---@param members table - [#]{(string) memberGUID, (string) name}
    local members = {}

    mapChallengeModeID, level, time, onTime, keystoneUpgradeLevels, practiceRun, oldOverallDungeonScore, newOverallDungeonScore, IsMapRecord, IsAffixRecord, PrimaryAffix, isEligibleForScore, members = unpack(challengeInfo) --ChallengeCompletion:getDummyData()
    local seasonMaps = DungeonTools:GetCurrentSeasonMaps()
    --if KeyMaster:GetTableLength(completionData) > 0 then

    if not mapChallengeModeID or mapChallengeModeID == 0 then
        KeyMaster:_ErrorMsg("setCompletionInfo","ChallengeCompletionMapping", "Challenge mode completion API call did not return data.")
        return
    end
    if not seasonMaps[mapChallengeModeID] then
        KeyMaster:_ErrorMsg("setCompletionInfo","ChallengeCompletionMapping", "Map ID "..tostring(mapChallengeModeID).." is not in the mythic+ rotation this season.")
        return
    end
    --[[ if not onTime then -- do not display on dungeon over completion time.
        KeyMaster:_DebugMsg("setCompletionInfo","ChallengeCompletionMapping", "Run over timed - skipping challenge notification.")
        return 
    end  ]]
    local mapName = DungeonTools:GetMapName(mapChallengeModeID)
    if not mapName then
        KeyMaster:_ErrorMsg("setCompletionInfo","ChallengeCompletionMapping", "Could not retrieve map name for mapID "..tostring(mapChallengeModeID)) 
        return
    end
    local timeStatus
    if onTime then timeStatus = "a timed" else timeStatus = "an untimed" end
    local plusText = "+"..tostring(keystoneUpgradeLevels)
    KeyMaster:Print("You've completed "..timeStatus.." "..mapName.. " ("..level..") at "..plusText.." in "..(KeyMaster:FormatCompTimeDurationMilsec(time))) -- todo: Point to function for party announcements?
    --local mapTexture = seasonMaps[mapChallengeModeID].texture

    -- THE frame
    local completionFrame = ChallengeCompletion:ChallengeCompletionFrame()

    -- new record?
    local recordText
    if IsMapRecord then
        recordText = KeyMasterLocals.CHALLENGECOMPLETE["NewRecord"]
    else
        recordText = ""
    end
    completionFrame.newRecord:SetText(recordText)

    -- map texture
    local mapTexture = seasonMaps[mapChallengeModeID].backgroundTexture
    completionFrame.texturemap:SetTexture(mapTexture)

    -- stars
    local oneStarFrame = _G["KM_Star1"]
    local twoStarFrame = _G["KM_Star2"]
    local threeStarFrame = _G["KM_Star3"]
    if not oneStarFrame or not twoStarFrame or not threeStarFrame then
        KeyMaster:_ErrorMsg("setCompletionInfo","ChallengeCompletionMapping", "Can not find one or more star bonus frames") 
    end

    setStarColor(oneStarFrame.texture, false)
    setStarColor(twoStarFrame.texture, false)
    setStarColor(threeStarFrame.texture, false)

    if keystoneUpgradeLevels > 0 then
        setStarColor(oneStarFrame.texture, true)
    end
    if keystoneUpgradeLevels > 1 then
        setStarColor(twoStarFrame.texture, true)
    end
    if keystoneUpgradeLevels > 2 then
        setStarColor(threeStarFrame.texture, true)
    end

    -- affix
    local affixName, _, _ = C_ChallengeMode.GetAffixInfo(PrimaryAffix)
    completionFrame.affix:SetText(affixName)
    
    -- key level
    completionFrame.levelText:SetText(tostring(level))

    -- map name
    completionFrame.mapName:SetText(seasonMaps[mapChallengeModeID].name)
    
    -- map time
    local runTime = KeyMaster:FormatCompTimeDurationMilsec(time) -- time is in milliseconds
    local maxTime = KeyMaster:FormatCompTimeDurationMilsec(seasonMaps[mapChallengeModeID].timeLimit*1000)
    completionFrame.mapTime:SetText(runTime.." / "..maxTime)

    -- rating text
    local ratingGained = "WIP" -- todo: set proper values
    local newRating = "WIP"
    completionFrame.ratingGain:SetText(ratingGained.." ("..newRating..")")

    -- member frames
    --print("Unpack: "..unpack(members))
    --if type(members) == "table" then KeyMaster:TPrint(members) end
    ChallengeCompletion:createMemberRows(completionFrame, members)

    --completionFrame:Show()
    
end

function ChallengeCompletion:CreateChallengeBanner(challengeInfo)
    setCompletionInfo(challengeInfo)
end

function ChallengeCompletion:GetCompletionInfoWithRetries(time, retries)
    local blizBanner = _G["ChallengeModeCompleteBanner"]
    if blizBanner then blizBanner:Hide() end
    local challengeInfo = {}
    challengeInfo = C_ChallengeMode.GetCompletionInfo()
    if challengeInfo == nil or not type(challengeInfo) == "table" then return end
    if #challengeInfo > 0 then
        ChallengeCompletion:CreateChallengeBanner(challengeInfo)
    else
        if retries > 0 then
            C_Timer.After(time, function() ChallengeCompletion:GetCompletionInfoWithRetries(2, retries - 1) end)
        else
            KeyMaster:_ErrorMsg("getCompletionInfoWithRetries", "ChallengeCompletionMapping", "Failed to get completion info after "..tostring(retries).." retries.")
        end
    end
end

local hooked = false
local function challengeBannerHoook(self, event, name, ...)
    if not KeyMaster_DB.addonConfig.completionScreen.showCompletion or hooked == true then return end
    if name == "Blizzard_ChallengesUI" then
        if not ChallengeModeCompleteBanner then ChallengeModeCompleteBanner = CreateFrame("Frame", "ChallengeModeCompleteBanner") end
        hooksecurefunc(ChallengeModeCompleteBanner,"PlayBanner",ChallengeCompletion:GetCompletionInfoWithRetries(1, 5)) -- could also try "OnLoad" instead of "PlayBanner"
        hooked = true
    end
end

local function challengeBannerWatch()
    local bannerWatchFrame = CreateFrame("Frame")
    bannerWatchFrame:RegisterEvent("ADDON_LOADED")
    bannerWatchFrame:SetScript("OnEvent", challengeBannerHoook)
end

--challengeBannerWatch()