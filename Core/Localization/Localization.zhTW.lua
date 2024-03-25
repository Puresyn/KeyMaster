KM_Localization_zhTW = {}
local L = KM_Localization_zhTW

-- Localization file for "zhTW": 正體中文 (Taiwan)
-- Translated by: 三皈依

-- Translation issue? Assist us in correcting it! Visit: https://discord.gg/bbMaUpfgn8

L.LANGUAGE = "正體中文 (TW)"
L.TRANSLATOR = "三皈依" -- Translator display name

L.TOCNOTES = {}
L.TOCNOTES["ADDONDESC"] = "傳奇+鑰石資訊以及協同工具"
L.TOCNOTES["ADDONNAME"] = "Key Master"

L.MAPNAMES = {}
L.MAPNAMES[9001] = { name = "未知", abbr = "???" }
L.MAPNAMES[463] = { name = "Dawn of the Infinite: Galakrond\'s Fall", abbr = "殞落"}
L.MAPNAMES[464] = { name = "Dawn of the Infinite: Murozond\'s Rise", abbr = "崛起"}
L.MAPNAMES[244] = { name = "Atal'Dazar", abbr = "阿塔" }
L.MAPNAMES[248] = { name = "Waycrest Manor", abbr = "莊園" }
L.MAPNAMES[199] = { name = "Black Rook Hold", abbr = "玄鴉" }
L.MAPNAMES[198] = { name = "Darkheart Thicket", abbr = "暗心" }
L.MAPNAMES[168] = { name = "The Everbloom", abbr = "永茂" }
L.MAPNAMES[456] = { name = "Throne of the Tides", abbr = "海潮" }

L.XPAC = {}
L.XPAC[0] = { enum = "LE_EXPANSION_CLASSIC", desc = "經典版" }
L.XPAC[1] = { enum = "LE_EXPANSION_BURNING_CRUSADE", desc = "燃燒的遠征" }
L.XPAC[2] = { enum = "LE_EXPANSION_WRATH_OF_THE_LICH_KING", desc = "巫妖王之怒" }
L.XPAC[3] = { enum = "LE_EXPANSION_CATACLYSM", desc = "浩劫與重生" }
L.XPAC[4] = { enum = "LE_EXPANSION_MISTS_OF_PANDARIA", desc = "潘達利亞的迷霧" }
L.XPAC[5] = { enum = "LE_EXPANSION_WARLORDS_OF_DRAENOR", desc = "德拉諾之霸" }
L.XPAC[6] = { enum = "LE_EXPANSION_LEGION", desc = "軍臨天下" }
L.XPAC[7] = { enum = "LE_EXPANSION_BATTLE_FOR_AZEROTH", desc = "決戰艾澤拉斯" }
L.XPAC[8] = { enum = "LE_EXPANSION_SHADOWLANDS", desc = "暗影之境" }
L.XPAC[9] = { enum = "LE_EXPANSION_DRAGONFLIGHT", desc = "巨龍崛起" }
L.XPAC[10] = { enum = "LE_EXPANSION_11_0", desc = "地心之戰" } -- enum will need updated when available

L.MPLUSSEASON = {}
L.MPLUSSEASON[11] = { name = "第3賽季" }
L.MPLUSSEASON[12] = { name = "第4賽季" }
L.MPLUSSEASON[13] = { name = "第1賽季" } -- expecting season 13 to be TWW S1
L.MPLUSSEASON[14] = { name = "第2賽季" } -- expecting season 14 to be TWW S2

L.ADDONNAME = "Key Master" -- do not translate
L.DISPLAYVERSION = "版本"
L.WELCOMEMESSAGE = "歡迎回來"
L.ON = "開"
L.OFF = "關"
L.ENABLED = "啟用"
L.DISABLED = "停用"
L.CLICK = "點擊"
L.CLICKDRAG = "點擊 + 拖拉"
L.TOOPEN = "來開啟"
L.TOREPOSITION = "來重新定位"
L.EXCLIMATIONPOINT = "!"
L.THISWEEKSAFFIXES = "本週..."
L.YOURRATING = "你的評分"
L.ERRORMESSAGES = "錯誤訊息為"
L.ERRORMESSAGESNOTIFY = "通知: 啟用錯誤訊息。"
L.DEBUGMESSAGES = "偵錯訊息為"
L.DEBUGMESSAGESNOTIFY = "通知: 啟用偵錯訊息。"
L.COMMANDERROR1 = "無效指令"
L.COMMANDERROR2 = "輸入"
L.COMMANDERROR3 = "指令"
L.YOURCURRENTKEY = "YOUR KEY"
L.ADDONOUTOFDATE = "你的 Key Master 插件已經過期！"
L.INSTANCETIMER = "副本訊息"
L.VAULTINFORMATION = "傳奇+ 寶庫進度"
L.TIMELIMIT = "時間限制"
L.SEASON = "賽季"

