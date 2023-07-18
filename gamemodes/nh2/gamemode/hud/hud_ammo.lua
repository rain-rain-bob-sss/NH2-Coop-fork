-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

local DrawTexture = surface.DrawTexturedRect
local DrawTextureUV = surface.DrawTexturedRectUV
local SetMaterial = surface.SetMaterial
local SetColor = surface.SetDrawColor

local DrawText = draw.SimpleText

local bg = Material("vgui/hud/bar_bg.png")

local ammoTypes = {
    [3] = Material("vgui/hud/slot2_ammo_icon.png"),
    [5] = Material("vgui/hud/slot3_ammo_icon.png"),
    [9] = Material("vgui/hud/slot4_ammo_icon.png"),
    [7] = Material("vgui/hud/slot5_ammo_icon.png"),
}

local clamp = math.Clamp
local remap = math.Remap

local lerp = math.Approach

local normal = Color(255,255,255)
local red = Color(185,42,42)

local clip1Color = normal
local ammo1Color = normal

local weaponAmmoIcons = {
    [3] = "p", -- pistol,
    [5] = "q", -- revolver
    [4] = "r", -- smg
    [7] = "s" -- shotgun
}

local function Paint(size)
    local wep = LocalPlayer():GetActiveWeapon()
    if not IsValid(wep) then return end

    local clip1 = LocalPlayer():GetActiveWeapon():Clip1()
    if clip1 == -1 then return end

    clip1 = clamp(clip1, 0, 9999)
    local maxClip = LocalPlayer():GetActiveWeapon():GetMaxClip1()

    if clip1 < maxClip / 5 then
        clip1Color = red
    else
        clip1Color = normal
    end

    local ammo1 = LocalPlayer():GetAmmoCount(wep:GetPrimaryAmmoType())
    ammo1 = clamp(ammo1, 0, 99)
    
    if ammo1 == 0 then
        ammo1Color = red
    else
        ammo1Color = normal
    end

    SetMaterial(bg)
    
    SetColor(255,255,255,255)
    DrawTexture(size.x - size.y * 0.24, size.y - size.y * 0.08056, size.y * 0.22, size.y * 0.06)

    if (weaponAmmoIcons[wep:GetPrimaryAmmoType()]) then
        DrawText(weaponAmmoIcons[wep:GetPrimaryAmmoType()], "NH_AmmoIcon", size.x - size.x * 0.119, size.y - size.y * 0.05, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    DrawText(clip1, "NH_NumbersBigger", size.x - size.y * 0.095, size.y - size.y * 0.083, clip1Color, TEXT_ALIGN_RIGHT)
    DrawText(ammo1, "NH_NumbersSmaller", size.x - size.y * 0.045, size.y - size.y * 0.075, ammo1Color, TEXT_ALIGN_RIGHT)
end

DECLARE_HUD_ELEMENT("HudAmmo", Paint, HUD_SUITONLY + HUD_ALIVEONLY + HUD_NOTINSPECTATOR)