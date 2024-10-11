KM_Localization_frFR = {}
local L = KM_Localization_frFR

-- Localization file for "frFR": French (France)
-- Translated by: Ragnarork

--[[Notes for Translators: In many locations throughout Key Master, line space is limited. This can cause
    overlapping or strange text display. Where possible, try to keep the overall length of the string comparable or shorter
    than the English version. If that is not possible, development adjustments may need made.
    If you are not comfortable setting up your own local testing to check for these issues, make sure you let a dev know
    so they can go over a screen-share with you.]]--

-- Problème de traduction ? Aidez-nous à le corriger ! Visite: https://discord.gg/bbMaUpfgn8

L.LANGUAGE = "Français (FR)"
L.TRANSLATOR = "Ragnarork" -- Translator display name

L.TOCNOTES = {} -- these are manually copied to the TOC so they show up in the appropriate language in the AddOns list. Please translate them both but let a dev know if you update them later.
L.TOCNOTES["ADDONDESC"] = "Outils d'Information et de Collaboration Mythique Plus"
L.TOCNOTES["ADDONNAME"] = "Key Master"

L.MAPNAMES = {} -- Note: Map abbrevations should be a max of 4 characters and be commonly known. Map names come directly from Blizzard already translated.
-- DF S3
L.MAPNAMES[9001] = { name = "Inconnu", abbr = "???" }
L.MAPNAMES[463] = { name = "Aube de l'Infini: Repos de Galakrond", abbr = "FALL"}
L.MAPNAMES[464] = { name = "Aube de l'Infini: Cime de Murozond", abbr = "RISE"}
L.MAPNAMES[244] = { name = "Atal'Dazar", abbr = "AD" }
L.MAPNAMES[248] = { name = "Manoir Malvoie", abbr = "WM" }
L.MAPNAMES[199] = { name = "Bastion du Freux", abbr = "BRH" }
L.MAPNAMES[198] = { name = "Fourré Sombrecoeur", abbr = "DHT" }
L.MAPNAMES[168] = { name = "Flore Éternelle", abbr = "EB" }
L.MAPNAMES[456] = { name = "Trone des Marées", abbr = "TOTT" }
--DF S4
L.MAPNAMES[399] = { name = "Bassins de l'Essence Rubis", abbr = "RLP" }
L.MAPNAMES[401] = { name = "Caveau d'Azur", abbr = "AV" }
L.MAPNAMES[400] = { name = "L'Offensive Nokhud", abbr = "NO" }
L.MAPNAMES[402] = { name = "Académie d'Algeth\'ar", abbr = "AA" }
L.MAPNAMES[403] = { name = "L'Héritage de Tyr", abbr = "ULD" }
L.MAPNAMES[404] = { name = "Neltharus", abbr = "NELT" }
L.MAPNAMES[405] = { name = "Creux des Fougerobes", abbr = "BH" }
L.MAPNAMES[406] = { name = "Salles de l'Imprégnation", abbr = "HOI" }
--TWW S1
L.MAPNAMES[503] = { name = "Ara-Kara, la Cité des Échos", abbr = "CE" }
L.MAPNAMES[502] = { name = "Cité des Fils", abbr = "CT" }
L.MAPNAMES[505] = { name = "Le Brise-Aube", abbr = "DB" }
L.MAPNAMES[501] = { name = "Cavepierre", abbr = "SV" }
L.MAPNAMES[353] = { name = "Siège de Boralus", abbr = "SB" }
L.MAPNAMES[507] = { name = "Grim Batol", abbr = "GB" }
L.MAPNAMES[375] = { name = "Brumes de Tirna Scithe", abbr = "MTS" }
L.MAPNAMES[376] = { name = "Sillage Nécrotique", abbr = "NW" }

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
L.MPLUSSEASON[11] = { name = "Saison 3" }
L.MPLUSSEASON[12] = { name = "Saison 4" }
L.MPLUSSEASON[13] = { name = "Saison 1" } -- expecting season 13 to be TWW S1
L.MPLUSSEASON[14] = { name = "Saison 2" } -- expecting season 14 to be TWW S2

