KM_Localization_frFR = {}
local L = KM_Localization_frFR

-- Localization file for "frFR": French (France)
-- Translated by: Google Translate

-- Problème de traduction ? Aidez-nous à le corriger ! Visite: https://discord.gg/bbMaUpfgn8

L.LANGUAGE = "Français (FR)"
L.TRANSLATOR = "Google Traduction" -- Translator display name

L.TOCNOTES = {}
L.TOCNOTES["ADDONDESC"] = "Mythic Plus Keystone Information and Collaboration Tool"

L.MAPNAMES = {}
L.MAPNAMES[9001] = { name = "Inconnu", abbr = "???" }
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
L.MPLUSSEASON[11] = { name = "Saison 3" }
L.MPLUSSEASON[12] = { name = "Saison 4" }
L.MPLUSSEASON[13] = { name = "Saison 1" } -- expecting season 13 to be TWW S1
L.MPLUSSEASON[14] = { name = "Saison 2" } -- expecting season 14 to be TWW S2

L.ADDONNAME = "Key Master" -- do not translate
L.DISPLAYVERSION = "v"
L.WELCOMEMESSAGE = "Content de te revoir"
L.ON = "sur"
L.OFF = "désactivé"
L.ENABLED = "activé"
L.DISABLED = "désactivé"
L.CLICK = "Cliquez sur"
L.CLICKDRAG = "Cliquez + faites glisser"
L.TOOPEN = "ouvrir"
L.TOREPOSITION = "repositionner"
L.EXCLIMATIONPOINT = "!"
L.THISWEEKSAFFIXES = "Cette semaine..."
L.YOURRATING = "Votre note"
L.ERRORMESSAGES = "Les messages d'erreur sont"
L.ERRORMESSAGESNOTIFY = "Notifier : les messages d'erreur sont activés."
L.DEBUGMESSAGES = "Les messages de débogage sont"
L.DEBUGMESSAGESNOTIFY = "Notifier : les messages de débogage sont activés."
L.COMMANDERROR1 = "Commande non valide"
L.COMMANDERROR2 = "Introduire"
L.COMMANDERROR3 = "pour les commandes"
L.YOURCURRENTKEY = "TA CLÉ"
L.ADDONOUTOFDATE = "Votre Key Master est obsolète !"
L.INSTANCETIMER = "Informations sur les instances"
L.VAULTINFORMATION = "Progression du coffre-fort M+"
L.TIMELIMIT = "Limite de temps"
L.SEASON = "Saison"

L.COMMANDLINE = {}
L.COMMANDLINE["/km"] = { name = "/km", text = "/km"} -- Do not translate
L.COMMANDLINE["/keymaster"] = {name = "/keymaster", text = "/keymaster"} -- Do not translate
L.COMMANDLINE["Show"] = { name = "montrer", text = " - afficher ou masquer la fenêtre principale."}
L.COMMANDLINE["Help"] = { name = "aide", text = " - affiche ce menu d'aide."}
L.COMMANDLINE["Errors"] = { name = "les erreurs", text = " - basculer les messages d'erreur."}
L.COMMANDLINE["Debug"] = { name = "déboguer", text = " - basculer les messages de débogage."}

L.TOOLTIPS = {}
L.TOOLTIPS["MythicRating"] = { name = "Note mythique", text = "Il s'agit de la note Mythique Plus actuelle du personnage." }
L.TOOLTIPS["OverallScore"] = { name = "Score global", text = "Le score global est une combinaison des scores de run tyrannique et fortifié pour une carte. (Avec beaucoup de mathématiques impliquées)"}
L.TOOLTIPS["TeamRatingGain"] = { name = "Gain estimé de note de groupe", text = "Il s’agit d’une estimation que Key Master fait en interne. Ce nombre représente le potentiel total minimum de gain de notation de votre groupe actuel pour réussir la clé de groupe donnée. Il se peut qu'il ne soit pas précis à 100 % et n'est présenté qu'à des fins d'estimation."}

