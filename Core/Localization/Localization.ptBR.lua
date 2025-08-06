KM_Localization_ptBR = {}
local L = KM_Localization_ptBR

-- Localization file for "ptBR": Portuguese (Brazil)
-- Traduzido por: Cyph

--[[Notes for Translators: In many locations throughout Key Master, line space is limited. This can cause
    overlapping or strange text display. Where possible, try to keep the overall length of the string comparable or shorter
    than the English version. If that is not possible, development adjustments may need made.
    If you are not comfortable setting up your own local testing to check for these issues, make sure you let a dev know
    so they can go over a screen-share with you.]]--

-- Problema de tradução? Ajude-nos a corrigi-lo! Visita: https://discord.gg/bbMaUpfgn8

L.LANGUAGE = "Português (BR)"
L.TRANSLATOR = "Cyph" -- Translator display name

L.TOCNOTES = {} -- these are manaually copied to the TOC so they show up in the appropriate language in the AddOns list. Please translate them both but let a dev know if you update them later.
L.TOCNOTES["ADDONDESC"] = "Ferramenta de informação e colaboração sobre chaves Mítica +"
L.TOCNOTES["ADDONNAME"] = "Key Master"

L.MAPNAMES = {} -- Note: Map abbrevations should be a max of 4 characters and be commonly known. Map names come directly from Blizzard already translated.

-- USE /fsstack to mouseover the icons in the player frame to find their mapIds if you need to add new dungeons.
-- DF S3
L.MAPNAMES[9001] = { name = "Desconhecido", abbr = "???" }
L.MAPNAMES[463] = { name = "Despertar do Infinito: Ruína de Galakrond", abbr = "FALL"}
L.MAPNAMES[464] = { name = "Despertar do Infinito: Ascensão de Murozond", abbr = "RISE"}
L.MAPNAMES[244] = { name = "Atal'Dazar", abbr = "AD" }
L.MAPNAMES[248] = { name = "Mansão Capelo", abbr = "WM" }
L.MAPNAMES[199] = { name = "Castelo Corvo Negro", abbr = "BRH" }
L.MAPNAMES[198] = { name = "Bosque Corenegro", abbr = "DHT" }
L.MAPNAMES[168] = { name = "Floretérnia", abbr = "EB" }
L.MAPNAMES[456] = { name = "Trono das Marés", abbr = "TotT" }
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
L.MAPNAMES[503] = { name = "Ara-Kara, Cidade dos Ecos", abbr = "CE" }
L.MAPNAMES[502] = { name = "Cidade das Tramas", abbr = "CT" }
L.MAPNAMES[505] = { name = "Alvorada", abbr = "DB" }
L.MAPNAMES[501] = { name = "Abóboda de Pedra", abbr = "SV" }
L.MAPNAMES[353] = { name = "Cerco de Boralus", abbr = "SB" }
L.MAPNAMES[507] = { name = "Grim Batol", abbr = "GB" }
L.MAPNAMES[375] = { name = "Brumas de Tirna Scithe", abbr = "MTS" }
L.MAPNAMES[376] = { name = "Chaga Necrótica", abbr = "NW" }
--TWW S2
L.MAPNAMES[500] = { name = "O Viveiro", abbr = "RKY" }
L.MAPNAMES[525] = { name = "Operação: Comporta", abbr = "FG" }
L.MAPNAMES[247] = { name = "MEGAMINA!!!", abbr = "ML" }
L.MAPNAMES[370] = { name = "Operação: Gnomecan - Workshop", abbr = "WORK" }
L.MAPNAMES[504] = { name = "Fenda Chamanegra", abbr = "DFC" }
L.MAPNAMES[382] = { name = "Teatro da Dor", abbr = "ToP" }
L.MAPNAMES[506] = { name = "Hidromelaria Cinzagris", abbr = "CBM" }
L.MAPNAMES[499] = { name = "Priorado da chama sagrada", abbr = "PoSF" }
--TWW S3
L.MAPNAMES[391] = { name = "So\'leah's Gambit", abbr = "GMBT" }
L.MAPNAMES[392] = { name = "Streets of Wonder", abbr = "STRT" }
L.MAPNAMES[378] = { name = "Halls of Attonement", abbr = "HOA" }
L.MAPNAMES[542] = { name = "Eco-Dome Al\'dani", abbr = "DOME" }

L.XPAC = {}
L.XPAC[0] = { enum = "LE_EXPANSION_CLASSIC", desc = "Clássico" }
L.XPAC[1] = { enum = "LE_EXPANSION_BURNING_CRUSADE", desc = "The Burning Crusade" }
L.XPAC[2] = { enum = "LE_EXPANSION_WRATH_OF_THE_LICH_KING", desc = "Wrath of the Lich King" }
L.XPAC[3] = { enum = "LE_EXPANSION_CATACLYSM", desc = "Cataclysm" }
L.XPAC[4] = { enum = "LE_EXPANSION_MISTS_OF_PANDARIA", desc = "Mists of Pandaria" }
L.XPAC[5] = { enum = "E_EXPANSION_WARLORDS_OF_DRAENOR", desc = "Warlords of Draenor" }
L.XPAC[6] = { enum = "LE_EXPANSION_LEGION", desc = "Legion" }
L.XPAC[7] = { enum = "LE_EXPANSION_BATTLE_FOR_AZEROTH", desc = "Battle for Azeroth" }
L.XPAC[8] = { enum = "LE_EXPANSION_SHADOWLANDS", desc = "Shadowlands" }
L.XPAC[9] = { enum = "LE_EXPANSION_DRAGONFLIGHT", desc = "Dragonflight" }
L.XPAC[10] = { enum = "LE_EXPANSION_WAR_WITHIN", desc = "The War Within" }

