KM_Localization_itIT = {}
local L = KM_Localization_itIT

-- Localization file for "itIT": Italian (Italy)
-- Translated by: Google Translate

--[[Notes for Translators: In many locations throughout Key Master, line space is limited. This can cause
    overlapping or strange text display. Where possible, try to keep the overall length of the string comparable or shorter
    than the English version. If that is not possible, development adjustments may need made.
    If you are not comfortable setting up your own local testing to check for these issues, make sure you let a dev know
    so they can go over a screen-share with you.]]--

-- Problema di traduzione? Aiutaci a correggerlo! Visita: https://discord.gg/bbMaUpfgn8

L.LANGUAGE = "Italiano (IT)"
L.TRANSLATOR = "Google Traduttore" -- Translator display name

L.TOCNOTES = {} -- these are manaually copied to the TOC so they show up in the appropriate language in the AddOns list. Please translate them both but let a dev know if you update them later.
L.TOCNOTES["ADDONDESC"] = "Mythic Plus Keystone Information and Collaboration Tool"
L.TOCNOTES["ADDONNAME"] = "Key Master"

L.MAPNAMES = {} -- Note: Map abbrevations should be a max of 4 characters and be commonly known. Map names come directly from Blizzard already translated.
-- DF S3
L.MAPNAMES[9001] = { name = "Sconosciuto", abbr = "???" }
L.MAPNAMES[463] = { name = "Dawn of the Infinite: Galakrond\'s Fall", abbr = "FALL"}
L.MAPNAMES[464] = { name = "Dawn of the Infinite: Murozond\'s Rise", abbr = "RISE"}
L.MAPNAMES[244] = { name = "Atal'Dazar", abbr = "AD" }
L.MAPNAMES[248] = { name = "Waycrest Manor", abbr = "WM" }
L.MAPNAMES[199] = { name = "Black Rook Hold", abbr = "BRH" }
L.MAPNAMES[198] = { name = "Darkheart Thicket", abbr = "DHT" }
L.MAPNAMES[168] = { name = "The Everbloom", abbr = "EB" }
L.MAPNAMES[456] = { name = "Throne of the Tides", abbr = "TotT" }
--DF S4
L.MAPNAMES[399] = { name = "Ruby Life Pools", abbr = "RLP" }
L.MAPNAMES[401] = { name = "The Azue Vault", abbr = "AV" }
L.MAPNAMES[400] = { name = "The Nokhud Offensive", abbr = "NO" }
L.MAPNAMES[402] = { name = "Algeth\'ar Academy", abbr = "AA" }
L.MAPNAMES[403] = { name = "Legacy of Tyr", abbr = "ULD" }
L.MAPNAMES[404] = { name = "Neltharus", abbr = "NELT" }
L.MAPNAMES[405] = { name = "Brackenhide Hollow", abbr = "BH" }
L.MAPNAMES[406] = { name = "Halls of Infusion", abbr = "HOI" }

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
L.MPLUSSEASON[11] = { name = "Stagione 3" }
L.MPLUSSEASON[12] = { name = "Stagione 4" }
L.MPLUSSEASON[13] = { name = "Stagione 1" } -- expecting season 13 to be TWW S1
L.MPLUSSEASON[14] = { name = "Stagione 2" } -- expecting season 14 to be TWW S2

