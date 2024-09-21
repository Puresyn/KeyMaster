local _, KeyMaster = ...
KeyMaster.HeaderFrameMapping = {}
local HeaderFrameMapping = KeyMaster.HeaderFrameMapping
local CharacterInfo = KeyMaster.CharacterInfo
local DungeonTools = KeyMaster.DungeonTools

function HeaderFrameMapping:RefreshData(fetchNew)
    if fetchNew == nil then fetchNew = true end
    local playerData 
    if fetchNew then
        playerData = CharacterInfo:GetMyCharacterInfo()
        KeyMaster.UnitData:SetUnitData(playerData)
    else
        playerData = KeyMaster.UnitData:GetUnitDataByUnitId("player")
    end

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

function HeaderFrameMapping:NewVersionAlert()
    local versionAlertFrame = _G["KM_AddonOutdated"]
    if(versionAlertFrame) then versionAlertFrame:Show() end
end