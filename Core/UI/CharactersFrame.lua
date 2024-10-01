--------------------------------
-- CharactersFrame.lua
-- Handles Character Select interface.
--------------------------------

local _, KeyMaster = ...
KeyMaster.CharactersFrame = {}
local CharactersFrame = KeyMaster.CharactersFrame
local Theme = KeyMaster.Theme
local CharacterData = KeyMaster.CharacterData
local PlayerFrameMapping = KeyMaster.PlayerFrameMapping
local CharactersFrameMapping = KeyMaster.CharactersFrameMapping

local function createCharacterSelectFrame(parent)
    local frameWidth = 175
    local characterSelectFrame = _G["KM_CharacterSelectFrame"] or CreateFrame("Frame", "KM_CharacterSelectFrame", parent, "BackdropTemplate")
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
    characterSelectFrame:SetScript("OnShow",  
        function() 
            CharactersFrame:ResetCharacterList()
            CharactersFrame:CreateCharacters() 
        end
    )
    
    local scrollFrame
    scrollFrame = _G["KM_CharacterListScrollFrame"] or CreateFrame("Frame", "KM_CharacterListScrollFrame", characterSelectFrame)
    scrollFrame:SetFrameLevel(characterSelectFrame:GetFrameLevel()+1)
    scrollFrame:SetSize(characterSelectFrame:GetWidth()-8, characterSelectFrame:GetHeight()-12)
    scrollFrame:SetPoint("BOTTOMLEFT", characterSelectFrame, "BOTTOMLEFT", 4, 6)
    
    scrollFrame.scrollframe = scrollFrame.scrollframe or CreateFrame("ScrollFrame", "KM_CharacterScrollFrame", scrollFrame, "UIPanelScrollFrameTemplate");
    
    scrollFrame.scrollchild = scrollFrame.scrollchild or CreateFrame("Frame", "KM_CharacterList")
    
    local scrollbarName = scrollFrame.scrollframe:GetName()
    scrollFrame.scrollbar = _G[scrollbarName.."ScrollBar"]
    scrollFrame.scrollupbutton = _G[scrollbarName.."ScrollBarScrollUpButton"]
    scrollFrame.scrolldownbutton = _G[scrollbarName.."ScrollBarScrollDownButton"]

    scrollFrame.scrollbar.background = scrollFrame.scrollbar:CreateTexture()
    scrollFrame.scrollbar.background:SetPoint("CENTER", scrollFrame.scrollbar, "CENTER", -1, 0)
    scrollFrame.scrollbar.background:SetSize(scrollFrame.scrollbar:GetWidth()+3, characterSelectFrame:GetHeight() - 8)
    scrollFrame.scrollbar.background:SetColorTexture(0,0,0,0.3)
    
    scrollFrame.scrollupbutton:ClearAllPoints()
    scrollFrame.scrollupbutton:SetPoint("TOPRIGHT", scrollFrame.scrollframe, "TOPRIGHT", -2, -2)
    
    scrollFrame.scrolldownbutton:ClearAllPoints()
    scrollFrame.scrolldownbutton:SetPoint("BOTTOMRIGHT", scrollFrame.scrollframe, "BOTTOMRIGHT", -2, 2)
    
    scrollFrame.scrollbar:ClearAllPoints()
    scrollFrame.scrollbar:SetPoint("TOP", scrollFrame.scrollupbutton, "BOTTOM", 0, -2)
    scrollFrame.scrollbar:SetPoint("BOTTOM", scrollFrame.scrolldownbutton, "TOP", 0, 2)
    
    scrollFrame.scrollframe:SetScrollChild(scrollFrame.scrollchild)
    scrollFrame.scrollframe:SetAllPoints(scrollFrame)
    
    scrollFrame.scrollchild:SetWidth(scrollFrame.scrollframe:GetWidth())

    characterSelectFrame:Hide()
    -- characterSelectFrame:SetScript("OnLoad", function()
    --     tinsert(UISpecialFrames, self:GetName());
    -- end)

    return characterSelectFrame
