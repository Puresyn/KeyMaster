local _, KeyMaster = ...
local ConfigFrame = {}
KeyMaster.ConfigFrame = ConfigFrame
local Theme = KeyMaster.Theme

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
    conFrameHeader.titleBG:SetAlpha(0.08)
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
    displaySetting:SetSize((conFrame:GetWidth()-mlr)/3, settingsPanelBaseHeight/4)
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
    displaySetting.showFloat = CreateFrame("CheckButton", "KM_DiplayFloatCheckBox", displaySetting, "ChatConfigCheckButtonTemplate")
    displaySetting.showFloat:SetPoint("TOPLEFT",displaySetting.title, "BOTTOMLEFT", 8, -4)
    local Path, _, Flags = conFrameHeader.title:GetFont()
    displaySetting.showFloat.Text:SetFont(Path, 12, Flags)
    displaySetting.showFloat.Text:SetTextColor(optionsColor.r, optionsColor.g, optionsColor.b, 1)
    displaySetting.showFloat.Text:SetPoint("LEFT", 24, 0)
    displaySetting.showFloat.Text:SetText(KeyMasterLocals.CONFIGURATIONFRAME["ToggleRatingFloat"].text)
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
    displaySetting.showMMB = CreateFrame("CheckButton", "KM_DiplayMinimapCheckBox", displaySetting, "ChatConfigCheckButtonTemplate")
    displaySetting.showMMB:SetPoint("TOPLEFT", displaySetting.showFloat, "BOTTOMLEFT", 0, 0)
    local Path, _, Flags = conFrameHeader.title:GetFont()
    displaySetting.showMMB.Text:SetFont(Path, 12, Flags)
    displaySetting.showMMB.Text:SetTextColor(optionsColor.r, optionsColor.g, optionsColor.b, 1)
    displaySetting.showMMB.Text:SetPoint("LEFT", 24, 0)
    displaySetting.showMMB.Text:SetText(KeyMasterLocals.CONFIGURATIONFRAME["ShowMiniMapButton"].text)
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

    local diagnosticSettings = CreateFrame("Frame", nil, conFrame)
    diagnosticSettings:SetPoint("TOPLEFT", displaySetting, "TOPRIGHT", 4, 0)
    diagnosticSettings:SetSize((conFrame:GetWidth()-mlr)/3, settingsPanelBaseHeight/4)
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
    local diagnosticSettingsWarning = CreateFrame("Frame", nil, diagnosticSettings)
    diagnosticSettingsWarning:SetPoint("TOPLEFT",diagnosticSettings.title, "BOTTOMLEFT", 8, -4)
    diagnosticSettingsWarning:SetSize(diagnosticSettings:GetWidth()-12, 28)
    diagnosticSettingsWarning.text = diagnosticSettingsWarning:CreateFontString(nil, "OVERLAY", "KeyMasterFontSmall")
    diagnosticSettingsWarning.text:SetPoint("TOPLEFT")
    diagnosticSettingsWarning.text:SetJustifyH("LEFT")
    diagnosticSettingsWarning.text:SetSize(diagnosticSettingsWarning:GetWidth(), diagnosticSettingsWarning:GetHeight())
    diagnosticSettingsWarning.text:SetTextColor(noteColor.r, noteColor.g, noteColor.b, 1)
    diagnosticSettingsWarning.text:SetText(KeyMasterLocals.CONFIGURATIONFRAME["DiagnosticsAdvanced"].text)

    -- Display Errors Checkbox/Button
    diagnosticSettings.showErrors = CreateFrame("CheckButton", "KM_DiplayFloatCheckBox", diagnosticSettings, "ChatConfigCheckButtonTemplate")
    diagnosticSettings.showErrors:SetPoint("TOPLEFT",diagnosticSettingsWarning, "BOTTOMLEFT", 0, -4)
    local Path, _, Flags = conFrameHeader.title:GetFont()
    diagnosticSettings.showErrors.Text:SetFont(Path, 12, Flags)
    diagnosticSettings.showErrors.Text:SetTextColor(optionsColor.r, optionsColor.g, optionsColor.b, 1)
    diagnosticSettings.showErrors.Text:SetPoint("LEFT", 24, 0)
    diagnosticSettings.showErrors.Text:SetText(KeyMasterLocals.CONFIGURATIONFRAME["DisplayErrorMessages"].text)
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
    diagnosticSettings.showDebug = CreateFrame("CheckButton", "KM_DiplayFloatCheckBox", diagnosticSettings, "ChatConfigCheckButtonTemplate")
    diagnosticSettings.showDebug:SetPoint("TOPLEFT", diagnosticSettings.showErrors, "BOTTOMLEFT", 0, 0)
    local Path, _, Flags = conFrameHeader.title:GetFont()
    diagnosticSettings.showDebug.Text:SetFont(Path, 12, Flags)
    diagnosticSettings.showDebug.Text:SetTextColor(optionsColor.r, optionsColor.g, optionsColor.b, 1)
    diagnosticSettings.showDebug.Text:SetPoint("LEFT", 24, 0)
    diagnosticSettings.showDebug.Text:SetText(KeyMasterLocals.CONFIGURATIONFRAME["DisplayDebugMessages"].text)
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

    return conFrame
end