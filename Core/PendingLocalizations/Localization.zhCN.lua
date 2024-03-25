KM_Localization_zhCN = {}
local L = KM_Localization_zhCN

-- Localization file for "zhCN": Chinese (China) (simplified) implemented LTR left-to-right in WoW
-- Translated by:

-- Translation issue? Assist us in correcting it! Visit: https://discord.gg/bbMaUpfgn8

L.LANGUAGE = "Chinese (CN)"
L.TRANSLATOR = "" -- Translator display name

L.TOCNOTES = {}
L.TOCNOTES["ADDONDESC"] = "Mythic Plus Keystone Information and Collaboration Tool"

L.MAPNAMES = {}
L.MAPNAMES[9001] = { name = "Unknown", abbr = "???" }
L.MAPNAMES[463] = { name = "Dawn of the Infinite: Galakrond\'s Fall", abbr = "FALL"}
L.MAPNAMES[464] = { name = "Dawn of the Infinite: Murozond\'s Rise", abbr = "RISE"}
L.MAPNAMES[244] = { name = "Atal'Dazar", abbr = "AD" }
L.MAPNAMES[248] = { name = "Waycrest Manor", abbr = "WM" }
L.MAPNAMES[199] = { name = "Black Rook Hold", abbr = "BRH" }
L.MAPNAMES[198] = { name = "Darkheart Thicket", abbr = "DHT" }
L.MAPNAMES[168] = { name = "The Everbloom", abbr = "EB" }
L.MAPNAMES[456] = { name = "Throne of the Tides", abbr = "TotT" }

L.XPAC = {}
L.XPAC[0] = { enum = "LE_EXPANSION_CLASSIC", desc = "Classic" }
L.XPAC[1] = { enum = "LE_EXPANSION_BURNING_CRUSADE", desc = "The Burning Crusade" }
L.XPAC[2] = { enum = "LE_EXPANSION_WRATH_OF_THE_LICH_KING", desc = "Wrath of the Lich King" }
L.XPAC[3] = { enum = "LE_EXPANSION_CATACLYSM", desc = "Cataclysm" }
L.XPAC[4] = { enum = "LE_EXPANSION_MISTS_OF_PANDARIA", desc = "Mists of Pandaria" }
L.XPAC[5] = { enum = "LE_EXPANSION_WARLORDS_OF_DRAENOR", desc = "Warlords of Draenor" }
L.XPAC[6] = { enum = "LE_EXPANSION_LEGION", desc = "Legion" }
L.XPAC[7] = { enum = "LE_EXPANSION_BATTLE_FOR_AZEROTH", desc = "Battle for Azeroth" }
L.XPAC[8] = { enum = "LE_EXPANSION_SHADOWLANDS", desc = "Shadowlands" }
L.XPAC[9] = { enum = "LE_EXPANSION_DRAGONFLIGHT", desc = "Dragonflight" }
L.XPAC[10] = { enum = "LE_EXPANSION_11_0", desc = "The War Within" } -- enum will need updated when available

L.MPLUSSEASON = {}
L.MPLUSSEASON[11] = { name = "Season 3" }
L.MPLUSSEASON[12] = { name = "Season 4" }
L.MPLUSSEASON[13] = { name = "Season 1" } -- expecting season 13 to be TWW S1
L.MPLUSSEASON[14] = { name = "Season 2" } -- expecting season 14 to be TWW S2

L.ADDONNAME = "Key Master" -- do not translate
L.DISPLAYVERSION = "v"
L.WELCOMEMESSAGE = "Welcome back"
L.ON = "on"
L.OFF = "off"
L.ENABLED = "enabled"
L.DISABLED = "disabled"
L.CLICK = "Click"
L.CLICKDRAG = "Click + drag"
L.TOOPEN = "to open"
L.TOREPOSITION = "to reposition"
L.EXCLIMATIONPOINT = "!"
L.THISWEEKSAFFIXES = "This Week..."
L.YOURRATING = "Your Rating"
L.ERRORMESSAGES = "Error messages are"
L.ERRORMESSAGESNOTIFY = "Notify: Error messages are enabled."
L.DEBUGMESSAGES = "Debug messages are"
L.DEBUGMESSAGESNOTIFY = "Notify: Debug messages are enabled."
L.COMMANDERROR1 = "Invalid command"
L.COMMANDERROR2 = "Enter"
L.COMMANDERROR3 = "for commands"
L.YOURCURRENTKEY = "YOUR KEY"
L.ADDONOUTOFDATE = "Your Key Master addon is out of date!"
L.INSTANCETIMER = "Instance Information"
L.VAULTINFORMATION = "M+ Vault Progression"
L.TIMELIMIT = "Time Limit"
L.SEASON = "Season"

