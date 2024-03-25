KM_Localization_ptBR = {}
local L = KM_Localization_ptBR

-- Localization file for "ptBR": Portuguese (Brazil)
-- Traduzido por: Cyph

-- Problema de tradução? Ajude-nos a corrigi-lo! Visita: https://discord.gg/bbMaUpfgn8

L.LANGUAGE = "Português (BR)"
L.TRANSLATOR = "Cyph" -- Translator display name

L.TOCNOTES = {}
L.TOCNOTES["ADDONDESC"] = "Ferramenta de informação e colaboração sobre chaves Mítica +"

L.MAPNAMES = {}
L.MAPNAMES[9001] = { name = "Desconhecido", abbr = "???" }
L.MAPNAMES[463] = { name = "Despertar do Infinito: Ruína de Galakrond", abbr = "FALL"}
L.MAPNAMES[464] = { name = "Despertar do Infinito: Ascensão de Murozond", abbr = "RISE"}
L.MAPNAMES[244] = { name = "Atal'Dazar", abbr = "AD" }
L.MAPNAMES[248] = { name = "Mansão Capelo", abbr = "WM" }
L.MAPNAMES[199] = { name = "Castelo Corvo Negro", abbr = "BRH" }
L.MAPNAMES[198] = { name = "Bosque Corenegro", abbr = "DHT" }
L.MAPNAMES[168] = { name = "Floretérnia", abbr = "EB" }
L.MAPNAMES[456] = { name = "Trono das Marés", abbr = "TotT" }

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
L.XPAC[10] = { enum = "LE_EXPANSION_11_0", desc = "The War Within" } -- enum will need updated when available

L.MPLUSSEASON = {}
L.MPLUSSEASON[11] = { name = "Temporada 3" }
L.MPLUSSEASON[12] = { name = "Temporada 4" }
L.MPLUSSEASON[13] = { name = "Temporada 1" } -- expecting season 13 to be TWW S1
L.MPLUSSEASON[14] = { name = "Temporada 2" } -- expecting season 14 to be TWW S2

L.ADDONNAME = "Key Master" -- do not translate
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

L.COMMANDLINE = {}
L.COMMANDLINE["/km"] = { name = "/km", text = "/km"} -- Do not translate
L.COMMANDLINE["/keymaster"] = {name = "/keymaster", text = "/keymaster"} -- Do not translate
L.COMMANDLINE["Show"] = { name = "Mostrar", text = " - mostra/esconde a tela principal."}
L.COMMANDLINE["Help"] = { name = "ajuda", text = " - exibe esse menu de ajuda."}
L.COMMANDLINE["Errors"] = { name = "erros", text = " - ativa mensagens de erro."}
L.COMMANDLINE["Debug"] = { name = "debug", text = " - ativa mensagens de debug."}

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

L.PLAYERFRAME = {}
L.PLAYERFRAME["KeyLevel"] = { name = "Nível da chave", text = "Nível da chave à ser calculado."}
L.PLAYERFRAME["Gain"] = { name = "Ganho", text = "Potencial de pontuação ganha."}
L.PLAYERFRAME["New"] = { name = "Novo", text = "Sua pontuação após completar essa chave +1."}
L.PLAYERFRAME["RatingCalculator"] = { name = "Calculadora", text = "Calcula o ganho potencial de pontuação."}
L.PLAYERFRAME["EnterKeyLevel"] = { name = "Nível-chave", text = "Insira o nível da chave para ver"}
L.PLAYERFRAME["YourBaseRating"] = { name = "Ganho base de pontuação", text = "previsão base de ganho de pontuação."}

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

L.ABOUTFRAME = {}
L.ABOUTFRAME["AboutGeneral"] = { name = "Informações Key Master", text = "Informações Key Master"}
L.ABOUTFRAME["AboutAuthors"] = { name = "Autores", text = "Autores"}
L.ABOUTFRAME["AboutSpecialThanks"] = { name = "Agradecimentos Especiais", text = "Agradecimentos Especiais"}
L.ABOUTFRAME["AboutContributors"] = { name = "Contribuidores", text = "Contribuidores"}