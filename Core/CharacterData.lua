local _, KeyMaster = ...
KeyMaster.CharacterData = {}
local CharacterData = KeyMaster.CharacterData

local LibSerialize = LibStub("LibSerialize")
local LibDeflate = LibStub("LibDeflate")

--KeyMaster_C_DB[unitData.GUID]

local selectedCharacterGUID = nil
function CharacterData:GetSelectedCharacterGUID()
    return selectedCharacterGUID
end
function CharacterData:SetSelectedCharacterGUID(playerGUID)
    selectedCharacterGUID = playerGUID
end

function CharacterData:GetCharacterDataByGUID(playerGUID)
    if KeyMaster_C_DB[playerGUID] == nil then
        KeyMaster:_DebugMsg("GetCharacterDataByGUID", "CharacterData", "Cannot find character data by GUID "..playerGUID)
        return nil
    end

    local encodedCharacterData = KeyMaster_C_DB[playerGUID].data
    
    local decoded = LibDeflate:DecodeForWoWAddonChannel(encodedCharacterData)
    if not decoded then return end
    local decompressed = LibDeflate:DecompressDeflate(decoded)
    if not decompressed then return end
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

    -- todo: Is this needed?
    -- clean all data every data-update because first run or two can be api-tempermental.
    if playerGUID.GUID == UnitGUID("PLAYER") then -- make sure it's only the client so not to spam cleanup (more than it already does).
        KeyMaster_C_DB = KeyMaster:CleanCharSavedData(KeyMaster_C_DB)
    end
end