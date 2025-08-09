KM_Localization_itIT = {}
local L = KM_Localization_itIT

-- Localization file for "itIT": Italian (Italy)
-- Translated by: Kereru

--[[Notes for Translators: In many locations throughout Key Master, line space is limited. This can cause
    overlapping or strange text display. Where possible, try to keep the overall length of the string comparable or shorter
    than the English version. If that is not possible, development adjustments may need made.
    If you are not comfortable setting up your own local testing to check for these issues, make sure you let a dev know
    so they can go over a screen-share with you.]]--

-- Problema di traduzione? Aiutaci a correggerlo! Visita: https://discord.gg/bbMaUpfgn8

L.LANGUAGE = "Italiano (IT)"
L.TRANSLATOR = "Kereru" -- Translator display name

L.TOCNOTES = {} -- these are manaually copied to the TOC so they show up in the appropriate language in the AddOns list. Please translate them both but let a dev know if you update them later.
L.TOCNOTES["ADDONDESC"] = "Informazioni sulle Chiavi Mythic Plus e Strumento di Collaborazione"
L.TOCNOTES["ADDONNAME"] = "Key Master"

L.MAPNAMES = {} -- Note: Map abbrevations should be a max of 4 characters and be commonly known. Map names come directly from Blizzard already translated.

-- USE /fsstack to mouseover the icons in the player frame to find their mapIds if you need to add new dungeons.
-- DF S3
L.MAPNAMES[9001] = { name = "Sconosciuto", abbr = "???" }
L.MAPNAMES[463] = { name = "Alba degli Infiniti: Cauduta di Galakrond", abbr = "AICG"}
L.MAPNAMES[464] = { name = "Alba degli Infiniti: Ascesa di Murozond", abbr = "AIAM"}
L.MAPNAMES[244] = { name = "Atal'dazar", abbr = "AD" }
L.MAPNAMES[248] = { name = "Maniero dei Crestabianca", abbr = "MdC" }
L.MAPNAMES[199] = { name = "Forte Corvonero", abbr = "FC" }
L.MAPNAMES[198] = { name = "Boschetto Cuortetro", abbr = "BCT" }
L.MAPNAMES[168] = { name = "Verdeterno", abbr = "VE" }
L.MAPNAMES[456] = { name = "Trono delle Maree", abbr = "TdM" }
--DF S4
L.MAPNAMES[399] = { name = "Pozze della Vita di Rubino", abbr = "PVR" }
L.MAPNAMES[401] = { name = "Cripta Azzurra", abbr = "CA" }
L.MAPNAMES[400] = { name = "Offensiva dei Nokhud", abbr = "OdN" }
L.MAPNAMES[402] = { name = "Accademia di Algeth\'ar", abbr = "AdA" }
L.MAPNAMES[403] = { name = "Uldaman: Eredità di Tyr", abbr = "UEdT" }
L.MAPNAMES[404] = { name = "Neltharus", abbr = "Nelt" }
L.MAPNAMES[405] = { name = "Conca dei Felcepelle", abbr = "CdF" }
L.MAPNAMES[406] = { name = "Sale dell'Infusione", abbr = "SdI" }
--TWW S1
L.MAPNAMES[503] = { name = "Ara-Kara, Città degli Echi", abbr = "CdE" }
L.MAPNAMES[502] = { name = "Città dei Fili", abbr = "CdF" }
L.MAPNAMES[505] = { name = "Alba Infranta", abbr = "AI" }
L.MAPNAMES[501] = { name = "Volta di Pietra", abbr = "VdP" }
L.MAPNAMES[353] = { name = "Assedio di Boralus", abbr = "AdB" }
L.MAPNAMES[507] = { name = "Grim Batol", abbr = "GB" }
L.MAPNAMES[375] = { name = "Nebbie di Tirna Falcis", abbr = "NdTF" }
L.MAPNAMES[376] = { name = "Scia Necrotica", abbr = "SN" }
--TWW S2
L.MAPNAMES[500] = { name = "Corveria", abbr = "Corv" }
L.MAPNAMES[525] = { name = "Paratoria", abbr = "Para" }
L.MAPNAMES[247] = { name = "Vena Madre", abbr = "VM" }
L.MAPNAMES[370] = { name = "Meccagon - Officina", abbr = "Off" }
L.MAPNAMES[504] = { name = "Faglia di Fiammoscura", abbr = "FdF" }
L.MAPNAMES[382] = { name = "Teatro del Dolore", abbr = "TdD" }
L.MAPNAMES[506] = { name = "Idromelificio Cinereo", abbr = "IC" }
L.MAPNAMES[499] = { name = "Prioria della Fiamma Sacra", abbr = "PdFS" }
--TWW S3
L.MAPNAMES[391] = { name = "Azzardo di So'leah", abbr = "AdS" }
L.MAPNAMES[392] = { name = "Strade delle Meraviglie", abbr = "SdM" }
L.MAPNAMES[378] = { name = "Sale della Redenzione", abbr = "SdR" }
L.MAPNAMES[542] = { name = "Ecosfera Al'dani", abbr = "EA" }

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
L.MPLUSSEASON[11] = { name = "Stagione 3" }
L.MPLUSSEASON[12] = { name = "Stagione 4" }
L.MPLUSSEASON[13] = { name = "Stagione 1" } -- expecting season 13 to be TWW S1
L.MPLUSSEASON[14] = { name = "Stagione 2" } -- expecting season 14 to be TWW S2
L.MPLUSSEASON[15] = { name = "Stagione 3" } -- expecting season 15 to be TWW S2

