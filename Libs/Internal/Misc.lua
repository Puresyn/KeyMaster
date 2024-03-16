--------------------------------
-- Misc.lua
-- Misc. tools
--------------------------------
local _, KeyMaster = ...
local DungeonTools = KeyMaster.DungeonTools
local Theme = KeyMaster.Theme

-- sort arrays by order (order optional)
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
    if (not width and parentFrame and realativeAnchor) then KeyMaster:_ErrorMsg("CreateHLine", "Misc", "Invalid params provided.") return end
    if (not xOfs) then xOfs = 0 end
    if (not yOfs) then yOfs = 0 end
    local f = CreateFrame("Frame", nil, parentFrame)
    f:ClearAllPoints()
    f:SetSize(width-lrm, 1)
    f:SetPoint("CENTER", parentFrame, realativeAnchor, xOfs, yOfs)
    f.t = f:CreateTexture(nil, "OVERLAY", nil, 7)
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

-- custom made rounding function to round to a single decimal place
function KeyMaster:RoundSingleDecimal(number)
    return math.floor((number * 10) + 0.5) * .1
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
    KeyMaster:_DebugMsg("IsTextureAvailable", "Misc", texture:GetTexture())

    return texture:GetTexture() ~= nil
end

-- KeyMaster error/debug output functions
local function KM_Print(...)
    local brandHex = select(4, Theme:GetThemeColor("default"))
    local prefix = string.format("|cff%s%s|r", brandHex:upper(), KeyMasterLocals.ADDONNAME..":");
    DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", prefix, ...))
end

-- Usage KeyMaster:_ErrorMsg(str, str, str)
function KeyMaster:_ErrorMsg(funcName, fileName, ...)
    if (KeyMaster_DB.addonConfig.showErrors == true) then
        local errorHex = "d00000"
        local msg = string.format("|cff%s%s|r", errorHex:upper(), "[ERROR] "  .. funcName .. " in " .. fileName .. " - " .. ...)
        KM_Print(msg)
    end
end

-- Usage KeyMaster:_DebugMsg(str, str, str)
function KeyMaster:_DebugMsg(funcName, fileName, ...)
    if (KeyMaster_DB.addonConfig.showDebugging == true) then
        local debugHex = "A3E7FC"
        local msg = string.format("|cff%s%s|r", debugHex:upper(), "[DEBUG] " .. funcName .. " in " .. fileName .. " - " .. ...);	
        KM_Print(msg)
    end
end


-- This function gets run when the PLAYER_LOGIN event fires:
function KeyMaster:LOAD_SAVED_GLOBAL_VARIABLES()
    -- This table defines the addon's default settings:
    local defaults = {
        addonConfig = {
            showErrors = false,
            showDebugging = false,
            showRatingFloat = false
        }
    }

    -- This function copies values from one table into another:
    local function copyDefaults(src, dst)
        -- If no source (defaults) is specified, return an empty table:
        if type(src) ~= "table" then return {} end
        -- If no target (saved variable) is specified, create a new table:
        if type(dst) ~= "table" then dst = { } end
        -- Loop through the source (defaults):
        for k, v in pairs(src) do
            -- If the value is a sub-table:
            if type(v) == "table" then
                -- Recursively call the function:
                dst[k] = copyDefaults(v, dst[k])
            -- Or if the default value type doesn't match the existing value type:
            elseif type(v) ~= type(dst[k]) then
                -- Overwrite the existing value with the default one:
                dst[k] = v
            end
        end
        -- Return the destination table:
        return dst
    end

    -- Copy the values from the defaults table into the saved variables table
    -- if it exists, and assign the result to the saved variable:
    KeyMaster_DB = copyDefaults(defaults, KeyMaster_DB)

end

function KeyMaster:ToggleDebug()
    KeyMaster_DB.addonConfig.showDebugging = not KeyMaster_DB.addonConfig.showDebugging
    local status = KeyMaster_DB.addonConfig.showDebugging
    if (status) then status = KeyMasterLocals.ENABLED.."." else status = KeyMasterLocals.DISABLED.."." end
    KeyMaster:Print(KeyMasterLocals.DEBUGMESSAGES .. " " .. status)
end

function KeyMaster:ToggleErrors()
    KeyMaster_DB.addonConfig.showErrors = not KeyMaster_DB.addonConfig.showErrors
    local status = KeyMaster_DB.addonConfig.showErrors
    if (status) then status = KeyMasterLocals.ENABLED.."." else status = KeyMasterLocals.DISABLED.."." end
    KeyMaster:Print(KeyMasterLocals.ERRORMESSAGES.. " " .. status)
end

function KeyMaster:RoundToOneDecimal(number)
    return math.floor((number * 10) + 0.5) * 0.1
end

-- if result is 0 than values are equal
-- if result is -1 than version1 is older
-- if result is 1 than version1 is newer
function KeyMaster:VersionCompare(version1, version2)
    local _, _, major1, minor1, patch1 = strfind(version1, "(%d+)%.(%d+)%.(%d+)")
    local _, _, major2, minor2, patch2 = strfind(version2, "(%d+)%.(%d+)%.(%d+)")
    major1 = tonumber(major1)
    minor1 = tonumber(minor1)
    patch1 = tonumber(patch1)
    
    major2 = tonumber(major2)
    minor2 = tonumber(minor2)
    patch2 = tonumber(patch2)   
    
    if (major1 == major2) then
       if (minor1 == minor2) then
          if (patch1 == patch2) then
             return 0
          elseif (patch1 > patch2) then
             return 1
          else
             return -1
          end
       elseif (minor1 > minor2) then
          return 1
       else
          return -1
       end
    elseif (major1 > major2) then
       return 1
    else
       return -1
    end
end
