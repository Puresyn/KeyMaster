KM_Localization_koKR = {}
local L = KM_Localization_koKR

-- Localization file for "koKR": Korean (Korea)
-- Translated by: 와우하는아저씨

--[[Notes for Translators: In many locations throughout Key Master, line space is limited. This can cause
    overlapping or strange text display. Where possible, try to keep the overall length of the string comparable or shorter
    than the English version. If that is not possible, development adjustments may need made.
    If you are not comfortable setting up your own local testing to check for these issues, make sure you let a dev know
    so they can go over a screen-share with you.]]--

-- Translation issue? Assist us in correcting it! Visit: https://discord.gg/bbMaUpfgn8

L.LANGUAGE = "한국어 (KR)"
L.TRANSLATOR = "Key Master" -- Translator display name

L.TOCNOTES = {} -- these are manaually copied to the TOC so they show up in the appropriate language in the AddOns list. Please translate them both but let a dev know if you update them later.
L.TOCNOTES["ADDONDESC"] = "쐐기돌 정보"
L.TOCNOTES["ADDONNAME"] = "Key Master"

L.MAPNAMES = {} -- Note: Map abbrevations should be a max of 4 characters and be commonly known. Map names come directly from Blizzard already translated.
-- DF S3
L.MAPNAMES[9001] = { name = "알수없음", abbr = "???" }
L.MAPNAMES[463] = { name = "무한의 여명: 갈라크론드의 몰락", abbr = "목락"}
L.MAPNAMES[464] = { name = "무한의 여명: 무르도즈노의 현신", abbr = "현신"}
L.MAPNAMES[244] = { name = "아탈다자르", abbr = "아탈" }
L.MAPNAMES[248] = { name = "웨이크레스트 저택", abbr = "저택" }
L.MAPNAMES[199] = { name = "검은 떼까마귀 요새", abbr = "검떼" }
L.MAPNAMES[198] = { name = "어둠심장 숲", abbr = "어심" }
L.MAPNAMES[168] = { name = "상록숲", abbr = "상록숲" }
L.MAPNAMES[456] = { name = "파도의 왕좌", abbr = "파도" }
--DF S4
L.MAPNAMES[399] = { name = "루비 생명의 웅덩이", abbr = "루비" }
L.MAPNAMES[401] = { name = "하늘빛 보관소", abbr = "하늘빛" }
L.MAPNAMES[400] = { name = "노쿠드 공격대", abbr = "노쿠드" }
L.MAPNAMES[402] = { name = "알게타르 대학", abbr = "대학" }
L.MAPNAMES[403] = { name = "울다만: 티르의 유산", abbr = "울다만" }
L.MAPNAMES[404] = { name = "넬타루스", abbr = "넬타" }
L.MAPNAMES[405] = { name = "담쟁이가죽 골짜기", abbr = "담쟁이" }
L.MAPNAMES[406] = { name = "주입의 전당", abbr = "주입" }
--TWW S1
L.MAPNAMES[503] = { name = "메아리의 도시 아라카라", abbr = "메아리" }
L.MAPNAMES[502] = { name = "실타래의 도시", abbr = "실타래" }
L.MAPNAMES[505] = { name = "새벽인도자호", abbr = "새벽" }
L.MAPNAMES[501] = { name = "바위 금고", abbr = "바위" }
L.MAPNAMES[353] = { name = "보랄러스 공성전", abbr = "보랄러스" }
L.MAPNAMES[507] = { name = "그림바톨", abbr = "그림" }
L.MAPNAMES[375] = { name = "티르너 사이드의 안개", abbr = "티르너" }
L.MAPNAMES[376] = { name = "죽음의 상흔", abbr = "죽상" }

L.XPAC = {}
L.XPAC[0] = { enum = "LE_EXPANSION_CLASSIC", desc = "클래식" }
L.XPAC[1] = { enum = "LE_EXPANSION_BURNING_CRUSADE", desc = "불타는 성전" }
L.XPAC[2] = { enum = "LE_EXPANSION_WRATH_OF_THE_LICH_KING", desc = "리치왕의 분노" }
L.XPAC[3] = { enum = "LE_EXPANSION_CATACLYSM", desc = "대격변" }
L.XPAC[4] = { enum = "LE_EXPANSION_MISTS_OF_PANDARIA", desc = "판다리아의 안개" }
L.XPAC[5] = { enum = "LE_EXPANSION_WARLORDS_OF_DRAENOR", desc = "드레노어의 전쟁군주" }
L.XPAC[6] = { enum = "LE_EXPANSION_LEGION", desc = "군단" }
L.XPAC[7] = { enum = "LE_EXPANSION_BATTLE_FOR_AZEROTH", desc = "격전의 아제로스" }
L.XPAC[8] = { enum = "LE_EXPANSION_SHADOWLANDS", desc = "어둠땅" }
L.XPAC[9] = { enum = "LE_EXPANSION_DRAGONFLIGHT", desc = "용군단" }
L.XPAC[10] = { enum = "LE_EXPANSION_WAR_WITHIN", desc = "내부 전쟁" }

