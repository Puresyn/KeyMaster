local _, KeyMaster = ...

--/////////////////////////////////////////
--/// Preperation file for Localization ///
--/////////////////////////////////////////

--[[
"frFR": French (France)
"deDE": German (Germany)
"enGB": English (Great Britain) if returned, can substitute 'enUS' for consistancy
"enUS": English (America)
"itIT": Italian (Italy)
"koKR": Korean (Korea) RTL - right-to-left
"zhCN": Chinese (China) (simplified) implemented LTR left-to-right in WoW
"zhTW": Chinese (Taiwan) (traditional) implemented LTR left-to-right in WoW
"ruRU": Russian (Russia)
"esES": Spanish (Spain)
"esMX": Spanish (Mexico)
"ptBR": Portuguese (Brazil)
]]


KeyMasterLocals = {}

if (GetLocale() == "enUS") then
    KeyMasterLocals = KM_Localization_enUS
else
    -- Localization.enUS.lua
    KeyMasterLocals = KM_Localization_enUS
end