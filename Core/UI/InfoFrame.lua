local _, KeyMaster = ...
local InfoFrame = {}
KeyMaster.InfoFrame = InfoFrame
local Theme = KeyMaster.Theme

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

    local generalText = [[Key Master AddOn for World of Warcraft
(c) 2024 - Released under the GNU General Public License
    
About:
Key Master is an addon developed for World of Warcraft that assists in gathering and displaying detailed information about you and your parties “live” (if they also have Key Master) data relating to Mythic Plus Instances.
This addon was conceived with the idea that it was too laborious to make well-informed decisions regarding “Key Running”; either for yourself, or a “push team”.

While there are many future features in-mind for Key Master to expand its usefulness, how far it may go and when that will happen is largely dependent on its user base. So, if you find Key Master useful, tell your friends!

Diagnostics:
If you are experiencing difficulties with Key Mater not working properly, you may use [/km errors] or or [/km debug] to obtain diagnostic feedback from Key Master. Please note that debug mode is very verbose and may render in-game chat difficult to navigate.]]
    
    local creditText = "Rexidan, Ithoro, Xanat, Doc, Sunnie, Charlie, Feathor, and the entire 'Last Pull' crew for invaluable testing and feedback."

    local indent = 10
    local generalFrame = CreateFrame("Frame", nil, infoFrame)
    generalFrame:SetPoint("TOPLEFT", infoFrame.textTitle, "BOTTOMLEFT", indent, -4)
    generalFrame:SetSize(500 - indent, infoFrame:GetHeight() - 24)
    generalFrame.textContent = generalFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    --generalFrame.textContent:SetAllPoints(generalFrame)
    generalFrame.textContent:SetPoint("TOPLEFT", generalFrame, "TOPLEFT")
    generalFrame.textContent:SetSize(generalFrame:GetWidth(), generalFrame:GetHeight())
    generalFrame.textContent:SetJustifyH("LEFT")
    generalFrame.textContent:SetJustifyV("TOP")
    generalFrame.textContent:SetText(generalText)

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
    infoFrame.textCreditsTitle:SetText("Special Thanks")

    infoFrame.textCredits = infoFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontNormal")
    infoFrame.textCredits:SetPoint("TOP", infoFrame.textCreditsTitle, "BOTTOM", 0, -4)
    infoFrame.textCredits:SetSize(200, 200)
    infoFrame.textCredits:SetJustifyV("TOP")
    infoFrame.textCredits:SetText(creditText)


    return infoFrame
end