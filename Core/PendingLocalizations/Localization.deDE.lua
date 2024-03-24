KM_Localization_deDE = {}
local L = KM_Localization_deDE

-- Localization file for "deDE": German (Germany)
-- Übersetzt von: Google Translate

-- Übersetzungsproblem? Helfen Sie uns bei der Korrektur! Besuchen: https://discord.gg/bbMaUpfgn8

L.LANGUAGE = "Deutsch (DE)"
L.TRANSLATOR = "Google Translate"

L.MAPNAMES = {}
L.MAPNAMES[9001] = { name = "Unbekannt", abbr = "???" }
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
L.MPLUSSEASON[11] = { name = "Staffel 3" }
L.MPLUSSEASON[12] = { name = "Staffel 4" }
L.MPLUSSEASON[13] = { name = "Staffel 1" } -- expecting season 13 to be TWW S1
L.MPLUSSEASON[14] = { name = "Staffel 2" } -- expecting season 14 to be TWW S2

L.ADDONNAME = "Key Master" -- do not translate
L.DISPLAYVERSION = "v"
L.WELCOMEMESSAGE = "Willkommen zurück"
L.ON = "An"
L.OFF = "aus"
L.ENABLED = "ermöglicht"
L.DISABLED = "deaktiviert"
L.CLICK = "Klicken"
L.CLICKDRAG = "Klicken + ziehen"
L.TOOPEN = "öffnen"
L.TOREPOSITION = "neu positionieren"
L.EXCLIMATIONPOINT = "!"
L.THISWEEKSAFFIXES = "Diese Woche..."
L.YOURRATING = "Deine Bewertung"
L.ERRORMESSAGES = "Fehlermeldungen sind"
L.ERRORMESSAGESNOTIFY = "Benachrichtigen: Fehlermeldungen sind aktiviert."
L.DEBUGMESSAGES = "Debug-Meldungen sind"
L.DEBUGMESSAGESNOTIFY = "Benachrichtigen: Debug-Meldungen sind aktiviert."
L.COMMANDERROR1 = "Ungültiger Befehl"
L.COMMANDERROR2 = "Eingeben"
L.COMMANDERROR3 = "für Befehle"
L.YOURCURRENTKEY = "DEIN SCHLÜSSEL"
L.ADDONOUTOFDATE = "Ihr Key Master-Addon ist veraltet!"
L.INSTANCETIMER = "Instanzinformationen"
L.VAULTINFORMATION = "M+ Vault-Fortschritt"
L.TIMELIMIT = "Zeitlimit"
L.SEASON = "Staffel"

L.COMMANDLINE = {}
L.COMMANDLINE["/km"] = { name = "/km", text = "/km"} -- Do not translate
L.COMMANDLINE["/keymaster"] = {name = "/keymaster", text = "/keymaster"} -- Do not translate
L.COMMANDLINE["Show"] = { name = "zeigen", text = " - Hauptfenster ein- oder ausblenden."}
L.COMMANDLINE["Help"] = { name = "helfen", text = " - zeigt dieses Hilfemenü."}
L.COMMANDLINE["Errors"] = { name = "Fehler", text = " - Fehlermeldungen umschalten."}
L.COMMANDLINE["Debug"] = { name = "debuggen", text = " - Debug-Meldungen umschalten."}

L.TOOLTIPS = {}
L.TOOLTIPS["MythicRating"] = { name = "Mythische Bewertung", text = "Dies ist die aktuelle Mythic Plus-Bewertung des Charakters." }
L.TOOLTIPS["OverallScore"] = { name = "Gesamtpunktzahl", text = "Die Gesamtpunktzahl ist eine Kombination aus Tyrannical- und Fortified-Run-Scores für eine Karte. (Mit viel Mathematik im Spiel)"}
L.TOOLTIPS["TeamRatingGain"] = { name = "Estimated Party Rating Gain", text = "Dies ist eine Schätzung, die Key Master intern durchführt. Diese Zahl stellt das gesamte Mindestbewertungsgewinnpotenzial Ihrer aktuellen Gruppe für den erfolgreichen Abschluss des angegebenen Gruppenschlüssels dar. Es ist möglicherweise nicht 100 % genau und dient nur zu Schätzungszwecken."}

