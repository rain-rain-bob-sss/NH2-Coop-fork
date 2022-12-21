-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

local DrawTexture = surface.DrawTexturedRect
local DrawTextureUV = surface.DrawTexturedRectUV
local SetMaterial = surface.SetMaterial
local SetColor = surface.SetDrawColor

local DrawText = draw.SimpleText

local bg = Material("vgui/hud/bar_bg.png")
local fgWhite = Material("vgui/hud/bar_fg_white.png")

local clamp = math.Clamp
local remap = math.Remap
local fgColor = Color(255,255,255,255)

local lerp = math.Approach

local width = 100

local function Paint(size)
    SetMaterial(bg)
    
    SetColor(255,255,255,255)
    DrawTexture(auto(33), size.y - size.y * 0.08056, size.y * 0.27, size.y * 0.06)

    DrawText(tostring(clamp(LocalPlayer():Health(), 0, 100)), "NH_Numbers", size.y * 0.0625, size.y - size.y * 0.0531, fgColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    SetColor(255,255,255,128)
    DrawTexture(size.y * 0.04, size.y - size.y * 0.076, size.y * 0.061, size.y * 0.05)

    width = lerp(width, size.y * clamp(remap(LocalPlayer():Health(), 0, LocalPlayer():GetMaxHealth(), 0, 0.195), 0, 0.195), FrameTime() * 100)

    SetMaterial(fgWhite)
    SetColor(255,255,255,255)
    DrawTextureUV(size.y * 0.095, size.y - size.y * 0.075, width, size.y * 0.045, 0, 0, width / 300, 1)
end

DECLARE_HUD_ELEMENT("HudHealth", Paint, HUD_SUITONLY + HUD_ALIVEONLY + HUD_NOTINSPECTATOR)