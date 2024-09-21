local _, KeyMaster = ...
KeyMaster.EventHooks = {}

---@type table Local namespace
local EventHooks = KeyMaster.EventHooks

---@type table - function queueing table.
EventHooks.combatEventQueue = {}

---@param hookFrame table Holds the event frame pointer
local hookFrame
---@type integer Mythic Plus Key item id as provided by Blizzard.
local MYTHIC_PLUS_KEY_ID = 180653

-- Example: table.insert(KeyMaster.EventHooks.combatEventQueue, function() print("Queue function test.") end)
---@type fun() process EventHooks.combatEventQueue table one command at a time while combat state checking
function EventHooks:ProcessCombatQueue()
    local eventTable = EventHooks.combatEventQueue
    if eventTable and type(eventTable) == "table" then
        if KeyMaster:GetTableLength(eventTable) > 0 then
            if type(eventTable[1]) == "function" then
                if not KM_PLAYER_IN_COMBAT then
                    eventTable[1]()
                    table.remove(eventTable, 1)
                    EventHooks:ProcessCombatQueue() -- execute the next funciton
                else
                    return -- stop processing if entering combat.
                end
            else
                KeyMaster:_ErrorMsg("ProcessCombatQueue","EventHooks", type(eventTable[1]).." "..tostring(eventTable[1]).." is not a function.")
                table.remove(eventTable, 1)
                EventHooks:ProcessCombatQueue()
            end
        end
    end
end

local function UpdateKeyInformation(playerData)    
    -- get new key information
    local mapid, _, keyLevel = KeyMaster.CharacterInfo:GetOwnedKey()
    playerData.ownedKeyLevel = keyLevel
    playerData.ownedKeyId = mapid

    return playerData
end



-- Use this function as an end-point event hanlder to group and process pre-validated events.
---@type fun() Event handling end-point. Use this function to process events registered in this file.
---@param event string A string representing the name of the local function for an event.
function EventHooks:NotifyEvent(event)
    if (event == "KEY_CHANGED") then
            C_Timer.After(5, function()
            KeyMaster:_DebugMsg("EventHooks:NotifyEvent", "EventHooks", "Event: KEY_CHANGED")

            -- fetch self data
            local playerData = KeyMaster.UnitData:GetUnitDataByUnitId("player")

            -- update key data
            playerData = UpdateKeyInformation(playerData)
            
            -- Store new data
            KeyMaster.UnitData:SetUnitData(playerData)

            -- Only update UI if it's open
            local mainFrame = _G["KeyMaster_MainFrame"]
            if mainFrame ~= nil then
                KeyMaster.PartyFrameMapping:UpdateSingleUnitData(playerData.GUID)
                KeyMaster.PartyFrameMapping:UpdateKeystoneHighlights()
                KeyMaster.PartyFrameMapping:CalculateTotalRatingGainPotential()
                KeyMaster.PlayerFrameMapping:RefreshData(false)
                KeyMaster.HeaderFrameMapping:RefreshData(false)
            end

            -- Transmit unit data to party members with addon
            MyAddon:Transmit(playerData, "PARTY", nil) 
        end)
    end
    if event == "SCORE_GAINED" then
        KeyMaster:_DebugMsg("EventHooks:NotifyEvent", "EventHooks", "Event: SCORE_GAINED")
        C_Timer.After(5, function()
            -- fetch self data
            local playerData = KeyMaster.CharacterInfo:GetMyCharacterInfo()
            
            -- Store new data
            KeyMaster.UnitData:SetUnitData(playerData)

            -- Only update UI if it's open
            local mainFrame = _G["KeyMaster_MainFrame"]
            if mainFrame ~= nil then
                KeyMaster.PartyFrameMapping:UpdateSingleUnitData(playerData.GUID)
                KeyMaster.PartyFrameMapping:UpdateKeystoneHighlights()
                KeyMaster.PartyFrameMapping:CalculateTotalRatingGainPotential()
                KeyMaster.PlayerFrameMapping:RefreshData(false)
                KeyMaster.HeaderFrameMapping:RefreshData(false)
            end
                    
            -- Transmit unit data to party members with addon
            MyAddon:Transmit(playerData, "PARTY", nil)    
        end)
    end
    if event == "CHALLENGE_MODE_COMPLETED" then
        KeyMaster:_DebugMsg("EventHooks:NotifyEvent", "EventHooks", "Event: CHALLENGE_MODE_COMPLETED")
        KeyMaster.DungeonTools:ChallengeModeCompletionInfo()

        -- get finished key information
        --local _, level, _, onTime, _, _, _, _, _, _, _, _, members = C_ChallengeMode.GetCompletionInfo()

        -- get current player information
        --local playerData = KeyMaster.CharacterInfo:GetMyCharacterInfo()

        -- CODE TO REMIND SOMEONE TO CHANGE THEIR KEY.. TESTING!!!
        --[[ if onTime and playerData.ownedKeyId <= level then
            -- get current io for key's mapid
            local tyrannicalScoreInfo = KeyMaster.CharacterInfo:GetMplusScoreForMap(playerData.ownedKeyId, KeyMasterLocals.TYRANNICAL) -- FUNCTION 'GetMplusScoreForMap' was DELETED!
            local mapRating = KeyMaster.DungeonTools:CalculateRating(playerData.ownedKeyId, tyrannicalScoreInfo.level, tyrannicalScoreInfo.durationSec)

            -- get potential io for key's mapid + level
            local potentialRating = KeyMaster.DungeonTools:CalculateRating(playerData.ownedKeyId, playerData.ownedKeyLevel, 0)

            -- compare current IO to potential IO from key owned
            -- if potential IO is lower or equal to current IO, then notify user to change key
            if potentialRating <= mapRating then
                KeyMaster:Print("|cff"..hexColor.. "TESTING: Please consider changing your key." .. "|r")
            else
                KeyMaster:Print("|cff"..hexColor.. "TESTING: Keep your key goon!" .. "|r")
            end
        end ]]
    end

    if event == "VAULT_UPDATE" then
        KeyMaster:_DebugMsg("EventHooks:NotifyEvent", "EventHooks", "Event: VAULT_UPDATE")
        if KeyMaster_C_DB[UnitGUID("player")] then
            C_Timer.After(5, 
            function()
                local mZeros = KeyMaster.WeeklyRewards:GetNumMythicZeroRuns()
                local rewards = KeyMaster.WeeklyRewards:GetMythicPlusWeeklyVaultTopKeys()
                if mZeros > 0 or rewards then
                    if not rewards then rewards = {} end
                    for i=1, mZeros, 1 do
                        table.insert(rewards, 0)
                    end
                    KeyMaster_C_DB[UnitGUID("player")].vault = rewards
                end
            end)
        end
    end

    if event == "PORTALS_UPDATE" then
        C_Timer.After(3,
        function() 
            KeyMaster.PartyFrame:UpdatePortals()
            KeyMaster:_DebugMsg("EventHooks:NotifyEvent", "EventHooks", "Event: PORTALS_UPDATE")
        end)
    end
