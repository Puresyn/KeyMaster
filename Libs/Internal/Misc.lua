--------------------------------
-- Misc.lua
-- Misc. tools
--------------------------------
local _, KeyMaster = ...
local DungeonTools = KeyMaster.DungeonTools

function KeyMaster:spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

-- Function to dump tablehash data
function KeyMaster:TPrint(myTable, indent)    
    if not indent then indent = 0 end
    if type(myTable) ~= "table" then
        print(tostring(myTable))
        return
    end
    for k, v in pairs(myTable) do
        formatting = string.rep("  ", indent) .. k .. ": "
        if type(v) == "table" then
            print(formatting)
            KeyMaster:TPrint(v, indent+1)
        elseif type(v) == 'boolean' then
            print(formatting .. tostring(v))      
        else
            print(formatting .. v)
        end
    end
end

function KeyMaster:FormatDurationSec(timeInSec)
    return date("%M:%S", timeInSec)
end

-- CreateHLine(width [INT], parentFrame [FRAME], xOfs [INT (optional)], yOfs [INT (optional)])
function KeyMaster:CreateHLine(width, parentFrame, realativeAnchor, xOfs, yOfs)
    local lrm = 8 -- left/right line margin
    if (not width and parentFrame and realativeAnchor) then KeyMaster:print("ERROR: Invalid params provided: CreateHLine") return end
    if (not xOfs) then xOfs = 0 end
    if (not yOfs) then yOfs = 0 end
    local f = CreateFrame("Frame", nil, parentFrame)
    f:ClearAllPoints()
    f:SetSize(width-lrm, 1)
    f:SetPoint("CENTER", parentFrame, realativeAnchor, xOfs, yOfs)
    f.t = f:CreateTexture()
    f.t:SetAllPoints(f)
    f.t:SetColorTexture(1, 1, 1, 0.5)
    return f
end

-- Find the last visible party member row
function KeyMaster:FindLastVisiblePlayerRow()
    for i=5, 1, -1 do
        local lastrow = _G["KM_PlayerRow"..i]
        if (lastrow and lastrow:IsShown()) then
            return lastrow
        end
    end
    return
end

function KeyMaster:GetTableLength(table)
    if table == nil then
        return 0
    end
    local count = 0
    for i,v in pairs(table) do
        count = count + 1
    end

    return count
end

function KeyMaster:IsTextureAvailable(texturePath)
    local texture = UIParent:CreateTexture()
    texture:SetPoint("CENTER")
    texture:SetTexture(texturePath)
    print(texture:GetTexture())

    return texture:GetTexture() ~= nil
end