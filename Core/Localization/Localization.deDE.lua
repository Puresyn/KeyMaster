KM_Localization_deDE = {}
local L = KM_Localization_deDE

-- Localization file for "deDE": German (Germany)
-- Übersetzt von: Feedy88 + Rumorix (Korrektur)

--[[Notes for Translators: In many locations throughout Key Master, line space is limited. This can cause
    overlapping or strange text display. Where possible, try to keep the overall length of the string comparable or shorter
    than the English version. If that is not possible, development adjustments may need made.
    If you are not comfortable setting up your own local testing to check for these issues, make sure you let a dev know
    so they can go over a screen-share with you.]]--

-- Übersetzungsproblem? Helfen Sie uns bei der Korrektur! Besuchen: https://discord.gg/bbMaUpfgn8

L.LANGUAGE = "Deutsch (DE)"
L.TRANSLATOR = "Feedy88 + Rumorix (Korrektur) + Salty" -- Translator display name

L.TOCNOTES = {} -- these are manaually copied to the TOC so they show up in the appropriate language in the AddOns list. Please translate them both but let a dev know if you update them later.
L.TOCNOTES["ADDONDESC"] = "Mythic Plus Schlüsselstein Informations- und Kollaborationstool"
L.TOCNOTES["ADDONNAME"] = "Key Master"

L.MAPNAMES = {} -- Note: Map abbrevations should be a max of 4 characters and be commonly known. Map names come directly from Blizzard already translated.
-- DF S3
L.MAPNAMES[9001] = { name = "Unbekannt", abbr = "???" }
L.MAPNAMES[463] = { name = "Dämmerung des Ewigen: Galakronds Sturz", abbr = "GS"}
L.MAPNAMES[464] = { name = "Dämmerung des Ewigen: Murozonds Erhebung", abbr = "ME"}
L.MAPNAMES[244] = { name = "Atal'Dazar", abbr = "AD" }
L.MAPNAMES[248] = { name = "Das Kronsteiganwesen", abbr = "KSA" }
L.MAPNAMES[199] = { name = "Die Rabenwehr", abbr = "RW" }
L.MAPNAMES[198] = { name = "Das Finsterherzdickicht", abbr = "FHD" }
L.MAPNAMES[168] = { name = "Der Immergrüne Flor", abbr = "IF" }
L.MAPNAMES[456] = { name = "Thron der Gezeiten", abbr = "TDG" }
--DF S4
L.MAPNAMES[399] = { name = "Rubinlebensbecken", abbr = "RLB" }
L.MAPNAMES[401] = { name = "Das Azurblaue Grwölbe", abbr = "AG" }
L.MAPNAMES[400] = { name = "Der Angriff der Nokhud", abbr = "ADN" } --ggf. nur Nokhud?
L.MAPNAMES[402] = { name = "Akademie von Algeth\'ar", abbr = "AA" }
L.MAPNAMES[403] = { name = "Uldaman: Vermächtnis von Tyr", abbr = "ULD" }
L.MAPNAMES[404] = { name = "Neltharus", abbr = "NELT" }
L.MAPNAMES[405] = { name = "Brackenfellhöle", abbr = "BFH" }
L.MAPNAMES[406] = { name = "Hallen der Infusion", abbr = "HDI" }
--TWW S1
L.MAPNAMES[503] = { name = "Ara-Kara, Stadt der Echos", abbr = "SdE" }
L.MAPNAMES[502] = { name = "Stadt der Fäden", abbr = "SdF" }
L.MAPNAMES[505] = { name = "Die Morgenbringer", abbr = "MB" }
L.MAPNAMES[501] = { name = "Das Steingewölbe", abbr = "SG" }
L.MAPNAMES[353] = { name = "Die Belagerung von Boralus", abbr = "SoB" }
L.MAPNAMES[507] = { name = "Grim Batol", abbr = "GB" }
L.MAPNAMES[375] = { name = "Die Nebel von Tirna Scithe", abbr = "MTS" }
L.MAPNAMES[376] = { name = "Die Nekrotische Schneise", abbr = "NW" }

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
L.MPLUSSEASON[11] = { name = "Saison 3" }
L.MPLUSSEASON[12] = { name = "Saison 4" }
L.MPLUSSEASON[13] = { name = "Saison 1" } -- expecting season 13 to be TWW S1
L.MPLUSSEASON[14] = { name = "Saison 2" } -- expecting season 14 to be TWW S2