L.MPLUSSEASON = {}
L.MPLUSSEASON[11] = { name = "Temporada 3" }
L.MPLUSSEASON[12] = { name = "Temporada 4" }
L.MPLUSSEASON[13] = { name = "Temporada 1" } -- expecting season 13 to be TWW S1
L.MPLUSSEASON[14] = { name = "Temporada 2" } -- expecting season 14 to be TWW S2
L.MPLUSSEASON[15] = { name = "Temporada 3" } -- expecting season 15 to be TWW S2

L.DISPLAYVERSION = "v"
L.WELCOMEMESSAGE = "Bem vindo"
L.ON = "on"
L.OFF = "off"
L.ENABLED = "ativada"
L.DISABLED = "desativada"
L.CLICK = "Click"
L.CLICKDRAG = "Click e arraste"
L.TOOPEN = "para abrir"
L.TOREPOSITION = "para reposicionar"
L.EXCLIMATIONPOINT = "!"
L.THISWEEKSAFFIXES = "Essa Semana..."
L.YOURRATING = "Sua Pontuação"
L.ERRORMESSAGES = "Mensagem de Erro"
L.ERRORMESSAGESNOTIFY = "Notificação: Mensagens de erro habilitadas."
L.DEBUGMESSAGES = "Mensagem de Debug"
L.DEBUGMESSAGESNOTIFY = "Notificação: Mensagens de debug estão habilitadas"
L.COMMANDERROR1 = "Comando invalido"
L.COMMANDERROR2 = "Insira"
L.COMMANDERROR3 = "para comandos"
L.YOURCURRENTKEY = "SUA CHAVE"
L.ADDONOUTOFDATE = "Seu addon Key Master está desatualizado!"
L.INSTANCETIMER = "Informação da Instância"
L.VAULTINFORMATION = "M+ Progressão do Baú"
L.TIMELIMIT = "Limite de Tempo"
L.SEASON = "Temporada"
L.COMBATMESSAGE = { errormsg = "Key Master indisponível em combate.", chatmsg = "A interface irá abrir assim que sair de combate."}

L.COMMANDLINE = {} -- translate whatever in this section would be standard of an addon in the language. i.e. /km show, /km XXXX, or /XX XXXX It will work just fine.
L.COMMANDLINE["/km"] = { name = "/km", text = "/km"}
L.COMMANDLINE["/keymaster"] = {name = "/keymaster", text = "/keymaster"}
L.COMMANDLINE["Show"] = { name = "Mostrar", text = " - mostra/esconde a tela principal."}
L.COMMANDLINE["Help"] = { name = "ajuda", text = " - exibe esse menu de ajuda."}
L.COMMANDLINE["Errors"] = { name = "erros", text = " - ativa mensagens de erro."}
L.COMMANDLINE["Debug"] = { name = "debug", text = " - ativa mensagens de debug."}
L.COMMANDLINE["Version"] = { name = "version", text = " - shows the current build version." }

L.TOOLTIPS = {}
L.TOOLTIPS["MythicRating"] = { name = "Pontuação Mítico", text = "Essa é a pontuação atual de Mítica+ desse personagem." }
L.TOOLTIPS["OverallScore"] = { name = "Pontuação Geral", text = "A pontuação geral é a combinação das pontuações de Tirânica e Fortificada para o mapa (Com muita matemática envolvida)"}
L.TOOLTIPS["TeamRatingGain"] = { name = "Ganho de pontuação estimado do grupo", text = "Essa é uma estimativa que o Key Master faz internamente. Esse número representa o ganho mínimo de pontuação esperado para o grupo ao finalizar a chave com sucesso. Esse número pode não ser 100% acurado e serve apenas para fins de estimativa."}

L.PARTYFRAME = {}
L.PARTYFRAME["PartyInformation"] = { name = "Informação do Grupo", text = "Informação do Grupo"}
L.PARTYFRAME["OverallRating"] = { name = "Geral atual", text = "Geral atual" }
L.PARTYFRAME["PartyPointGain"] = { name = "Ganho do grupo", text = "Ganho do grupo"}
L.PARTYFRAME["Level"] = { name = "Nível", text = "Nível" }
L.PARTYFRAME["Weekly"] = { name = "Semanal", text = "Semanal"}
L.PARTYFRAME["NoAddon"] = { name = "Addon não detectado", text = "não detectado!"}
L.PARTYFRAME["PlayerOffline"] = { name = "Jogador Offline", text = "Jogador offline."}
L.PARTYFRAME["TeamRatingGain"] = { name = "Potencial de ganho do grupo", text = "Ganho estimado do grupo"}
L.PARTYFRAME["MemberPointsGain"] = { name = "Potencial de ganho", text = "Estimativa pessoal de ganho de pontos para as chaves disponíveis na conclusão +1."}
L.PARTYFRAME["NoKey"] = { name = "Nenhuma chave", text = "Nenhuma chave"}
L.PARTYFRAME["NoPartyInfo"] = { text = "Informação dos jogadores da equipe indisponível em formador de grupo. (Localizador de Masmorras, Localizador de Raides, etc.)" }

