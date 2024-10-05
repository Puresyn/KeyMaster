local _, KeyMaster = ...
KeyMaster.Factory = {}
local KMFactory = KeyMaster.Factory
local Theme = KeyMaster.Theme

-- Key Master Widget Factory

--//////////////////////////////
--// Do not edit this without //
--// fulling understanding it //
--// or talking with Strylor. //
--//////////////////////////////

local function createTitle(p, options)
    local titleFrame
    local text = options.text
    local margin = options.margin
    local maxWidth = options.maxwidth
    local fontRef = options.font

    if not text and p then return end
    titleFrame = CreateFrame("Frame", nil, p)
    titleFrame.titletext = titleFrame:CreateFontString(nil, "OVERLAY", fontRef)
    titleFrame.titletext:SetText(text)

    if maxWidth then
        titleFrame:SetWidth(maxWidth+margin)
        titleFrame.titletext:SetWidth(maxWidth)
    else
        titleFrame:SetWidth(titleFrame.titletext:GetWidth()+(margin*2))
        titleFrame.titletext:SetWidth(titleFrame.titletext:GetWidth())
    end

    titleFrame:SetHeight(titleFrame.titletext:GetHeight()+margin)
    titleFrame.titletext:SetHeight(titleFrame.titletext:GetHeight())
    titleFrame.titletext:SetPoint("BOTTOMLEFT", titleFrame, "BOTTOMLEFT")
    titleFrame.titletext:SetJustifyV("CENTER")
    titleFrame.titletext:SetJustifyH("LEFT")

    titleFrame:SetPoint("BOTTOMLEFT", p, "TOPLEFT")
    p:SetAttribute("title", titleFrame.titletext)

    return titleFrame
    
end

local function createSubmenu(p, options)
    local menuWidth = p:GetAttribute('menuwidth')
    local subMenu = CreateFrame("Frame", "$parent_Submenu", p)
    subMenu:SetPoint("TOPLEFT", p, "BOTTOMLEFT")
    subMenu:SetSize(menuWidth, 80)
    subMenu.texture = subMenu:CreateTexture()
    subMenu.texture:SetAllPoints(subMenu)
    subMenu.texture:SetColorTexture(0,0,0, 0.6)
    p:SetAttribute('submenu', subMenu)
    return subMenu
end

local function createItem(p, name, value, callback)
    local options = p:GetParent():GetAttribute("options")
    local margins = options.margin
    local menuWidth = p:GetParent():GetAttribute('menuwidth')
    local menuListItem = CreateFrame("Frame", "$parent_MenuItem_"..name, p)
    --local font = parent.text:GetFont()
    menuListItem:SetSize(menuWidth, 40)
    if value then
        menuListItem.text = menuListItem:CreateFontString(nil, "OVERLAY", options.itemfont)
        menuListItem.text:SetAllPoints(menuListItem)
        menuListItem.text:SetText(value)
        menuListItem.text:SetJustifyH("LEFT")
        menuListItem:SetHeight(menuListItem.text:GetHeight()+(margins*2))
        menuListItem:SetWidth(menuWidth)
    end

    if callback then
        menuListItem:SetScript("OnClick", callback)
        menuListItem:RegisterForClicks("AnyDown", "AnyUp")
    end
    return menuListItem
end

local function addItem(parent, menuitems)

    local f = parent:GetAttribute("submenu")
    if not f then
       f = createSubmenu(parent)
    end

    local prevAnchor = f

    if (type(menuitems) == "table") then
        for key, text in pairs(menuitems) do

            local newItem = createItem(f, key, text)
            newItem:SetPoint("TOPLEFT", prevAnchor, "TOPLEFT")

            parent:SetAttribute("submenuitem_"..key, text)
            --print(text.." added with key "..key)
        end
    else
        KeyMaster:_DebugMsg("dropDownMenu:AddItem","KMFactory","menuitems is not a table.")
    end

    return
end