end

local function toggleActiveCharacterRow(guid, setActive)
    local characterRow = _G["KM_CharacterRow_"..guid]
    if not characterRow then
        -- removed in 1.3.5 as it only displayed when logging onto sub max level character and clicking a max character for the first time...
        --[[ if KeyMaster_C_DB[guid] then
            KeyMaster:_ErrorMsg("toggleActiveCharacterRow","CharactersFrame", "Character row not found.")
        end ]]
        return
    end
    local characterSelectFrame = _G["KM_CharacterSelectFrame"]
    if not characterSelectFrame then
        KeyMaster:_ErrorMsg("toggleActiveCharacterRow","CharactersFrame", "Character select frame not found.")
        return
    end

    if setActive then
        characterRow.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Title-BG1")
        CharacterData:SetSelectedCharacterGUID(guid)
        characterRow.selectedTexture:Show()
    else
        characterRow.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight")
        characterRow.selectedTexture:Hide()
    end
end

local function characterRow_OnRowClick(self)
    local selectedCharacterGUID = CharacterData:GetSelectedCharacterGUID()
    if self:GetAttribute("GUID") == selectedCharacterGUID then return end -- already the selected character

    -- Deselect current character
    toggleActiveCharacterRow(selectedCharacterGUID, false)

    -- Set new selected character
    toggleActiveCharacterRow(self:GetAttribute("GUID"), true)
    PlayerFrameMapping:RefreshData(false)    
end

local function characterRow_onmouseover(self)
    local selectedCharacterGUID = CharacterData:GetSelectedCharacterGUID()
    if self:GetAttribute("GUID") == selectedCharacterGUID then return end -- already the selected character
    
    self.selectedTexture:Show()
end

local function characterRow_onmouseout(self)
    local selectedCharacterGUID = CharacterData:GetSelectedCharacterGUID()
    if self:GetAttribute("GUID") == selectedCharacterGUID then return end -- already the selected character
    
    self.selectedTexture:Hide()    
end

local function updateCharacterData(guid, characterData)
    -- get or create a frame for character
    local characterFrame = _G["KM_CharacterRow_"..guid]
    if not characterFrame then
        KeyMaster:_ErrorMsg("updateCharacterData","CharactersFrame", "Character frame not found.")
    end

    -- Class Color
    local classColor = {}
    local _, className, _ = GetClassInfo(characterData.class)
    classColor.r, classColor.g, classColor.b, _ = GetClassColor(className)
    characterFrame.textureHighlight:SetVertexColor(classColor.r,classColor.g,classColor.b, 1)
    characterFrame:SetAttribute("defColor", {classColor.r, classColor.g, classColor.b})
    characterFrame.selectedTexture:SetVertexColor(classColor.r, classColor.g, classColor.b, 0.3)
    characterFrame.charName:SetTextColor(classColor.r, classColor.g, classColor.b, 1)
    
    -- Name
    characterFrame.charName:SetText(characterData.name)
    
    -- Realm Name
    characterFrame.realmName:SetText(characterData.realm)

    -- Overall Score
    characterFrame.overallScore:SetText(characterData.rating)
    
    -- Key Information
    if characterData.keyId > 0 and characterData.keyLevel > 0 then
        if not KeyMasterLocals.MAPNAMES[characterData.keyId] then
            characterData.keyId = 9001 -- unknown keyId
        end
        local keyText = "("..tostring(characterData.keyLevel)..") "..KeyMasterLocals.MAPNAMES[characterData.keyId].abbr
        characterFrame.key:SetText(keyText)
    end    
end

