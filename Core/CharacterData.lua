local _, KeyMaster = ...
KeyMaster.CharacterData = {}
local CharacterData = KeyMaster.CharacterData
local CharacterInfo = KeyMaster.CharacterInfo

local LibSerialize = LibStub("LibSerialize")
local LibDeflate = LibStub("LibDeflate")

--KeyMaster_C_DB[unitData.GUID]

local function charServerFilter(table)
    local realmName = GetRealmName()
    if not realmName then 
        KeyMaster:_ErrorMsg("charServerFilter","CharactersFrame","API did not repond with realm name.")
        return
    end
    local filteredTable = {}
    for cGUID, v in pairs(table) do
        if table[cGUID].realm == realmName then
            filteredTable[cGUID] = v
        end
    end
    return filteredTable
end

local function charRatingFilter(table)
    local filteredTable = {}
    for cGUID, v in pairs(table) do
        if table[cGUID].rating and table[cGUID].rating > 0 then
            filteredTable[cGUID] = v
        end
    end
    return filteredTable
end

local function charKeyFilter(table)
    local filteredTable = {}
    for cGUID, v in pairs(table) do
        if table[cGUID].keyLevel and table[cGUID].keyLevel > 0 then
            filteredTable[cGUID] = v
        end
    end
    return filteredTable
end

local function charLevelFilter(table)
    local filteredTable = {}
    local maxLevel = GetMaxPlayerLevel()
    for cGUID, v in pairs(table) do
        if table[cGUID].level and table[cGUID].level == maxLevel then
            filteredTable[cGUID] = v
        end
    end
    return filteredTable
end

local function charSort(sortTable, sort)
    --local sortTable = sortTable
    local tempTable = {}
    local sortedTable = {}

    -- always sort by rating
    for k, v in KeyMaster:spairs(sortTable, function(t, a, b)
        return t[b][sort] < t[a][sort]
    end) do
        -- have to build a sorted table this way becuase the PK is how Lua orders it.. :(
        table.insert(sortedTable, {[k] = v})
    end

    return sortedTable
end

local selectedCharacterGUID = nil
function CharacterData:GetSelectedCharacterGUID()
    if selectedCharacterGUID == nil then
        selectedCharacterGUID = UnitGUID("player")
    end
    return selectedCharacterGUID
end
function CharacterData:SetSelectedCharacterGUID(playerGUID)
    selectedCharacterGUID = playerGUID
end

function CharacterData:GetCharacterDataByGUID(playerGUID)
    if KeyMaster_C_DB[playerGUID] == nil then
        KeyMaster:_DebugMsg("GetCharacterDataByGUID", "CharacterData", playerGUID.." is not in the list of alternate characters.")
        return nil
    end

    local encodedCharacterData = KeyMaster_C_DB[playerGUID].data --saved variable
    if not encodedCharacterData then return nil end
    
    local decoded = LibDeflate:DecodeForWoWAddonChannel(encodedCharacterData)
    if not decoded then 
        KeyMaster:_DebugMsg("GetCharacterDataByGUID", "CharacterData", "Failed to decode data for "..playerGUID)
        return 
    end
    local decompressed = LibDeflate:DecompressDeflate(decoded)
    if not decompressed then 
        KeyMaster:_DebugMsg("GetCharacterDataByGUID", "CharacterData", "Failed to decompress data for "..playerGUID)
        return
    end
    local success, data = LibSerialize:Deserialize(decompressed)
    if not success then
        KeyMaster:_DebugMsg("GetCharacterDataByGUID", "CharacterData", "Failed to deserialize data for "..playerGUID)
        return
    end
    
    return data
end

function CharacterData:SetCharacterData(playerGUID, data)

    -- Serialize, compress and encode Unit Data for Saved Variables
    local serialized = LibSerialize:Serialize(data)
    local compressed = LibDeflate:CompressDeflate(serialized)
    local encoded = LibDeflate:EncodeForWoWAddonChannel(compressed)

    KeyMaster_C_DB[playerGUID].data = encoded

    -- pull out/set a couple details for better performance.
    KeyMaster_C_DB[data.GUID].rating = data.mythicPlusRating
    KeyMaster_C_DB[data.GUID].keyId = data.ownedKeyId
    KeyMaster_C_DB[data.GUID].keyLevel = data.ownedKeyLevel
    KeyMaster_C_DB[data.GUID].level = data.charLevel
    --KeyMaster_C_DB[unitData.GUID].timestamp = GetServerTime()
    local rewards = KeyMaster.WeeklyRewards:GetMythicPlusWeeklyVaultTopKeys()
    if rewards then
        KeyMaster_C_DB[data.GUID].vault = rewards
    else
        KeyMaster_C_DB[data.GUID].vault = {}
    end

    -- todo: Is this needed?
    -- clean all data every data-update because first run or two can be api-tempermental.
    if playerGUID.GUID == UnitGUID("PLAYER") then -- make sure it's only the client so not to spam cleanup (more than it already does).
        KeyMaster_C_DB = KeyMaster:CleanCharSavedData(KeyMaster_C_DB)
    end
end

function CharacterData:GetCharactersList()
    -- look at database
    local sortTable = KeyMaster_C_DB
    if KeyMaster_DB.addonConfig.characterFilters.serverFilter then
        if KeyMaster_DB.addonConfig.characterFilters.serverFilter == true then
            sortTable = charServerFilter(sortTable)
        end
    end

    if KeyMaster_DB.addonConfig.characterFilters.filterNoRating then
        if KeyMaster_DB.addonConfig.characterFilters.filterNoRating == true then
            sortTable = charRatingFilter(sortTable)
        end
    end

    if KeyMaster_DB.addonConfig.characterFilters.filterNoKey then
        if KeyMaster_DB.addonConfig.characterFilters.filterNoKey == true then
            sortTable = charKeyFilter(sortTable)
        end
    end

    if KeyMaster_DB.addonConfig.characterFilters.filterMaxLvl then
        if KeyMaster_DB.addonConfig.characterFilters.filterMaxLvl == true then
            sortTable = charLevelFilter(sortTable)
        end
    end

    local characterTable = charSort(sortTable, "rating") -- sorts by rating

    return characterTable
end

-- dealing with a purged character that now needs popluated.
function CharacterData:CreateDefaultCharacterData()
    local playerGUID = UnitGUID("player")
    local charDefaults = KeyMaster:CreateDefaultCharacterData() -- Misc.lua - Get character defaults data and structure.
    
    charDefaults = charDefaults[playerGUID] -- move data up one level for proper data format.

    -- store default data
    KeyMaster_C_DB[playerGUID] = charDefaults
    
    local playerData = CharacterInfo:GetMyCharacterInfo()
    local serialized = LibSerialize:Serialize(playerData)
    local compressed = LibDeflate:CompressDeflate(serialized)
    local encoded = LibDeflate:EncodeForWoWAddonChannel(compressed)

    -- store retrieved data
    KeyMaster_C_DB[playerGUID].data = encoded

    -- pull out/set a couple details for better performance.
    KeyMaster_C_DB[playerGUID].rating = playerData.mythicPlusRating
    KeyMaster_C_DB[playerGUID].keyId = playerData.ownedKeyId
    KeyMaster_C_DB[playerGUID].keyLevel = playerData.ownedKeyLevel
    --KeyMaster_C_DB[unitData.GUID].timestamp = GetServerTime()
    local rewards = KeyMaster.WeeklyRewards:GetMythicPlusWeeklyVaultTopKeys()
    if rewards then
        KeyMaster_C_DB[playerGUID].vault = rewards
    else
        KeyMaster_C_DB[playerGUID].vault = {}
    end        
end