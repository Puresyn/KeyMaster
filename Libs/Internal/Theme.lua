local _, KeyMaster = ...

local Colors = {
    default = { r = 1, 
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
    color_DEATH_KNIGHT = {
        r = 0,
        g = 0,
        b = 0,
        hex = "c41f3b"
    },
    color_DRUID = {
        r = 0,
        g = 0,
        b = 0,
        hex = "ff7d0a"
    },
    color_HUNTER = {
        r = 0,
        g = 0,
        b = 0,
        hex = "abd473"
    },
    color_MAGE = {
        r = 0,
        g = 0,
        b = 0,
        hex = "69ccff0"
    },
    color_MONK = {
        r = 0,
        g = 0,
        b = 0,
        hex = "00ff96"
    },
    color_PALADIN = {
        r = 0,
        g = 0,
        b = 0,
        hex = "f58cba"
    },
    color_PRIEST = {
        r = 0,
        g = 0,
        b = 0,
        hex = "ffffff"
    },
    color_ROGUE = {
        r = 0,
        g = 0,
        b = 0,
        hex = "fff569"
    },
    color_SHAMAN = {
        r = 0,
        g = 0,
        b = 0,
        hex = "0070de"
    },
    color_WARLOCK = {
        r = 0,
        g = 0,
        b = 0,
        hex = "9482c9"
    },
    color_WARRIOR = {
        r = 0,
        g = 0,
        b = 0,
        hex = "c79c6e"
    },
    color_EVOKER = {
        r = 0,
        g = 0,
        b = 0,
        hex = "33937f"
    },
    color_DEMON_HUNTER = { 
        r = 0,
        g = 0,
        b = 0,
        hex = "a330c9"
    },
    color_POOR = {
        r = 0,
        g = 0,
        b = 0,
        hex = "889d9d"
    },
    color_COMMON = {
        r = 0,
        g = 0,
        b = 0,
        hex = "ffffff"
    },
    color_UNCOMMON = {
        r = 0,
        g = 0,
        b = 0,
        hex = "1eff0c"
    },
    color_RARE = {
        r = 0,
        g = 0,
        b = 0,
        hex = "0070ff"
    },
    color_EPIC = {
        r = 0,
        g = 0,
        b = 0,
        hex = "a335ee"
    },
    color_LEGENDARY = {
        r = 0,
        g = 0,
        b = 0,
        hex = "ff8000"
    },
    color_HEIRLOOM = {
        r = 0,
        g = 0,
        b = 0,
        hex = "e6cc80"
    }
}

function KeyMaster:GetThemeColor(themeName)
	local c = Colors[themeName];
	return c.r, c.g, c.b, c.hex
end

function KeyMaster:GetFrameRegions(myRegion, mainPanel)
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