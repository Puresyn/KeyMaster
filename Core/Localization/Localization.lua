local _, KeyMaster = ...

--////////////////////////////
--/// Localization Mapping ///
--////////////////////////////

--[[
"frFR": French (France)
"deDE": German (Germany)
"enUS": English (America)
"itIT": Italian (Italy)
"zhCN": Chinese (China) (simplified) implemented LTR left-to-right in WoW
"zhTW": Chinese (Taiwan) (traditional) implemented LTR left-to-right in WoW
"ruRU": Russian (Russia)
"esES": Spanish (Spain)
"esMX": Spanish (Mexico)
"ptBR": Portuguese (Brazil)
"bwON": Bwonsamdi (Jamaican [enUS]) - YES PLEASE! This needs to happen!
]]

KeyMasterLocals = {}
--function KeyMaster:LoadLocalization(langPref)
    --local langPref = KeyMaster_DB.addonConfig["languagePreference"]
    if (langPref ~= nil ) then print("Loaded from config: "..langPref) end
    if (langPref == nil or langPref == "") then
        langPref = GetLocale()
        print("Loaded from locale: "..langPref)
    end

    if (langPref == "frFR") then
        -- Localization.frFR.lua
        KeyMasterLocals = KM_Localization_frFR
    elseif (langPref == "deDE") then
        -- Localization.deDE.lua
        KeyMasterLocals = KM_Localization_deDE
    elseif (langPref == "itIT") then
        -- Localization.itIT.lua
        KeyMasterLocals = KM_Localization_itIT
    elseif (langPref == "zhCN") then
        -- Localization.zhCN.lua
        KeyMasterLocals = KM_Localization_zhCN
    elseif (langPref == "zhTW") then
        -- Localization.zhTW.lua
        KeyMasterLocals = KM_Localization_zhTW
    elseif (langPref == "ruRU") then
        -- Localization.ruRU.lua
        KeyMasterLocals = KM_Localization_ruRU
    elseif (langPref == "esES") then
        -- Localization.esES.lua
        KeyMasterLocals = KM_Localization_esES
    elseif (langPref == "esMX") then
        -- Localization.esMX.lua
        KeyMasterLocals = KM_Localization_esMX
    elseif (langPref == "ptBR") then
        -- Localization.ptBR.lua
        KeyMasterLocals = KM_Localization_ptBR
    elseif (langPref == "bwON") then
        -- Localization.bwON.lua
        KeyMasterLocals = KM_Localization_bwON
    else -- Default
        -- Localization.enUS.lua
        KeyMasterLocals = KM_Localization_enUS
    end
--end

-- KeyMaster:LoadLocalization(KeyMaster_DB.addonConfig.languagePreference)