L.DISPLAYVERSION = "v"
L.WELCOMEMESSAGE = "Bentornato"
L.ON = "acceso"
L.OFF = "spento"
L.ENABLED = "abilitato"
L.DISABLED = "disabilitato"
L.CLICK = "Clicca"
L.CLICKDRAG = "Clicca e trascina"
L.TOOPEN = "per aprire"
L.TOREPOSITION = "per riposizionare"
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
L.ADDONOUTOFDATE = "Il tuo addon Key Master non è aggiornato!"
L.INSTANCETIMER = "Informazioni sull'istanza"
L.VAULTINFORMATION = "Progresso M+ della Gran Banca"
L.TIMELIMIT = "Limite di tempo"
L.SEASON = "Stagione"
L.COMBATMESSAGE = { errormsg = "Key Master non è disponibile in combattimento.", chatmsg = "L'interfaccia si aprirà una volta fuori dal combattimento."}

L.COMMANDLINE = {} -- translate whatever in this section would be standard of an addon in the language. i.e. /km show, /km XXXX, or /XX XXXX It will work just fine.
L.COMMANDLINE["/km"] = { name = "/km", text = "/km"}
L.COMMANDLINE["/keymaster"] = {name = "/keymaster", text = "/keymaster"}
L.COMMANDLINE["Show"] = { name = "spettacolo", text = " - mostra o nascondi la finestra principale."}
L.COMMANDLINE["Help"] = { name = "aiuto", text = " - mostra questo menu di aiuto."}
L.COMMANDLINE["Errors"] = { name = "errori", text = " - attiva/disattiva i messaggi di errore."}
L.COMMANDLINE["Debug"] = { name = "debug", text = " - attiva/disattiva i messaggi di debug."}
L.COMMANDLINE["Version"] = { name = "version", text = " - mostra l'attuale versione della build." }

L.TOOLTIPS = {}
L.TOOLTIPS["MythicRating"] = { name = "Valutazione mitica", text = "Questa è l'attuale valutazione Mitica Plus del personaggio." }
L.TOOLTIPS["OverallScore"] = { name = "Punteggio totale", text = "Il punteggio complessivo è una combinazione dei punteggi delle run in Tirannia e Potenziamento per una mappa. (Con un sacco di matematica coinvolta)"}
L.TOOLTIPS["TeamRatingGain"] = { name = "Guadagno stimato di punteggio del gruppo", text = "Questa è una stima che Key Master fa internamente. Questo numero rappresenta il guadagno di punteggio minimo potenziale totale del tuo gruppo attuale per completare con successo la chiave del gruppo specificata. Potrebbe non essere accurato al 100% ed è qui solo a scopo di stima."}

L.PARTYFRAME = {}
L.PARTYFRAME["PartyInformation"] = { name = "Informazioni sul gruppo", text = "Informazioni sul gruppo"}
L.PARTYFRAME["OverallRating"] = { name = "Punteggio complessivo attuale", text = "Punteggio complessivo attuale" }
L.PARTYFRAME["PartyPointGain"] = { name = "Guadagno punti del gruppo", text = "Guadagno punti del gruppo"}
L.PARTYFRAME["Level"] = { name = "Livello", text = "Livello" }
L.PARTYFRAME["Weekly"] = { name = "settimanalmente", text = "settimanalmente"}
L.PARTYFRAME["NoAddon"] = { name = "Nessun addon rilevato", text = "non rilevato!"}
L.PARTYFRAME["PlayerOffline"] = { name = "Giocatore offline", text = "Il giocatore è offline."}
L.PARTYFRAME["TeamRatingGain"] = { name = "Guadagno potenziale del gruppo", text = "Guadagno stimato di punteggio del gruppo"}
L.PARTYFRAME["MemberPointsGain"] = { name = "Guadagno potenziale", text = "Guadagno di punti personali stimato per le chiavi disponibili al completamento +1."}
L.PARTYFRAME["NoKey"] = { name = "Nessuna chiave", text = "Nessuna chiave"}
L.PARTYFRAME["NoPartyInfo"] = { text = "Informazioni sul membro del gruppo non disponibili nei gruppi di matchmaking. (Ricarca Gruppi, Ricerca Incursioni, etc.)" }

