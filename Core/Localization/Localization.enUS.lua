KM_Localization_enUS = {}
local L = KM_Localization_enUS

-- Localization file for "enUS": English (America)
-- Translated by: Key Master

--[[Notes for Translators: In many locations throughout Key Master, line space is limited. This can cause
    overlapping or strange text display. Where possible, try to keep the overall length of the string comparable or shorter
    than the English version. If that is not possible, development adjustments may need made.
    If you are not comfortable setting up your own local testing to check for these issues, make sure you let a dev know
    so they can go over a screen-share with you.]]--

-- Translation issue? Assist us in correcting it! Visit: https://discord.gg/bbMaUpfgn8

L.LANGUAGE = "English (US)"
L.TRANSLATOR = "Key Master" -- Translator display name

L.TOCNOTES = {} -- these are manaually copied to the TOC so they show up in the appropriate language in the AddOns list. Please translate them both but let a dev know if you update them later.
L.TOCNOTES["ADDONDESC"] = "Mythic Plus Keystone Information and Collaboration Tool"
L.TOCNOTES["ADDONNAME"] = "Key Master"

L.MAPNAMES = {} -- Note: Map abbrevations should be a max of 4 characters and be commonly known. Map names come directly from Blizzard already translated.
-- DF S3
L.MAPNAMES[9001] = { name = "Unknown", abbr = "???" }
L.MAPNAMES[463] = { name = "Dawn of the Infinite: Galakrond\'s Fall", abbr = "FALL"}
L.MAPNAMES[464] = { name = "Dawn of the Infinite: Murozond\'s Rise", abbr = "RISE"}
L.MAPNAMES[244] = { name = "Atal'Dazar", abbr = "AD" }
L.MAPNAMES[248] = { name = "Waycrest Manor", abbr = "WM" }
L.MAPNAMES[199] = { name = "Black Rook Hold", abbr = "BRH" }
L.MAPNAMES[198] = { name = "Darkheart Thicket", abbr = "DHT" }
L.MAPNAMES[168] = { name = "The Everbloom", abbr = "EB" }
L.MAPNAMES[456] = { name = "Throne of the Tides", abbr = "TOTT" }
--DF S4
L.MAPNAMES[399] = { name = "Ruby Life Pools", abbr = "RLP" }
L.MAPNAMES[401] = { name = "The Azue Vault", abbr = "AV" }
L.MAPNAMES[400] = { name = "The Nokhud Offensive", abbr = "NO" }
L.MAPNAMES[402] = { name = "Algeth\'ar Academy", abbr = "AA" }
L.MAPNAMES[403] = { name = "Legacy of Tyr", abbr = "ULD" }
L.MAPNAMES[404] = { name = "Neltharus", abbr = "NELT" }
L.MAPNAMES[405] = { name = "Brackenhide Hollow", abbr = "BH" }
L.MAPNAMES[406] = { name = "Halls of Infusion", abbr = "HOI" }
--TWW S1
L.MAPNAMES[503] = { name = "Ara-Kara, City of Echoes", abbr = "CoE" }
L.MAPNAMES[502] = { name = "City of Threads", abbr = "CoT" }
L.MAPNAMES[505] = { name = "The Dawnbreaker", abbr = "DB" }
L.MAPNAMES[501] = { name = "The Stonevault", abbr = "SV" }
L.MAPNAMES[353] = { name = "Siege of Boralus", abbr = "SoB" }
L.MAPNAMES[507] = { name = "The Grim Batol", abbr = "GB" }
L.MAPNAMES[375] = { name = "Mists of Tirna Scithe", abbr = "MTS" }
L.MAPNAMES[376] = { name = "The Necrotic Wake", abbr = "NW" }
--TWW S2
L.MAPNAMES[500] = { name = "The Rookery", abbr = "RKY" }
L.MAPNAMES[525] = { name = "Floodgate", abbr = "FG" }
L.MAPNAMES[247] = { name = "The MOTHERLODE!!", abbr = "ML" }
L.MAPNAMES[370] = { name = "Mechagon - Workshop", abbr = "WORK" }
L.MAPNAMES[504] = { name = "Darkflame Cleft", abbr = "DFC" }
L.MAPNAMES[382] = { name = "Theater of Pain", abbr = "ToP" }
L.MAPNAMES[506] = { name = "Cinderbrew Meadery", abbr = "CBM" }
L.MAPNAMES[499] = { name = "Priory of the Sacred Flame", abbr = "PoSF" }

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
L.XPAC[10] = { enum = "LE_EXPANSION_WAR_WITHIN", desc = "The War Within" }