end

---@type fun() Sets up the event watch frame.
local function Init()
    if (not hookFrame) then
        ---@param f table Event Frame
        local f = CreateFrame("Frame")
        hookFrame = f
    end
    return hookFrame
end

---@type fun() Watches for events related to Mythic Plus Key Changes.
local function KeyWatch()
    ---@param f table Event Frame
    local f = Init()
    f:SetScript("OnEvent", function(self, event, ...)
        if event == "ITEM_COUNT_CHANGED" then
            ---@param itemID integer Arg1 returned ID of the count changed item.
            local itemID, _ = ...
            if (itemID == MYTHIC_PLUS_KEY_ID) then
                KeyMaster:_DebugMsg("KeyWatch", "EventHooks", "ITEM_COUNT_CHANGED: "..tostring(MYTHIC_PLUS_KEY_ID))
                EventHooks:NotifyEvent("KEY_CHANGED")                
            end
        end
        if event == "ITEM_CHANGED" then
            ---@param itemChangedFrom integer Returned ID of the changed item.
            ---@param itemChangedTo integer Returned ID of what the item changed to.
            local itemChangedFrom, itemChangedTo, _ = ...
            if (string.match(itemChangedFrom, tostring(MYTHIC_PLUS_KEY_ID))) then
                KeyMaster:_DebugMsg("KeyWatch", "EventHooks", "ITEM_CHANGED: "..tostring(itemChangedFrom))
                EventHooks:NotifyEvent("KEY_CHANGED")                
            end
        end
        --[[ if event == "ITEM_DATA_LOAD_RESULT" then
            local itemID
            itemID, _ = ...
            if (itemID == MYTHIC_PLUS_KEY_ID) then
                KeyMaster:_DebugMsg("KeyWatch", "EventHooks", "ITEM_DATA_LOAD_RESULT")
                EventHooks:NotifyEvent("KEY_CHANGED")
            end
        end ]]
        if event == "CHALLENGE_MODE_START" then
            local mapid = ...
            KeyMaster:_DebugMsg("KeyWatch", "EventHooks", "CHALLENGE_MODE_START")
            EventHooks:NotifyEvent("KEY_CHANGED")
        end
        if event == "CHALLENGE_MODE_COMPLETED" then
            KeyMaster:_DebugMsg("KeyWatch", "EventHooks", "CHALLENGE_MODE_COMPLETED")
            EventHooks:NotifyEvent("SCORE_GAINED")
            EventHooks:NotifyEvent("CHALLENGE_MODE_COMPLETED")
            EventHooks:NotifyEvent("VAULT_UPDATE")
            EventHooks:NotifyEvent("PORTALS_UPDATE")
        end
        if event == "CHAT_MSG_LOOT" then
            local itemTextRecieved, _, _, _, _, _, _, _, _, _, _, guid, _ = ...
            if guid == UnitGUID("player") then
                if (string.match(itemTextRecieved, tostring(MYTHIC_PLUS_KEY_ID))) then
                    KeyMaster:_DebugMsg("KeyWatch", "EventHooks", "CHAT_MSG_LOOT: "..tostring(itemTextRecieved))
                    EventHooks:NotifyEvent("KEY_CHANGED")
                end
            end
        end
    end)
    f:RegisterEvent("ITEM_COUNT_CHANGED") -- fired when getting key from vendor (only fires when going into default bag?!?!)
    f:RegisterEvent("ITEM_CHANGED") -- fires on key downgrade from vendor
    f:RegisterEvent("CHALLENGE_MODE_START") -- key going down on start
    f:RegisterEvent("CHALLENGE_MODE_COMPLETED") -- key going up & score change
    --f:RegisterEvent("ITEM_DATA_LOAD_RESULT")
    f:RegisterEvent("CHAT_MSG_LOOT")
end

-- Trigger all event staging here. (for now)
KeyWatch()