L.DISPLAYVERSION = "v"
L.WELCOMEMESSAGE = "Bentornato"
L.ON = "SU"
L.OFF = "spento"
L.ENABLED = "abilitato"
L.DISABLED = "disabilitato"
L.CLICK = "Clic"
L.CLICKDRAG = "Fare clic e trascinare"
L.TOOPEN = "aprire"
L.TOREPOSITION = "riposizionare"
L.EXCLIMATIONPOINT = "!"
L.THISWEEKSAFFIXES = "Questa settimana..."
L.YOURRATING = "Il tuo punteggio"
L.ERRORMESSAGES = "I messaggi di errore sono"
L.ERRORMESSAGESNOTIFY = "Notifica: i messaggi di errore sono abilitati."
L.DEBUGMESSAGES = "I messaggi di debug sono"
L.DEBUGMESSAGESNOTIFY = "Notifica: i messaggi di debug sono abilitati."
L.COMMANDERROR1 = "Comando non valido"
L.COMMANDERROR2 = "Inserire"
L.COMMANDERROR3 = "per i comandi"
L.YOURCURRENTKEY = "LA TUA CHIAVE"
L.ADDONOUTOFDATE = "Il tuo componente aggiuntivo Key Master non è aggiornato!"
L.INSTANCETIMER = "Informazioni sull'istanza"
L.VAULTINFORMATION = "M+ Progressione del volteggio"
L.TIMELIMIT = "Limite di tempo"
L.SEASON = "Stagione"

L.COMMANDLINE = {} -- translate whatever in this section would be standard of an addon in the language. i.e. /km show, /km XXXX, or /XX XXXX It will work just fine.
L.COMMANDLINE["/km"] = { name = "/km", text = "/km"}
L.COMMANDLINE["/keymaster"] = {name = "/keymaster", text = "/keymaster"}
L.COMMANDLINE["Show"] = { name = "spettacolo", text = " - mostrare o nascondere la finestra principale."}
L.COMMANDLINE["Help"] = { name = "aiuto", text = " - mostra questo menu di aiuto."}
L.COMMANDLINE["Errors"] = { name = "errori", text = " - attiva/disattiva i messaggi di errore."}
L.COMMANDLINE["Debug"] = { name = "debug", text = " - attiva/disattiva i messaggi di debug."}

L.TOOLTIPS = {}
L.TOOLTIPS["MythicRating"] = { name = "Valutazione mitica", text = "Questa è l'attuale valutazione Mitica Plus del personaggio." }
L.TOOLTIPS["OverallScore"] = { name = "Punteggio totale", text = "Il punteggio complessivo è una combinazione dei punteggi delle corse Tiranniche e Fortificate per una mappa. (Con un sacco di matematica coinvolta)"}
L.TOOLTIPS["TeamRatingGain"] = { name = "Guadagno stimato del rating del partito", text = "Questa è una stima che Key Master fa internamente. Questo numero rappresenta il potenziale minimo totale di guadagno di valutazione del tuo gruppo attuale per completare con successo la chiave del gruppo specificata. Potrebbe non essere accurato al 100% ed è qui solo a scopo di stima."}

L.PARTYFRAME = {}
L.PARTYFRAME["PartyInformation"] = { name = "Informazioni sul partito", text = "Informazioni sul partito"}
L.PARTYFRAME["OverallRating"] = { name = "Complessivamente attuale", text = "Complessivamente attuale" }
L.PARTYFRAME["PartyPointGain"] = { name = "Guadagno punti del partito", text = "Guadagno punti del partito"}
L.PARTYFRAME["Level"] = { name = "Livello", text = "Livello" }
L.PARTYFRAME["Weekly"] = { name = "settimanalmente", text = "settimanalmente"}
L.PARTYFRAME["NoAddon"] = { name = "Nessun componente aggiuntivo rilevato", text = "non rilevata!"}
L.PARTYFRAME["PlayerOffline"] = { name = "Giocatore non in linea", text = "Il giocatore è offline."}
L.PARTYFRAME["TeamRatingGain"] = { name = "Potenziale di guadagno del partito", text = "Guadagno stimato del rating del partito"}
L.PARTYFRAME["MemberPointsGain"] = { name = "Guadagna potenziale", text = "Guadagno di punti personali stimato per le chiavi disponibili al completamento +1."}
L.PARTYFRAME["NoKey"] = { name = "Nessuna chiave", text = "Nessuna chiave"}
L.PARTYFRAME["NoPartyInfo"] = { text = "Party member information unavailable in matchmaking groups. (Dungeon Finder, Raid Finder, etc.)" }