L.COMMANDLINE = {}
L.COMMANDLINE["/km"] = { name = "/km", text = "/km"} -- Do not translate
L.COMMANDLINE["/keymaster"] = {name = "/keymaster", text = "/keymaster"} -- Do not translate
L.COMMANDLINE["Show"] = { name = "show", text = " - 顯示/隱藏主視窗。"}
L.COMMANDLINE["Help"] = { name = "help", text = " - 顯示幫助選單。"}
L.COMMANDLINE["Errors"] = { name = "errors", text = " - 切換錯誤訊息。"}
L.COMMANDLINE["Debug"] = { name = "debug", text = " - 切換偵錯訊息。"}

L.TOOLTIPS = {}
L.TOOLTIPS["MythicRating"] = { name = "傳奇評分", text = "此為角色當前的傳奇+評分。" }
L.TOOLTIPS["OverallScore"] = { name = "總體分數", text = "總分是地圖的暴君和強悍分數的結合。（涉及大量計算）"}
L.TOOLTIPS["TeamRatingGain"] = { name = "估計隊伍評分收穫", text = "這是Key Master內部進行的估計。 該數字代表成功完成隊伍給予的鑰石時，您當前隊伍的總最低評分收益潛力。它可能不是100％準確的，並且僅出於估計目的。"}

L.PARTYFRAME = {}
L.PARTYFRAME["PartyInformation"] = { name = "隊伍資訊", text = "隊伍資訊"}
L.PARTYFRAME["OverallRating"] = { name = "當前總分", text = "當前總分" }
L.PARTYFRAME["PartyPointGain"] = { name = "隊伍獲得分數", text = "隊伍獲得分數"}
L.PARTYFRAME["Level"] = { name = "層級", text = "層級" }
L.PARTYFRAME["Weekly"] = { name = "每週", text = "每週"}
L.PARTYFRAME["NoAddon"] = { name = "沒偵測到插件", text = "未偵測到！"}
L.PARTYFRAME["PlayerOffline"] = { name = "玩家離線", text = "玩家已離線。"}
L.PARTYFRAME["TeamRatingGain"] = { name = "隊伍收益預估", text = "預估隊伍評分收益"}
L.PARTYFRAME["MemberPointsGain"] = { name = "收益預估", text = "預估個人分數收益，當完成 +1 的可用鑰石時。"}
L.PARTYFRAME["NoKey"] = { name = "無鑰石", text = "無鑰石"}

L.PLAYERFRAME = {}
L.PLAYERFRAME["KeyLevel"] = { name = "鑰石層級", text = "要計算的鑰石層級。"}
L.PLAYERFRAME["Gain"] = { name = "收益", text = "潛在的評分收益。"}
L.PLAYERFRAME["New"] = { name = "新", text = "你完成此鑰石+1後的評分。"}
L.PLAYERFRAME["RatingCalculator"] = { name = "評分計算", text = "計算潛在評分收益。"}
L.PLAYERFRAME["EnterKeyLevel"] = { name = "輸入鑰石層數", text = "輸入一個鑰石層數來觀看"}
L.PLAYERFRAME["YourBaseRating"] = { name = "基礎評分收益", text = "你的基礎評分收益預測。"}

L.CHARACTERINFO = {}
L.CHARACTERINFO["NoKeyFound"] = { name = "未找到鑰石", text = "未找到鑰石"}
L.CHARACTERINFO["KeyInVault"] = { name = "鑰石在寶庫", text = "在寶庫"}
L.CHARACTERINFO["AskMerchant"] = { name = "詢問鑰石商人", text = "鑰石商人"}

L.TABPLAYER = "玩家"
L.TABPARTY = "隊伍"
L.TABABOUT = "關於"
L.TABCONFIG = "配置"

L.CONFIGURATIONFRAME = {}
L.CONFIGURATIONFRAME["DisplaySettings"] = { name = "顯示設定", text = "顯示設定"}
L.CONFIGURATIONFRAME["ToggleRatingFloat"] = { name = "切換評分小數點", text = "顯示評分小數點。"}
L.CONFIGURATIONFRAME["ShowMiniMapButton"] = { name = "顯示小地圖按鈕", text = "顯示小地圖按鈕。"}
L.CONFIGURATIONFRAME["DiagnosticSettings"] = { name = "診斷設定", text = "診斷設定。"}
L.CONFIGURATIONFRAME["DisplayErrorMessages"] = { name = "顯示錯誤", text = "顯示錯誤訊息。"}
L.CONFIGURATIONFRAME["DisplayDebugMessages"] = { name = "顯示偵錯", text = "顯示偵錯訊息。"}
L.CONFIGURATIONFRAME["DiagnosticsAdvanced"] = { name = "進階診斷", text="注意: 這些僅用於診斷目的。 如果啟用，他們可能會洗您的聊天視窗！"}

L.ABOUTFRAME = {}
L.ABOUTFRAME["AboutGeneral"] = { name = "Key Master 資訊", text = "Key Master 資訊"}
L.ABOUTFRAME["AboutAuthors"] = { name = "作者", text = "作者"}
L.ABOUTFRAME["AboutSpecialThanks"] = { name = "特別感謝", text = "特別感謝"}
L.ABOUTFRAME["AboutContributors"] = { name = "貢獻者", text = "貢獻者"}