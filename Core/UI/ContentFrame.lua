local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface

-- Setup content region
function MainInterface:createContentRegion(parentFrame, headerRegion)
    local fr, mlr, mtb = KeyMaster:GetFrameRegions("content", parentFrame)
    local contentRegion = CreateFrame("Frame", "KeyMaster_ContentRegion", parentFrame);
    contentRegion:SetSize(fr.w, fr.h)
    contentRegion:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", mtb, -(headerRegion:GetHeight() + (mtb*2)))
    contentRegion.texture = contentRegion:CreateTexture()
    contentRegion.texture:SetAllPoints(contentRegion)
    --ContentFrame.texture:SetTexture("Interface\\AddOns\\KeyMaster\\Imgs\\WHITE8X8")
    contentRegion.texture:SetColorTexture(0, 0, 0, 1)

    return contentRegion
end