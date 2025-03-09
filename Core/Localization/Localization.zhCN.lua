KM_Localization_zhCN = {}
local L = KM_Localization_zhCN

-- Localization file for "zhCN": 简体中文
-- Translated by: 姜铁憨, gjfLeo

--[[Notes for Translators: In many locations throughout Key Master, line space is limited. This can cause
    overlapping or strange text display. Where possible, try to keep the overall length of the string comparable or shorter
    than the English version. If that is not possible, development adjustments may need made.
    If you are not comfortable setting up your own local testing to check for these issues, make sure you let a dev know
    so they can go over a screen-share with you.]]--

-- Translation issue? Assist us in correcting it! Visit: https://discord.gg/bbMaUpfgn8

L.LANGUAGE = "简体中文 (CN)"
L.TRANSLATOR = "姜铁憨" -- Translator display name

L.TOCNOTES = {} -- these are manaually copied to the TOC so they show up in the appropriate language in the AddOns list. Please translate them both but let a dev know if you update them later.
L.TOCNOTES["ADDONDESC"] = "大秘境钥石信息与合作工具"
L.TOCNOTES["ADDONNAME"] = "钥石大师"

L.MAPNAMES = {} -- Note: Map abbrevations should be a max of 4 characters and be commonly known. Map names come directly from Blizzard already translated.
-- DF S3
L.MAPNAMES[9001] = { name = "Unknown", abbr = "???" }
L.MAPNAMES[463] = { name = "Dawn of the Infinite: Galakrond\'s Fall", abbr = "陨落"}
L.MAPNAMES[464] = { name = "Dawn of the Infinite: Murozond\'s Rise", abbr = "崛起"}
L.MAPNAMES[244] = { name = "Atal'Dazar", abbr = "阿塔" }
L.MAPNAMES[248] = { name = "Waycrest Manor", abbr = "庄园" }
L.MAPNAMES[199] = { name = "Black Rook Hold", abbr = "黑鸦" }
L.MAPNAMES[198] = { name = "Darkheart Thicket", abbr = "黑心" }
L.MAPNAMES[168] = { name = "The Everbloom", abbr = "永茂" }
L.MAPNAMES[456] = { name = "Throne of the Tides", abbr = "潮汐" }
--DF S4
L.MAPNAMES[399] = { name = "Ruby Life Pools", abbr = "红玉" }
L.MAPNAMES[401] = { name = "The Azue Vault", abbr = "碧蓝" }
L.MAPNAMES[400] = { name = "The Nokhud Offensive", abbr = "诺库德" }
L.MAPNAMES[402] = { name = "Algeth\'ar Academy", abbr = "学院" }
L.MAPNAMES[403] = { name = "Legacy of Tyr", abbr = "奥达曼" }
L.MAPNAMES[404] = { name = "Neltharus", abbr = "奈萨" }
L.MAPNAMES[405] = { name = "Brackenhide Hollow", abbr = "蕨皮" }
L.MAPNAMES[406] = { name = "Halls of Infusion", abbr = "注能" }
--TWW S1
L.MAPNAMES[503] = { name = "Ara-Kara, City of Echoes", abbr = "回响" }
L.MAPNAMES[502] = { name = "City of Threads", abbr = "千丝" }
L.MAPNAMES[505] = { name = "The Dawnbreaker", abbr = "破晨" }
L.MAPNAMES[501] = { name = "The Stonevault", abbr = "矶石" }
L.MAPNAMES[353] = { name = "Siege of Boralus", abbr = "围攻" }
L.MAPNAMES[507] = { name = "The Grim Batol", abbr = "格瑞" }
L.MAPNAMES[375] = { name = "Mists of Tirna Scithe", abbr = "仙林" }
L.MAPNAMES[376] = { name = "The Necrotic Wake", abbr = "通灵" }
--TWW S2
L.MAPNAMES[500] = { name = "The Rookery", abbr = "驭雷" }
L.MAPNAMES[525] = { name = "Floodgate", abbr = "水闸" }
L.MAPNAMES[247] = { name = "The MOTHERLODE!!", abbr = "暴富" }
L.MAPNAMES[370] = { name = "Mechagon - Workshop", abbr = "麦卡贡" }
L.MAPNAMES[504] = { name = "Darkflame Cleft", abbr = "暗焰" }
L.MAPNAMES[382] = { name = "Theater of Pain", abbr = "剧场" }
L.MAPNAMES[506] = { name = "Cinderbrew Meadery", abbr = "酒庄" }
L.MAPNAMES[499] = { name = "Priory of the Sacred Flame", abbr = "圣焰" }