local function createDropDownMenu(f, options)
    local options = options or {}
    local dropDownMenu, titleFrame

    -- Set options default values if none given
    options.margin = options.margin or 4
    options.titlefont = options.titlefont or "KeyMasterFontNormal"
    options.itemfont = options.itemfont or "KeyMasterFontSmall"
    options.framelevel = options.framelevel or (f:GetFrameLevel() +1)
    options.bginsets = options.bginsets or {top = 0, left = 0, bottom = 0, right = 0}
    options.backdropcolor = options.backdropcolor -- {0, 0, 0, 0.3}
    options.backgroundcoloralpha = options.backgroundcoloralpha or 1

    -- if more than 1 dropdown menu for this parent, create unique name
    local i = 1
    if _G["$parent_DropdownMenu"..i] then
        while _G["$parent_DropdownMenu"..i] ~= nil do
            i = i+1
        end
    end

    -- Create the main dropdown menu frame
    dropDownMenu = CreateFrame("Frame", "$parent_DropdownMenu"..i, f)

    -- store options table in this frames attributes so we can access them later.
    dropDownMenu:SetAttribute('options', options)

    dropDownMenu.text = dropDownMenu:CreateFontString(nil, "OVERLAY", options.itemfont)
    dropDownMenu.text:SetPoint("RIGHT", dropDownMenu, "RIGHT", -options.margin, -options.margin)

    -- set options
    if options.strata then
        dropDownMenu:SetFrameStrata(options.strata)
    end

    if options.framelevel then
        dropDownMenu:SetFrameLevel(options.framelevel)
    end

    if options.bg then
        dropDownMenu:SetBackdrop({
            bgFile = options.bg,
            insets = options.bginsets,
        })
    end

    if options.bg and options.backdropcolor then 
        dropDownMenu:SetBackdropColor(options.backdropcolor)
    end

    if options.backgroundcolor then
        dropDownMenu.background = dropDownMenu:CreateTexture()
        dropDownMenu.background:SetAllPoints(dropDownMenu)
        dropDownMenu.background:SetColorTexture(options.backgroundcolor[1], options.backgroundcolor[2], options.backgroundcolor[3], options.backgroundcoloralpha)
        dropDownMenu:SetAttribute("backgroundcolor", options.backgroundcolor)
    end

    if options.defaultext then
        dropDownMenu.text:SetText(options.defaultext)
        dropDownMenu.text:SetHeight(dropDownMenu.text:GetHeight())
    else
        dropDownMenu.text:SetText("HeightCheck")
        dropDownMenu.text:SetHeight(dropDownMenu.text:GetHeight())
        dropDownMenu.text:SetText("")
    end

    if options.title then
        local titleFrameOptions = {
            text = options.title,
            margin = options.margin,
            maxwidth = options.titlewidth,
            font = options.titlefont
        }
        local titleFrame = createTitle(dropDownMenu, titleFrameOptions)
        dropDownMenu:SetAttribute("titleFrame", titleFrame)
    end

    -- setting dynamic sizing - this must happen at the end so it can
    -- read sizing information from placed text.
    local menuWidth = dropDownMenu.text:GetWidth()+(options.margin*2)
    dropDownMenu:SetHeight(dropDownMenu.text:GetHeight()+(options.margin*2))
    dropDownMenu:SetWidth(menuWidth)
    dropDownMenu:SetAttribute("menuwidth", menuWidth)

    -- add a pointer in the attributes for this menu's frame reference
    -- incase we need to find it later.
    dropDownMenu:SetAttribute("dropDownMenu", dropDownMenu)

    -- Create submenu outer frame. 
    -- Can call directly if unique options are needed.
    -- It is created automaticly if "AddItem()"
    -- is used and no submenu frame exists.
    function dropDownMenu:CreateSubmenu(options)
        createSubmenu(self, options)
    end

    -- adds items to the submenu
    --  menuitems = {key=text, key=text, ...}
    function dropDownMenu:AddItem(menuitems)
        addItem(self, menuitems, options)
    end

    return dropDownMenu

end

