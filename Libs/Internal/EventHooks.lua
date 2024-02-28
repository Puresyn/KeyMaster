local _, KeyMaster = ...
KeyMaster.EventHooks = {}

---@type table Local namespace
local EventHooks = KeyMaster.EventHooks

---@param hookFrame table Holds the event frame pointer
local hookFrame
---@type integer Mythic Plus Key item id as provided by Blizzard.
local MYTHIC_PLUS_KEY_ID = 180653

-- Use this function as an end-point event hanlder to group and process pre-validated events.
---@type fun() Event handling end-point. Use this function to process events registered in this file.
---@param event string A string representing the name of the local function for an event.
local function NotifyEvent(event)
    if (event == "KEY_CHANGED") then
        KeyMaster:_DebugMsg("NotifyEvent", "EventHooks", "Event: KEY_CHANGED")
        -- fetch self data
        local playerData = KeyMaster.UnitData:GetUnitDataByUnitId("player")

        -- get new key information
        local mapid, _, keyLevel = KeyMaster.CharacterInfo:GetOwnedKey()
        playerData.ownedKeyLevel = keyLevel
        playerData.ownedKeyId = mapid
        
        -- Store new data
        KeyMaster.UnitData:SetUnitData(playerData)
                
        -- Transmit unit data to party members with addon
        MyAddon:Transmit(playerData, "PARTY", nil)
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
                NotifyEvent("KEY_CHANGED")                
            end
        end
        if event == "ITEM_CHANGED" then
            local itemChangedFrom, itemChangedTo, _ = ...
            itemChangedFrom = tostring(itemChangedFrom)
            if (string.match(itemChangedFrom, "Mythic Keystone")) then
                KeyMaster:_DebugMsg("KeyWatch", "EventHooks", "ITEM_CHANGED: "..itemChangedFrom)
                NotifyEvent("KEY_CHANGED")                
            end
        end
    end)
    f:RegisterEvent("ITEM_COUNT_CHANGED")
    f:RegisterEvent("ITEM_CHANGED")
end

-- Trigger all event staging here. (for now)
KeyWatch()