L.XPAC = {}
L.XPAC[0] = { enum = "LE_EXPANSION_CLASSIC", desc = "经典旧世" }
L.XPAC[1] = { enum = "LE_EXPANSION_BURNING_CRUSADE", desc = "燃烧的远征" }
L.XPAC[2] = { enum = "LE_EXPANSION_WRATH_OF_THE_LICH_KING", desc = "巫妖王之怒" }
L.XPAC[3] = { enum = "LE_EXPANSION_CATACLYSM", desc = "大地的裂变" }
L.XPAC[4] = { enum = "LE_EXPANSION_MISTS_OF_PANDARIA", desc = "熊猫人之谜" }
L.XPAC[5] = { enum = "LE_EXPANSION_WARLORDS_OF_DRAENOR", desc = "德拉诺之王" }
L.XPAC[6] = { enum = "LE_EXPANSION_LEGION", desc = "军团再临" }
L.XPAC[7] = { enum = "LE_EXPANSION_BATTLE_FOR_AZEROTH", desc = "争霸艾泽拉斯" }
L.XPAC[8] = { enum = "LE_EXPANSION_SHADOWLANDS", desc = "暗影国度" }
L.XPAC[9] = { enum = "LE_EXPANSION_DRAGONFLIGHT", desc = "巨龙时代" }
L.XPAC[10] = { enum = "LE_EXPANSION_WAR_WITHIN", desc = "地心之战" }

L.MPLUSSEASON = {}
L.MPLUSSEASON[11] = { name = "第三赛季" }
L.MPLUSSEASON[12] = { name = "第四赛季" }
L.MPLUSSEASON[13] = { name = "第一赛季" } -- expecting season 13 to be TWW S1
L.MPLUSSEASON[14] = { name = "第二赛季" } -- expecting season 14 to be TWW S2

L.DISPLAYVERSION = "版本"
L.WELCOMEMESSAGE = "欢迎回来"
L.ON = "开"
L.OFF = "关"
L.ENABLED = "启用"
L.DISABLED = "停用"
L.CLICK = "点击"
L.CLICKDRAG = "点击 + 拖动"
L.TOOPEN = "来开启"
L.TOREPOSITION = "来移动位置"
L.EXCLIMATIONPOINT = "!"
L.THISWEEKSAFFIXES = "本周词缀"
L.YOURRATING = "你的分数"
L.ERRORMESSAGES = "错误提示为"
L.ERRORMESSAGESNOTIFY = "通知：错误提示已启用。"
L.DEBUGMESSAGES = "调试信息为"
L.DEBUGMESSAGESNOTIFY = "通知：调试信息已启用。"
L.COMMANDERROR1 = "无效指令"
L.COMMANDERROR2 = "输入"
L.COMMANDERROR3 = "指令"
L.YOURCURRENTKEY = "你的钥匙"
L.ADDONOUTOFDATE = "你的钥石大师插件已过期！"
L.INSTANCETIMER = "地城信息"
L.VAULTINFORMATION = "大秘境宝库进度"
L.TIMELIMIT = "时间限制"
L.SEASON = "赛季"
L.COMBATMESSAGE = { errormsg = "无法在战斗中使用钥石大师。", chatmsg = "界面将在你离开战斗后开启。"}

L.COMMANDLINE = {} -- translate whatever in this section would be standard of an addon in the language. i.e. /km show, /km XXXX, or /XX XXXX It will work just fine.
L.COMMANDLINE["/km"] = { name = "/km", text = "/km"}
L.COMMANDLINE["/keymaster"] = {name = "/keymaster", text = "/keymaster"}
L.COMMANDLINE["Show"] = { name = "show", text = " - 显示/隐藏主窗口。"}
L.COMMANDLINE["Help"] = { name = "help", text = " - 显示帮助菜单。"}
L.COMMANDLINE["Errors"] = { name = "errors", text = " - 切换错误提示。"}
L.COMMANDLINE["Debug"] = { name = "debug", text = " - 切换调试信息。"}
L.COMMANDLINE["Version"] = { name = "version", text = " - 显示当前版本。" }

L.TOOLTIPS = {}
L.TOOLTIPS["MythicRating"] = { name = "大秘境分数", text = "这是角色当前的大秘境分数。" }
L.TOOLTIPS["OverallScore"] = { name = "总分", text = "总分是一个地图的残暴和强韧分数的组合。（涉及大量的运算）"}
L.TOOLTIPS["TeamRatingGain"] = { name = "预估小队分数收益", text = "这是钥石大师进行的内部估算，此数代表你当前的小队顺利完成此小队钥石时，可能获得的总最低分数收益。它可能不是100%准确的，在此仅用作参考。"}