L.PLAYERFRAME = {}
L.PLAYERFRAME["KeyLevel"] = { name = "Nível da chave", text = "Nível da chave à ser calculado."}
L.PLAYERFRAME["Gain"] = { name = "Ganho", text = "Potencial de pontuação ganha."}
L.PLAYERFRAME["New"] = { name = "Novo", text = "Sua pontuação após completar essa chave +1."}
L.PLAYERFRAME["RatingCalculator"] = { name = "Calculadora", text = "Calcula o ganho potencial de pontuação."}
L.PLAYERFRAME["EnterKeyLevel"] = { name = "Nível-chave", text = "Insira o nível da chave para ver"}
L.PLAYERFRAME["YourBaseRating"] = { name = "Ganho base de pontuação", text = "previsão base de ganho de pontuação."}
L.PLAYERFRAME["Characters"] = "Personagens"
L.PLAYERFRAME["DungeonTools"] = { name = "Ferramentas de Masmorra", text = "Várias ferramentas relacionadas à essa masmorra"}

L.CHARACTERINFO = {}
L.CHARACTERINFO["NoKeyFound"] = { name = "Chave não encontrada", text = "Chave não encontrada"}
L.CHARACTERINFO["KeyInVault"] = { name = "Chave no baú", text = "No baú"}
L.CHARACTERINFO["AskMerchant"] = { name = "Peça ao mercador de chaves", text = "Mercador de chaves"}

L.TABPLAYER = "Jogador"
L.TABPARTY = "Grupo"
L.TABABOUT = "Sobre"
L.TABCONFIG = "Configuração"

L.CONFIGURATIONFRAME = {}
L.CONFIGURATIONFRAME["DisplaySettings"] = { name = "Configurações de Exibição", text = "Configurações de Exibição"}
L.CONFIGURATIONFRAME["ToggleRatingFloat"] = { name = "Ativar Pontuação em Decimal", text = "Exibir Decimais."}
L.CONFIGURATIONFRAME["ShowMiniMapButton"] = { name = "Exibir botão no minimapa", text = "Exibir botão no minimapa."}
L.CONFIGURATIONFRAME["DiagnosticSettings"] = { name = "Configurações de Diagnóstico", text = "Configurações de Diagnóstico."}
L.CONFIGURATIONFRAME["DisplayErrorMessages"] = { name = "Exibir erros", text = "Exibir mensagens de erro."}
L.CONFIGURATIONFRAME["DisplayDebugMessages"] = { name = "Exibir Debug", text = "Exibir mensagens de debugging."}
L.CONFIGURATIONFRAME["DiagnosticsAdvanced"] = { name = "Diagnóstico Avançado", text="Nota: Apenas para propósito de diagnóstico. Poderá inundar sua janela de chat se ativado!"}
L.CONFIGURATIONFRAME["CharacterSettings"] = { name="Filtros da lista de Persoagens", text = "Opções alternativas de filtro para lista de personagens." }
L.CONFIGURATIONFRAME["FilterByServer"] = { name = "Servidor atual", text = "Mostrar apenas servidor atual." }
L.CONFIGURATIONFRAME["FilterByNoRating"] = { name = "Sem classificação", text = "Mostrar apenas personagens com classificação M+." }
L.CONFIGURATIONFRAME["FilterByNoKey"] = { name = "Sem Chave", text = "Mostrar apenas personagens com chave M+." }
L.CONFIGURATIONFRAME["FilterByMaxLvl"] = { name = "Apenas Máximo", text = "Mostra apenas personagens com nível máximo." }
L.CONFIGURATIONFRAME["Purge"] = { present = "Expurgar", past = "Expurgados" }

L.ABOUTFRAME = {}
L.ABOUTFRAME["AboutGeneral"] = { name = "Informações Key Master", text = "Informações Key Master"}
L.ABOUTFRAME["AboutAuthors"] = { name = "Autores", text = "Autores"}
L.ABOUTFRAME["AboutSpecialThanks"] = { name = "Agradecimentos Especiais", text = "Agradecimentos Especiais"}
L.ABOUTFRAME["AboutContributors"] = { name = "Contribuidores", text = "Contribuidores"}
L.ABOUTFRAME["Translators"] = { text = "Tradutores" }
L.ABOUTFRAME["WhatsNew"] = { text = "Mostrar atualizações"}

L.SYSTEMMESSAGE = {}
L.SYSTEMMESSAGE["NOTICE"] = { text = "Aviso: As pontuações dessa temporada ainda estão sendo verificadas."}