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

We are actively seeking volunteer translators and proof readers for the following languages:
-French (France)
-German (Germany)
-Italian (Italy)
-Chinese (China) (simplified) implemented LTR
-Chinese (Taiwan) (traditional) implemented LTR
-Russian (Russia)
-Spanish (Spain)
-Spanish (Mexico)
-Portuguese (Brazil)
Please visit our Discord (https://discord.gg/bbMaUpfgn8) and let one of the Admins know if you are interested!
(Must be fluent in English (US), WoW lingo, the desired region language, and be active/responsive on Discord.)

]]

KeyMasterLocals = {}

local langPref = GetLocale()
if(langPref == "enUS") then
    -- Localization.enUS.lua
    KeyMasterLocals = KM_Localization_enUS
elseif (langPref == "frFR") then
    -- Localization.frFR.lua
    KeyMasterLocals = KM_Localization_frFR
elseif (langPref == "deDE") then
    -- Localization.deDE.lua
    KeyMasterLocals = KM_Localization_deDE
elseif (langPref == "itIT") then
    -- Localization.itIT.lua
    KeyMasterLocals = KM_Localization_itIT
elseif (langPref == "ruRU") then
    -- Localization.ruRU.lua
    KeyMasterLocals = KM_Localization_ruRU
--[[ elseif (langPref == "esES") then
    -- Localization.esES.lua
    KeyMasterLocals = KM_Localization_esES
elseif (langPref == "esMX") then
    -- Localization.esMX.lua
    KeyMasterLocals = KM_Localization_esMX ]]
elseif (langPref == "ptBR") then
    -- Localization.ptBR.lua
    KeyMasterLocals = KM_Localization_ptBR
elseif (langPref == "zhTW") then
    -- Localization.zhTW.lua
    KeyMasterLocals = KM_Localization_zhTW
elseif (langPref == "koKR") then
    -- Localization.koKR.lua
    KeyMasterLocals = KM_Localization_koKR
elseif (langPref == "zhCN") then
    -- Localization.zhCN.lua
    KeyMasterLocals = KM_Localization_zhCN
else -- Default
    -- Localization.enUS.lua
    KeyMasterLocals = KM_Localization_enUS
end

local TYRANNICAL_ID = 9
local FORTIFIED_ID = 10
local CHALLENGERSPERIL_ID = 152 -- not sure if this is needed?
KeyMasterLocals.TYRANNICAL, _, _ = C_ChallengeMode.GetAffixInfo(TYRANNICAL_ID)
KeyMasterLocals.FORTIFIED, _, _ = C_ChallengeMode.GetAffixInfo(FORTIFIED_ID)
KeyMasterLocals.CHALLENGERSPERIL, _, _ = C_ChallengeMode.GetAffixInfo(CHALLENGERSPERIL_ID)  -- not sure if this is needed?
KeyMasterLocals.ASCENDANT = C_ChallengeMode.GetAffixInfo(KM_XBASCENDANT_ID)
KeyMasterLocals.VOIDBOUND = C_ChallengeMode.GetAffixInfo(KM_XBVOIDBOUND_ID)
KeyMasterLocals.OBLIVION = C_ChallengeMode.GetAffixInfo(KM_XBOBLIVION_ID)
KeyMasterLocals.DEVOUR = C_ChallengeMode.GetAffixInfo(KM_XBDEVOUR_ID)
KeyMasterLocals.BUILDRELEASE = "release" -- must remain in ENGLISH - DO NOT TRANSLATE
KeyMasterLocals.BUILDBETA = "beta" -- must remain in ENGLISH - DO NOT TRANSLATE
KeyMasterLocals.ADDONNAME = "Key Master" -- do not translate