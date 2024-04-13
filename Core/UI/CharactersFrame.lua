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

local function setDefaultColor(row)
    local defColor = {}
    local color = {}
    defColor = row:GetAttribute("defColor")
    color.r = defColor[1]
    color.g = defColor[2]
    color.b = defColor[3]
    row.textureHighlight:SetVertexColor(color.r, color.g, color.b, 1)
end

local function setRowActive(row)
    local activeColor = {}
    row.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Title-BG1")
    --row:SetAttribute("highlight", row.textureHighlight)
    activeColor.r, activeColor.g, activeColor.b, _ = Theme:GetThemeColor("themeFontColorMain")
    row.textureHighlight:SetVertexColor(activeColor.r, activeColor.g, activeColor.b, 1)
end

local function characterRow_OnRowClick(self)
    if self:GetAttribute('active') == true then return end
    local prevRow, prevCharacter
    prevRow = _G["KM_CharacterSelectFrame"]:GetAttribute("selectedCharacterRow")
    --prevCharacter = _G["KM_CharacterSelectFrame"]:GetAttribute("selectedCharacterGUID")
    if prevCharacter ~= self:GetAttribute("GUID") then
        if prevRow then
            prevRow:SetAttribute("active", false)
            prevRow.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight")
            setDefaultColor(prevRow)
        end
        self:SetAttribute("active", true)
        setRowActive(self)

        -- store new row information pointers
        _G["KM_CharacterSelectFrame"]:SetAttribute("selectedCharacterRow", self) -- track selected character row
        _G["KM_CharacterSelectFrame"]:SetAttribute("selectedCharacterGUID", self:GetAttribute("GUID")) -- track selected character GUID
    end
end

local function characterRow_onmouseover(self)
    if self:GetAttribute("active") == false then
        local hoverColor = {}
        hoverColor.r, hoverColor.g, hoverColor.b, _ = Theme:GetThemeColor("party_colHighlight")
        self.textureHighlight:SetVertexColor(hoverColor.r, hoverColor.g, hoverColor.b, 1)
    end
end

local function characterRow_onmouseout(self)
    if self:GetAttribute("active") == false then
        setDefaultColor(self)
    end
end

local function createScrollFrame(parent)
    -- Credit: https://www.wowinterface.com/forums/showthread.php?t=45982
    local frameHolder;
 
    local self = frameHolder or CreateFrame("Frame", nil, parent); -- re-size this to whatever size you wish your ScrollFrame to be, at this point
    self:SetFrameLevel(parent:GetFrameLevel()+1)
    self:SetSize(parent:GetWidth()-8, parent:GetHeight()-12)
    self:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 4, 6)
    
    self.scrollframe = self.scrollframe or CreateFrame("ScrollFrame", "KM_CharacterScrollFrame", self, "UIPanelScrollFrameTemplate");
    
    self.scrollchild = self.scrollchild or CreateFrame("Frame", "KM_CharacterList"); -- not sure what happens if you do, but to be safe, don't parent this yet (or do anything with it)
    
    local scrollbarName = self.scrollframe:GetName()
    self.scrollbar = _G[scrollbarName.."ScrollBar"];
    self.scrollupbutton = _G[scrollbarName.."ScrollBarScrollUpButton"];
    self.scrolldownbutton = _G[scrollbarName.."ScrollBarScrollDownButton"];

    self.scrollbar.background = self.scrollbar:CreateTexture()
    self.scrollbar.background:SetPoint("CENTER", self.scrollbar, "CENTER", -1, 0)
    self.scrollbar.background:SetSize(self.scrollbar:GetWidth()+3, parent:GetHeight() - 8)
    self.scrollbar.background:SetColorTexture(0,0,0,0.3)
    
    self.scrollupbutton:ClearAllPoints();
    self.scrollupbutton:SetPoint("TOPRIGHT", self.scrollframe, "TOPRIGHT", -2, -2);
    
    self.scrolldownbutton:ClearAllPoints();
    self.scrolldownbutton:SetPoint("BOTTOMRIGHT", self.scrollframe, "BOTTOMRIGHT", -2, 2);
    
    self.scrollbar:ClearAllPoints();
    self.scrollbar:SetPoint("TOP", self.scrollupbutton, "BOTTOM", 0, -2);
    self.scrollbar:SetPoint("BOTTOM", self.scrolldownbutton, "TOP", 0, 2);
    self.scrollframe:SetScrollChild(self.scrollchild);
    
    self.scrollframe:SetAllPoints(self);
    
    self.scrollchild:SetWidth(self.scrollframe:GetWidth())
    --[[ self.moduleoptions = self.moduleoptions or CreateFrame("Frame", nil, self.scrollchild);
    self.moduleoptions:SetAllPoints(self.scrollchild); ]]