local function createButton(f, options)

    local btnText = ""
    --text.width = 0
    --text.height = 0
    local btnName = nil

    local btnTint = {0.779, 0.686, 0.384, 0.8} --{1, 1,  1, 0.6} -- default NONPHOTOBLUE
    local btnTextColor = {1, 0.854, 0, 0.85}
    local btnTextHoverColor = {1, 0.854, 0, 1} -- {0.64, 0.91, 0.99, 1} -- {1, 0.854, 0, 1}
    local btnHoverColor = {0.779, 0.686, 0.384, 0.8}
    local font = "KeyMasterFontSmall"

    if options and type(options) == "table" then
        if options["text"] then btnText = options["text"] end
        if options["name"] then btnName = options["name"] end
        if options["tint"] then btnTint = options["tint"] end
        if options["textColor"] then btnTextColor = options["textColor"] end
        if options["textHoverColor"] then btnTextHoverColor = options["textHoverColor"] end
        if options["btnHoverColor"] then btnHoverColor = options["btnHoverColor"] end
        if options["font"] then font = options["font"] end
    end

    local function ButtonEnter(self)
        self.text:SetTextColor(btnTextHoverColor[1], btnTextHoverColor[2], btnTextHoverColor[3], btnTextHoverColor[4])
    end

    local function ButtonLeave(self)
        self.text:SetTextColor(btnTextColor[1], btnTextColor[2],btnTextColor[3], btnTextColor[4])
    end

    local btn = CreateFrame("Button", btnName, f)

    btn:SetText(nil) -- not using built-in text becuase it lacks some functionality
    btn.text = btn:CreateFontString(nil, "OVERLAY", font)
    btn.text:SetPoint("CENTER", btn, "CENTER")
    btn.text:SetText(btnText)
    btn.text:SetTextColor(btnTextColor[1], btnTextColor[2], btnTextColor[3], btnTextColor[4])
    btn:SetSize(btn.text:GetStringWidth()+24,btn.text:GetStringHeight()+8)
    btn.upTexture = btn:CreateTexture()
    btn.upTexture:SetTexture("Interface/Addons/KeyMaster/Assets/Images/KM-Panel-Button-Up")
    btn.upTexture:SetTexCoord(0, 79/128, 0, 22/32)
    btn.upTexture:SetAllPoints(btn)
    btn.upTexture:SetSize(btn:GetWidth(), btn:GetHeight())
    btn.upTexture:SetVertexColor(btnTint[1],btnTint[2],btnTint[3],btnTint[4])
    btn:SetNormalTexture(btn.upTexture)

    btn.pushedTexture = btn:CreateTexture()
    btn.pushedTexture:SetTexture("Interface/Addons/KeyMaster/Assets/Images/KM-Panel-Button-Down")
    btn.pushedTexture:SetTexCoord(0, 79/128, 0, 22/32)
    btn.pushedTexture:SetAllPoints(btn)
    btn.pushedTexture:SetVertexColor(btnTint[1],btnTint[2],btnTint[3],btnTint[4])
    btn:SetPushedTexture(btn.pushedTexture)

    btn.highlightTexture = btn:CreateTexture()
    btn.highlightTexture:SetTexture("Interface/Addons/KeyMaster/Assets/Images/KM-Panel-Button-Highlight")
    btn.highlightTexture:SetTexCoord(0, 79/128, 0, 22/32)
    btn.highlightTexture:SetAllPoints(btn)
    btn.highlightTexture:SetVertexColor(btnHoverColor[1],btnHoverColor[2],btnHoverColor[3],btnHoverColor[4])
    btn:SetHighlightTexture(btn.highlightTexture)

    btn:SetScript("OnEnter", ButtonEnter)
    btn:SetScript("OnLeave", ButtonLeave)

    return btn
end