L.DISPLAYVERSION = "v"
L.WELCOMEMESSAGE = "Willkommen zurück"
L.ON = "an"
L.OFF = "aus"
L.ENABLED = "aktiviert"
L.DISABLED = "deaktiviert"
L.CLICK = "Klicken"
L.CLICKDRAG = "Klicken + ziehen"
L.TOOPEN = "zum öffnen"
L.TOREPOSITION = "zum neu positionieren"
L.EXCLIMATIONPOINT = "!"
L.THISWEEKSAFFIXES = "Diese Woche..."
L.YOURRATING = "Deine Wertung"
L.ERRORMESSAGES = "Fehlermeldungen sind"
L.ERRORMESSAGESNOTIFY = "Benachrichtigen: Fehlermeldungen sind aktiviert."
L.DEBUGMESSAGES = "Debug-Meldungen sind"
L.DEBUGMESSAGESNOTIFY = "Benachrichtigen: Debug-Meldungen sind aktiviert."
L.COMMANDERROR1 = "Ungültiger Befehl"
L.COMMANDERROR2 = "Eingeben"
L.COMMANDERROR3 = "für Befehle"
L.YOURCURRENTKEY = "DEIN KEY"
L.ADDONOUTOFDATE = "Dein Key Master-Addon ist veraltet!"
L.INSTANCETIMER = "Instanzinformationen"
L.VAULTINFORMATION = "M+ Schatzkammer-Fortschritt"
L.TIMELIMIT = "Zeitlimit"
L.SEASON = "Saison"
L.COMBATMESSAGE = { errormsg = "Key Master im Kampf nicht verfügbar.", chatmsg = "Das Interface wird geöffnet, sobald der Kampf verlassen wird."}

L.COMMANDLINE = {} -- translate whatever in this section would be standard of an addon in the language. i.e. /km show, /km XXXX, or /XX XXXX It will work just fine.
L.COMMANDLINE["/km"] = { name = "/km", text = "/km"}
L.COMMANDLINE["/keymaster"] = {name = "/keymaster", text = "/keymaster"}
L.COMMANDLINE["Show"] = { name = "anzeigen", text = " - Hauptfenster ein- oder ausblenden."}
L.COMMANDLINE["Help"] = { name = "hilfe", text = " - zeigt dieses Hilfemenü."}
L.COMMANDLINE["Errors"] = { name = "Fehler", text = " - Fehlermeldungen umschalten."}
L.COMMANDLINE["Debug"] = { name = "Debug", text = " - Debug-Meldungen umschalten."}
L.COMMANDLINE["Version"] = { name = "version", text = " - shows the current build version." }

L.TOOLTIPS = {}
L.TOOLTIPS["MythicRating"] = { name = "Mythisch-Wertung", text = "Dies ist die aktuelle Mythisch Plus Wertung des Charakters." }
L.TOOLTIPS["OverallScore"] = { name = "Gesamtwertung", text = "Die Gesamtwertung ist eine Kombination aus Tyrannisch- und Verstärkt Wertungen für einen Dungeon. (Beinhaltet viel Mathematik!)"}
L.TOOLTIPS["TeamRatingGain"] = { name = "Erwartete Wertsteigerung der Gruppe", text = "Dies ist eine Schätzung, die Key Master intern durchführt. Diese Zahl stellt das gesamte mindeste Potential zur Wertungssteigerung deiner aktuellen Gruppe für den erfolgreichen Abschluss des angegebenen Schlüsselsteins dar. Es ist möglicherweise nicht 100 % akurat und dient nur zur Abschätzung."} -- just changed it a bit - habe das ein wenig anders übersetzt

L.PARTYFRAME = {}
L.PARTYFRAME["PartyInformation"] = { name = "Gruppeninformationen", text = "Gruppeninformationen"}
L.PARTYFRAME["OverallRating"] = { name = "Gesamtwertung", text = "Gesamtwertung" }
L.PARTYFRAME["PartyPointGain"] = { name = "Gruppenwertungssteigerung", text = "Gruppenwertungssteigerung"}
L.PARTYFRAME["Level"] = { name = "Stufe", text = "Stufe" }
L.PARTYFRAME["Weekly"] = { name = "Wöchentlich", text = "Wöchentlich"}
L.PARTYFRAME["NoAddon"] = { name = "Kein Add-on erkannt", text = "nicht erkannt!"}
L.PARTYFRAME["PlayerOffline"] = { name = "Spieler offline", text = "Spieler offline."}
L.PARTYFRAME["TeamRatingGain"] = { name = "Gruppensteigerungspotenzial", text = "Geschätzte Gruppenwertungssteigerung"}
L.PARTYFRAME["MemberPointsGain"] = { name = "Steigerungspotenzial", text = "Geschätzte persönlicher Wertungssteigerung für verfügbare Schlüssel bei +1 Abschluss."}
L.PARTYFRAME["NoKey"] = { name = "Kein Schlüsselstein", text = "Kein Schlüsselstein"}
L.PARTYFRAME["NoPartyInfo"] = { text = "Informationen über Gruppenmitglieder sind in Matchmaking-Gruppen nicht verfügbar. (Dungeonbrowser, Schlachtzugsbrowser, etc.)" }