function CharactersFrame:NoCharactersToDisplay(show)
    if not show then show = false end
    local noCharacters = _G["KM_NoCharacters"]

    local function showHide(frame)
        if frame and show then
            frame:Show()
        elseif frame and not show then
            frame:Hide()
        end
        return frame 
    end

    if noCharacters then
        noCharacters = showHide(noCharacters)
        return noCharacters
    end

    local parent = _G["KM_CharacterSelectFrame"]
    if not parent then 
        KeyMaster:_ErrorMsg("NoCharactersToDisplay","CharactersFrame", "Attemped to create (no characters) icon before parent frame created.")
        return
    end

    noCharacters = CreateFrame("Frame", "KM_NoCharacters", parent)
    noCharacters:SetSize(80, 80)
    noCharacters:SetPoint("CENTER", parent, "CENTER", -5, 0)
    noCharacters:SetFrameLevel(parent:GetFrameLevel()+1)
    noCharacters.icon = noCharacters:CreateTexture()
    noCharacters.icon:SetTexture("Interface/Addons/KeyMaster/Assets/Images/"..Theme.style)
    noCharacters.icon:SetTexCoord(916/1024, 1, 216/1024, 322/1024)
    noCharacters.icon:SetAllPoints(noCharacters)
    noCharacters.icon:SetSize(80, 80)
    noCharacters.icon:SetAlpha(0.1)
 
    noCharacters = showHide(noCharacters)
    return noCharacters

end

function CharactersFrame:CreateCharacterRow(characterGUID)
    local parent = _G["KM_CharacterList"]
    if not parent then 
        KeyMaster:_ErrorMsg("createCharacterRow","CharactersFrame", "Attemped to create character before parent frame created.")
        return
    end

    local mlr = 4 -- margin left/rigth
    local mtb = 4 -- margin top/bottom
    local sbw = 20 -- scroll bar width
    local rWidth = parent:GetWidth() - sbw
    local rHeight = 50
    parent:SetHeight(parent:GetHeight() + rHeight + (mtb*2))

    local characterRow = CreateFrame("Frame", "KM_CharacterRow_"..characterGUID, parent)
    characterRow:SetAttribute("GUID", characterGUID)
    characterRow:SetSize(rWidth-mlr, rHeight)
    characterRow:SetFrameLevel(parent:GetFrameLevel()+1)
    
    local Hline = KeyMaster:CreateHLine(characterRow:GetWidth()+8, characterRow, "TOP", 0, 0)
    Hline:SetAlpha(0.5)

    characterRow.textureHighlight = characterRow:CreateTexture(nil, "BACKGROUND", nil, 1)
    characterRow.textureHighlight:SetSize(characterRow:GetWidth(), characterRow:GetHeight())
    characterRow.textureHighlight:SetAllPoints(characterRow)
    characterRow.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    characterRow.textureHighlight:SetAlpha(1)
    
    characterRow:SetAttribute("highlight", characterRow.textureHighlight)
    characterRow:SetAttribute("defColor", {1, 1, 1})
    characterRow:SetAttribute("defAlpha", 1)

    local maxTextWidth = characterRow:GetWidth() - 8
    characterRow.charName = characterRow:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    characterRow.charName:SetPoint("TOPLEFT", characterRow, "TOPLEFT", 4, -4)
    characterRow.charName:SetWidth(maxTextWidth)
    local Path, _, Flags = characterRow.charName:GetFont()
    characterRow.charName:SetFont(Path, 18, Flags)
    characterRow.charName:SetJustifyH("LEFT")
    characterRow.charName:SetText("")
    
    characterRow.realmName = characterRow:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    characterRow.realmName:SetPoint("TOPLEFT", characterRow.charName, "BOTTOMLEFT", 0, 0)
    characterRow.realmName:SetWidth(maxTextWidth)
    local Path, _, Flags = characterRow.realmName:GetFont()
    characterRow.realmName:SetFont(Path, 9, Flags)
    characterRow.realmName:SetJustifyH("LEFT")
    characterRow.realmName:SetText("")
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
    characterRow.overallScore:SetText("")

    characterRow.key = characterRow:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    characterRow.key:SetPoint("BOTTOMRIGHT", characterRow, "BOTTOMRIGHT", 0, 4)
    characterRow.key:SetJustifyH("RIGHT")
    
    characterRow.selectedTexture = characterRow:CreateTexture(nil, "ARTWORK")
    characterRow.selectedTexture:SetTexture("Interface/Addons/KeyMaster/Assets/Images/"..Theme.style)
    characterRow.selectedTexture:SetTexCoord(957/1024, 1, 332/1024,  399/1024)
    characterRow.selectedTexture:SetSize(66, characterRow:GetHeight())
    characterRow.selectedTexture:SetPoint("LEFT", characterRow, "LEFT", -3, 1)
    characterRow.selectedTexture:SetAlpha(0)
    
    characterRow.selectedTexture:Hide()

    characterRow.key:SetText("")

    -- Scripts    
    characterRow:SetScript("OnMouseUp", characterRow_OnRowClick)
    characterRow:SetScript("OnEnter", characterRow_onmouseover)
    characterRow:SetScript("OnLeave", characterRow_onmouseout)

    return characterRow