L.COMMANDLINE = {}
L.COMMANDLINE["/km"] = { name = "/km", text = "/km"} -- Do not translate
L.COMMANDLINE["/keymaster"] = {name = "/keymaster", text = "/keymaster"} -- Do not translate
L.COMMANDLINE["Show"] = { name = "show", text = " - show/hide the main window."}
L.COMMANDLINE["Help"] = { name = "help", text = " - shows this help menu."}
L.COMMANDLINE["Errors"] = { name = "errors", text = " - toggle error messages."}
L.COMMANDLINE["Debug"] = { name = "debug", text = " - toggle debug messages."}

L.TOOLTIPS = {}
L.TOOLTIPS["MythicRating"] = { name = "Mythic Rating", text = "This is the chacacter's current Mythic Plus rating." }
L.TOOLTIPS["OverallScore"] = { name = "Overall Score", text = "The ovrall score is a combination of both Tyrannical and Fortified run scores for a map. (With lots of math involved)"}
L.TOOLTIPS["TeamRatingGain"] = { name = "Estimated Party Rating Gain", text = "This is an estimation that Key Master does internally. This number represents your current party\'s total minimum Rating gain potential for successfully completing the given party key. It may not be 100% accurate and is only here for estimation purposes."}

L.PARTYFRAME = {}
L.PARTYFRAME["PartyInformation"] = { name = "Party Information", text = "Party Information"}
L.PARTYFRAME["OverallRating"] = { name = "Current Overall", text = "Current Overall" }
L.PARTYFRAME["PartyPointGain"] = { name = "Party Point Gain", text = "Party Point Gain"}
L.PARTYFRAME["Level"] = { name = "Level", text = "Level" }
L.PARTYFRAME["Weekly"] = { name = "Weekly", text = "Weekly"}
L.PARTYFRAME["NoAddon"] = { name = "No Addon Detected", text = "not detected!"}
L.PARTYFRAME["PlayerOffline"] = { name = "Player Offline", text = "Player is offline."}
L.PARTYFRAME["TeamRatingGain"] = { name = "Party Gain Potential", text = "Estimated Party Rating Gain"}
L.PARTYFRAME["MemberPointsGain"] = { name = "Gain Potential", text = "Estimated personal point gain for available key(s) at +1 completion."}
L.PARTYFRAME["NoKey"] = { name = "No Key", text = "No Key"}

L.PLAYERFRAME = {}
L.PLAYERFRAME["KeyLevel"] = { name = "Key Level", text = "Key level to be calculated."}
L.PLAYERFRAME["Gain"] = { name = "Gain", text = "Potential rating gain."}
L.PLAYERFRAME["New"] = { name = "New", text = "Your rating after completing this key at a +1."}
L.PLAYERFRAME["RatingCalculator"] = { name = "Rating Calculator", text = "Calculate potential rating gains."}
L.PLAYERFRAME["EnterKeyLevel"] = { name = "Enter Key Level", text = "Enter a key level to see"}
L.PLAYERFRAME["YourBaseRating"] = { name = "Base Rating Gain", text = "your base rating gain prediction."}

L.CHARACTERINFO = {}
L.CHARACTERINFO["NoKeyFound"] = { name = "NoKeyFound", text = "No Key Found"}
L.CHARACTERINFO["KeyInVault"] = { name = "Key in Vault", text = "In Vault"}
L.CHARACTERINFO["AskMerchant"] = { name = "Ask Key Merchant", text = "Key Merchant"}

L.TABPLAYER = "Player"
L.TABPARTY = "Party"
L.TABABOUT = "About"
L.TABCONFIG = "Configuration"

L.CONFIGURATIONFRAME = {}
L.CONFIGURATIONFRAME["DisplaySettings"] = { name = "Display Settings", text = "Display Settings"}
L.CONFIGURATIONFRAME["ToggleRatingFloat"] = { name = "Toggle Rating Float", text = "Show rating decimals."}
L.CONFIGURATIONFRAME["ShowMiniMapButton"] = { name = "Show Minimap Button", text = "Show minimap button."}
L.CONFIGURATIONFRAME["DiagnosticSettings"] = { name = "Diagnostic Settings", text = "Diagnostic Settings."}
L.CONFIGURATIONFRAME["DisplayErrorMessages"] = { name = "Display Errors", text = "Display error messages."}
L.CONFIGURATIONFRAME["DisplayDebugMessages"] = { name = "Display Debug", text = "Display debugging messages."}
L.CONFIGURATIONFRAME["DiagnosticsAdvanced"] = { name = "Advanced Diagnostics", text="Note: These are for diagnostic purposes only. They may flood your chat box if enabled!"}

L.ABOUTFRAME = {}
L.ABOUTFRAME["AboutGeneral"] = { name = "Key Master Information", text = "Key Master Information"}
L.ABOUTFRAME["AboutAuthors"] = { name = "Authors", text = "Authors"}
L.ABOUTFRAME["AboutSpecialThanks"] = { name = "Special Thanks", text = "Special Thanks"}
L.ABOUTFRAME["AboutContributors"] = { name = "Contributors", text = "Contributors"}