L.MPLUSSEASON = {}
L.MPLUSSEASON[11] = { name = "시즌 3" }
L.MPLUSSEASON[12] = { name = "시즌 4" }
L.MPLUSSEASON[13] = { name = "시즌 1" } -- expecting season 13 to be TWW S1
L.MPLUSSEASON[14] = { name = "시즌 2" } -- expecting season 14 to be TWW S2

L.DISPLAYVERSION = "버전"
L.WELCOMEMESSAGE = "돌아오신걸 환영합니다."
L.ON = "켜짐"
L.OFF = "꺼짐"
L.ENABLED = "활성화"
L.DISABLED = "비활성화"
L.CLICK = "클릭"
L.CLICKDRAG = "클릭 + 드래그"
L.TOOPEN = "하여 설정창 열기"
L.TOREPOSITION = "하여 위치 이동"
L.EXCLIMATIONPOINT = "!"
L.THISWEEKSAFFIXES = "이번주..."
L.YOURRATING = "당신의 점수"
L.ERRORMESSAGES = "오류 메세지는 다음과 같습니다."
L.ERRORMESSAGESNOTIFY = "알림: 오류메시지 활성화."
L.DEBUGMESSAGES = "디버깅 메세지는 다음과 같습니다."
L.DEBUGMESSAGESNOTIFY = "알림: 오류메시지 비활성화."
L.COMMANDERROR1 = "잘못된 명령"
L.COMMANDERROR2 = "입력"
L.COMMANDERROR3 = "명령"
L.YOURCURRENTKEY = "쐐기돌 보유"
L.ADDONOUTOFDATE = "Key Master 플러그인이 만료 되었습니다!"
L.INSTANCETIMER = "던전 정보"
L.VAULTINFORMATION = "쐐기 주간보상(금고)"
L.TIMELIMIT = "제한 시간"
L.SEASON = "시즌"
L.COMBATMESSAGE = { errormsg = "Key Master는 전투 중 사용할 수 없습니다.", chatmsg = "Key Master는 전투 중 사용할 수 없습니다." }

L.COMMANDLINE = {} -- translate whatever in this section would be standard of an addon in the language. i.e. /km show, /km XXXX, or /XX XXXX It will work just fine.
L.COMMANDLINE["/km"] = { name = "/km", text = "/km"}
L.COMMANDLINE["/keymaster"] = {name = "/keymaster", text = "/keymaster"}
L.COMMANDLINE["Show"] = { name = "show", text = " - 메인창 표시/숨기기"}
L.COMMANDLINE["Help"] = { name = "help", text = " - 도움말 메뉴를 표시합니다."}
L.COMMANDLINE["Errors"] = { name = "errors", text = " - 오류 메세지 전환."}
L.COMMANDLINE["Debug"] = { name = "debug", text = " - 디버그 메세지 전환."}
L.COMMANDLINE["Version"] = { name = "version", text = " - 현재 빌드 버전을 표시합니다." }

L.TOOLTIPS = {}
L.TOOLTIPS["MythicRating"] = { name = "쐐기 점수", text = "캐릭터의 현재 쐐기 점수입니다.." }
L.TOOLTIPS["OverallScore"] = { name = "전체 점수", text = "전체 점수는 쐐기의 폭군/경화 점수 합계입니다. (복잡한 계산식 포함)"}
L.TOOLTIPS["TeamRatingGain"] = { name = "파티 예상 점수", text = "이것은 Key Master 내부적으로 예상하는 추정치입니다. 이 수치는 현재 파티의 최소 점수 획득 가능성을 나타냅니다. 100% 정확하지 않을 수 있으며, 추정 목적으로만 제공됩니다"}

L.PARTYFRAME = {}
L.PARTYFRAME["PartyInformation"] = { name = "파티 정보", text = "파티 정보"}
L.PARTYFRAME["OverallRating"] = { name = "전체 점수", text = "전체 점수" }
L.PARTYFRAME["PartyPointGain"] = { name = "파티 점수 획득", text = "파티 점수 획득"}
L.PARTYFRAME["Level"] = { name = "레벨", text = "레벨" }
L.PARTYFRAME["Weekly"] = { name = "주간", text = "주간"}
L.PARTYFRAME["NoAddon"] = { name = "애드온이 감지되지 않습니다!", text = "애드온이 감지되지 않습니다!"}
L.PARTYFRAME["PlayerOffline"] = { name = "플레이어 오프라인", text = "플레이어 오프라인"}
L.PARTYFRAME["TeamRatingGain"] = { name = "파티 예상 점수", text = "예상되는 파티 점수"}
L.PARTYFRAME["MemberPointsGain"] = { name = "예상 점수", text = "+1상 달성시 개인 획득 점수를 예상합니다. "}
L.PARTYFRAME["NoKey"] = { name = "쐐기돌 없음", text = "쐐기돌 없음"}
L.PARTYFRAME["NoPartyInfo"] = { text = "팀 구성원 정보는 파티찾기 창에서 구성된 파티에서는 사용할 수 없습니다. (던전 찾기, 공격대 찾기등)" }

