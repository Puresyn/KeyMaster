local _, KeyMaster = ...
local ConfigFrame = {}
KeyMaster.ConfigFrame = ConfigFrame
local Theme = KeyMaster.Theme
local KMFactory = KeyMaster.Factory
local CharacterData = KeyMaster.CharacterData
local CharacterInfo = KeyMaster.CharacterInfo
local CharactersFrame = KeyMaster.CharactersFrame

function ConfigFrame:CreateConfigFrame(parentFrame)
    local mtb = 4 -- margin top/bottom
    local mlr = 4 -- margin left/right
    local conFrame = CreateFrame("Frame", "KM_Configuration_Frame",parentFrame)
    conFrame:SetPoint("CENTER", parentFrame, "CENTER", 0, -2)
    conFrame:SetSize(parentFrame:GetWidth()-(mlr*2), parentFrame:GetHeight()-(mtb*3))

    -- Header Frame
    local conFrameHeader = CreateFrame("Frame", "KM_ConfigHeader_Frame",conFrame)
    conFrameHeader:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 4, -8)
    conFrameHeader:SetSize(parentFrame:GetWidth()-8, 100)
    conFrameHeader.texture = conFrameHeader:CreateTexture(nil, "BACKGROUND", nil, 0)
    conFrameHeader.texture:SetAllPoints(conFrameHeader)
    conFrameHeader.texture:SetColorTexture(0, 0, 0, 1)

    conFrameHeader.textureHighlight = conFrameHeader:CreateTexture(nil, "BACKGROUND", nil)
    conFrameHeader.textureHighlight:SetSize(conFrameHeader:GetWidth(), conFrameHeader:GetHeight())
    conFrameHeader.textureHighlight:SetPoint("LEFT", conFrameHeader, "LEFT", 0, 0)
    conFrameHeader.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    local headerColor = {}
    headerColor.r, headerColor.g, headerColor.b, _ = Theme:GetThemeColor("color_COMMON")
    conFrameHeader.textureHighlight:SetVertexColor(headerColor.r, headerColor.g, headerColor.b, 1)

    -- Page Header Title Large Background
    conFrameHeader.titleBG = conFrameHeader:CreateFontString(nil, "ARTWORK", "KeyMasterFontBig")
    local Path, _, Flags = conFrameHeader.titleBG:GetFont()
    conFrameHeader.titleBG:SetFont(Path, 120, Flags)
    conFrameHeader.titleBG:SetSize(conFrameHeader:GetWidth(), conFrameHeader:GetHeight())
    conFrameHeader.titleBG:SetPoint("BOTTOMLEFT", conFrameHeader, "BOTTOMLEFT", -4, -8)
    local headerBGTextColor = {}
    headerBGTextColor.r, headerBGTextColor.g, headerBGTextColor.b, _ = Theme:GetThemeColor("color_COMMON")
    conFrameHeader.titleBG:SetTextColor(headerBGTextColor.r, headerBGTextColor.g, headerBGTextColor.b, 1)
    conFrameHeader.titleBG:SetText(KeyMasterLocals.TABCONFIG)
    conFrameHeader.titleBG:SetAlpha(0.04)
    conFrameHeader.titleBG:SetJustifyH("LEFT")

    -- Page Header Title
    conFrameHeader.title = conFrameHeader:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    conFrameHeader.title:SetPoint("BOTTOMLEFT", conFrameHeader, "BOTTOMLEFT", 4, 4)
    local Path, _, Flags = conFrameHeader.title:GetFont()
    conFrameHeader.title:SetFont(Path, 40, Flags)
    local headerTextColor = {}
    headerTextColor.r, headerTextColor.g, headerTextColor.b, _ = Theme:GetThemeColor("color_COMMON")
    conFrameHeader.title:SetTextColor(headerTextColor.r, headerTextColor.g, headerTextColor.b, 1)
    conFrameHeader.title:SetText(KeyMasterLocals.TABCONFIG)

    --[[ conFrame.boxBackground = conFrame:CreateTexture(nil, "ARTWORK")
    conFrame.boxBackground:SetSize(conFrame:GetWidth(), conFrame:GetHeight())
    conFrame.boxBackground:SetPoint("CENTER", conFrame, "CENTER")
    conFrame.boxBackground:SetColorTexture(0.3,0.3,0.3,1) ]]

    --/////////////////////////// 
    --Configuration Panels Colors
    --///////////////////////////
    -- Gradient highlight
    local highlightAlpha = 0.5
    local hlColor = {}
    local hlColorString = "color_NONPHOTOBLUE"
    hlColor.r, hlColor.g, hlColor.b, _ = Theme:GetThemeColor(hlColorString)

    -- Title Color
    local titleColor = {}
    local titleColorString = "color_THEMEGOLD"
    titleColor.r, titleColor.g, titleColor.b, _ = Theme:GetThemeColor(titleColorString)

    -- Options color
    local optionsColor = {}
    local optionsColorString = "color_COMMON"
    optionsColor.r, optionsColor.g, optionsColor.b, _ = Theme:GetThemeColor(optionsColorString)

    -- Note color
    local noteColor = {}
    local noteColorString = "color_DEBUGMSG"
    noteColor.r, noteColor.g, noteColor.b, _ = Theme:GetThemeColor(noteColorString)

    --////////////////////
    --Configuration Panels
    --////////////////////
    local settingsPanelBaseHeight = conFrame:GetHeight()-conFrameHeader:GetHeight()-12

    -- Display Settings
    local displaySetting = CreateFrame("Frame", nil, conFrame)
    displaySetting:SetPoint("TOPLEFT", conFrameHeader, "BOTTOMLEFT", 0, -4)
    displaySetting:SetSize((conFrame:GetWidth()-(mlr*2))/3, settingsPanelBaseHeight/2)
    displaySetting.title = displaySetting:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    displaySetting.title:SetTextColor(titleColor.r, titleColor.g, titleColor.b, 1)
    displaySetting.title:SetPoint("TOPLEFT", displaySetting, "TOPLEFT", 4, -4)
    displaySetting.title:SetText(KeyMasterLocals.CONFIGURATIONFRAME["DisplaySettings"].name)

    local Hline = KeyMaster:CreateHLine(displaySetting:GetWidth()+8, displaySetting, "TOP", 0, 0)
    Hline:SetAlpha(0.5)

    displaySetting.texture = displaySetting:CreateTexture(nil, "BACKGROUND", nil, 0)
    displaySetting.texture:SetAllPoints(displaySetting)
    displaySetting.texture:SetColorTexture(0, 0, 0, 1)

    displaySetting.textureHighlight = displaySetting:CreateTexture(nil, "BACKGROUND", nil, 1)
    displaySetting.textureHighlight:SetSize(displaySetting:GetWidth(), displaySetting:GetHeight())
    displaySetting.textureHighlight:SetPoint("LEFT", displaySetting, "LEFT", 0, 0)
    displaySetting.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    displaySetting.textureHighlight:SetAlpha(highlightAlpha)
    displaySetting.textureHighlight:SetVertexColor(hlColor.r,hlColor.g,hlColor.b, highlightAlpha)

    -- Display Float Checkbox/Button
    local showFloatFrame = CreateFrame("Frame", nil, displaySetting)
    showFloatFrame:SetPoint("TOPLEFT", displaySetting.title, "BOTTOMLEFT", 0, 0)
    showFloatFrame:SetWidth(displaySetting:GetWidth()-8)
    
    displaySetting.showFloat = CreateFrame("CheckButton", "KM_DiplayFloatCheckBox", showFloatFrame, "ChatConfigCheckButtonTemplate")
    local Path, _, Flags = conFrameHeader.title:GetFont()
    displaySetting.showFloat.Text:SetFont(Path, 12, Flags)
    displaySetting.showFloat.Text:SetTextColor(optionsColor.r, optionsColor.g, optionsColor.b, 1)
    displaySetting.showFloat.Text:SetText(KeyMasterLocals.CONFIGURATIONFRAME["ToggleRatingFloat"].text)
    displaySetting.showFloat.Text:SetWidth(showFloatFrame:GetWidth()- displaySetting.showFloat:GetWidth())

    showFloatFrame:SetHeight(displaySetting.showFloat.Text:GetHeight()+12)

    displaySetting.showFloat:SetPoint("BOTTOMLEFT",showFloatFrame, "BOTTOMLEFT", 0, 0)
    displaySetting.showFloat.Text:SetPoint("BOTTOMLEFT", displaySetting.showFloat, "BOTTOMRIGHT", 0, 6)

    if (KeyMaster_DB.addonConfig.showRatingFloat) then
        displaySetting.showFloat:SetChecked(KeyMaster_DB.addonConfig.showRatingFloat)
    end
    displaySetting.showFloat:HookScript("OnClick", function()
        if (displaySetting.showFloat:GetChecked()) == true then
            KeyMaster_DB.addonConfig.showRatingFloat = true
        else
            KeyMaster_DB.addonConfig.showRatingFloat = false
        end
    end)

    -- Display Minimap Icon Checkbox/Button
    local showMMIFrame = CreateFrame("Frame", nil, displaySetting)
    showMMIFrame:SetPoint("TOPLEFT", showFloatFrame, "BOTTOMLEFT", 0, 0)
    showMMIFrame:SetWidth(displaySetting:GetWidth()-8)

    displaySetting.showMMB = CreateFrame("CheckButton", "KM_DiplayMinimapCheckBox", showMMIFrame, "ChatConfigCheckButtonTemplate")
    local Path, _, Flags = conFrameHeader.title:GetFont()
    displaySetting.showMMB.Text:SetFont(Path, 12, Flags)
    displaySetting.showMMB.Text:SetTextColor(optionsColor.r, optionsColor.g, optionsColor.b, 1)
    displaySetting.showMMB.Text:SetText(KeyMasterLocals.CONFIGURATIONFRAME["ShowMiniMapButton"].text)

    displaySetting.showMMB.Text:SetWidth(showMMIFrame:GetWidth()- displaySetting.showMMB:GetWidth())

    showMMIFrame:SetHeight(displaySetting.showMMB.Text:GetHeight()+12)

    displaySetting.showMMB:SetPoint("BOTTOMLEFT",showMMIFrame, "BOTTOMLEFT", 0, 0)
    displaySetting.showMMB.Text:SetPoint("BOTTOMLEFT", displaySetting.showMMB, "BOTTOMRIGHT", 0, 6)

    if (KeyMaster_DB.addonConfig.miniMapButtonPos.hide == false) then
        displaySetting.showMMB:SetChecked(true)
    end
    displaySetting.showMMB:HookScript("OnClick", function()
        if (displaySetting.showMMB:GetChecked()) == true then
            KeyMaster_DB.addonConfig.miniMapButtonPos.hide = false
            _G["LibDBIcon10_KeyMaster"]:Show()
        else
            KeyMaster_DB.addonConfig.miniMapButtonPos.hide = true
            _G["LibDBIcon10_KeyMaster"]:Hide()
        end
    end)

    -- Diagnostic Settings
    local diagnosticSettings = CreateFrame("Frame", nil, conFrame)
    diagnosticSettings:SetPoint("TOPLEFT", displaySetting, "TOPRIGHT", 4, 0)
    diagnosticSettings:SetSize((conFrame:GetWidth()-(mlr*2))/3, settingsPanelBaseHeight/2)
    diagnosticSettings.title = diagnosticSettings:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    diagnosticSettings.title:SetTextColor(titleColor.r, titleColor.g, titleColor.b, 1)
    diagnosticSettings.title:SetPoint("TOPLEFT", diagnosticSettings, "TOPLEFT", 4, -4)
    diagnosticSettings.title:SetText(KeyMasterLocals.CONFIGURATIONFRAME["DiagnosticSettings"].name)

    local Hline = KeyMaster:CreateHLine(diagnosticSettings:GetWidth()+8, diagnosticSettings, "TOP", 0, 0)
    Hline:SetAlpha(0.5)

    diagnosticSettings.texture = diagnosticSettings:CreateTexture(nil, "BACKGROUND", nil, 0)
    diagnosticSettings.texture:SetAllPoints(diagnosticSettings)
    diagnosticSettings.texture:SetColorTexture(0, 0, 0, 1)

    diagnosticSettings.textureHighlight = diagnosticSettings:CreateTexture(nil, "BACKGROUND", nil, 1)
    diagnosticSettings.textureHighlight:SetSize(diagnosticSettings:GetWidth(), diagnosticSettings:GetHeight())
    diagnosticSettings.textureHighlight:SetPoint("LEFT", diagnosticSettings, "LEFT", 0, 0)
    diagnosticSettings.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    diagnosticSettings.textureHighlight:SetAlpha(highlightAlpha)
    diagnosticSettings.textureHighlight:SetVertexColor(hlColor.r,hlColor.g,hlColor.b, highlightAlpha)

    -- Diagnostics Notification
    local diagnosticSettingsWarningFrame = CreateFrame("Frame", nil, diagnosticSettings)
    diagnosticSettingsWarningFrame:SetPoint("TOPLEFT", diagnosticSettings.title, "BOTTOMLEFT", 0, 0)
    diagnosticSettingsWarningFrame:SetWidth(diagnosticSettings:GetWidth()-8)

    local diagnosticSettingsWarning = CreateFrame("Frame", nil, diagnosticSettings)
    diagnosticSettingsWarning:SetPoint("TOPLEFT",diagnosticSettings.title, "BOTTOMLEFT", 8, -4)
    diagnosticSettingsWarning.text = diagnosticSettingsWarning:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    diagnosticSettingsWarning.text:SetPoint("TOPLEFT")
    diagnosticSettingsWarning.text:SetJustifyH("LEFT")
    diagnosticSettingsWarning.text:SetTextColor(noteColor.r, noteColor.g, noteColor.b, 1)
    diagnosticSettingsWarning.text:SetText(KeyMasterLocals.CONFIGURATIONFRAME["DiagnosticsAdvanced"].text)

    diagnosticSettingsWarning.text:SetWidth(diagnosticSettingsWarningFrame:GetWidth()-10)

    diagnosticSettingsWarningFrame:SetHeight(diagnosticSettingsWarning.text:GetHeight()+12)

    diagnosticSettingsWarning:SetPoint("CENTER",diagnosticSettingsWarningFrame, "CENTER", 0, 0)
    diagnosticSettingsWarning.text:SetPoint("CENTER", diagnosticSettingsWarning, "CENTER", 0, 0) 

    -- Display Errors Checkbox/Button
    local diagnosticSettingsErrorsFrame = CreateFrame("Frame", nil, diagnosticSettings)
    diagnosticSettingsErrorsFrame:SetPoint("TOPLEFT", diagnosticSettingsWarningFrame, "BOTTOMLEFT", 0, 0)
    diagnosticSettingsErrorsFrame:SetWidth(diagnosticSettings:GetWidth()-8)

    diagnosticSettings.showErrors = CreateFrame("CheckButton", "KM_DiplayFloatCheckBox", diagnosticSettingsErrorsFrame, "ChatConfigCheckButtonTemplate")
    local Path, _, Flags = conFrameHeader.title:GetFont()
    diagnosticSettings.showErrors.Text:SetFont(Path, 12, Flags)
    diagnosticSettings.showErrors.Text:SetTextColor(optionsColor.r, optionsColor.g, optionsColor.b, 1)
    --diagnosticSettings.showErrors.Text:SetPoint("LEFT", 24, 0)
    diagnosticSettings.showErrors.Text:SetText(KeyMasterLocals.CONFIGURATIONFRAME["DisplayErrorMessages"].text)
    
    diagnosticSettings.showErrors.Text:SetWidth(diagnosticSettingsErrorsFrame:GetWidth()-24)

    diagnosticSettingsErrorsFrame:SetHeight(diagnosticSettings.showErrors.Text:GetHeight()+12)

    diagnosticSettings.showErrors:SetPoint("BOTTOMLEFT",diagnosticSettingsErrorsFrame, "BOTTOMLEFT", 0, 0)
    diagnosticSettings.showErrors.Text:SetPoint("BOTTOMLEFT", diagnosticSettings.showErrors, "BOTTOMRIGHT", 0, 6) 

    if (KeyMaster_DB.addonConfig.showErrors) then
        diagnosticSettings.showErrors:SetChecked(KeyMaster_DB.addonConfig.showErrors)
    end
    diagnosticSettings.showErrors:HookScript("OnClick", function()
        local status = diagnosticSettings.showErrors:GetChecked()
        if (status) == true then
            KeyMaster_DB.addonConfig.showErrors = true
        else
            KeyMaster_DB.addonConfig.showErrors = false
        end
        if (status == true) then status = KeyMasterLocals.ENABLED.."." else status = KeyMasterLocals.DISABLED.."." end
        KeyMaster:Print(KeyMasterLocals.ERRORMESSAGES .. " " .. status)
    end)

    -- Display Debug Checkbox/Button
    local diagnosticSettingsDebugFrame = CreateFrame("Frame", nil, diagnosticSettings)
    diagnosticSettingsDebugFrame:SetPoint("TOPLEFT", diagnosticSettingsErrorsFrame, "BOTTOMLEFT", 0, 0)
    diagnosticSettingsDebugFrame:SetWidth(diagnosticSettings:GetWidth()-8)

    diagnosticSettings.showDebug = CreateFrame("CheckButton", "KM_DiplayFloatCheckBox", diagnosticSettings, "ChatConfigCheckButtonTemplate")
    local Path, _, Flags = conFrameHeader.title:GetFont()
    diagnosticSettings.showDebug.Text:SetFont(Path, 12, Flags)
    diagnosticSettings.showDebug.Text:SetTextColor(optionsColor.r, optionsColor.g, optionsColor.b, 1)
    diagnosticSettings.showDebug.Text:SetText(KeyMasterLocals.CONFIGURATIONFRAME["DisplayDebugMessages"].text)

    diagnosticSettings.showDebug.Text:SetWidth(diagnosticSettingsDebugFrame:GetWidth()-24)

    diagnosticSettingsDebugFrame:SetHeight(diagnosticSettings.showDebug.Text:GetHeight()+12)

    diagnosticSettings.showDebug:SetPoint("BOTTOMLEFT",diagnosticSettingsDebugFrame, "BOTTOMLEFT", 0, 0)
    diagnosticSettings.showDebug.Text:SetPoint("BOTTOMLEFT", diagnosticSettings.showDebug, "BOTTOMRIGHT", 0, 6) 

    if (KeyMaster_DB.addonConfig.showDebugging) then
        diagnosticSettings.showDebug:SetChecked(KeyMaster_DB.addonConfig.showDebugging)
    end
    diagnosticSettings.showDebug:HookScript("OnClick", function()
        local status = diagnosticSettings.showDebug:GetChecked()
        if (status == true) then
            KeyMaster_DB.addonConfig.showDebugging = true
        else
            KeyMaster_DB.addonConfig.showDebugging = false
        end
        if (status == true) then status = KeyMasterLocals.ENABLED.."." else status = KeyMasterLocals.DISABLED.."." end
        KeyMaster:Print(KeyMasterLocals.DEBUGMESSAGES .. " " .. status)
    end)

    -- Character Filter Settings
    local charactersSetting = CreateFrame("Frame", nil, conFrame)
    charactersSetting:SetPoint("TOPLEFT", diagnosticSettings, "TOPRIGHT", 4, 0)
    charactersSetting:SetSize((conFrame:GetWidth()-(mlr*2))/3, settingsPanelBaseHeight/2)
    charactersSetting.title = charactersSetting:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    charactersSetting.title:SetTextColor(titleColor.r, titleColor.g, titleColor.b, 1)
    charactersSetting.title:SetPoint("TOPLEFT", charactersSetting, "TOPLEFT", 4, -4)
    charactersSetting.title:SetText(KeyMasterLocals.CONFIGURATIONFRAME["CharacterSettings"].name)

    local Hline = KeyMaster:CreateHLine(charactersSetting:GetWidth()+8, charactersSetting, "TOP", 0, 0)
    Hline:SetAlpha(0.5)

    charactersSetting.texture = charactersSetting:CreateTexture(nil, "BACKGROUND", nil, 0)
    charactersSetting.texture:SetAllPoints(charactersSetting)
    charactersSetting.texture:SetColorTexture(0, 0, 0, 1)

    charactersSetting.textureHighlight = charactersSetting:CreateTexture(nil, "BACKGROUND", nil, 1)
    charactersSetting.textureHighlight:SetSize(charactersSetting:GetWidth(), charactersSetting:GetHeight())
    charactersSetting.textureHighlight:SetPoint("LEFT", charactersSetting, "LEFT", 0, 0)
    charactersSetting.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    charactersSetting.textureHighlight:SetAlpha(highlightAlpha)
    charactersSetting.textureHighlight:SetVertexColor(hlColor.r,hlColor.g,hlColor.b, highlightAlpha)

    -- Filter Server Checkbox/Button
    local serverFilterFrame = CreateFrame("Frame", nil, charactersSetting)
    serverFilterFrame:SetPoint("TOPLEFT", charactersSetting.title, "BOTTOMLEFT", 0, 0)
    serverFilterFrame:SetWidth(charactersSetting:GetWidth()-8)
    
    charactersSetting.filterServer = CreateFrame("CheckButton", "KM_FilterServerCheckBox", serverFilterFrame, "ChatConfigCheckButtonTemplate")
    local Path, _, Flags = conFrameHeader.title:GetFont()
    charactersSetting.filterServer.Text:SetFont(Path, 12, Flags)
    charactersSetting.filterServer.Text:SetTextColor(optionsColor.r, optionsColor.g, optionsColor.b, 1)
    charactersSetting.filterServer.Text:SetText(KeyMasterLocals.CONFIGURATIONFRAME["FilterByServer"].text)
    charactersSetting.filterServer.Text:SetWidth(serverFilterFrame:GetWidth()- charactersSetting.filterServer:GetWidth())

    serverFilterFrame:SetHeight(charactersSetting.filterServer.Text:GetHeight()+12)

    charactersSetting.filterServer:SetPoint("BOTTOMLEFT",serverFilterFrame, "BOTTOMLEFT", 0, 0)
    charactersSetting.filterServer.Text:SetPoint("BOTTOMLEFT", charactersSetting.filterServer, "BOTTOMRIGHT", 0, 6)

    if (KeyMaster_DB.addonConfig.characterFilters.serverFilter) then
        charactersSetting.filterServer:SetChecked(KeyMaster_DB.addonConfig.characterFilters.serverFilter)
    end
    charactersSetting.filterServer:HookScript("OnClick", function()
        if (charactersSetting.filterServer:GetChecked()) == true then
            KeyMaster_DB.addonConfig.characterFilters.serverFilter = true
        else
            KeyMaster_DB.addonConfig.characterFilters.serverFilter = false
        end
    end)

    -- Filter Rating Checkbox/Button
    local characterRatingFrame = CreateFrame("Frame", nil, charactersSetting)
    characterRatingFrame:SetPoint("TOPLEFT", serverFilterFrame, "BOTTOMLEFT", 0, 0)
    characterRatingFrame:SetWidth(charactersSetting:GetWidth()-8)
    
    charactersSetting.filterNoRating = CreateFrame("CheckButton", "KM_FilerRatingCheckBox", characterRatingFrame, "ChatConfigCheckButtonTemplate")
    local Path, _, Flags = conFrameHeader.title:GetFont()
    charactersSetting.filterNoRating.Text:SetFont(Path, 12, Flags)
    charactersSetting.filterNoRating.Text:SetTextColor(optionsColor.r, optionsColor.g, optionsColor.b, 1)
    charactersSetting.filterNoRating.Text:SetText(KeyMasterLocals.CONFIGURATIONFRAME["FilterByNoRating"].text)
    charactersSetting.filterNoRating.Text:SetWidth(characterRatingFrame:GetWidth()- charactersSetting.filterNoRating:GetWidth())

    characterRatingFrame:SetHeight(charactersSetting.filterNoRating.Text:GetHeight()+12)

    charactersSetting.filterNoRating:SetPoint("BOTTOMLEFT",characterRatingFrame, "BOTTOMLEFT", 0, 0)
    charactersSetting.filterNoRating.Text:SetPoint("BOTTOMLEFT", charactersSetting.filterNoRating, "BOTTOMRIGHT", 0, 6)

    if (KeyMaster_DB.addonConfig.characterFilters.filterNoRating) then
        charactersSetting.filterNoRating:SetChecked(KeyMaster_DB.addonConfig.characterFilters.filterNoRating)
    end
    charactersSetting.filterNoRating:HookScript("OnClick", function()
        if (charactersSetting.filterNoRating:GetChecked()) == true then
            KeyMaster_DB.addonConfig.characterFilters.filterNoRating = true
        else
            KeyMaster_DB.addonConfig.characterFilters.filterNoRating = false
        end
    end)

    -- Filter Key Checkbox/Button
    local characterKeyFrame = CreateFrame("Frame", nil, charactersSetting)
    characterKeyFrame:SetPoint("TOPLEFT", characterRatingFrame, "BOTTOMLEFT", 0, 0)
    characterKeyFrame:SetWidth(charactersSetting:GetWidth()-8)
    
    charactersSetting.filterNoKey = CreateFrame("CheckButton", "KM_FilerKeyCheckBox", characterKeyFrame, "ChatConfigCheckButtonTemplate")
    local Path, _, Flags = conFrameHeader.title:GetFont()
    charactersSetting.filterNoKey.Text:SetFont(Path, 12, Flags)
    charactersSetting.filterNoKey.Text:SetTextColor(optionsColor.r, optionsColor.g, optionsColor.b, 1)
    charactersSetting.filterNoKey.Text:SetText(KeyMasterLocals.CONFIGURATIONFRAME["FilterByNoKey"].text)
    charactersSetting.filterNoKey.Text:SetWidth(characterKeyFrame:GetWidth()- charactersSetting.filterNoKey:GetWidth())

    characterKeyFrame:SetHeight(charactersSetting.filterNoKey.Text:GetHeight()+12)

    charactersSetting.filterNoKey:SetPoint("BOTTOMLEFT",characterKeyFrame, "BOTTOMLEFT", 0, 0)
    charactersSetting.filterNoKey.Text:SetPoint("BOTTOMLEFT", charactersSetting.filterNoKey, "BOTTOMRIGHT", 0, 6)

    if (KeyMaster_DB.addonConfig.characterFilters.filterNoKey) then
        charactersSetting.filterNoKey:SetChecked(KeyMaster_DB.addonConfig.characterFilters.filterNoKey)
    end
    charactersSetting.filterNoKey:HookScript("OnClick", function()
        if (charactersSetting.filterNoKey:GetChecked()) == true then
            KeyMaster_DB.addonConfig.characterFilters.filterNoKey = true
        else
            KeyMaster_DB.addonConfig.characterFilters.filterNoKey = false
        end
    end)

    -- Filter Level Checkbox/Button
    local characterLevelFrame = CreateFrame("Frame", nil, charactersSetting)
    characterLevelFrame:SetPoint("TOPLEFT", characterKeyFrame, "BOTTOMLEFT", 0, 0)
    characterLevelFrame:SetWidth(charactersSetting:GetWidth()-8)
    
    charactersSetting.filterMaxLvl = CreateFrame("CheckButton", "KM_FilterLevelCheckBox", characterLevelFrame, "ChatConfigCheckButtonTemplate")
    local Path, _, Flags = conFrameHeader.title:GetFont()
    charactersSetting.filterMaxLvl.Text:SetFont(Path, 12, Flags)
    charactersSetting.filterMaxLvl.Text:SetTextColor(optionsColor.r, optionsColor.g, optionsColor.b, 1)
    charactersSetting.filterMaxLvl.Text:SetText(KeyMasterLocals.CONFIGURATIONFRAME["FilterByMaxLvl"].text)
    charactersSetting.filterMaxLvl.Text:SetWidth(characterLevelFrame:GetWidth()- charactersSetting.filterMaxLvl:GetWidth())

    characterLevelFrame:SetHeight(charactersSetting.filterMaxLvl.Text:GetHeight()+12)

    charactersSetting.filterMaxLvl:SetPoint("BOTTOMLEFT",characterLevelFrame, "BOTTOMLEFT", 0, 0)
    charactersSetting.filterMaxLvl.Text:SetPoint("BOTTOMLEFT", charactersSetting.filterMaxLvl, "BOTTOMRIGHT", 0, 6)


    if (KeyMaster_DB.addonConfig.characterFilters.filterMaxLvl) then
        charactersSetting.filterMaxLvl:SetChecked(KeyMaster_DB.addonConfig.characterFilters.filterMaxLvl)
    end
    charactersSetting.filterMaxLvl:HookScript("OnClick", function()
        if (charactersSetting.filterMaxLvl:GetChecked()) == true then
            KeyMaster_DB.addonConfig.characterFilters.filterMaxLvl = true
        else
            KeyMaster_DB.addonConfig.characterFilters.filterMaxLvl = false
        end
    end)

    local function purgeStatus(button)
        if not button then return end
        if not KeyMaster_C_DB or type(KeyMaster_C_DB) ~= "table" or KeyMaster:GetTableLength(KeyMaster_C_DB) == 0 then
            button:Hide()
        else
            button:Show()
        end
    end
    local btnOptions = {}
    local hoverColor = {}
    hoverColor.r, hoverColor.g, hoverColor.b, hoverColor.hex = Theme:GetThemeColor("color_ERRORMSG")
    btnOptions.textHoverColor = {hoverColor.r, hoverColor.g, hoverColor.b, 1}
    btnOptions.btnHoverColor = {hoverColor.r, hoverColor.g, hoverColor.b, 1}
    local preText = KeyMasterLocals.CONFIGURATIONFRAME["Purge"].present.." "..KeyMasterLocals.PLAYERFRAME["Characters"]
    local listCountText = " ("..(tostring(KeyMaster:GetTableLength(KeyMaster_C_DB)))..")"
    btnOptions.text = preText..listCountText

    local function purgeCharacterList(self)
        listCountText = " ("..(tostring(KeyMaster:GetTableLength(KeyMaster_C_DB)))..")"
        KeyMaster.CharactersFrame:ResetCharacterList() -- change load order?
        KeyMaster_C_DB = {}
        CharacterData:CreateDefaultCharacterData()

        KeyMaster:Print("|cff"..hoverColor.hex..KeyMasterLocals.CONFIGURATIONFRAME["Purge"].past..listCountText.." "..KeyMasterLocals.PLAYERFRAME["Characters"].."|r")
        self:Hide()
    end

    charactersSetting.purgeButton = KMFactory:Create(charactersSetting, "Button", btnOptions)
    charactersSetting.purgeButton:SetPoint("BOTTOMLEFT", charactersSetting, "BOTTOMLEFT", 4, 8)
    charactersSetting.purgeButton:SetScript("OnClick", purgeCharacterList)

    charactersSetting:HookScript("OnShow", function() 
        purgeStatus(charactersSetting.purgeButton)
        charactersSetting.purgeButton.text:SetText(KeyMasterLocals.CONFIGURATIONFRAME["Purge"].present.." "..KeyMasterLocals.PLAYERFRAME["Characters"].." ("..KeyMaster:GetTableLength(KeyMaster_C_DB)..")")
    end)

    --[[ -- Testing DropDownMenu IN DEVELOPMENT
    local dropDownTest = CreateFrame("Frame", nil, conFrame)
    dropDownTest:SetPoint("TOPLEFT", diagnosticSettings, "TOPRIGHT", mlr, 0)
    dropDownTest:SetSize((conFrame:GetWidth()-(mlr*2))/3, settingsPanelBaseHeight/4)
    dropDownTest.title = dropDownTest:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    dropDownTest.title:SetTextColor(titleColor.r, titleColor.g, titleColor.b, 1)
    dropDownTest.title:SetPoint("TOPLEFT", dropDownTest, "TOPLEFT", 4, -4)
    dropDownTest.title:SetText("Drop Down Testing")

    local Hline = KeyMaster:CreateHLine(dropDownTest:GetWidth()+8, dropDownTest, "TOP", 0, 0)
    Hline:SetAlpha(0.5)

    dropDownTest.texture = dropDownTest:CreateTexture(nil, "BACKGROUND", nil, 0)
    dropDownTest.texture:SetAllPoints(dropDownTest)
    dropDownTest.texture:SetColorTexture(0, 0, 0, 1)

    dropDownTest.textureHighlight = dropDownTest:CreateTexture(nil, "BACKGROUND", nil, 1)
    dropDownTest.textureHighlight:SetSize(dropDownTest:GetWidth(), dropDownTest:GetHeight())
    dropDownTest.textureHighlight:SetPoint("LEFT", dropDownTest, "LEFT", 0, 0)
    dropDownTest.textureHighlight:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\Row-Highlight", true)
    dropDownTest.textureHighlight:SetAlpha(highlightAlpha)
    dropDownTest.textureHighlight:SetVertexColor(hlColor.r,hlColor.g,hlColor.b, highlightAlpha)

    local dropDownMenu1 = KMFactory:Create(dropDownTest, "DropDownMenu", {
        defaultext = "Testing 123456789",
        title = "Dropdown Test",
        backgroundcolor = {1, 0, 0},
        backgroundcoloralpha = 1
    })
    dropDownMenu1:SetPoint("TOPLEFT", dropDownTest.title, "BOTTOMLEFT", 0, -20)

    dropDownMenu1:AddItem({ item1 = "Item 1 name."}) ]]

    return conFrame
end