KM_Localization_ruRU = {}
local L = KM_Localization_ruRU

-- Localization file for "ruRU": Russian (Russia)
-- Translated by: Google Translate

-- Проблема с переводом? Помогите нам исправить это! Посещать: https://discord.gg/bbMaUpfgn8

L.LANGUAGE = "Русский (RU)"
L.TRANSLATOR = "Google Переводчик"

L.MAPNAMES = {}
L.MAPNAMES[9001] = { name = "Неизвестный", abbr = "???" }
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
L.MPLUSSEASON[11] = { name = "3 сезон" }
L.MPLUSSEASON[12] = { name = "4 сезон" }
L.MPLUSSEASON[13] = { name = "1 сезон" } -- expecting season 13 to be TWW S1
L.MPLUSSEASON[14] = { name = "2 сезон" } -- expecting season 14 to be TWW S2

L.ADDONNAME = "Key Master" -- do not translate
L.BUILDRELEASE = "release" -- do not translate
L.BUILDBETA = "beta" -- do not translate
L.DISPLAYVERSION = "v" -- do not translate
L.WELCOMEMESSAGE = "Добро пожаловать"
L.ON = "на"
L.OFF = "выключенный"
L.ENABLED = "включено"
L.DISABLED = "неполноценный"
L.CLICK = "Нажмите"
L.CLICKDRAG = "Нажмите + перетащите"
L.TOOPEN = "открыть"
L.TOREPOSITION = "переместить"
L.EXCLIMATIONPOINT = "!"
L.THISWEEKSAFFIXES = "На этой неделе..."
L.YOURRATING = "Ваш рейтинг"
L.ERRORMESSAGES = "Сообщения об ошибках"
L.ERRORMESSAGESNOTIFY = "Уведомление: сообщения об ошибках включены."
L.DEBUGMESSAGES = "Отладочные сообщения"
L.DEBUGMESSAGESNOTIFY = "Уведомление: сообщения отладки включены."
L.COMMANDERROR1 = "Неверная команда"
L.COMMANDERROR2 = "вводить"
L.COMMANDERROR3 = "для команд"
L.YOURCURRENTKEY = "ТВОЙ КЛЮЧ"
L.ADDONOUTOFDATE = "Ваше дополнение Key Master устарело!"
L.INSTANCETIMER = "Информация об экземпляре"
L.VAULTINFORMATION = "Прогресс Хранилища М+"
L.TIMELIMIT = "Лимит времени"
L.SEASON = "сезон"

L.COMMANDLINE = {}
L.COMMANDLINE["/km"] = { name = "/km", text = "/km"} -- Do not translate
L.COMMANDLINE["/keymaster"] = {name = "/keymaster", text = "/keymaster"} -- Do not translate
L.COMMANDLINE["Show"] = { name = "показ", text = " - показать или скрыть главное окно."}
L.COMMANDLINE["Help"] = { name = "помощь", text = " - показывает это меню помощи."}
L.COMMANDLINE["Errors"] = { name = "ошибки", text = " - переключить сообщения об ошибках."}
L.COMMANDLINE["Debug"] = { name = "отлаживать", text = " - переключить отладочные сообщения."}

L.TOOLTIPS = {}
L.TOOLTIPS["MythicRating"] = { name = "Мифический рейтинг", text = "Это текущий рейтинг персонажа в Mythic Plus." }
L.TOOLTIPS["OverallScore"] = { name = "Общая оценка", text = "Общий балл представляет собой комбинацию очков Тиранического и Укрепленного прохождения карты. (с большим количеством математики)"}
L.TOOLTIPS["TeamRatingGain"] = { name = "Предполагаемый групповой выигрыш", text = "Это оценка, которую Key Master делает внутри компании. Это число представляет собой общий минимальный потенциал повышения рейтинга вашей текущей группы за успешное выполнение данного ключа группы. Оно может быть не на 100% точным и приведено здесь только в целях оценки."}