L.PARTYFRAME = {}
L.PARTYFRAME["PartyInformation"] = { name = "Parteiinformationen", text = "Parteiinformationen"}
L.PARTYFRAME["OverallRating"] = { name = "Aktueller Gesamtwert", text = "Aktueller Gesamtwert" }
L.PARTYFRAME["PartyPointGain"] = { name = "Gruppenpunktgewinn", text = "Gruppenpunktgewinn"}
L.PARTYFRAME["Level"] = { name = "Ebene", text = "Ebene" }
L.PARTYFRAME["Weekly"] = { name = "Wöchentlich", text = "Wöchentlich"}
L.PARTYFRAME["NoAddon"] = { name = "Kein Add-on erkannt", text = "nicht erkannt!"}
L.PARTYFRAME["PlayerOffline"] = { name = "Spieler offline", text = "Spieler offline."}
L.PARTYFRAME["TeamRatingGain"] = { name = "Party-Gewinnpotenzial", text = "Geschätzter Gruppenbewertungsgewinn"}
L.PARTYFRAME["MemberPointsGain"] = { name = "Potenzial gewinnen", text = "Geschätzter persönlicher Punktegewinn für verfügbare Schlüssel bei +1 Abschluss."}
L.PARTYFRAME["NoKey"] = { name = "Kein Schlüssel", text = "Kein Schlüssel"}

L.PLAYERFRAME = {}
L.PLAYERFRAME["KeyLevel"] = { name = "Schlüsselebene", text = "Zu berechnendes Schlüsselniveau."}
L.PLAYERFRAME["Gain"] = { name = "Gewinnen", text = "Möglicher Ratinggewinn."}
L.PLAYERFRAME["New"] = { name = "Neu", text = "Ihre Bewertung nach Abschluss dieses Schlüssels liegt bei +1."}
L.PLAYERFRAME["RatingCalculator"] = { name = "Bewertungsrechner", text = "Berechnen Sie potenzielle Ratinggewinne."}
L.PLAYERFRAME["EnterKeyLevel"] = { name = "Geben Sie die Schlüsselebene ein", text = "Geben Sie eine Schlüsselebene ein, um sie anzuzeigen"}
L.PLAYERFRAME["YourBaseRating"] = { name = "Basisbewertungsgewinn", text = "Ihre Basisbewertungsgewinnvorhersage."}

L.CHARACTERINFO = {}
L.CHARACTERINFO["NoKeyFound"] = { name = "Kein Schlüssel gefunden", text = "Kein Schlüssel gefunden"}
L.CHARACTERINFO["KeyInVault"] = { name = "Geben Sie den Tresor ein", text = "Im Tresor"}
L.CHARACTERINFO["AskMerchant"] = { name = "Fragen Sie den Schlüsselhändler", text = "Schlüsselhändler"}

L.TABPLAYER = "Spieler"
L.TABPARTY = "Gruppe"
L.TABABOUT = "Um"
L.TABCONFIG = "Aufbau"

L.CONFIGURATIONFRAME = {}
L.CONFIGURATIONFRAME["DisplaySettings"] = { name = "Bildschirmeinstellungen", text = "Bildschirmeinstellungen"}
L.CONFIGURATIONFRAME["ToggleRatingFloat"] = { name = "Bewertungs-Float umschalten", text = "Bewertungsdezimalstellen anzeigen."}
L.CONFIGURATIONFRAME["ShowMiniMapButton"] = { name = "Schaltfläche „Minikarte anzeigen“.", text = "Schaltfläche „Minikarte anzeigen“."}
L.CONFIGURATIONFRAME["DiagnosticSettings"] = { name = "Diagnoseeinstellungen", text = "Diagnoseeinstellungen."}
L.CONFIGURATIONFRAME["DisplayErrorMessages"] = { name = "Anzeigefehler", text = "Fehlermeldungen anzeigen."}
L.CONFIGURATIONFRAME["DisplayDebugMessages"] = { name = "Debug anzeigen", text = "Debugging-Meldungen anzeigen."}
L.CONFIGURATIONFRAME["DiagnosticsAdvanced"] = { name = "Erweiterte Diagnose", text="Hinweis: Diese dienen nur zu Diagnosezwecken. Wenn sie aktiviert sind, können sie Ihre Chatbox überfluten!"}

L.ABOUTFRAME = {}
L.ABOUTFRAME["AboutGeneral"] = { name = "Wichtige Masterinformationen", text = "Wichtige Masterinformationen"}
L.ABOUTFRAME["AboutAuthors"] = { name = "Autoren", text = "Autoren"}
L.ABOUTFRAME["AboutSpecialThanks"] = { name = "Besonderen Dank", text = "Besonderen Dank"}
L.ABOUTFRAME["AboutContributors"] = { name = "Mitwirkende", text = "Mitwirkende"}