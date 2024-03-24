local _, KeyMaster = ...
local KMFactory = {}
KeyMaster.Factory = KMFactory

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
        menuListItem:RegisterForClicks("AnyDown") -- , "AnyUp"
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

-- Create(parent, ["DropDownMenu", "Submenu"], {options}
function KMFactory:Create(parent, itemType, options)

    local obj
    local f = parent or UIParent

    if itemType == "DropDownMenu" then
        obj = createDropDownMenu(f, options)
    end

    return obj
end