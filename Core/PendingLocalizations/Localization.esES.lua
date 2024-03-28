KM_Localization_esES = {}
local L = KM_Localization_esES

-- Localization file for "esES": Spanish (Spain)
-- Translated by: Google Translate

-- ¿Problema de traducción? ¡Ayúdanos a corregirlo! Visita: https://discord.gg/bbMaUpfgn8

L.LANGUAGE = "Español (ES)"
L.TRANSLATOR = "Google Translate" -- Translator display name

L.TOCNOTES = {}
L.TOCNOTES["ADDONDESC"] = "Mythic Plus Keystone Information and Collaboration Tool"
L.TOCNOTES["ADDONNAME"] = "Key Master"

L.MAPNAMES = {}
-- DF S3
L.MAPNAMES[9001] = { name = "Desconocido", abbr = "???" }
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
L.MPLUSSEASON[11] = { name = "Temporada 3" }
L.MPLUSSEASON[12] = { name = "Temporada 4" }
L.MPLUSSEASON[13] = { name = "Temporada 1" } -- expecting season 13 to be TWW S1
L.MPLUSSEASON[14] = { name = "Temporada 2" } -- expecting season 14 to be TWW S2

L.ADDONNAME = "Key Master" -- do not translate
L.DISPLAYVERSION = "v"
L.WELCOMEMESSAGE = "Bienvenido de nuevo"
L.ON = "en"
L.OFF = "apagado"
L.ENABLED = "activado"
L.DISABLED = "desactivado"
L.CLICK = "Hacer clic"
L.CLICKDRAG = "Hacer clic + arrastrar"
L.TOOPEN = "abrir"
L.TOREPOSITION = "reposicionar"
L.EXCLIMATIONPOINT = "!"
L.THISWEEKSAFFIXES = "Esta semana..."
L.YOURRATING = "Tu clasificación"
L.ERRORMESSAGES = "Los mensajes de error son"
L.ERRORMESSAGESNOTIFY = "Notificar: Los mensajes de error están habilitados."
L.DEBUGMESSAGES = "Los mensajes de depuración son"
L.DEBUGMESSAGESNOTIFY = "Notificar: los mensajes de depuración están habilitados."
L.COMMANDERROR1 = "Comando invalido"
L.COMMANDERROR2 = "Entrar"
L.COMMANDERROR3 = "para comandos"
L.YOURCURRENTKEY = "TU LLAVE"
L.ADDONOUTOFDATE = "¡Tu complemento Key Master está desactualizado!"
L.INSTANCETIMER = "Información de instancia"
L.VAULTINFORMATION = "Progresión de bóveda M+"
L.TIMELIMIT = "Límite de tiempo"
L.SEASON = "Temporada"

L.COMMANDLINE = {}
L.COMMANDLINE["/km"] = { name = "/km", text = "/km"} -- Do not translate
L.COMMANDLINE["/keymaster"] = {name = "/keymaster", text = "/keymaster"} -- Do not translate
L.COMMANDLINE["Show"] = { name = "mostrar", text = " - mostrar u ocultar la ventana principal."}
L.COMMANDLINE["Help"] = { name = "ayuda", text = " - muestra este menú de ayuda."}
L.COMMANDLINE["Errors"] = { name = "errores", text = " - alternar mensajes de error."}
L.COMMANDLINE["Debug"] = { name = "depurar", text = " - alternar mensajes de depuración."}

L.TOOLTIPS = {}
L.TOOLTIPS["MythicRating"] = { name = "Calificación mítica", text = "Esta es la calificación Mythic Plus actual del personaje." }
L.TOOLTIPS["OverallScore"] = { name = "Puntuación general", text = "La puntuación general es una combinación de las puntuaciones de carrera tiránica y fortificada de un mapa. (Con muchas matemáticas involucradas)"}
L.TOOLTIPS["TeamRatingGain"] = { name = "Ganancia del partido", text = "Esta es una estimación que Key Master hace internamente. Este número representa el potencial mínimo total de ganancia de calificación de su grupo actual para completar con éxito la clave de grupo dada. Puede que no sea 100% exacto y solo está aquí con fines de estimación."}

