-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

local ref1 = Material("vgui/reference_2.png")

local function Paint(size)
    surface.SetMaterial(ref1)
    surface.SetDrawColor(255,255,255,128)
    --surface.DrawTexturedRect(0,0,ScrW(),ScrH())
end

DECLARE_HUD_ELEMENT("HudReference", Paint)