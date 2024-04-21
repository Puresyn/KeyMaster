--------------------------------
-- CharactersFrame.lua
-- Handles Character Select interface.
--------------------------------

local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface
local DungeonTools = KeyMaster.DungeonTools
local CharacterInfo = KeyMaster.CharacterInfo
local Theme = KeyMaster.Theme
local UnitData = KeyMaster.UnitData
local PartyFrameMapping = KeyMaster.PartyFrameMapping
local PartyFrame = KeyMaster.PartyFrame
local PlayerFrame = KeyMaster.PlayerFrame
local UnitData = KeyMaster.UnitData
local CharacterData = KeyMaster.CharacterData
local PlayerFrameMapping = KeyMaster.PlayerFrameMapping

local function setDefaultColor(row)
    local defColor = {}
    local color = {}
    defColor = row:GetAttribute("defColor")
    color.r = defColor[1]
    color.g = defColor[2]
    color.b = defColor[3]
    row.textureHighlight:SetVertexColor(color.r, color.g, color.b, 1)
end

local function setRowActive(row, setActive)
    if not row then return end
    if setActive == nil then setActive = true end-- set true by default if undefined
    local characterSelectFrame = _G["KM_CharacterSelectFrame"]
    if not characterSelectFrame then return end -- just incase setRowActive is called to early
    local currentActiveGUID = characterSelectFrame:GetAttribute("selectedCharacterGUID")
    local thisGUID = row:GetAttribute("GUID")

    if setActive then

        row.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Title-BG1")
        CharacterData:SetSelectedCharacterGUID(thisGUID)
        characterSelectFrame:SetAttribute("selectedCharacterRow", row)
        characterSelectFrame:SetAttribute("selectedCharacterGUID", thisGUID)
        row.selectedTexture:Show()
    else
        row:SetAttribute("active", false)
        row.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight")
        row.selectedTexture:Hide()
    end
end

local function characterRow_OnRowClick(self)
    if self:GetAttribute('active') == true then return end -- already the selected character

    local prevRow = _G["KM_CharacterSelectFrame"]:GetAttribute("selectedCharacterRow")
    if prevRow then setRowActive(prevRow, false) end
    
    -- Store selected character
    CharacterData:SetSelectedCharacterGUID(self:GetAttribute("GUID"))
    PlayerFrameMapping:RefreshData(false)
    
    setRowActive(self, true)

end

local function characterRow_onmouseover(self)
    if self ~= _G["KM_CharacterSelectFrame"]:GetAttribute("selectedCharacterRow") then
        self.selectedTexture:Show()
    end
end

local function characterRow_onmouseout(self)
    if self ~= _G["KM_CharacterSelectFrame"]:GetAttribute("selectedCharacterRow") then
            self.selectedTexture:Hide()
        end
end

local function createScrollFrame(parent)
    -- Credit: https://www.wowinterface.com/forums/showthread.php?t=45982
    local frameHolder;
 
    local self = frameHolder or CreateFrame("Frame", nil, parent)
    self:SetFrameLevel(parent:GetFrameLevel()+1)
    self:SetSize(parent:GetWidth()-8, parent:GetHeight()-12)
    self:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 4, 6)
    
    self.scrollframe = self.scrollframe or CreateFrame("ScrollFrame", "KM_CharacterScrollFrame", self, "UIPanelScrollFrameTemplate");
    
    self.scrollchild = self.scrollchild or CreateFrame("Frame", "KM_CharacterList")
    
    local scrollbarName = self.scrollframe:GetName()
    self.scrollbar = _G[scrollbarName.."ScrollBar"]
    self.scrollupbutton = _G[scrollbarName.."ScrollBarScrollUpButton"]
    self.scrolldownbutton = _G[scrollbarName.."ScrollBarScrollDownButton"]

    self.scrollbar.background = self.scrollbar:CreateTexture()
    self.scrollbar.background:SetPoint("CENTER", self.scrollbar, "CENTER", -1, 0)
    self.scrollbar.background:SetSize(self.scrollbar:GetWidth()+3, parent:GetHeight() - 8)
    self.scrollbar.background:SetColorTexture(0,0,0,0.3)
    
    self.scrollupbutton:ClearAllPoints()
    self.scrollupbutton:SetPoint("TOPRIGHT", self.scrollframe, "TOPRIGHT", -2, -2)
    
    self.scrolldownbutton:ClearAllPoints()
    self.scrolldownbutton:SetPoint("BOTTOMRIGHT", self.scrollframe, "BOTTOMRIGHT", -2, 2)
    
    self.scrollbar:ClearAllPoints()
    self.scrollbar:SetPoint("TOP", self.scrollupbutton, "BOTTOM", 0, -2)
    self.scrollbar:SetPoint("BOTTOM", self.scrolldownbutton, "TOP", 0, 2)
    
    self.scrollframe:SetScrollChild(self.scrollchild)
    self.scrollframe:SetAllPoints(self)
    
    self.scrollchild:SetWidth(self.scrollframe:GetWidth())

    self.scrollframe:SetScript("OnShow",  function() PlayerFrame:UpdateCharacterList() end)

    return self

