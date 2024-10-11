local _, KeyMaster = ...
local DungeonJournal = {}
KeyMaster.DungeonJournal = DungeonJournal

-- NOT IN  USE YET
local function getInstances(tier)
    EJ_SelectTier(tier); -- sets dungeon journal data to current tier data
    local instances = {}
    local dataIndex = 1;
	local instanceID, name, description, _, buttonImage, _, _, _, link, _, mapID = EJ_GetInstanceByIndex(dataIndex, false);

	while instanceID ~= nil do
		tinsert(instances,
        {
			instanceID = instanceID,
			name = name,
			description = description,
			buttonImage = buttonImage,
			link = link,
			mapID = mapID,
		});

		dataIndex = dataIndex + 1;
		instanceID, name, description, _, buttonImage, _, _, _, link, _, mapID = EJ_GetInstanceByIndex(dataIndex, false);
	end

    return instances
end

 function DungeonJournal:getInstanceId(mapName)
	local currentTier = EJ_GetCurrentTier()
	EJ_SelectTier(currentTier); -- sets dungeon journal data to current tier data
    local instances = {}
    local dataIndex = 1;
	local instanceID, name, description, _, buttonImage, _, _, _, link, _, mapID = EJ_GetInstanceByIndex(dataIndex, false);

	while instanceID ~= nil do
		if (name == mapName) then
			return instanceID
		end

		dataIndex = dataIndex + 1;
		instanceID, name, description, _, buttonImage, _, _, _, link, _, mapID = EJ_GetInstanceByIndex(dataIndex, false);
	end

	KeyMaster:_DebugMsg("getInstanceId","DungeonJournal", "Could not find instanceID for mapName: "..mapName)
	return nil
end

function DungeonJournal:ShowDungeonJournal(mapName)
    local mythicPlusDifficultiyId = 8
    local instanceID = DungeonJournal:getInstanceId(mapName)
    if (not EncounterJournal_OpenJournal) then
        UIParentLoadAddOn('Blizzard_EncounterJournal')
    end
    EncounterJournal_OpenJournal(mythicPlusDifficultiyId, instanceID)
end

function DungeonJournal:ShowDungeonMap(mapName)
	local mythicPlusDifficultiyId = 8
    local instanceID = DungeonJournal:getInstanceId(mapName)
    if (not EncounterJournal_OpenJournal) then
        UIParentLoadAddOn('Blizzard_EncounterJournal')
    end
    EncounterJournal_OpenJournal(mythicPlusDifficultiyId, instanceID)
	local _, _, _, _, _, _, mapID = EJ_GetInstanceInfo();
	if mapID and mapID > 0 then
		OpenWorldMap(mapID);
	end
end