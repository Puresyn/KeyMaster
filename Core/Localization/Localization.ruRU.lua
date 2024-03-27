KM_Localization_ruRU = {}
local L = KM_Localization_ruRU

-- Localization file for "ruRU": Russian (Russia)
-- Translated by: Hollicsh

-- Проблема с переводом? Помогите нам исправить это! Посетите: https://discord.gg/bbMaUpfgn8

L.LANGUAGE = "Русский (RU)"
L.TRANSLATOR = "Hollicsh" -- Translator display name

L.TOCNOTES = {}
L.TOCNOTES["ADDONDESC"] = "Отображение подробной информации о контенте М+"
L.TOCNOTES["ADDONNAME"] = "Мастер ключей"

L.MAPNAMES = {}
-- DF S3
L.MAPNAMES[9001] = { name = "Неизвестный", abbr = "???" }
L.MAPNAMES[463] = { name = "Dawn of the Infinite: Galakrond's Fall", abbr = "ПГ"}
L.MAPNAMES[464] = { name = "Dawn of the Infinite: Murozond's Rise", abbr = "ПД"}
L.MAPNAMES[244] = { name = "Atal'Dazar", abbr = "АД" }
L.MAPNAMES[248] = { name = "Waycrest Manor", abbr = "УЭ" }
L.MAPNAMES[199] = { name = "Black Rook Hold", abbr = "КЧЛ" }
L.MAPNAMES[198] = { name = "Darkheart Thicket", abbr = "ЧАЩА" }
L.MAPNAMES[168] = { name = "The Everbloom", abbr = "ВЦ" }
L.MAPNAMES[456] = { name = "Throne of the Tides", abbr = "ТРОН" }
--DF S4
L.MAPNAMES[399] = { name = "Ruby Life Pools", abbr = "РоЖ" }
L.MAPNAMES[401] = { name = "The Azue Vault", abbr = "ЛХ" }
L.MAPNAMES[400] = { name = "The Nokhud Offensive", abbr = "НкН" }
L.MAPNAMES[402] = { name = "Algeth'ar Academy", abbr = "АА" }
L.MAPNAMES[403] = { name = "Legacy of Tyr", abbr = "УЛЬД" }
L.MAPNAMES[404] = { name = "Neltharus", abbr = "НЕЛТ" }
L.MAPNAMES[405] = { name = "Brackenhide Hollow", abbr = "ЛБ" }
L.MAPNAMES[406] = { name = "Halls of Infusion", abbr = "ЧН" }

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
L.MPLUSSEASON[13] = { name = "1 сезон" } -- ожидая, что 13 сезон будет TWW S1
L.MPLUSSEASON[14] = { name = "2 сезон" } -- ожидая, что 14 сезон будет TWW S2

L.ADDONNAME = "Key Master" -- Не нужно переводить
L.DISPLAYVERSION = "вер. " -- перевёл, потому что на русском языке так будет лучше
L.WELCOMEMESSAGE = "Добро пожаловать"
L.ON = "вкл."
L.OFF = "выкл."
L.ENABLED = "включены"
L.DISABLED = "выключены"
L.CLICK = "ПКМ"
L.CLICKDRAG = "ПКМ + перетащить"
L.TOOPEN = "- открыть главное окно"
L.TOREPOSITION = "- переместить значок"
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
L.INSTANCETIMER = "Информация о подземелье"
L.VAULTINFORMATION = "Прогресс Хранилища М+"
L.TIMELIMIT = "Лимит времени"
L.SEASON = "сезон"

L.COMMANDLINE = {}
L.COMMANDLINE["/km"] = { name = "/km", text = "/km"} -- Do not translate
L.COMMANDLINE["/keymaster"] = {name = "/keymaster", text = "/keymaster"} -- Do not translate
L.COMMANDLINE["Show"] = { name = "показать", text = " - показать/скрыть главное окно."}
L.COMMANDLINE["Help"] = { name = "помощь", text = " - показать меню помощи."}
L.COMMANDLINE["Errors"] = { name = "ошибки", text = " - включить/отключить сообщения об ошибках."}
L.COMMANDLINE["Debug"] = { name = "отладка", text = " - включить/отключить сообщения об отладке."}

L.TOOLTIPS = {}
L.TOOLTIPS["MythicRating"] = { name = "Рейтинг М+", text = "Текущий М+ рейтинг персонажа" }
L.TOOLTIPS["OverallScore"] = { name = "Общий рейтинг", text = "Общий рейтинг представляет собой комбинацию очков за прохождение Тиранической и Укрепленной недели. (С большим количеством математических рассчетов)"}
L.TOOLTIPS["TeamRatingGain"] = { name = "Предполагаемое увеличение рейтинга группы", text = "Это оценка, которую Key Master делает самостоятельно. Это число представляет собой общую минимальную вероятность повышения рейтинга Вашей текущей группы за успешное завершение данного ключа группы. Оно не может быть точным на 100% и приведено здесь только в целях оценки."}