end

local cRowCount = 0
local prevRowAnchor
local function createCharacterRow(characterGUID, cData)
    local parent = _G["KM_CharacterList"]
    if not parent or not cData then 
        KeyMaster:_ErrorMsg("createCharacterRow","CharactersFrame","Attemped to create character row with nil data.")
        return
    end

    local mlr = 4 -- margin left/rigth
    local mtb = 4 -- margin top/bottom
    local sbw = 20 -- scroll bar width
    local rWidth = parent:GetWidth() - sbw - mlr
    local rHeight = 50
    parent:SetHeight(parent:GetHeight() + rHeight + (mtb*2))


    local characterRow = CreateFrame("Frame", "KM_CharacterRow_"..characterGUID, parent)
    characterRow:SetAttribute("GUID", characterGUID)
    characterRow:SetSize(rWidth-mlr, rHeight)
    if prevRowAnchor == nil then
        characterRow:SetPoint("TOPLEFT", parent, "TOPLEFT", mlr, -mtb)
        characterRow:SetFrameLevel(parent:GetFrameLevel()+1)
        prevRowAnchor = characterRow
    else
        characterRow:SetPoint("TOP", prevRowAnchor, "BOTTOM", 0, -mtb)
        characterRow:SetFrameLevel(parent:GetFrameLevel()+1)
        prevRowAnchor = characterRow
    end

    local Hline = KeyMaster:CreateHLine(characterRow:GetWidth()+8, characterRow, "TOP", 0, 0)
    Hline:SetAlpha(0.5)

    local highlightAlpha = 1
    characterRow.textureHighlight = characterRow:CreateTexture(nil, "BACKGROUND", nil, 1)
    characterRow.textureHighlight:SetSize(characterRow:GetWidth(), characterRow:GetHeight())
    --characterRow.textureHighlight:SetPoint("LEFT", characterRow, "LEFT", 0, 0)
    characterRow.textureHighlight:SetAllPoints(characterRow)
    characterRow.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    characterRow.textureHighlight:SetAlpha(highlightAlpha)
    local classColor = {}
    --local hlColorString = "color_COMMON"
    local _, className, _ = GetClassInfo(cData.class)
    classColor.r, classColor.g, classColor.b, _ = GetClassColor(className)
    --hlColor.r, hlColor.g, hlColor.b, _ = Theme:GetThemeColor(hlColorString)
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
    realmColor.r, realmColor.g, realmColor.b, _ = Theme:GetThemeColor("color_DARKGREY")
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

    characterRow.key = characterRow:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    characterRow.key:SetPoint("BOTTOMRIGHT", characterRow, "BOTTOMRIGHT", 0, 4)
    characterRow.key:SetJustifyH("RIGHT")
    --[[ local Path, _, Flags = characterRow.key:GetFont()
    characterRow.key:SetFont(Path, 16, Flags) ]]
    --[[ local OverallColor = {}
    OverallColor.r, OverallColor.g, OverallColor.b, _ = Theme:GetThemeColor("color_HEIRLOOM")
    characterRow.key:SetTextColor(OverallColor.r, OverallColor.g, OverallColor.b, 1) ]]
    local keyText = "" -- KeyMasterLocals.PARTYFRAME["NoKey"].text
    if cData.keyId > 0 and cData.keyLevel > 0 then
        if not KeyMasterLocals.MAPNAMES[cData.keyId] then
            cData.keyId = 9001 -- unknown keyId
        end
        keyText = "("..tostring(cData.keyLevel)..") "..KeyMasterLocals.MAPNAMES[cData.keyId].abbr
    end
    characterRow.key:SetText(keyText)

    characterRow:SetScript("OnMouseUp", characterRow_OnRowClick)
    characterRow:SetScript("OnEnter", characterRow_onmouseover)
    characterRow:SetScript("OnLeave", characterRow_onmouseout)

    return characterRow
end