end

local function getKeyText(cData)
    local keyText
    if cData.keyId > 0 and cData.keyLevel > 0 then
        if not KeyMasterLocals.MAPNAMES[cData.keyId] then
            cData.keyId = 9001 -- unknown keyId
        end
        keyText = "("..tostring(cData.keyLevel)..") "..KeyMasterLocals.MAPNAMES[cData.keyId].abbr
    end
    return keyText
end

-- Access data holders via _G["KM_CharacterRow_"..characterGUID]:GetAttribute([attribute])
-- perform displayed data updates via object type actions.
-- *i.e. _G["KM_CharacterRow_"..characterGUID]:GetAttribute("keyText"):SetText("(15) DHT")*
-- GUID = (Frame Attribute) *text*
-- row = (Frame Object) *table*
-- overallScore = (FontString Object) *pointer*
-- keyText (FontString Object) *pointer*
local cRowCount = 0
local mlr = 4 -- margin left/rigth
local mtb = 4 -- margin top/bottom
local function createCharacterRow(characterGUID, cData)
    local parent = _G["KM_CharacterList"]
    if not parent or not cData then 
        KeyMaster:_ErrorMsg("createCharacterRow","CharactersFrame","Attemped to create character row with nil data.")
        return
    end

    local sbw = 20 -- scroll bar width
    local rWidth = parent:GetWidth() - sbw
    local rHeight = 50
    parent:SetHeight(parent:GetHeight() + rHeight + (mtb*2))


    local characterRow = CreateFrame("Frame", "KM_CharacterRow_"..characterGUID, parent)
    characterRow:SetAttribute("GUID", characterGUID)
    characterRow:SetSize(rWidth-mlr, rHeight)
    characterRow:SetFrameLevel(parent:GetFrameLevel()+1)
    characterRow:SetAttribute("row", characterRow)

    local Hline = KeyMaster:CreateHLine(characterRow:GetWidth()+8, characterRow, "TOP", 0, 0)
    Hline:SetAlpha(0.5)

    local highlightAlpha = 1
    characterRow.textureHighlight = characterRow:CreateTexture(nil, "BACKGROUND", nil, 1)
    characterRow.textureHighlight:SetSize(characterRow:GetWidth(), characterRow:GetHeight())
    characterRow.textureHighlight:SetAllPoints(characterRow)
    characterRow.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    characterRow.textureHighlight:SetAlpha(highlightAlpha)
    local classColor = {}
    local _, className, _ = GetClassInfo(cData.class)
    classColor.r, classColor.g, classColor.b, _ = GetClassColor(className)
    characterRow.textureHighlight:SetVertexColor(classColor.r,classColor.g,classColor.b, highlightAlpha)
    characterRow:SetAttribute("highlight", characterRow.textureHighlight)
    characterRow:SetAttribute("defColor", {classColor.r, classColor.g, classColor.b})
    characterRow:SetAttribute("defAlpha", highlightAlpha)

    local maxTextWidth = characterRow:GetWidth() - 8
    characterRow.charName = characterRow:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    characterRow.charName:SetPoint("TOPLEFT", characterRow, "TOPLEFT", 4, -4)
    characterRow.charName:SetWidth(maxTextWidth)
    local Path, _, Flags = characterRow.charName:GetFont()
    characterRow.charName:SetFont(Path, 18, Flags)
    characterRow.charName:SetJustifyH("LEFT")
    characterRow.charName:SetText(cData.name)
    characterRow.charName:SetTextColor(classColor.r, classColor.g, classColor.b, 1)

    characterRow.realmName = characterRow:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    characterRow.realmName:SetPoint("TOPLEFT", characterRow.charName, "BOTTOMLEFT", 0, 0)
    characterRow.realmName:SetWidth(maxTextWidth)
    local Path, _, Flags = characterRow.realmName:GetFont()
    characterRow.realmName:SetFont(Path, 9, Flags)
    characterRow.realmName:SetJustifyH("LEFT")
    characterRow.realmName:SetText(cData.realm)
    local realmColor = {}
    realmColor.r, realmColor.g, realmColor.b, _ = Theme:GetThemeColor("color_POOR")
    characterRow.realmName:SetTextColor(realmColor.r, realmColor.g, realmColor.b, 1)

    characterRow.overallScore = characterRow:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    characterRow.overallScore:SetPoint("TOPLEFT", characterRow.realmName, "BOTTOMLEFT", 0, -2)
    characterRow.overallScore:SetJustifyH("LEFT")
    --[[ local Path, _, Flags = characterRow.overallScore:GetFont()
    characterRow.overallScore:SetFont(Path, 18, Flags) ]]
    local OverallColor = {}
    OverallColor.r, OverallColor.g, OverallColor.b, _ = Theme:GetThemeColor("color_HEIRLOOM")
    characterRow.overallScore:SetTextColor(OverallColor.r, OverallColor.g, OverallColor.b, 1)
    characterRow.overallScore:SetText(cData.rating)
    characterRow:SetAttribute("overallScore", characterRow.overallScore)

    characterRow.key = characterRow:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    characterRow.key:SetPoint("BOTTOMRIGHT", characterRow, "BOTTOMRIGHT", 0, 4)
    characterRow.key:SetJustifyH("RIGHT")
    
    characterRow.selectedTexture = characterRow:CreateTexture(nil, "ARTWORK")
    characterRow.selectedTexture:SetTexture("Interface/Addons/KeyMaster/Assets/Images/KeyMaster-Interface-Clean")
    characterRow.selectedTexture:SetTexCoord(957/1024, 1, 332/1024,  399/1024)
    characterRow.selectedTexture:SetSize(66, characterRow:GetHeight())
    characterRow.selectedTexture:SetPoint("LEFT", characterRow, "LEFT", -3, 1)
    characterRow.selectedTexture:SetAlpha(0)
    characterRow.selectedTexture:SetVertexColor(classColor.r, classColor.g, classColor.b, 0.3)
    characterRow.selectedTexture:Hide()

    local keyText = getKeyText(cData) or ""
    characterRow.key:SetText(keyText)
    characterRow:SetAttribute("keyText", characterRow.key)

    characterRow:SetScript("OnMouseUp", characterRow_OnRowClick)
    characterRow:SetScript("OnEnter", characterRow_onmouseover)
    characterRow:SetScript("OnLeave", characterRow_onmouseout)

    return characterRow