-- GetCursorPosition();
local function createToolTip(anchor, options)
    local tooltipFrame
    local mainFrame = _G["KeyMaster_MainFrame"]

    local name, icon, title, desc
    if options and type(options) == "table" then
        if options["name"] then name = options["name"] else return nil end
        if options["icon"] then icon = options["icon"] end
        if options["title"] then title = options["title"] end
        if options["desc"] then desc = options["desc"] end
    end

    tooltipFrame = CreateFrame("Frame", name, mainFrame, "TooltipTemplate")
    
    tooltipFrame:SetMovable("false")
    tooltipFrame:SetFrameStrata("HIGH")
    tooltipFrame:SetClampedToScreen(true)

    tooltipFrame:SetBackdrop({
        bgFile="Interface/Tooltips/UI-Tooltip-Background",
        edgeFile="Interface\\AddOns\\KeyMaster\\Assets\\Images\\UI-Border", 
        tile = false, 
        tileSize = 0, 
        edgeSize = 16, 
        insets = {left = 4, right = 4, top = 4, bottom = 4}})
        tooltipFrame:SetBackdropColor(0,0,0,1)

        local tooltipTitleColor = {}
        tooltipTitleColor.r, tooltipTitleColor.g, tooltipTitleColor.b, _ = Theme:GetThemeColor("themeFontColorYellow")
    

        tooltipFrame.titleFrame = CreateFrame("Frame", "KM_TooltipTitle", tooltipFrame)
        tooltipFrame.titleFrame:SetPoint("TOPLEFT", tooltipFrame, "TOPLEFT", 8, -8)
       
        tooltipFrame.titleText = tooltipFrame.titleFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
        local path, _, flags = tooltipFrame.titleText:GetFont()
        tooltipFrame.titleText:SetFont(path, 12, flags)
        tooltipFrame.titleText:SetWordWrap(false)
        tooltipFrame.titleText:SetAllPoints(tooltipFrame.titleFrame)
        tooltipFrame.titleText:SetTextColor(tooltipTitleColor.r,tooltipTitleColor.g,tooltipTitleColor.b)
        tooltipFrame.titleText:SetJustifyH("LEFT")
        tooltipFrame.titleText:SetJustifyV("TOP")
        tooltipFrame.titleText:SetText(title)

        tooltipFrame.titleFrame:SetHeight(tooltipFrame.titleText:GetStringHeight())

        tooltipFrame.descFrame = CreateFrame("Frame", "KM_TooltipDesc", tooltipFrame)
        tooltipFrame.descFrame:SetPoint("TOPLEFT", tooltipFrame.titleFrame, "BOTTOMLEFT", 0, 0)

        tooltipFrame.descText = tooltipFrame.descFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
        local path, _, flags = tooltipFrame.descText:GetFont()
        tooltipFrame.descText:SetFont(path, 12, flags)
        tooltipFrame.descText:SetWordWrap(true)
        tooltipFrame.descText:SetAllPoints(tooltipFrame.descFrame)
        tooltipFrame.descText:SetTextColor(1,1,1)
        tooltipFrame.descText:SetJustifyH("LEFT")
        tooltipFrame.descText:SetJustifyV("TOP")
        tooltipFrame.descText:SetText(desc)

        local tooltipWidth = tooltipFrame.titleText:GetStringWidth()
        if tooltipWidth < 200 then tooltipWidth = 200 end
        tooltipFrame.titleFrame:SetWidth(tooltipWidth)
        tooltipFrame.descFrame:SetWidth(tooltipWidth)
        tooltipFrame:SetWidth(tooltipWidth+16)
        tooltipFrame:SetHeight(tooltipFrame.titleFrame:GetHeight()+tooltipFrame.descFrame:GetHeight()+16)

    tooltipFrame:Hide()
    return tooltipFrame
end

-- Create(parent, ["DropDownMenu", "Submenu", "Button", "Tooltip"], {options}
---@param parent table - parent object
---@param itemType string - type of object to create
---@param options table - object options
---@return table - object
function KMFactory:Create(parent, itemType, options)

    local obj
    local f = parent or UIParent

    if itemType == "DropDownMenu" then
        obj = createDropDownMenu(f, options)
    end

    if itemType == "Button" then
        obj = createButton(f, options)
    end

    if itemType == "Tooltip" then
        obj = createToolTip(f, options)
    end

    return obj
end