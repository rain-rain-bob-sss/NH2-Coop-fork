-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy
local DrawTexture = surface.DrawTexturedRect
local DrawTextureUV = surface.DrawTexturedRectUV
local SetMaterial = surface.SetMaterial
local SetColor = surface.SetDrawColor
local SetAlpha = surface.SetAlphaMultiplier
local GetAlpha = surface.GetAlphaMultiplier
local bg = Material("vgui/hud/bar_bg.png")
local fgWhite = Material("vgui/hud/bar_fg_white.png")
local fgWhite = Material("vgui/hud/bar_fg_white.png")
local icon_on = Material("vgui/hud/flashlight_icon_on.png", "smooth")
local icon_off = Material("vgui/hud/flashlight_icon.png")
local clamp = math.Clamp
local remap = math.Remap
local fgColor = Color(255, 255, 255, 255)
local flashlightAlpha = 255
local lerp = math.Approach
local width = ScrH() * 0.195
local nextHideTime = CurTime()
local alpha = 1
local cached_power = 100

local function Paint(size)
    local power = LocalPlayer():GetNWFloat("FlashlightNH2Power", 100)
    local backupAlpha = GetAlpha()

    -- Update timer to hide element
    if LocalPlayer():FlashlightState() and cached_power ~= power and power < 100 then
        cached_power = power
        nextHideTime = CurTime() + 0.5
    end

    if not LocalPlayer():FlashlightState() and CurTime() > nextHideTime and power == 100 then
        alpha = lerp(alpha, 0, FrameTime() * 5)
    else
        alpha = lerp(alpha, 1, FrameTime() * 5)
    end

    SetAlpha(alpha)
    SetMaterial(bg)
    SetColor(255, 255, 255, 255)
    DrawTexture(size.y * 0.35, size.y - size.y * 0.08056, size.y * 0.27, size.y * 0.06)

    --DrawText(tostring(clamp(LocalPlayer():Health(), 0, 100)), "NH_Numbers", size.y * 0.0625, size.y - size.y * 0.0531, fgColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    if LocalPlayer():FlashlightState() then
        SetMaterial(icon_on)
        flashlightAlpha = lerp(flashlightAlpha, 255, FrameTime() * 355)
    else
        SetMaterial(icon_off)
        flashlightAlpha = lerp(flashlightAlpha, 96, FrameTime() * 355)
    end

    SetColor(255, 255, 255, flashlightAlpha)
    DrawTexture(size.y * 0.36, size.y - size.y * 0.08, size.y * 0.05, size.y * 0.05)
    width = lerp(width, size.y * clamp(remap(power, 0, 100, 0, 0.195), 0, 0.195), FrameTime() * 25)
    SetMaterial(fgWhite)
    SetColor(255, 255, 255, 255)
    DrawTextureUV(size.y * 0.415, size.y - size.y * 0.075, width, size.y * 0.045, 0, 0, width / 300, 1)
    SetAlpha(backupAlpha)
end

DECLARE_HUD_ELEMENT("HudFlashlight", Paint, HUD_SUITONLY + HUD_ALIVEONLY + HUD_NOTINSPECTATOR)