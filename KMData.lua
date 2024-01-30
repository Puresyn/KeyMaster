--------------------------------
-- Namespace
--------------------------------
local _, core = ...
core.Data = {}

local Data = core.Data
local dataCheck = false
local myPlayerName = UnitName("player")
local myRealmName = GetRealmName()
local _, myClass, _ = UnitClass("player")

--------------------------------
-- Data Queries
--------------------------------
-- Is the current character max level
function Data:IsMaxLevel()
    if (UnitLevel("player") == GetMaxPlayerLevel()) then
        return true
    else
        return false
    end
end

-- Retrieve the color for the class that blizzard has set.
function Data:GetMyClassColor()
    local c
    local _, myClass, _ = UnitClass("player")
    local c = string.sub(select(4, GetClassColor(myClass)), 3, -1)
    return c
end

-- Query what key the character has in bags, if any.
function Data:GetOwnedKey()
    local i, l, n
    i = C_MythicPlus.GetOwnedKeystoneChallengeMapID()

    if (i) then
        -- key found in bags
        -- Get Data
        -- name, id, timeLimit, texture, backgroundTexture = C_ChallengeMode.GetMapUIInfo(i)
        -- todo: search local table (Data:GetCurrentSeasonMaps()) instead of querying for new data
        n, _, _, _, _ = C_ChallengeMode.GetMapUIInfo(i)
        l = C_MythicPlus.GetOwnedKeystoneLevel(i)
        local n, l
        return i, n, l
    else
        -- No key but has Vault Ready
        if (C_MythicPlus.IsWeeklyRewardAvailable()) then
            -- todo: Tell player to get their vault key or go ask key merchant for one
        else
            -- No Key Available, no vault available
            -- todo: Notify player (if max level) to go get a key from merchant
            return
        end
    end

end

function Data:GetBestMythicRuns(mapID)
    -- retrieve all best run data on a map
    local a, b
    -- a = affixScores, b = bestOverAllScore
    -- todo: evaluate data returns
   
    if not mapID then return end
   
    a, b = C_MythicPlus.GetSeasonBestAffixScoreInfoForMap(mapID)
    if (a or b) then
       return {a, b}
    else
        return
    end
end

-- Not Used
local function buildMapTable(...)
    -- todo: check, build, and store season map data
    -- https://wowpedia.fandom.com/wiki/Category:API_namespaces/C_ChallengeMode
end


-- build a current season map table pulled from the API
function Data:GetCurrentSeasonMaps()
    local mapTable
    local i=0
    local mapTable = {}

    m = C_ChallengeMode.GetMapTable();
    local i
    if (not m) then return end
    local mapTable = {}
    for i=1, #m, i+1 do
        name, id, timeLimit, texture, backgroundTexture = C_ChallengeMode.GetMapUIInfo(m[i])
        mapTable[id] = {
            ["name"] = name,
            ["timeLimit"] = timeLimit,
            ["texture"] = texture,
            ["backgroundTexture"] = backgroundTexture
            }
        end
    return mapTable
end

-- Retrieve from API the current active player's M+ score.
function Data:GetCurrentRating()
    local r = C_ChallengeMode.GetOverallDungeonScore()
    return r
end

--------------------------------
-- Saved Variables
--------------------------------
-- todo: Evaluate data storage hiarchy and create a code library to validate, store, retrieve, and access it.
-- todo: Use player characters GUID for storage instead of a name. Names can be changed.
-- -I don't belive a GUID can be?
-- name = set characters's name, curKey = keyID | keyLevel, realm = character's realm,
-- myCharacter = is this the player's character or a team member, maxlevel = is this character max level,
-- teamNames = name of teams this character is in.
KeyMaster_DB = {
	characters = {
		[1] = {name = format(myPlayerName, 1), curKey = "0|0", realm = myRealmName, myCharacter = true, maxLevel = Data:IsMaxLevel(), teamNames = ""}
	},
    -- may not be needed? This identifies in saved variables the character they are currently on. (Game crashes will corrupt this)
    -- May be better to use the GUID as the index and query Saved Variables based on that?
	currentCharacter = 1
}

-- Unused: Was thought to use this as an overall (Did any data screw up on load) check.
-- - If so, show some kind of "Fix Me" screen.
function Data:Init()
    -- todo: return data query success validation
    return dataCheck
end

