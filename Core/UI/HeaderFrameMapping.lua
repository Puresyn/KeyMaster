local _, KeyMaster = ...
KeyMaster.HeaderFrameMapping = {}
local HeaderFrameMapping = KeyMaster.HeaderFrameMapping
local CharacterInfo = KeyMaster.CharacterInfo
local DungeonTools = KeyMaster.DungeonTools

function HeaderFrameMapping:RefreshData()
    local playerData = CharacterInfo:GetMyCharacterInfo()
    KeyMaster.UnitData:SetUnitData(playerData)

    local playerKeyHeader = _G["KeyMaster_MythicKeyHeader"]
    playerKeyHeader.keyLevelText:SetText("--")
    playerKeyHeader.keyAbbrText:SetText("---")
    if (playerData) then
        if (playerData.ownedKeyLevel > 0) then
            playerKeyHeader.keyLevelText:SetText(playerData.ownedKeyLevel)
            playerKeyHeader.keyAbbrText:SetText(DungeonTools:GetDungeonNameAbbr(playerData.ownedKeyId))
        end
    end
end