L.PLAYERFRAME = {}
L.PLAYERFRAME["KeyLevel"] = { name = "Schlüsselsteinstufe", text = "Zu berechnendes Schlüsselsteinniveau." }
L.PLAYERFRAME["Gain"] = { name = "Steigerung", text = "Mögliche Wertungssteigerung."}
L.PLAYERFRAME["New"] = { name = "Neu", text = "Deine Wertung nach Abschluss dieses Schlüsselsteins liegt bei +1." }
L.PLAYERFRAME["RatingCalculator"] = { name = "Wertungsrechner", text = "Berechne potenzielle Wertungssteigerungen." }
L.PLAYERFRAME["EnterKeyLevel"] = { name = "Gib die Schlüsselsteinstufe ein", text = "Gib eine Schlüsselsteinstufe ein, um eine Abschätzung" }
L.PLAYERFRAME["YourBaseRating"] = { name = "Basiswertungssteigerung", text = "der Basiswertungssteigerung zu sehen." }
L.PLAYERFRAME["Characters"] = "Charaktere"
L.PLAYERFRAME["DungeonTools"] = { name = "Instanzwerkzeuge", text = "Verschiedene Werkzeuge für diese Instanz."}

L.CHARACTERINFO = {}
L.CHARACTERINFO["NoKeyFound"] = { name = "Keinen Schlüsselstein gefunden", text = "Keinen Schlüsselstein gefunden" }
L.CHARACTERINFO["KeyInVault"] = { name = "Schlüsselstein im Bankschließfach", text = "Im Bankschließfach" }
L.CHARACTERINFO["AskMerchant"] = { name = "Frag den Schlüsselsteinhändler", text = "Schlüsselsteinhändler" }

L.TABPLAYER = "Spieler"
L.TABPARTY = "Gruppe"
L.TABABOUT = "Über"
L.TABCONFIG = "Konfiguration"

L.CONFIGURATIONFRAME = {}
L.CONFIGURATIONFRAME["DisplaySettings"] = { name = "Anzeigeeinstellungen", text = "Anzeigeeinstellungen" }
L.CONFIGURATIONFRAME["ToggleRatingFloat"] = { name = "Wertungsdezimale umschalten", text = "Wertungsdezimalstellen anzeigen." }
L.CONFIGURATIONFRAME["ShowMiniMapButton"] = { name = "Schaltfläche „Minikarte anzeigen“.", text = "Schaltfläche an der „Minikarte\" anzeigen."}
L.CONFIGURATIONFRAME["DiagnosticSettings"] = { name = "Diagnoseeinstellungen", text = "Diagnoseeinstellungen." }
L.CONFIGURATIONFRAME["DisplayErrorMessages"] = { name = "Fehlermeldungen anzeigen", text = "Fehlermeldungen anzeigen." }
L.CONFIGURATIONFRAME["DisplayDebugMessages"] = { name = "Debuginformationen anzeigen", text = "Debugging-Meldungen anzeigen." }
L.CONFIGURATIONFRAME["DiagnosticsAdvanced"] = { name = "Erweiterte Diagnoseinformationen", text="Hinweis: Diese dienen nur zu Diagnosezwecken. Wenn sie aktiviert sind, könnten sie deine Chatbox überfluten!"}
L.CONFIGURATIONFRAME["CharacterSettings"] = { name="Charakterlistenfilter", text = "Filteroptionen für die Liste der alternativen Charaktere." }
L.CONFIGURATIONFRAME["FilterByServer"] = { name = "Aktueller Server", text = "Nur aktuellen Server anzeigen." }
L.CONFIGURATIONFRAME["FilterByNoRating"] = { name = "Keine Wertung", text = "Nur Charaktere mit Wertung anzeigen." }
L.CONFIGURATIONFRAME["FilterByNoKey"] = { name = "Kein Schlüsselstein", text = "Nur Charaktere mit einem Schlüsselstein anzeigen." }
L.CONFIGURATIONFRAME["FilterByMaxLvl"] = { name = "Nur Max-Level", text = "Nur Max-Level Charaktere anzeigen." }
L.CONFIGURATIONFRAME["Purge"] = { present = "Zurücksetzen", past = "Zurückgesetzt" }

L.ABOUTFRAME = {}
L.ABOUTFRAME["AboutGeneral"] = { name = "Allgemeine Informationen", text = "Allgemeine Informationen" }
L.ABOUTFRAME["AboutAuthors"] = { name = "Autoren", text = "Autoren"}
L.ABOUTFRAME["AboutSpecialThanks"] = { name = "Besonderer Dank", text = "Besonderer Dank" }
L.ABOUTFRAME["AboutContributors"] = { name = "Mitwirkende", text = "Mitwirkende" }
L.ABOUTFRAME["Translators"] = { text = "Übersetzer" }
L.ABOUTFRAME["WhatsNew"] = { text = "Neuerungen anzeigen" }

L.SYSTEMMESSAGE = {}
L.SYSTEMMESSAGE["NOTICE"] = { text = "Hinweis: Die Berechnung der Wertung wird zurzeit noch verifiziert."}