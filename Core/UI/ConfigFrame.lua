local _, KeyMaster = ...
local ConfigFrame = {}
KeyMaster.ConfigFrame = ConfigFrame

function ConfigFrame:CreateConfigFrame(parentFrame)
    local conFrame = CreateFrame("Frame", "KM_Configuration_Frame",parentFrame)
    conFrame:SetAllPoints(parentFrame)
    conFrame:SetSize(parentFrame:GetHeight(), parentFrame:GetWidth())
    conFrame.text = conFrame:CreateFontString(nil, "OVERLAY", "KeyMasterFontBig")
    conFrame.text:SetPoint("CENTER", conFrame, "CENTER", 0, 50)
    conFrame.text:SetText("Configuration tab intentionally left blank")
    return conFrame
end