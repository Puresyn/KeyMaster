KeyMasterLocals = {}
local L = KeyMasterLocals

SLASH_KeyMaster1 = "/km"
SLASH_KeyMaster2 = "/keymaster"

L.ADDONNAME = "Key Master"
L.BUILDRELEASE = "release"
L.BUILDBETA = "beta"
L.BUILDALPHA = "alpha"
L.WELCOMEMESSAGE = "Welcome back"
L.EXCLIMATIONPOINT = "!"

L.COMMANDLINE = {}
L.COMMANDLINE["/km"] = { name = "/km", text = "/km"}
L.COMMANDLINE["Show"] = { name = "show", text = " - shows the main window."}
L.COMMANDLINE["Help"] = { name = "help", text = " - shows this help menu."}

L.TOOLTIPS = {}
L.TOOLTIPS["MythicRating"] = { name = "Mythic Rating", text = "This is the chacacter's current Mythic Plus rating." }
L.TOOLTIPS["OverallScore"] = { name = "Overall Score", text = "The overall score is a combination of both Tyrannical and Fortified run scores for a map. (With lots of math involved)"}

L.PARTYFRAME = {}
L.PARTYFRAME["OverallScore"] = { name = "Overall Score", text = "Overall Score" }
L.PARTYFRAME["PartyPointGain"] = { name = "Party Point Gain", text = "Party Point Gain"}
L.PARTYFRAME["Level"] = { name = "Level", text = "Level" }
L.PARTYFRAME["Weekly"] = { name = "Weekly", text = "Weekly"}

L.MAPNAMES = {}
L.MAPNAMES[9001] = { name = "Unknown", abbr = "???" }
L.MAPNAMES[463] = { name = "Dawn of the Infinite: Galakrond\'s Fall", abbr = "FALL"}
L.MAPNAMES[464] = { name = "Dawn of the Infinite: Murozond\'s Rise", abbr = "RISE"}
L.MAPNAMES[244] = { name = "Atal'Dazar", abbr = "AD" }
L.MAPNAMES[248] = { name = "Waycrest Manor", abbr = "WCM" }
L.MAPNAMES[199] = { name = "Black Rook Hold", abbr = "BRH" }
L.MAPNAMES[198] = { name = "Darkheart Thicket", abbr = "DHT" }
L.MAPNAMES[168] = { name = "The Everbloom", abbr = "EB" }
L.MAPNAMES[456] = { name = "Throne of the Tides", abbr = "TotT" }

L.CHARACTERINFO = {}
L.CHARACTERINFO["KeyInVault"] = { name = "Key in Vault", text = "In Vault"}
L.CHARACTERINFO["AskMerchant"] = { name = "Ask Key Merchant", text = "Ask Key Merchant"}