local _, KeyMaster = ...
local MainInterface = KeyMaster.MainInterface

-- Setup content region
function MainInterface:CreateContentRegion(parentFrame, headerRegion)
    local fr, mlr, mtb = MainInterface:GetFrameRegions("content", parentFrame)
    local contentRegion = CreateFrame("Frame", "KeyMaster_ContentRegion", parentFrame);
    contentRegion:SetSize(fr.w, fr.h)
    contentRegion:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", mtb, -(headerRegion:GetHeight() + (mtb*2)))
    contentRegion.texture = contentRegion:CreateTexture()
    contentRegion.texture:SetAllPoints(contentRegion)
    contentRegion.texture:SetColorTexture(0, 0, 0, 1)
    contentRegion.texture:SetAlpha(0.4)
    contentRegion.overlayTexture = contentRegion:CreateTexture(nil, "OVERLAY", nil)
    contentRegion.overlayTexture:SetSize(contentRegion:GetWidth(), contentRegion:GetHeight())
    contentRegion.overlayTexture:SetPoint("BOTTOMLEFT")
    contentRegion.overlayTexture:SetTexture("Interface\\Addons\\KeyMaster\\Assets\\Images\\AdventureMapBorder")
    contentRegion.overlayTexture:SetTexCoord(0, 1004/1024, 0, 670/1024)

    return contentRegion
end