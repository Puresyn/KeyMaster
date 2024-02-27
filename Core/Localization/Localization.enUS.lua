KeyMasterLocals = {}
local L = KeyMasterLocals

L.ADDONNAME = "Key Master"
L.BUILDRELEASE = "release"
L.BUILDBETA = "beta"
L.BUILDALPHA = "alpha"
L.WELCOMEMESSAGE = "Welcome back"
L.EXCLIMATIONPOINT = "!"
L.ASTERISK = "*"
L.THISWEEKSAFFIXES = "This Week..."
L.YOURRATING = "Your Rating"
L.TYRANNICAL = "Tyrannical"
L.FORTIFIED = "Fortified"
L.ERRORMESSAGES = "Error messages"
L.ERRORMESSAGESNOTIFY = "Notify: Error messages are on."
L.DEBUGMESSAGES = "Debug messages"
L.DEBUGMESSAGESNOTIFY = "Notify: Debug messages are on."
L.COMMANDERROR1 = "Invalid command"
L.COMMANDERROR2 = "Enter"
L.COMMANDERROR3 = "for commands"
L.YOURCURRENTKEY = "YOUR KEY"

L.COMMANDLINE = {}
L.COMMANDLINE["/km"] = { name = "/km", text = "/km"}
L.COMMANDLINE["/keymaster"] = {name = "/keymaster", text = "/keymaster"}
L.COMMANDLINE["Show"] = { name = "show", text = " - show/hide the main window."}
L.COMMANDLINE["Help"] = { name = "help", text = " - shows this help menu."}
L.COMMANDLINE["Errors"] = { name = "errors", text = " - toggle error messages."}
L.COMMANDLINE["Debug"] = { name = "debug", text = " - toggle debug messages."}

L.TOOLTIPS = {}
L.TOOLTIPS["MythicRating"] = { name = "Mythic Rating", text = "This is the chacacter's current Mythic Plus rating." }
L.TOOLTIPS["OverallScore"] = { name = "Overall Score", text = "The ovrall score is a combination of both Tyrannical and Fortified run scores for a map. (With lots of math involved)"}
L.TOOLTIPS["TeamRatingGain"] = { name = "Estimated Rating Gain", text = "This is an estimation that Key Master does internally. This number represents your current party\'s total minimum Rating gain potential for successfully completing the given party key. It may not be 100% accurate and is only here for estimation purposes."}

L.PARTYFRAME = {}
L.PARTYFRAME["PartyInformation"] = { name = "Party Information", text = "Party Information"}
L.PARTYFRAME["OverallRating"] = { name = "Overall Rating", text = "Overall Rating" }
L.PARTYFRAME["PartyPointGain"] = { name = "Party Point Gain", text = "Party Point Gain"}
L.PARTYFRAME["Level"] = { name = "Level", text = "Level" }
L.PARTYFRAME["Weekly"] = { name = "Weekly", text = "Weekly"}
L.PARTYFRAME["NoAddon"] = { name = "No Addon Detected", text = "not detected!"}
L.PARTYFRAME["PlayerOffline"] = { name = "Player Offline", text = "Player is offline."}
L.PARTYFRAME["TeamRatingGain"] = { name = "Estimated Rating Gain", text = "Estimated Rating Gain"}

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
L.CHARACTERINFO["NoKeyFound"] = { name = "NoKeyFound", text = "No Key Found"}
L.CHARACTERINFO["KeyInVault"] = { name = "Key in Vault", text = "In Vault"}
L.CHARACTERINFO["AskMerchant"] = { name = "Ask Key Merchant", text = "Key Merchant"}


-- DO NOT EDIT
SLASH_KeyMaster1 = L.COMMANDLINE["/km"].name
SLASH_KeyMaster2 = L.COMMANDLINE["/keymaster"].name