L.PLAYERFRAME = {}
L.PLAYERFRAME["KeyLevel"] = { name = "Livello chiave", text = "Livello chiave da calcolare."}
L.PLAYERFRAME["Gain"] = { name = "Guadagno", text = "Guadagno potenziale di punteggio."}
L.PLAYERFRAME["New"] = { name = "Nuovo", text = "La tua valutazione dopo aver completato questa chiave a +1."}
L.PLAYERFRAME["RatingCalculator"] = { name = "Calcolatore della valutazione", text = "Calcola i potenziali guadagni di punteggio."}
L.PLAYERFRAME["EnterKeyLevel"] = { name = "Livello chiave", text = "Inserisci un livello chiave per vedere"}
L.PLAYERFRAME["YourBaseRating"] = { name = "Guadagno base di punteggio", text = "la previsione del guadagno base di punteggio."}
L.PLAYERFRAME["Characters"] = "Characters"
L.PLAYERFRAME["DungeonTools"] = { name = "Strumenti Spedizione", text = "Vari strumenti relativi a questa spedizione."}

L.CHARACTERINFO = {}
L.CHARACTERINFO["NoKeyFound"] = { name = "Nessuna chiave trovata", text = "Nessuna chiave trovata"}
L.CHARACTERINFO["KeyInVault"] = { name = "Chiave nella Gran Banca", text = "Nella Gran Banca"}
L.CHARACTERINFO["AskMerchant"] = { name = "Mercante di chiavi", text = "Mercante di chiavi"}

L.TABPLAYER = "Giocatore"
L.TABPARTY = "Gruppo"
L.TABABOUT = "Informazioni"
L.TABCONFIG = "Configurazione"

L.CONFIGURATIONFRAME = {}
L.CONFIGURATIONFRAME["DisplaySettings"] = { name = "Impostazioni di visualizzazione", text = "Impostazioni di visualizzazione"}
L.CONFIGURATIONFRAME["ToggleRatingFloat"] = { name = "Attiva/disattiva valutazione variabile", text = "Mostra i decimali della valutazione."}
L.CONFIGURATIONFRAME["ShowMiniMapButton"] = { name = "Mostra pulsante minimappa", text = "Mostra pulsante minimappa."}
L.CONFIGURATIONFRAME["DiagnosticSettings"] = { name = "Impostazioni diagnostiche", text = "Impostazioni diagnostiche."}
L.CONFIGURATIONFRAME["DisplayErrorMessages"] = { name = "Visualizza errori", text = "Visualizza messaggi di errore."}
L.CONFIGURATIONFRAME["DisplayDebugMessages"] = { name = "Visualizza debug", text = "Visualizza i messaggi di debug."}
L.CONFIGURATIONFRAME["DiagnosticsAdvanced"] = { name = "Diagnostica avanzata", text="Nota: questi dati sono solo a scopo diagnostico. Se abilitati, potrebbero inondare la tua finestra di chat!"}
L.CONFIGURATIONFRAME["CharacterSettings"] = { name="Filtri Lista Personaggi", text = "Opzioni alternative per i filtri della lista personaggi." }
L.CONFIGURATIONFRAME["FilterByServer"] = { name = "Server Attuale", text = "Mostra solo server attuale." }
L.CONFIGURATIONFRAME["FilterByNoRating"] = { name = "Nessun punteggio", text = "Mostra solo personaggi con un punteggio." }
L.CONFIGURATIONFRAME["FilterByNoKey"] = { name = "Nessuna chiave", text = "Mostra solo personaggi con una chiave." }
L.CONFIGURATIONFRAME["FilterByMaxLvl"] = { name = "Solo livello massimo", text = "Mostra solo i personaggi al livello massimo." }
L.CONFIGURATIONFRAME["Purge"] = { present = "Pulisci", past = "Pulito" }

L.ABOUTFRAME = {}
L.ABOUTFRAME["AboutGeneral"] = { name = "Informazioni su Key Master", text = "Informazioni su Key Master"}
L.ABOUTFRAME["AboutAuthors"] = { name = "Autori", text = "Autori"}
L.ABOUTFRAME["AboutSpecialThanks"] = { name = "Ringraziamenti speciali", text = "Ringraziamenti speciali"}
L.ABOUTFRAME["AboutContributors"] = { name = "Collaboratori", text = "Collaboratori"}
L.ABOUTFRAME["Translators"] = { text = "Traduttori" }
L.ABOUTFRAME["WhatsNew"] = { text = "Mostra cosa c'è di nuovo"}

L.SYSTEMMESSAGE = {}
L.SYSTEMMESSAGE["NOTICE"] = { text = "Nota: I calcoli del punteggio di questa stagione sono ancora in fase di verifica."}