L.PARTYFRAME = {}
L.PARTYFRAME["PartyInformation"] = { name = "Información del grupo", text = "Información del grupo"}
L.PARTYFRAME["OverallRating"] = { name = "General actual", text = "General actual" }
L.PARTYFRAME["PartyPointGain"] = { name = "Ganancia grupal", text = "Ganancia grupal"}
L.PARTYFRAME["Level"] = { name = "Nivel", text = "Nivel" }
L.PARTYFRAME["Weekly"] = { name = "Semanalmente", text = "Semanalmente"}
L.PARTYFRAME["NoAddon"] = { name = "No se detectó ningún complemento", text = "¡no detectado!"}
L.PARTYFRAME["PlayerOffline"] = { name = "Jugador sin conexión", text = "El jugador está desconectado."}
L.PARTYFRAME["TeamRatingGain"] = { name = "Potencial de ganancia grupal", text = "Ganancia estimada de calificación grupal"}
L.PARTYFRAME["MemberPointsGain"] = { name = "Ganar potencial", text = "Ganancia de puntos personales estimada para las claves disponibles al completar +1."}
L.PARTYFRAME["NoKey"] = { name = "No hay llave", text = "No hay llave"}

L.PLAYERFRAME = {}
L.PLAYERFRAME["KeyLevel"] = { name = "Nivel clave", text = "Nivel clave a calcular."}
L.PLAYERFRAME["Gain"] = { name = "Ganar", text = "Posible ganancia de calificación."}
L.PLAYERFRAME["New"] = { name = "Nuevo", text = "Tu calificación después de completar esta clave en un +1."}
L.PLAYERFRAME["RatingCalculator"] = { name = "Calculadora", text = "Calcule las posibles ganancias de calificación."}
L.PLAYERFRAME["EnterKeyLevel"] = { name = "Nivel clave", text = "Introduzca un nivel clave para ver"}
L.PLAYERFRAME["YourBaseRating"] = { name = "Base Rating Gain", text = "Ganancia de calificación base"}

L.CHARACTERINFO = {}
L.CHARACTERINFO["NoKeyFound"] = { name = "No hay llave", text = "No hay llave"}
L.CHARACTERINFO["KeyInVault"] = { name = "Clave en la bóveda", text = "Clave en la bóveda"}
L.CHARACTERINFO["AskMerchant"] = { name = "Pregunta al comerciante clave", text = "Pregunta al comerciante clave"}

L.TABPLAYER = "Jugador"
L.TABPARTY = "Grupo"
L.TABABOUT = "Acerca de"
L.TABCONFIG = "Configuración"

L.CONFIGURATIONFRAME = {}
L.CONFIGURATIONFRAME["DisplaySettings"] = { name = "Configuración de pantalla", text = "Configuración de pantalla"}
L.CONFIGURATIONFRAME["ToggleRatingFloat"] = { name = "Alternar clasificación flotante", text = "Mostrar decimales de calificación."}
L.CONFIGURATIONFRAME["ShowMiniMapButton"] = { name = "Botón Mostrar minimapa", text = "Mostrar botón de minimapa."}
L.CONFIGURATIONFRAME["DiagnosticSettings"] = { name = "Configuración de diagnóstico", text = "Configuración de diagnóstico"}
L.CONFIGURATIONFRAME["DisplayErrorMessages"] = { name = "Errores de visualización", text = "Errores de visualización"}
L.CONFIGURATIONFRAME["DisplayDebugMessages"] = { name = "Mostrar depuración", text = "Mostrar mensajes de depuración."}
L.CONFIGURATIONFRAME["DiagnosticsAdvanced"] = { name = "Diagnóstico avanzado", text="Nota: Estos son sólo para fines de diagnóstico. ¡Pueden inundar tu cuadro de chat si están habilitados!"}

L.ABOUTFRAME = {}
L.ABOUTFRAME["AboutGeneral"] = { name = "Información maestra clave", text = "Key Master Information"}
L.ABOUTFRAME["AboutAuthors"] = { name = "Autores", text = "Autores"}
L.ABOUTFRAME["AboutSpecialThanks"] = { name = "Gracias especiales", text = "Gracias especiales"}
L.ABOUTFRAME["AboutContributors"] = { name = "Colaboradores", text = "Colaboradores"}

L.SYSTEMMESSAGE = {}
L.SYSTEMMESSAGE["NOTICE"] = { text = "Notice: Dragonflight Season 4 rating calculations are still being verified."}