-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

local blur = Material("vgui/hud/blureffect.vmt")

local function Paint(size)
    surface.SetMaterial(blur)
    surface.SetDrawColor(255,255,255,128)
    surface.DrawTexturedRect(0,0,ScrW(),ScrH())
end

DECLARE_BACKGROUND_HUD_ELEMENT("HudBlur", Paint)