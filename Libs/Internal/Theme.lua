local _, KeyMaster = ...
KeyMaster.Theme = {}
local Theme = KeyMaster.Theme

local Colors = {
    default = { 
        r = 1, 
		g = 0.353,
		b = 0,
		hex = "ff5a00"
	},
    themeFontColorMain = {
        r = 1,
        g = 0.353,
        b = 0,
        hex = "ff5a00"
    },
    themeFontColorYellow = {
        r = 1,
        g = 0.854,
        b = 0,
        hex = "ffda00"
    },
    themeFontColorGreen1 = {
        r = 0.647,
        g = 1,
        b = 0,
        hex = "a5ff00"
    },
    themeFontColorGreen2 = {
        r = 0.145,
        g = 1,
        b = 0,
        hex = "25ff00"
    },
    themeFontColorBlue1 = {
        r = 0,
        g = 1,
        b = 0.855,
        hex = "00ffda"
    },
    party_CurrentWeek = {
        r = 0.647,
        g = 1,
        b = 0,
        hex = "a5ff00"
    },
    party_OffWeek = {
        r = 0.53,
        g = 0.62,
        b = 0.62,
        hex = "889d9d"

    },
    color_DEATH_KNIGHT = {
        r = 0.77,
        g = 0.12,
        b = 0.23,
        hex = "c41f3b"
    },
    color_DRUID = {
        r = 1,
        g = 0.49,
        b = 0.04,
        hex = "ff7d0a"
    },
    color_HUNTER = {
        r = 0.67,
        g = 0.83,
        b = 0.45,
        hex = "abd473"
    },
    color_MAGE = {
        r = 0.41,
        g = 0.8,
        b = 1,
        hex = "69ccff"
    },
    color_MONK = {
        r = 0,
        g = 1,
        b = 0.59,
        hex = "00ff96"
    },
    color_PALADIN = {
        r = 0.96,
        g = 0.55,
        b = 0.73,
        hex = "f58cba"
    },
    color_PRIEST = {
        r = 1,
        g = 1,
        b = 1,
        hex = "ffffff"
    },
    color_ROGUE = {
        r = 1,
        g = 0.96,
        b = 0.41,
        hex = "fff569"
    },
    color_SHAMAN = {
        r = 0,
        g = 0.44,
        b = 0.87,
        hex = "0070de"
    },
    color_WARLOCK = {
        r = 0.58,
        g = 0.51,
        b = 0.77,
        hex = "9482c9"
    },
    color_WARRIOR = {
        r = 0.78,
        g = 0.61,
        b = 0.43,
        hex = "c79c6e"
    },
    color_EVOKER = {
        r = 0.2,
        g = 0.58,
        b = 0.5,
        hex = "33937f"
    },
    color_DEMON_HUNTER = { 
        r = 0.64,
        g = 0.19,
        b = 0.79,
        hex = "a330c9"
    },
    color_POOR = {
        r = 0.53,
        g = 0.62,
        b = 0.62,
        hex = "889d9d"
    },
    color_COMMON = {
        r = 1,
        g = 1,
        b = 1,
        hex = "ffffff"
    },
    color_UNCOMMON = {
        r = 0.12,
        g = 1,
        b = 0.05,
        hex = "1eff0c"
    },
    color_RARE = {
        r = 0,
        g = 0.43,
        b = 1,
        hex = "0070ff"
    },
    color_EPIC = {
        r = 0.64,
        g = 0.21,
        b = 0.93,
        hex = "a335ee"
    },
    color_LEGENDARY = {
        r = 1,
        g = 0.50,
        b = 0,
        hex = "ff8000"
    },
    color_HEIRLOOM = {
        r = 0.9,
        g = 0.8,
        b = 0.5,
        hex = "e6cc80"
    },
    party_colHighlight = {
        r = 0.8,
        g = 0.8,
        b = 0.8,
        hex = "cccccc"
    },
    color_TAUPE = {
        r = 0.9,
        g = 0.69,
        b = 0.5,
        hex = "e6b080"
    },
    color_PORTRAITFRAME = {
        r = 0.7,
        g = 0.7,
        b = 0.7,
        hex = "cccccc"
    },
    color_NONPHOTOBLUE = {
        r = 0.64,
        g = 0.91,
        b = 0.99,
        hex = "A3E7FC"
    },
    color_ERRORMSG = {
        r = 1,
        g = 1,
        b = 1,
        hex = "FF2F2F"
    },
    color_DEBUGMSG = {
        r = 0.64,
        g = 0.91,
        b = 0.99,
        hex = "A3E7FC"
    }
}

function Theme:GetThemeColor(colorName)
	local c = Colors[colorName];
    if (c) then
	    return c.r, c.g, c.b, c.hex
    else
        KeyMaster:_ErrorMsg("GetThemeColor", "Theme", "Theme color \""..colorName.."\" was not found.")
    end
end

function Theme:GetFrameRegions(myRegion, mainPanel)
    local p, w, h, mh, mw, hh, mtb, mlr
    local r = myRegion
    local myRegionInfo = {}
    if (not r) then return end

    mh = mainPanel:GetHeight()
    mw = mainPanel:GetWidth()

    -- desired region heights and margins in pixels.
    -- todo: Needs pulled from saved variables or some other file instead of hard-coded.
    hh = 100 -- header height
    mtb = 4 -- top/bottom margin
    mlr = 4 -- left/right margin

    if (r == "header") then
    -- p = points, w = width, h = height, mtb = margin top and bottom, mlr = margin left and right
        myRegionInfo = {
            w = mw - (mlr*2),
            h = hh
    } 
    elseif (r == "content") then
        myRegionInfo = {
            w = mw - (mlr*2),
            h = mh - hh - (mtb*3)
        }
    else return
    end

    return myRegionInfo, mlr, mtb
end