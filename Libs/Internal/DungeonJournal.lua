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

local function showDungeonJournal()
    local mythicPlusDifficultiyId = 8
    local currentTier = EJ_GetCurrentTier()
    local instances = getInstances(currentTier)
    if (not EncounterJournal_OpenJournal) then
        UIParentLoadAddOn('Blizzard_EncounterJournal')
    end
    EncounterJournal_OpenJournal(mythicPlusDifficultiyId, instances[1].instanceID) -- Throws blizzard only action error   
end