L.PLAYERFRAME = {}
L.PLAYERFRAME["KeyLevel"] = { name = "Livello chiave", text = "Livello chiave da calcolare."}
L.PLAYERFRAME["Gain"] = { name = "Guadagno", text = "Potenziale guadagno di rating."}
L.PLAYERFRAME["New"] = { name = "Nuovo", text = "La tua valutazione dopo aver completato questa chiave a +1."}
L.PLAYERFRAME["RatingCalculator"] = { name = "Calcolatore della valutazione", text = "Calcola i potenziali guadagni di rating."}
L.PLAYERFRAME["EnterKeyLevel"] = { name = "Livello chiave", text = "Inserisci un livello chiave per vedere"}
L.PLAYERFRAME["YourBaseRating"] = { name = "Guadagno della valutazione base", text = "la previsione del guadagno della tua valutazione base."}

L.CHARACTERINFO = {}
L.CHARACTERINFO["NoKeyFound"] = { name = "Nessuna chiave trovata", text = "Nessuna chiave trovata"}
L.CHARACTERINFO["KeyInVault"] = { name = "Digitare nel caveau", text = "Nel caveau"}
L.CHARACTERINFO["AskMerchant"] = { name = "Mercante di chiavi", text = "Mercante di chiavi"}

L.TABPLAYER = "Giocatore"
L.TABPARTY = "Gruppo"
L.TABABOUT = "Attorno"
L.TABCONFIG = "Configurazione"

L.CONFIGURATIONFRAME = {}
L.CONFIGURATIONFRAME["DisplaySettings"] = { name = "Impostazioni di visualizzazione", text = "Impostazioni di visualizzazione"}
L.CONFIGURATIONFRAME["ToggleRatingFloat"] = { name = "Attiva/disattiva valutazione variabile", text = "Mostra i decimali della valutazione."}
L.CONFIGURATIONFRAME["ShowMiniMapButton"] = { name = "Mostra pulsante minimappa", text = "Mostra pulsante minimappa."}
L.CONFIGURATIONFRAME["DiagnosticSettings"] = { name = "Impostazioni diagnostiche", text = "Impostazioni diagnostiche."}
L.CONFIGURATIONFRAME["DisplayErrorMessages"] = { name = "Visualizza errori", text = "Visualizza messaggi di errore."}
L.CONFIGURATIONFRAME["DisplayDebugMessages"] = { name = "Visualizza debug", text = "Visualizza i messaggi di debug."}
L.CONFIGURATIONFRAME["DiagnosticsAdvanced"] = { name = "Diagnostica avanzata", text="Nota: questi sono solo a scopo diagnostico. Se abilitati, potrebbero inondare la tua casella di chat!"}
L.CONFIGURATIONFRAME["CharacterSettings"] = { name="Character List Filters", text = "Alternate character list filter options." }
L.CONFIGURATIONFRAME["FilterByServer"] = { name = "Current Server", text = "Only show current server." }
L.CONFIGURATIONFRAME["FilterByNoRating"] = { name = "No Rating", text = "Only show characters with a rating." }
L.CONFIGURATIONFRAME["FilterByNoKey"] = { name = "No Key", text = "Only show characters with a key." }

L.ABOUTFRAME = {}
L.ABOUTFRAME["AboutGeneral"] = { name = "Key Master Informazione", text = "Key Master Informazione"}
L.ABOUTFRAME["AboutAuthors"] = { name = "Autori", text = "Autori"}
L.ABOUTFRAME["AboutSpecialThanks"] = { name = "Ringraziamenti speciali", text = "Ringraziamenti speciali"}
L.ABOUTFRAME["AboutContributors"] = { name = "Contributori", text = "Contributori"}
L.ABOUTFRAME["Translators"] = { text = "Translators" }

L.SYSTEMMESSAGE = {}
L.SYSTEMMESSAGE["NOTICE"] = { text = "Notice: Dragonflight Season 4 rating calculations are still being verified."}