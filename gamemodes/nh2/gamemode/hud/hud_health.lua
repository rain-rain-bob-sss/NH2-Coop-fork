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
local fgColor = Color(255, 255, 255, 255)
local lerp = math.Approach
local width = 100

local tab = {
    ["$pp_colour_addr"] = 0,
    ["$pp_colour_addg"] = 0,
    ["$pp_colour_addb"] = 0,
    ["$pp_colour_brightness"] = 0,
    ["$pp_colour_contrast"] = 1.2,
    ["$pp_colour_colour"] = 0.9,
    ["$pp_colour_mulr"] = 0,
    ["$pp_colour_mulg"] = 0,
    ["$pp_colour_mulb"] = 0
}

local function Paint(size)
    SetMaterial(bg)

    if LocalPlayer():Health() <= 20 then
        fgColor.r = clamp(200 + (160 - 200) * math.sin(CurTime() * 8), 160, 200)
        fgColor.g = 0
        fgColor.b = 0
    else
        fgColor.r = 255
        fgColor.g = 255
        fgColor.b = 255
    end

    tab["$pp_colour_contrast"] = LocalPlayer():Health() <= 20 and 1.2 or 1
    tab["$pp_colour_colour"] = LocalPlayer():Health() <= 20 and 0.9 or 1
    SetColor(255, 255, 255, 255)
    DrawTexture(auto(33), size.y - size.y * 0.08056, size.y * 0.27, size.y * 0.06)
    DrawText(tostring(clamp(LocalPlayer():Health(), 0, 100)), "NH_Numbers", size.y * 0.0625, size.y - size.y * 0.0531, fgColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    SetColor(255, 255, 255, 128)
    DrawTexture(size.y * 0.04, size.y - size.y * 0.076, size.y * 0.061, size.y * 0.05)
    width = lerp(width, size.y * clamp(remap(LocalPlayer():Health(), 0, LocalPlayer():GetMaxHealth(), 0, 0.195), 0, 0.195), FrameTime() * 100)
    SetMaterial(fgWhite)
    SetColor(fgColor)
    DrawTextureUV(size.y * 0.095, size.y - size.y * 0.075, width, size.y * 0.045, 0, 0, width / 300, 1)
end

hook.Add("RenderScreenspaceEffects", "HudHealthEffects", function()
    DrawColorModify(tab)

    if LocalPlayer():Health() <= 20 then
        DrawMotionBlur(0.3 * (LocalPlayer():GetMaxHealth() - LocalPlayer():Health()), 1, 0.005)
    end
end)

DECLARE_HUD_ELEMENT("HudHealth", Paint, HUD_SUITONLY + HUD_ALIVEONLY + HUD_NOTINSPECTATOR)