function PlayerFrame:CreateCharacterSelectFrame(parent)
    local frameWidth = 175
    local characterSelectFrame = CreateFrame("Frame", "KM_CharacterSelectFrame", parent, "BackdropTemplate")
    characterSelectFrame:ClearAllPoints()
    --characterSelectFrame:SetClampedToScreen(true)
    characterSelectFrame:SetFrameLevel(_G["KeyMaster_MainFrame"]:GetFrameLevel()-1)
    characterSelectFrame:SetSize(frameWidth, parent:GetHeight())
    characterSelectFrame:SetPoint("RIGHT", parent, "LEFT", 4, 0)
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
    --characterSelectFrame.bgTexture:SetAllPoints(characterSelectFrame)
    characterSelectFrame.bgTexture:SetPoint("TOPLEFT", characterSelectFrame, "TOPLEFT", 4, 0)
    characterSelectFrame.bgTexture:SetSize(bgWidth, bgHeight)
    characterSelectFrame.bgTexture:SetTexture("Interface/Addons/KeyMaster/Assets/Images/"..Theme.style)
    characterSelectFrame.bgTexture:SetTexCoord(bgHOffset/1024, (bgWidth+bgHOffset)/1024, 175/1024, bgHeight/1024)

   --[[  characterSelectFrame.closeBtn = CreateFrame("Button", "CloseButton", mainFrame, "UIPanelCloseButton")
    characterSelectFrame.closeBtn:SetPoint("TOPRIGHT")
    characterSelectFrame.closeBtn:SetSize(20, 20)
    characterSelectFrame.closeBtn:SetNormalFontObject("GameFontNormalLarge")
    characterSelectFrame.closeBtn:SetHighlightFontObject("GameFontHighlightLarge") ]]
    --characterSelectFrame:Hide()

    createScrollFrame(characterSelectFrame)

--[[     local function highestRating(ratingLhs, ratingRhs) -- sort by rating, highest on top
        print(ratingLhs["rating"])
        return KeyMaster_C_DB[ratingLhs].rating < KeyMaster_C_DB[ratingLhs].rating
    end ]]

    local currentPlayerGUID = UnitGUID("PLAYER")
    if KeyMaster:GetTableLength(KeyMaster_C_DB) ~= 0 then
        local currentRow

        local FS_REALM = "realm"
        local FS_RATING = "rating"
        local FS_NAME = "name"

        local function charServerFilter()
            local realmName = GetRealmName()
            if not realmName then 
                KeyMaster:_ErrorMsg("charServerFilter","CharactersFrame","API did not repond with realm name.")
                return
            end
            local filteredTable = {}
            for cGUID, v in pairs(KeyMaster_C_DB) do
                if KeyMaster_C_DB[cGUID].realm == realmName then
                    table.insert(filteredTable, v)
                end
            end
            return filteredTable
        end      

        local function charSort(sortTable, filter)
            local sortTable = sortTable
            local sortedTable = {}

            -- always sort by rating
            for k, v in KeyMaster:spairs(sortTable, function(t, a, b)
                return t[b][filter] < t[a][filter]
            end) do
                table.insert(sortedTable, v)
            end
            return sortedTable
        end

        local sortTable = charServerFilter()
        local characterTable = charSort(sortTable, FS_RATING)
        if characterTable[currentPlayerGUID] ~= nil then -- set active player to the top row if has data
            currentRow = createCharacterRow(currentPlayerGUID, characterTable[currentPlayerGUID])
            currentRow:SetAttribute("active", true) -- set as currently selected
            characterSelectFrame:SetAttribute("selectedCharacterRow", currentRow) -- track selected character row
            characterSelectFrame:SetAttribute("selectedCharacterGUID", currentPlayerGUID) -- track selected character GUID
            setRowActive(currentRow)
        end
        for playerGUID in pairs(characterTable) do
            if playerGUID ~= currentPlayerGUID then -- skip active character. We already took care of that row.
                currentRow = createCharacterRow(playerGUID, characterTable[playerGUID])
                currentRow:SetAttribute("active", false) -- set as not currently selected
                -- uncomment to test multiple rows
                --[[ createCharacterRow(playerGUID, KeyMaster_C_DB[playerGUID])
                createCharacterRow(playerGUID, KeyMaster_C_DB[playerGUID]) ]]
            end
        end
        KeyMaster.characterList = characterTable
    end

    characterSelectFrame:Hide()
    return characterSelectFrame
end