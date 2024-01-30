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
function Data:IsMaxLevel()
    if (UnitLevel("player") == GetMaxPlayerLevel()) then
        return true
    else
        return false
    end
end

function Data:GetMyModel()
    --MyModel:SetModel("Character\\NightElf\\Female\\NightElfFemale.mdx");
    local model = CreateFrame("PlayerModel", nil, UIParent)
    model:SetSize(600, 800)
    model:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    model:SetUnit("player")
    model:SetPosition(0, 0, -0.75)
    model:SetCustomCamera(1)
    model:SetCameraPosition(2.8, -1, 0.4)
    model:RefreshCamera()
    
    model:Show()
    return model
end

function Data:GetMyClassColor()
    local c
    local _, myClass, _ = UnitClass("player")
    local c = string.sub(select(4, GetClassColor(myClass)), 3, -1)
    return c
end

function Data:GetOwnedKey()
    local i, l, n
    i = C_MythicPlus.GetOwnedKeystoneChallengeMapID()

    if (i) then
        -- Get Data
        --name, id, timeLimit, texture, backgroundTexture = C_ChallengeMode.GetMapUIInfo(i)
        -- todo: search local table (Data:GetCurrentSeasonMaps()) instead of querying for new data
        n, _, _, _, _ = C_ChallengeMode.GetMapUIInfo(i)
        l = C_MythicPlus.GetOwnedKeystoneLevel(i)
        local n, l
        return i, n, l
    else
        -- Has Vault Ready
        if (C_MythicPlus.IsWeeklyRewardAvailable()) then
            -- todo: Tell player to get their vault key or go ask key merchant for one
        else
            -- No Key Available
            -- todo: Notify player (if max level) to go get a key from merchant
            return
        end
    end

end

function Data:GetBestMythicRuns(mapID)
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

function Data:GetCurrentRating()
    local r = C_ChallengeMode.GetOverallDungeonScore()
    return r
end

--------------------------------
-- Save Variables
--------------------------------
KeyMaster_DB = {
	characters = {
		[1] = {name = format(myPlayerName, 1), curKey = "0|0", realm = myRealmName, myCharacter = true, maxlevel = Data:IsMaxLevel(), teamName = ""}
	},
	currentCharacter = 1
}

function Data:Init()
    -- todo: return data query success validation
    return dataCheck
end