L.DISPLAYVERSION = "v"
L.WELCOMEMESSAGE = "Bienvenue"
L.ON = "on"
L.OFF = "off"
L.ENABLED = "activés"
L.DISABLED = "désactivés"
L.CLICK = "Clic"
L.CLICKDRAG = "Clic + déplacer"
L.TOOPEN = "pour ouvrir"
L.TOREPOSITION = "pour repositionner"
L.EXCLIMATIONPOINT = "!"
L.THISWEEKSAFFIXES = "Cette semaine..."
L.YOURRATING = "Votre classement"
L.ERRORMESSAGES = "Les messages d'erreur sont"
L.ERRORMESSAGESNOTIFY = "Notification : messages d'erreur activés."
L.DEBUGMESSAGES = "Les messages de debug sont"
L.DEBUGMESSAGESNOTIFY = "Notification : messages de debug activés."
L.COMMANDERROR1 = "Commande invalide"
L.COMMANDERROR2 = "Entrer"
L.COMMANDERROR3 = "pour les commandes"
L.YOURCURRENTKEY = "VOTRE CLÉ"
L.ADDONOUTOFDATE = "Votre addon Key Master est obsolète!"
L.INSTANCETIMER = "Information de l'instance"
L.VAULTINFORMATION = "Progression Grande Chambre Forte M+"
L.TIMELIMIT = "Limite de temps"
L.SEASON = "Saison"
L.COMBATMESSAGE = { errormsg = "Key Master est indisponible en combat.", chatmsg = "L'interface s'affichera lorsque vous quitterez le combat."}

L.COMMANDLINE = {} -- translate whatever in this section would be standard of an addon in the language. i.e. /km show, /km XXXX, or /XX XXXX It will work just fine.
L.COMMANDLINE["/km"] = { name = "/km", text = "/km"}
L.COMMANDLINE["/keymaster"] = {name = "/keymaster", text = "/keymaster"}
L.COMMANDLINE["Show"] = { name = "afficher", text = " - afficher/cacher la fenêtre principale."}
L.COMMANDLINE["Help"] = { name = "aide", text = " - afficher ce menu d'aide."}
L.COMMANDLINE["Errors"] = { name = "erreurs", text = " - activer/désactiver l'affichage des messages d'erreur"}
L.COMMANDLINE["Debug"] = { name = "debug", text = " - activer/désactiver l'affichage des message de debug."}
L.COMMANDLINE["Version"] = { name = "version", text = " - afficher la version du build actuel." }

L.TOOLTIPS = {}
L.TOOLTIPS["MythicRating"] = { name = "Cote Mythique", text = "Cote Mythic+ actuelle pour ce personnage." }
L.TOOLTIPS["OverallScore"] = { name = "Cote Globale", text = "La cote globale est une combinaison des cotes Tyranniques et Fortifiés pour un donjon. (Impliquant moultes mathématiques)"}
L.TOOLTIPS["TeamRatingGain"] = { name = "Estimation du gain de cote du groupe", text = "Estimation interne de Key Master. Ce nombre représente le gain de cote minimum en cas de réussite pour la clé actuelle du groupe. Il s'agit uniquement d'une estimation et peut différer de la cote réelle."}

L.PARTYFRAME = {}
L.PARTYFRAME["PartyInformation"] = { name = "Informations du groupe", text = "Information du groupe"}
L.PARTYFRAME["OverallRating"] = { name = "Score combiné actuel", text = "Score combiné actuel" }
L.PARTYFRAME["PartyPointGain"] = { name = "Gain de points du groupe", text = "Gain de points du groupe"}
L.PARTYFRAME["Level"] = { name = "Niveau", text = "Niveau" }
L.PARTYFRAME["Weekly"] = { name = "Hebdomadaire", text = "Hebdomadaire"}
L.PARTYFRAME["NoAddon"] = { name = "Aucun addon détecté", text = "non détecté!"}
L.PARTYFRAME["PlayerOffline"] = { name = "Joueur hors-ligne", text = "Joueur hors-ligne."}
L.PARTYFRAME["TeamRatingGain"] = { name = "Gain potentiel du groupe", text = "Gain de score estimé du groupe"}
L.PARTYFRAME["MemberPointsGain"] = { name = "Gain potentiel", text = "Estimation du gain de point personnel pour la (les) clé(s) disponible en cas de complétion +1."}
L.PARTYFRAME["NoKey"] = { name = "Aucune clé", text = "Aucune clé"}
L.PARTYFRAME["NoPartyInfo"] = { text = "Informations du membre du groupe indisponibles en matchmaking. (Dungeon Finder, Raid Finder, etc.)" }