L.PARTYFRAME = {}
L.PARTYFRAME["PartyInformation"] = { name = "小队信息", text = "小队信息"}
L.PARTYFRAME["OverallRating"] = { name = "当前总分", text = "当前总分" }
L.PARTYFRAME["PartyPointGain"] = { name = "小队分数收益", text = "小队分数收益"}
L.PARTYFRAME["Level"] = { name = "层", text = "层" }
L.PARTYFRAME["Weekly"] = { name = "每周", text = "每周"}
L.PARTYFRAME["NoAddon"] = { name = "未发现插件", text = "未发现！"}
L.PARTYFRAME["PlayerOffline"] = { name = "玩家离线", text = "玩家已离线。"}
L.PARTYFRAME["TeamRatingGain"] = { name = "小队收益预估", text = "潜在的小队分数收益"}
L.PARTYFRAME["MemberPointsGain"] = { name = "收益预估", text = "当完成可用钥石 +1 时的潜在的个人分数收益。"}
L.PARTYFRAME["NoKey"] = { name = "无钥石", text = "无钥石"}
L.PARTYFRAME["NoPartyInfo"] = { text = "在匹配队伍时队伍成员信息不可用。（如地下城查找器， 团队副本查找器，等等。）" }

L.PLAYERFRAME = {}
L.PLAYERFRAME["KeyLevel"] = { name = "钥石等级", text = "用于计算的钥石等级。"}
L.PLAYERFRAME["Gain"] = { name = "收益", text = "潜在的分数收益。"}
L.PLAYERFRAME["New"] = { name = "新", text = "完成此钥石+1后你的分数。"}
L.PLAYERFRAME["RatingCalculator"] = { name = "分数计算器", text = "计算潜在的分数收益。"}
L.PLAYERFRAME["EnterKeyLevel"] = { name = "输入钥石等级", text = "输入一个钥石等级来查看"}
L.PLAYERFRAME["YourBaseRating"] = { name = "基本分数收益", text = "你的基础分数收益预测。"}
L.PLAYERFRAME["Characters"] = "角色"
L.PLAYERFRAME["DungeonTools"] = { name = "Dungeon Tools", text = "Various tools related to this dungeon."}

L.CHARACTERINFO = {}
L.CHARACTERINFO["NoKeyFound"] = { name = "未找到钥石", text = "未找到钥石"}
L.CHARACTERINFO["KeyInVault"] = { name = "钥石在宝库中", text = "在宝库中"}
L.CHARACTERINFO["AskMerchant"] = { name = "询问钥石商人", text = "钥石商人"}

L.TABPLAYER = "玩家"
L.TABPARTY = "小队"
L.TABABOUT = "关于"
L.TABCONFIG = "配置"

L.CONFIGURATIONFRAME = {}
L.CONFIGURATIONFRAME["DisplaySettings"] = { name = "显示设置", text = "显示设置"}
L.CONFIGURATIONFRAME["ToggleRatingFloat"] = { name = "切换小数分数", text = "显示小数分数。"}
L.CONFIGURATIONFRAME["ShowMiniMapButton"] = { name = "显示小地图图标", text = "显示小地图图标。"}
L.CONFIGURATIONFRAME["DiagnosticSettings"] = { name = "诊断设置", text = "诊断设置。"}
L.CONFIGURATIONFRAME["DisplayErrorMessages"] = { name = "显示错误", text = "显示错误提示。"}
L.CONFIGURATIONFRAME["DisplayDebugMessages"] = { name = "显示调试", text = "显示调试信息。"}
L.CONFIGURATIONFRAME["DiagnosticsAdvanced"] = { name = "高级诊断", text="注意：这些仅用于诊断目的。启用可能导致聊天窗被刷屏！"}
L.CONFIGURATIONFRAME["CharacterSettings"] = { name="角色列表过滤", text = "分身角色列表过滤选项。" }
L.CONFIGURATIONFRAME["FilterByServer"] = { name = "当前服务器", text = "只显示当前服务器。" }
L.CONFIGURATIONFRAME["FilterByNoRating"] = { name = "无分数", text = "只显示有分数的角色。" }
L.CONFIGURATIONFRAME["FilterByNoKey"] = { name = "无钥石", text = "只显示有钥石的角色。" }
L.CONFIGURATIONFRAME["FilterByMaxLvl"] = { name = "满级", text = "只显示达到最高等级的角色。" }
L.CONFIGURATIONFRAME["Purge"] = { present = "清空", past = "已清空" }

L.ABOUTFRAME = {}
L.ABOUTFRAME["AboutGeneral"] = { name = "钥石大师信息", text = "钥石大师信息"}
L.ABOUTFRAME["AboutAuthors"] = { name = "作者", text = "作者"}
L.ABOUTFRAME["AboutSpecialThanks"] = { name = "特别鸣谢", text = "特别鸣谢"}
L.ABOUTFRAME["AboutContributors"] = { name = "贡献者", text = "贡献者"}
L.ABOUTFRAME["Translators"] = { text = "译者" }
L.ABOUTFRAME["WhatsNew"] = { text = "显示更新内容"}

L.SYSTEMMESSAGE = {}
L.SYSTEMMESSAGE["NOTICE"] = { text = "注意：本赛季的分数计算仍在验证中。"}