L.PARTYFRAME = {}
L.PARTYFRAME["PartyInformation"] = { name = "Информация о группе", text = "Информация о группе"}
L.PARTYFRAME["OverallRating"] = { name = "Текущий общий объем", text = "Текущий общий объем" }
L.PARTYFRAME["PartyPointGain"] = { name = "Получение групповых очков", text = "Получение групповых очков"}
L.PARTYFRAME["Level"] = { name = "Cтупень", text = "Cтупень" }
L.PARTYFRAME["Weekly"] = { name = "Еженедельно", text = "Еженедельно"}
L.PARTYFRAME["NoAddon"] = { name = "Аддон не обнаружен", text = "не обнаружен!"}
L.PARTYFRAME["PlayerOffline"] = { name = "Игрок оффлайн", text = "Игрок не в сети."}
L.PARTYFRAME["TeamRatingGain"] = { name = "Потенциал групповой выгоды", text = "Прирост группового рейтинга"}
L.PARTYFRAME["MemberPointsGain"] = { name = "Получите потенциал", text = "Предполагаемый прирост личных очков за доступные ключи при завершении +1."}
L.PARTYFRAME["NoKey"] = { name = "Нет ключа", text = "Нет ключа"}

L.PLAYERFRAME = {}
L.PLAYERFRAME["KeyLevel"] = { name = "Ключевой уровень", text = "Ключевой уровень, подлежащий расчету."}
L.PLAYERFRAME["Gain"] = { name = "Прирост", text = "Возможное повышение рейтинга."}
L.PLAYERFRAME["New"] = { name = "новейший", text = "Ваш рейтинг после прохождения этого ключа на +1."}
L.PLAYERFRAME["RatingCalculator"] = { name = "Калькулятор", text = "Рассчитайте потенциальный прирост рейтинга."}
L.PLAYERFRAME["EnterKeyLevel"] = { name = "Ключевой уровень", text = "Введите ключевой уровень, чтобы увидеть"}
L.PLAYERFRAME["YourBaseRating"] = { name = "Базовый прирост рейтинга", text = "ваш базовый прогноз повышения рейтинга."}

L.CHARACTERINFO = {}
L.CHARACTERINFO["NoKeyFound"] = { name = "Ключ не найден", text = "Ключ не найден"}
L.CHARACTERINFO["KeyInVault"] = { name = "Ключ в хранилище", text = "В хранилище"}
L.CHARACTERINFO["AskMerchant"] = { name = "Ключевой торговец", text = "Ключевой торговец"}

L.TABPLAYER = "Игрок"
L.TABPARTY = "Группа"
L.TABABOUT = "Oтносительно"
L.TABCONFIG = "Конфигурация"

L.CONFIGURATIONFRAME = {}
L.CONFIGURATIONFRAME["DisplaySettings"] = { name = "Настройки отображения", text = "Настройки отображения"}
L.CONFIGURATIONFRAME["ToggleRatingFloat"] = { name = "Переключить плавающий рейтинг", text = "Показывать десятичные дроби рейтинга."}
L.CONFIGURATIONFRAME["ShowMiniMapButton"] = { name = "Показать кнопку мини-карты", text = "Показать кнопку мини-карты."}
L.CONFIGURATIONFRAME["DiagnosticSettings"] = { name = "Настройки диагностики", text = "Настройки диагностики."}
L.CONFIGURATIONFRAME["DisplayErrorMessages"] = { name = "Отображение ошибок", text = "Отображать сообщения об ошибках."}
L.CONFIGURATIONFRAME["DisplayDebugMessages"] = { name = "Отображение отладки", text = "Отображать сообщения отладки."}
L.CONFIGURATIONFRAME["DiagnosticsAdvanced"] = { name = "Расширенная диагностика", text="Примечание. Они предназначены только для диагностических целей. Они могут заполонить ваш чат, если он включен!"}

L.ABOUTFRAME = {}
L.ABOUTFRAME["AboutGeneral"] = { name = "Key Master Информация", text = "Key Master Информация"}
L.ABOUTFRAME["AboutAuthors"] = { name = "Авторы", text = "Авторы"}
L.ABOUTFRAME["AboutSpecialThanks"] = { name = "Особая благодарность", text = "Особая благодарность"}
L.ABOUTFRAME["AboutContributors"] = { name = "Авторы", text = "Авторы"}