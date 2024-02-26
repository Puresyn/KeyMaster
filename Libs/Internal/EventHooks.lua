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
        -- todo: Process a client key change
        KeyMaster:_DebugMsg("NotifyEvent", "EventHooks", "Event: KEY_CHANGED")
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
                NotifyEvent("KEY_CHANGED")
                KeyMaster:_DebugMsg("KeyWatch", "EventHooks", "ITEM_COUNT_CHANGED: "..tostring(MYTHIC_PLUS_KEY_ID))
            end
        end
        if event == "ITEM_CHANGED" then
            local itemChangedFrom, itemChangedTo, _ = ...
            itemChangedFrom = tostring(itemChangedFrom)
            if (string.match(itemChangedFrom, "Mythic Keystone")) then
                NotifyEvent("KEY_CHANGED")
                KeyMaster:_DebugMsg("KeyWatch", "EventHooks", "ITEM_CHANGED: "..itemChangedFrom)
            end
        end
    end)
    f:RegisterEvent("ITEM_COUNT_CHANGED")
    f:RegisterEvent("ITEM_CHANGED")
end

-- Trigger all event staging here. (for now)
KeyWatch()