L.PARTYFRAME = {}
L.PARTYFRAME["PartyInformation"] = { name = "Информация о группе", text = "Информация о группе"}
L.PARTYFRAME["OverallRating"] = { name = "Общий счет", text = "Общий счет" }
L.PARTYFRAME["PartyPointGain"] = { name = "Получение групповых очков", text = "Получение групповых очков"}
L.PARTYFRAME["Level"] = { name = "Уровень", text = "Уровень" }
L.PARTYFRAME["Weekly"] = { name = "Еженедельно", text = "Еженедельно"}
L.PARTYFRAME["NoAddon"] = { name = "Аддон не обнаружен", text = "не обнаружен!"}
L.PARTYFRAME["PlayerOffline"] = { name = "Игрок оффлайн", text = "Игрок не в сети"}
L.PARTYFRAME["TeamRatingGain"] = { name = "Потенциальный групповой прирост", text = "Потенциальный прирост группового рейтинга"}
L.PARTYFRAME["MemberPointsGain"] = { name = "Вероятность прироста", text = "Предполагаемый прирост личных очков за доступные ключи при завершении их на +1"}
L.PARTYFRAME["NoKey"] = { name = "Нет ключа", text = "Нет ключа"}

L.PLAYERFRAME = {}
L.PLAYERFRAME["KeyLevel"] = { name = "Уровень ключа", text = "Уровень ключа, подлежащий расчету"}
L.PLAYERFRAME["Gain"] = { name = "Прирост", text = "Возможное повышение рейтинга"}
L.PLAYERFRAME["New"] = { name = "Новый", text = "Ваш рейтинг после прохождения этого ключа на +1"}
L.PLAYERFRAME["RatingCalculator"] = { name = "Калькулятор", text = "Рассчитайте потенциальный прирост рейтинга"}
L.PLAYERFRAME["EnterKeyLevel"] = { name = "Введите уровень ключа", text = "Введите уровень ключа, чтобы увидеть"}
L.PLAYERFRAME["YourBaseRating"] = { name = "Базовый прирост рейтинга", text = "Ваш базовый прирост рейтинга"}

L.CHARACTERINFO = {}
L.CHARACTERINFO["NoKeyFound"] = { name = "Ключ не найден", text = "Ключ не найден"}
L.CHARACTERINFO["KeyInVault"] = { name = "Ключ в хранилище", text = "В хранилище"}
L.CHARACTERINFO["AskMerchant"] = { name = "Спросить торговца ключами", text = "Линдорми <Эпохальные ключи>"}

L.TABPLAYER = "Игрок"
L.TABPARTY = "Группа"
L.TABABOUT = "Информация"
L.TABCONFIG = "Конфигурация"

L.CONFIGURATIONFRAME = {}
L.CONFIGURATIONFRAME["DisplaySettings"] = { name = "Настройки отображения", text = "Настройки отображения"}
L.CONFIGURATIONFRAME["ToggleRatingFloat"] = { name = "Переключить плавающий рейтинг", text = "Показывать десятичные числа рейтинга"}
L.CONFIGURATIONFRAME["ShowMiniMapButton"] = { name = "Показать кнопку миникарты", text = "Показать кнопку миникарты"}
L.CONFIGURATIONFRAME["DiagnosticSettings"] = { name = "Настройки диагностики", text = "Настройки диагностики"}
L.CONFIGURATIONFRAME["DisplayErrorMessages"] = { name = "Отображение ошибок", text = "Отображать сообщения об ошибках"}
L.CONFIGURATIONFRAME["DisplayDebugMessages"] = { name = "Отображение отладки", text = "Отображать сообщения отладки"}
L.CONFIGURATIONFRAME["DiagnosticsAdvanced"] = { name = "Расширенная диагностика", text="Примечание: Это предназначено только для диагностических целей. Это может заспамить Ваш чат, если он включен!"}

L.ABOUTFRAME = {}
L.ABOUTFRAME["AboutGeneral"] = { name = "Информация Key Master", text = "Информация Key Master"}
L.ABOUTFRAME["AboutAuthors"] = { name = "Авторы", text = "Авторы"}
L.ABOUTFRAME["AboutSpecialThanks"] = { name = "Особая благодарность", text = "Особая благодарность"}
L.ABOUTFRAME["AboutContributors"] = { name = "Участники", text = "Участники"}

L.SYSTEMMESSAGE = {}
L.SYSTEMMESSAGE["NOTICE"] = { text = "Notice: Dragonflight Season 4 rating calculations are still being verified."}