L.MPLUSSEASON = {}
L.MPLUSSEASON[11] = { name = "Season 3" }
L.MPLUSSEASON[12] = { name = "Season 4" }
L.MPLUSSEASON[13] = { name = "Season 1" } -- expecting season 13 to be TWW S1
L.MPLUSSEASON[14] = { name = "Season 2" } -- expecting season 14 to be TWW S2

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
L.COMBATMESSAGE = { errormsg = "Key Master unavailable in combat.", chatmsg = "The interface will open once you exit combat."}

L.COMMANDLINE = {} -- translate whatever in this section would be standard of an addon in the language. i.e. /km show, /km XXXX, or /XX XXXX It will work just fine.
L.COMMANDLINE["/km"] = { name = "/km", text = "/km"}
L.COMMANDLINE["/keymaster"] = {name = "/keymaster", text = "/keymaster"}
L.COMMANDLINE["Show"] = { name = "show", text = " - show/hide the main window."}
L.COMMANDLINE["Help"] = { name = "help", text = " - shows this help menu."}
L.COMMANDLINE["Errors"] = { name = "errors", text = " - toggle error messages."}
L.COMMANDLINE["Debug"] = { name = "debug", text = " - toggle debug messages."}
L.COMMANDLINE["Version"] = { name = "version", text = " - shows the current build version." }

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
L.PARTYFRAME["NoPartyInfo"] = { text = "Party member information unavailable in matchmaking groups. (Dungeon Finder, Raid Finder, etc.)" }

L.PLAYERFRAME = {}
L.PLAYERFRAME["KeyLevel"] = { name = "Key Level", text = "Key level to be calculated."}
L.PLAYERFRAME["Gain"] = { name = "Gain", text = "Potential rating gain."}
L.PLAYERFRAME["New"] = { name = "New", text = "Your rating after completing this key at a +1."}
L.PLAYERFRAME["RatingCalculator"] = { name = "Rating Calculator", text = "Calculate potential rating gains."}
L.PLAYERFRAME["EnterKeyLevel"] = { name = "Enter Key Level", text = "Enter a key level to see"}
L.PLAYERFRAME["YourBaseRating"] = { name = "Base Rating Gain", text = "your base rating gain prediction."}
L.PLAYERFRAME["Characters"] = "Characters"
L.PLAYERFRAME["DungeonTools"] = { name = "Dungeon Tools", text = "Various tools related to this dungeon."}

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
L.CONFIGURATIONFRAME["CharacterSettings"] = { name="Character List Filters", text = "Alternate character list filter options." }
L.CONFIGURATIONFRAME["FilterByServer"] = { name = "Current Server", text = "Only show current server." }
L.CONFIGURATIONFRAME["FilterByNoRating"] = { name = "No Rating", text = "Only show characters with a rating." }
L.CONFIGURATIONFRAME["FilterByNoKey"] = { name = "No Key", text = "Only show characters with a key." }
L.CONFIGURATIONFRAME["FilterByMaxLvl"] = { name = "Max Only", text = "Only show maximum level characters." }
L.CONFIGURATIONFRAME["Purge"] = { present = "Purge", past = "Purged" }

L.ABOUTFRAME = {}
L.ABOUTFRAME["AboutGeneral"] = { name = "Key Master Information", text = "Key Master Information"}
L.ABOUTFRAME["AboutAuthors"] = { name = "Authors", text = "Authors"}
L.ABOUTFRAME["AboutSpecialThanks"] = { name = "Special Thanks", text = "Special Thanks"}
L.ABOUTFRAME["AboutContributors"] = { name = "Contributors", text = "Contributors"}
L.ABOUTFRAME["Translators"] = { text = "Translators" }
L.ABOUTFRAME["WhatsNew"] = { text = "Show What\'s New"}

L.SYSTEMMESSAGE = {}
L.SYSTEMMESSAGE["NOTICE"] = { text = "Notice: This seasons rating calculations are still being verified."}