end

function CharactersFrame:ResetCharacterList()
    -- do nothing if no data in saved variables
    if KeyMaster:GetTableLength(KeyMaster_C_DB) == 0 then 
        return 
    end

    for guid, characterData in pairs(KeyMaster_C_DB) do
        local characterRow = _G["KM_CharacterRow_"..guid]
        if characterRow then
            toggleActiveCharacterRow(guid, false)
            characterRow:ClearAllPoints()
            characterRow:Hide()
        end
    end
end

function CharactersFrame:CreateCharacters()
    -- do nothing if no data in saved variables
    if KeyMaster:GetTableLength(KeyMaster_C_DB) == 0 then 
        return 
    end

    local charactersTable = CharacterData:GetCharactersList()
    local selectedCharacterGUID = CharacterData:GetSelectedCharacterGUID()
    local isToggledActiveCharacter = false
    local prevRowAnchor = nil
    local mlr = 4 -- margin left/rigth
    local mtb = 4 -- margin top/bottom

    -- create a frame and set data for each character
    for _, v in ipairs(charactersTable) do
        for guid, characterData in pairs(v) do
            local characterRow = _G["KM_CharacterRow_"..guid] or CharactersFrame:CreateCharacterRow(guid)
            -- set display order of the rows
            if prevRowAnchor == nil then
                characterRow:SetPoint("TOPLEFT", _G["KM_CharacterList"], "TOPLEFT", mlr, -mtb)
            else
                characterRow:SetPoint("TOP", prevRowAnchor, "BOTTOM", 0, -mtb)
            end

            characterRow:Show()
            prevRowAnchor = characterRow

            updateCharacterData(guid, characterData)
            if guid == selectedCharacterGUID then
                toggleActiveCharacterRow(guid, true)
                isToggledActiveCharacter = true
            end
        end
    end
    -- if nobody is selected, reset to player
    if isToggledActiveCharacter == false then
        local playerGUID = UnitGUID("player")
        CharacterData:SetSelectedCharacterGUID(playerGUID)
        if _G["KM_CharacterRow_"..playerGUID] then
            toggleActiveCharacterRow(playerGUID, true)
        end
        PlayerFrameMapping:RefreshData(false)
    end

    if KeyMaster:GetTableLength(charactersTable) == 0 then
        CharactersFrame:NoCharactersToDisplay(true)
    else
        CharactersFrame:NoCharactersToDisplay(false)
    end

end

function CharactersFrame:Initialize(parentFrame)
    local characterSelectFrame = _G["KM_CharacterSelectFrame"] or createCharacterSelectFrame(parentFrame)

    -- clean up any old data in saved variables
    KeyMaster_C_DB = KeyMaster:CleanCharSavedData(KeyMaster_C_DB)
    CharactersFrame:CreateCharacters()

    return characterSelectFrame
end