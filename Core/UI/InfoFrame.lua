local _, KeyMaster = ...
local InfoFrame = {}
KeyMaster.InfoFrame = InfoFrame

function InfoFrame:CreateInfoFrame(parentFrame)
    local infoFrame = CreateFrame("Frame", "KM_Info_Frame",parentFrame)
    infoFrame:SetAllPoints(parentFrame)
    infoFrame:SetSize(parentFrame:GetHeight(), parentFrame:GetWidth())
    infoFrame:SetScript("OnShow", function(self)
        
    end)

    infoFrame.textTitle = infoFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    infoFrame.textTitle:SetPoint("TOPLEFT", infoFrame, "TOPLEFT", 14, -14)
    infoFrame.textTitle:SetHeight(20)
    infoFrame.textTitle:SetText("General Information:")

    local generalText = "Key Master AddOn for World of Warcraft\n"..
    "(c) 2024 – Released under the GNU General Public License\n"..

    "\nJoin the conversation helping us improve Key Master!\n"..
    "Visit https://github.com/Puresyn/KeyMaster/discussions/18\n"..
    
    "\nInitialization:\n"..
    "Use /km or a keybind available in game keybindings to toggle the main window.\n"..
    "Use /km help for command line options.\n"..
    
    "\nAbout:\n"..
    "The Key Master is an addon developed for World of Warcraft that assists in\n"..
    "gathering and displaying detailed information about you and your parties \'live\'\n"..
    "(if they also have Key Master) data relating to Mythic Plus Instances.\n"..
    "This addon was conceived with the idea that it was too laborious to make\n"..
    "well-informed decisions regarding “Key Running”; either for yourself, or a\n"..
    "\'push team\'.\n"..
    
    "\nWhile there are many future features in-mind for Key Master to expand its\n"..
    "usefulness, how far it may go and when that will happen is largely dependent on\n"..
    "its user base. So, if you find Key Master useful, tell your friends!\n"..
    
    "\nDiagnostics:\n"..
    "If you are experiencing difficulties with Key Mater not working properly, you\n"..
    "may use [/km errors] or or [/km debug] to obtain diagnostic feedback from Key\n"..
    "Master. Please note that debug mode is very verbose and may render in-game\n"..
    "chat difficult to navigate.\n"..
    
    "\nRepository:\n"..
    "For full source code, bug submission, bug tracking, and other source related\n"..
    "issues. Please visit the GitHub repository at:\n"..
    "\nhttps://github.com/Puresyn/KeyMaster"

    local indent = 10
    infoFrame.textContent = infoFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    infoFrame.textContent:SetPoint("TOPLEFT", infoFrame.textTitle, "BOTTOMLEFT", indent, -4)
    infoFrame.textContent:SetHeight(infoFrame:GetHeight() - 24)
    infoFrame.textContent:SetWidth(500 - indent)
    infoFrame.textContent:SetJustifyH("LEFT")
    infoFrame.textContent:SetJustifyV("TOP")
    infoFrame.textContent:SetText(generalText)

    infoFrame.textAuthorsTitle = infoFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    infoFrame.textAuthorsTitle:SetPoint("TOPRIGHT", infoFrame, "TOPRIGHT", -14, -14)
    infoFrame.textAuthorsTitle:SetSize(200, 20)
    infoFrame.textAuthorsTitle:SetText("Authors")

    infoFrame.textAuthors = infoFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    infoFrame.textAuthors:SetPoint("TOP", infoFrame.textAuthorsTitle, "BOTTOM", 0, -4)
    infoFrame.textAuthors:SetSize(200, 50)
    infoFrame.textAuthors:SetJustifyV("TOP")
    infoFrame.textAuthors:SetText("Strylor-Proudmoore\nShantisoc-Proudmoore")

    infoFrame.textCreditsTitle = infoFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    infoFrame.textCreditsTitle:SetPoint("TOP", infoFrame.textAuthors, "BOTTOM", 0, -14)
    infoFrame.textCreditsTitle:SetSize(200, 20)
    infoFrame.textCreditsTitle:SetText("Special Thanks:")

    local creditText = "Rexidan, Ithoro, Xanat, Doc, Sunnie, Charlie, Feathor, and the entire 'Last Pull' crew for invaluable testing and feedback."

    infoFrame.textCredits = infoFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    infoFrame.textCredits:SetPoint("TOP", infoFrame.textCreditsTitle, "BOTTOM", 0, -4)
    infoFrame.textCredits:SetSize(200, 200)
    infoFrame.textCredits:SetJustifyV("TOP")
    infoFrame.textCredits:SetText(creditText)


    return infoFrame
end