L.PLAYERFRAME = {}
L.PLAYERFRAME["KeyLevel"] = { name = "쐐기돌 레벨", text = "사용될 쐐기돌 레벨입니다."}
L.PLAYERFRAME["Gain"] = { name = "획득", text = "추가 예상 점수."}
L.PLAYERFRAME["New"] = { name = "New", text = "+1상 완료 후의 점수"}
L.PLAYERFRAME["RatingCalculator"] = { name = "점수 계산기", text = "추가되는 점수를 예상할 수 있습니다."}
L.PLAYERFRAME["EnterKeyLevel"] = { name = "쐐기돌 레벨 입력", text = "쐐기돌 레벨을 입력해서 보기"}
L.PLAYERFRAME["YourBaseRating"] = { name = "기본 획득 점수", text = "기본 획득 점수를 예상합니다."}
L.PLAYERFRAME["Characters"] = "캐릭터"

L.CHARACTERINFO = {}
L.CHARACTERINFO["NoKeyFound"] = { name = "쐐기돌을 찾을 수 없음", text = "쐐기돌을 찾을 수 없음"}
L.CHARACTERINFO["KeyInVault"] = { name = "쐐기돌은 금고에 있습니다.", text = "금고 안에 있음"}
L.CHARACTERINFO["AskMerchant"] = { name = "쐐기돌 상인에게 문의", text = "쐐기돌 상인"}

L.TABPLAYER = "플레이어"
L.TABPARTY = "파티"
L.TABABOUT = "정보"
L.TABCONFIG = "설정"

L.CONFIGURATIONFRAME = {}
L.CONFIGURATIONFRAME["DisplaySettings"] = { name = "디스플레이 설정", text = "디스플레이 설정"}
L.CONFIGURATIONFRAME["ToggleRatingFloat"] = { name = "소수점 표시", text = "소수점 표시."}
L.CONFIGURATIONFRAME["ShowMiniMapButton"] = { name = "미니맵 버튼 표시", text = "미니맵 버튼 표시"}
L.CONFIGURATIONFRAME["DiagnosticSettings"] = { name = "진단 설정", text = "진단 설정."}
L.CONFIGURATIONFRAME["DisplayErrorMessages"] = { name = "오류 표시", text = "에러 메세지를 표시 합니다."}
L.CONFIGURATIONFRAME["DisplayDebugMessages"] = { name = "디버그 표시", text = "디버깅 메세지를 표시 합니다."}
L.CONFIGURATIONFRAME["DiagnosticsAdvanced"] = { name = "고급 진단", text="참고: 이것은 진단 목적으로만 사용되며, 활성화된 경우 대화창이 가득 찰 수 있습니다."}
L.CONFIGURATIONFRAME["CharacterSettings"] = { name="캐릭터 목록 필터", text = "캐릭터 목록 필터 옵션" }
L.CONFIGURATIONFRAME["FilterByServer"] = { name = "현재 서버", text = "현재 서버만 표시합니다.." }
L.CONFIGURATIONFRAME["FilterByNoRating"] = { name = "점수 없음", text = "점수가 있는 캐릭터만 표시합니다." }
L.CONFIGURATIONFRAME["FilterByNoKey"] = { name = "쐐기돌 없음", text = "쐐기돌이 있는 캐릭터만 표시 합니다." }
L.CONFIGURATIONFRAME["Purge"] = { present = "제거", past = "제거됨" }

L.ABOUTFRAME = {}
L.ABOUTFRAME["AboutGeneral"] = { name = "Key Master 정보", text = "Key Master 정보"}
L.ABOUTFRAME["AboutAuthors"] = { name = "제작자", text = "제작자"}
L.ABOUTFRAME["AboutSpecialThanks"] = { name = "특별히 고마운 분들", text = "특별히 고마운 분들"}
L.ABOUTFRAME["AboutContributors"] = { name = "도움 주신분들", text = "도움 주신 분들"}
L.ABOUTFRAME["Translators"] = { text = "번역" }
L.ABOUTFRAME["WhatsNew"] = { text = "업데이트 내용 보기"}

L.SYSTEMMESSAGE = {}
L.SYSTEMMESSAGE["NOTICE"] = { text = "참고: 이번 시즌 점수 계산은 아직 검증 중입니다."}