L.PLAYERFRAME = {}
L.PLAYERFRAME["KeyLevel"] = { name = "Niveau de clé", text = "Niveau de clé à calculer."}
L.PLAYERFRAME["Gain"] = { name = "Gain", text = "Gain potentiel."}
L.PLAYERFRAME["New"] = { name = "Nouveau", text = "Votre cote après complétion de cette clé en +1."}
L.PLAYERFRAME["RatingCalculator"] = { name = "Calcul de cote", text = "Calculer les gains de cote potentiels."}
L.PLAYERFRAME["EnterKeyLevel"] = { name = "Entrez niveau de clé", text = "Entrez un niveau de clé pour voir"}
L.PLAYERFRAME["YourBaseRating"] = { name = "Base du gain de cote", text = "la prédiction de la base du gain de cote."}
L.PLAYERFRAME["Characters"] = "Personnages"
L.PLAYERFRAME["DungeonTools"] = { name = "Outils de donjon", text = "Divers outils pour ce donjon."}

L.CHARACTERINFO = {}
L.CHARACTERINFO["NoKeyFound"] = { name = "Aucune clé trouvée", text = "Aucune clé trouvée"}
L.CHARACTERINFO["KeyInVault"] = { name = "Clé dans le coffre", text = "Dans le coffre"}
L.CHARACTERINFO["AskMerchant"] = { name = "Marchand de clé", text = "Marchand de clé"}

L.TABPLAYER = "Joueur"
L.TABPARTY = "Groupe"
L.TABABOUT = "À propos"
L.TABCONFIG = "Configuration"

L.CONFIGURATIONFRAME = {}
L.CONFIGURATIONFRAME["DisplaySettings"] = { name = "Paramètres d'affichage", text = "Paramètres d'affichage"}
L.CONFIGURATIONFRAME["ToggleRatingFloat"] = { name = "Cote décimale", text = "Afficher les décimales de la cote."}
L.CONFIGURATIONFRAME["ShowMiniMapButton"] = { name = "Afficher bouton de la minimap", text = "Afficher le bouton de la minimap."}
L.CONFIGURATIONFRAME["DiagnosticSettings"] = { name = "Paramètres de diagnostique", text = "Paramètres de diagnostique."}
L.CONFIGURATIONFRAME["DisplayErrorMessages"] = { name = "Affichage des erreurs", text = "Afficher les messages d'erreur."}
L.CONFIGURATIONFRAME["DisplayDebugMessages"] = { name = "Affichage debug", text = "Afficher les messages de debug."}
L.CONFIGURATIONFRAME["DiagnosticsAdvanced"] = { name = "Diagnostiques avancés", text="Note : À n'utiliser qu'à des fins de diagnostiques. L'activer peut engorger votre chat !"}
L.CONFIGURATIONFRAME["CharacterSettings"] = { name="Filtres de la liste de personnages", text = "Options de filtrage de la liste de personnages alternatifs" }
L.CONFIGURATIONFRAME["FilterByServer"] = { name = "Serveur courant", text = "Afficher uniquement le serveur courant." }
L.CONFIGURATIONFRAME["FilterByNoRating"] = { name = "Aucune cote", text = "Afficher uniquement les personnages avec cote." }
L.CONFIGURATIONFRAME["FilterByNoKey"] = { name = "Aucune clé", text = "Afficher uniquement les personnages avec clé." }
L.CONFIGURATIONFRAME["FilterByMaxLvl"] = { name = "Max uniquement", text = "Afficher uniquement les personnages de niveau maximum." }
L.CONFIGURATIONFRAME["Purge"] = { present = "Purger", past = "Purgé" }

L.ABOUTFRAME = {}
L.ABOUTFRAME["AboutGeneral"] = { name = "Informations générales", text = "Informations générales"}
L.ABOUTFRAME["AboutAuthors"] = { name = "Auteurs", text = "Auteurs"}
L.ABOUTFRAME["AboutSpecialThanks"] = { name = "Remerciements", text = "Remerciements"}
L.ABOUTFRAME["AboutContributors"] = { name = "Contributeurs", text = "Contributeurs"}
L.ABOUTFRAME["Translators"] = { text = "Traducteurs" }
L.ABOUTFRAME["WhatsNew"] = { text = "Dernières actualités"}

L.SYSTEMMESSAGE = {}
L.SYSTEMMESSAGE["NOTICE"] = { text = "Note : Les calculs de cote de la saison actuelle sont en cours de vérification."}