end

local function charServerFilter(table)
    local realmName = GetRealmName()
    if not realmName then 
        KeyMaster:_ErrorMsg("charServerFilter","CharactersFrame","API did not repond with realm name.")
        return
    end
    local filteredTable = {}
    for cGUID, v in pairs(table) do
        if table[cGUID].realm == realmName then
            filteredTable[cGUID] = v
        end
    end
    return filteredTable
end

local function charRatingFilter(table)
    local filteredTable = {}
    for cGUID, v in pairs(table) do
        if table[cGUID].rating and table[cGUID].rating > 0 then
            filteredTable[cGUID] = v
        end
    end
    return filteredTable
end

local function charKeyFilter(table)
    local filteredTable = {}
    for cGUID, v in pairs(table) do
        if table[cGUID].keyLevel and table[cGUID].keyLevel > 0 then
            filteredTable[cGUID] = v
        end
    end
    return filteredTable
end

local function charSort(sortTable, sort)
    --local sortTable = sortTable
    local tempTable = {}
    local sortedTable = {}

    -- always sort by rating
    for k, v in KeyMaster:spairs(sortTable, function(t, a, b)
        return t[b][sort] < t[a][sort]
    end) do
        -- have to build a sorted table this way becuase the PK is how Lua orders it.. :(
        table.insert(sortedTable, {[k] = v})
    end

    return sortedTable
end

function PlayerFrame:GenerateCharacterList(characterSelectFrame)
    local currentPlayerGUID = UnitGUID("PLAYER")
    if KeyMaster:GetTableLength(KeyMaster_C_DB) ~= 0 then
        local prevRowAnchor, currentRow
        -- constant options for future use
        local FS_REALM = "realm"
        local FS_RATING = "rating"
        local FS_NAME = "name"

        local sortTable = KeyMaster_C_DB
        if KeyMaster_DB.addonConfig.characterFilters.serverFilter then
            if KeyMaster_DB.addonConfig.characterFilters.serverFilter == true then
                sortTable = charServerFilter(sortTable)
            end
        end

        if KeyMaster_DB.addonConfig.characterFilters.filterNoRating then
            if KeyMaster_DB.addonConfig.characterFilters.filterNoRating == true then
                sortTable = charRatingFilter(sortTable)
            end
        end

        if KeyMaster_DB.addonConfig.characterFilters.filterNoKey then
            if KeyMaster_DB.addonConfig.characterFilters.filterNoKey == true then
                sortTable = charKeyFilter(sortTable)
            end
        end

        local characterTable = charSort(sortTable, FS_RATING)

        -- see if we removed a previously selected row from the list and set the correct character to selected.
        local isInNewList = false
        local playerGUID = UnitGUID("player")
        local selectedGUID = CharacterData:GetSelectedCharacterGUID()
        if not selectedGUID then
            CharacterData:SetSelectedCharacterGUID(playerGUID)
            selectedGUID = playerGUID
        end
        local previousGUID = characterSelectFrame:GetAttribute("selectedCharacterGUID")
        
        if previousGUID ~= selectedGUID then 
            previousGUID = selectedGUID
        end

        if previousGUID then
            for k in pairs(characterTable) do
                if characterTable[k][previousGUID] then
                    isInNewList = true
                end
            end
            if not isInNewList then
                characterSelectFrame:SetAttribute("selectedCharacterRow", nil)
                characterSelectFrame:SetAttribute("selectedCharacterGUID", nil)
                CharacterData:SetSelectedCharacterGUID(playerGUID)
                previousGUID = playerGUID
                PlayerFrameMapping:RefreshData(false)
            end
        end

        for k, v in pairs(characterTable) do
            for k2 in pairs(v) do

                currentRow = _G["KM_CharacterRow_"..k2] or createCharacterRow(k2, characterTable[k][k2])
                
                if previousGUID == k2 then
                    setRowActive(currentRow, true)
                else
                    setRowActive(currentRow, false)
                end

                -- set display order of the rows
                if prevRowAnchor == nil then
                    currentRow:SetPoint("TOPLEFT", characterSelectFrame, "TOPLEFT", mlr, -mtb)
                else
                    currentRow:SetPoint("TOP", prevRowAnchor, "BOTTOM", 0, -mtb)
                end

                currentRow:Show()
                prevRowAnchor = currentRow
            end

        end

        KeyMaster.characterList = characterTable
    end
end

function PlayerFrame:CreateCharacterSelectFrame(parent)
    local frameWidth = 175
    local characterSelectFrame = CreateFrame("Frame", "KM_CharacterSelectFrame", parent, "BackdropTemplate")
    characterSelectFrame:ClearAllPoints()
    characterSelectFrame:SetFrameLevel(_G["KeyMaster_MainFrame"]:GetFrameLevel()-1)
    characterSelectFrame:SetSize(frameWidth, parent:GetHeight())
    characterSelectFrame:SetPoint("RIGHT", parent, "LEFT", 4, 0)
    characterSelectFrame:EnableMouse(true)
    characterSelectFrame:SetBackdrop({bgFile="", 
        edgeFile="Interface\\AddOns\\KeyMaster\\Assets\\Images\\UI-Border", 
        tile = false, 
        tileSize = 0, 
        edgeSize = 16, 
        insets = {left = 4, right = 4, top = 4, bottom = 4}})

    local bgWidth = characterSelectFrame:GetWidth()-4
    local bgHeight = characterSelectFrame:GetHeight()-4
    local bgHOffset = 150
    characterSelectFrame.bgTexture = characterSelectFrame:CreateTexture(nil, "BACKGROUND")
    characterSelectFrame.bgTexture:SetPoint("TOPLEFT", characterSelectFrame, "TOPLEFT", 4, 0)
    characterSelectFrame.bgTexture:SetSize(bgWidth, bgHeight)
    characterSelectFrame.bgTexture:SetTexture("Interface/Addons/KeyMaster/Assets/Images/"..Theme.style)
    characterSelectFrame.bgTexture:SetTexCoord(bgHOffset/1024, (bgWidth+bgHOffset)/1024, 175/1024, bgHeight/1024)

    createScrollFrame(characterSelectFrame)

    PlayerFrame:GenerateCharacterList(characterSelectFrame)

    characterSelectFrame:Hide()
    characterSelectFrame:SetScript("OnLoad", function()
        tinsert(UISpecialFrames, self:GetName());
    end)

    return characterSelectFrame
end

function PlayerFrame:UpdateCharacterList()
    if not _G["KM_CharacterSelectFrame"] or not KeyMaster.characterList then return end -- can't run this yet. (race condition)

    local allCharacters = KeyMaster_C_DB
    -- locate any character list row frames that we generated but no longer want to display
    for k in pairs(allCharacters) do
        local rowFrame = _G["KM_CharacterRow_"..k]
        if rowFrame then -- frame exists for this character
            rowFrame:ClearAllPoints()
            rowFrame:Hide() 
        end
    end

    -- update UI with the updated character list (resort, etc)
    PlayerFrame:GenerateCharacterList(_G["KM_CharacterSelectFrame"])
end