L.PARTYFRAME = {}
L.PARTYFRAME["PartyInformation"] = { name = "Informations sur le groupe", text = "Informations sur le groupe"}
L.PARTYFRAME["OverallRating"] = { name = "Actuel Global", text = "Actuel Global" }
L.PARTYFRAME["PartyPointGain"] = { name = "Gain de points de groupe", text = "Gain de points de groupe"}
L.PARTYFRAME["Level"] = { name = "Niveau", text = "Niveau" }
L.PARTYFRAME["Weekly"] = { name = "Hebdomadaire", text = "Hebdomadaire"}
L.PARTYFRAME["NoAddon"] = { name = "Aucun module complémentaire détecté", text = "non-détecté!"}
L.PARTYFRAME["PlayerOffline"] = { name = "Joueur hors ligne", text = "Le joueur est hors ligne."}
L.PARTYFRAME["TeamRatingGain"] = { name = "Potentiel de gain de groupe", text = "Gain estimé de note de groupe"}
L.PARTYFRAME["MemberPointsGain"] = { name = "Gagner du potentiel", text = "Gain de points personnels estimé pour les clés disponibles à l'achèvement de +1."}
L.PARTYFRAME["NoKey"] = { name = "Pas de clé", text = "Pas de clé"}

L.PLAYERFRAME = {}
L.PLAYERFRAME["KeyLevel"] = { name = "Niveau clé", text = "Niveau clé à calculer."}
L.PLAYERFRAME["Gain"] = { name = "Gagner", text = "Gain de notation potentiel."}
L.PLAYERFRAME["New"] = { name = "Nouveau", text = "Votre note après avoir complété cette clé à un +1."}
L.PLAYERFRAME["RatingCalculator"] = { name = "Calculateur", text = "Calculez les gains de notation potentiels."}
L.PLAYERFRAME["EnterKeyLevel"] = { name = "Niveau clé", text = "Entrez un niveau clé pour voir"}
L.PLAYERFRAME["YourBaseRating"] = { name = "Gain de note de base", text = "yvotre prédiction de gain de note de base."}

L.CHARACTERINFO = {}
L.CHARACTERINFO["NoKeyFound"] = { name = "Aucune clé trouvée", text = "Aucune clé trouvée"}
L.CHARACTERINFO["KeyInVault"] = { name = "Clé dans le coffre-fort", text = "Clé dans le coffre-fort"}
L.CHARACTERINFO["AskMerchant"] = { name = "Demandez au marchand clé", text = "Marchand clé"}

L.TABPLAYER = "Joueur"
L.TABPARTY = "Groupe"
L.TABABOUT = "Quelque"
L.TABCONFIG = "Configuration"

L.CONFIGURATIONFRAME = {}
L.CONFIGURATIONFRAME["DisplaySettings"] = { name = "Paramètres d'affichage", text = "Paramètres d'affichage"}
L.CONFIGURATIONFRAME["ToggleRatingFloat"] = { name = "Toggle Note flottante", text = "Afficher les décimales de notation."}
L.CONFIGURATIONFRAME["ShowMiniMapButton"] = { name = "Afficher le bouton de la mini-carte", text = "Afficher le bouton de la mini-carte."}
L.CONFIGURATIONFRAME["DiagnosticSettings"] = { name = "Paramètres de diagnostic", text = "Paramètres de diagnostic."}
L.CONFIGURATIONFRAME["DisplayErrorMessages"] = { name = "Erreurs d'affichage", text = "Afficher les messages d'erreur."}
L.CONFIGURATIONFRAME["DisplayDebugMessages"] = { name = "Afficher le débogage", text = "Afficher les messages de débogage."}
L.CONFIGURATIONFRAME["DiagnosticsAdvanced"] = { name = "Diagnostic avancé", text="Remarque : ces informations sont uniquement destinées à des fins de diagnostic. Ils peuvent inonder votre boîte de discussion s’ils sont activés !"}

L.ABOUTFRAME = {}
L.ABOUTFRAME["AboutGeneral"] = { name = "Key Master Information", text = "Key Master Information"}
L.ABOUTFRAME["AboutAuthors"] = { name = "Auteurs", text = "Auteurs"}
L.ABOUTFRAME["AboutSpecialThanks"] = { name = "Remerciement spécial", text = "Remerciement spécial"}
L.ABOUTFRAME["AboutContributors"] = { name = "Contributeurs", text = "Contributeurs"}