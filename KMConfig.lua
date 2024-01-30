-- https://www.youtube.com/watch?v=lYr7obl0KlU&list=PL3wt7cLYn4N-3D3PTTUZBM2t1exFmoA2G&index=9
--------------------------------
-- Namespace
--------------------------------
local _, core = ...
core.Config = {}

local Config = core.Config
local UIConfig

--------------------------------
-- Defaults
--------------------------------
local defaults = {
    theme = { r = 1, 
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

--------------------------------
-- Config Functions
--------------------------------
function Config:Toggle()
    local menu = UIConfig or Config:CreateMenu()
    menu:SetShown(not menu:IsShown())
end

function Config:GetThemeColor()
	local c = defaults.theme;
	return c.r, c.g, c.b, c.hex
end

function Config:GetTextColorYellow()
	local c = defaults.themeFontColorYellow
	return c.r, c.g, c.b, c.hex;
end

function Config:GetClassColor(className)
    local n = "color_"..className
    local c = defaults.n
    return c
end

function Config:CreateButton(point, realativeFrame, relativePoint, yOffset, text)
    local btn = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate")
    btn:SetPoint(point, realativeFrame, relativePoint, 0, yOffset)
    btn:SetSize(140, 40)
    btn:SetText(text)
    btn:SetNormalFontObject("GameFontNormalLarge")
    btn:SetHighlightFontObject("GameFontHighlightLarge")
    return btn
end

function Config:CreateMenu()
    UIConfig = CreateFrame("Frame", "KeyMasterConfig", UIParent, "BasicFrameTemplate")
    UIConfig:SetSize(1000, 800)
    UIConfig:SetPoint("CENTER")

    UIConfig.title = UIConfig:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    UIConfig.title:SetPoint("LEFT", UIConfig.TitleBg, "LEFT", 5, 0)
    UIConfig.title:SetText("Key Master Options")

    --------------------------------
    -- Buttons
    --------------------------------
    -- ToDo: Condense to CreateButton function
        
    -- Save Button:
    -- UIConfig:saveBtn = self:CreateButton("CENTER", UIConfig, "TOP", -70, "Save")
    UIConfig.saveBtn = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate")
    UIConfig.saveBtn:SetPoint("CENTER", UIConfig, "TOP", 0, -70)
    UIConfig.saveBtn:SetSize(140, 40)
    UIConfig.saveBtn:SetText("Save")
    UIConfig.saveBtn:SetNormalFontObject("GameFontNormalLarge")
    UIConfig.saveBtn:SetHighlightFontObject("GameFontHighlightLarge")

    -- Reset Button:
    -- UIConfig.resetBtn = self:CreateButton("TOP", UIConfig.saveBtn, "BOTTOM", -10, "Reset")
    UIConfig.resetBtn = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate")
    UIConfig.resetBtn:SetPoint("TOP", UIConfig.saveBtn, "BOTTOM", 0, -10)
    UIConfig.resetBtn:SetSize(140, 40)
    UIConfig.resetBtn:SetText("Reset")
    UIConfig.resetBtn:SetNormalFontObject("GameFontNormalLarge")
    UIConfig.resetBtn:SetHighlightFontObject("GameFontHighlightLarge")

    -- Load Button:
    -- UIConfig.loadBtn = self:CreateButton("TOP", UIConfig.resetBtn, "BOTTOM", -10, "Load")
    UIConfig.loadBtn = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate")
    UIConfig.loadBtn:SetPoint("TOP", UIConfig.resetBtn, "BOTTOM", 0, -10)
    UIConfig.loadBtn:SetSize(140, 40)
    UIConfig.loadBtn:SetText("Load")
    UIConfig.loadBtn:SetNormalFontObject("GameFontNormalLarge")
    UIConfig.loadBtn:SetHighlightFontObject("GameFontHighlightLarge")

    --------------------------------
    -- Sliders
    --------------------------------
    -- Slider 1:
    UIConfig.slider1 = CreateFrame("SLIDER", nil, UIConfig, "OptionsSliderTemplate")
    UIConfig.slider1:SetPoint("TOP", UIConfig.loadBtn, "BOTTOM", 0, -20)
    UIConfig.slider1:SetMinMaxValues(1, 100)
    UIConfig.slider1:SetValue(50)
    UIConfig.slider1:SetValueStep(20)
    UIConfig.slider1:SetObeyStepOnDrag(true)

    --------------------------------
    -- Check Boxes
    --------------------------------
    -- Check Button 1:
    UIConfig.checkBtn1 = CreateFrame("CheckButton", nil, UIConfig, "UICheckButtonTemplate")
    UIConfig.checkBtn1:SetPoint("TOPLEFT", UIConfig.slider1, "BOTTOMLEFT", -10, -40)
    UIConfig.checkBtn1.text:SetText("Check Button 1!")
    UIConfig.checkBtn1:SetChecked(false)

    UIConfig:Hide()
    return UIConfig
end