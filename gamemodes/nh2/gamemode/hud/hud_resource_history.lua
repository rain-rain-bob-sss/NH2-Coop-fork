-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy
local DrawTexture = surface.DrawTexturedRect
local SetMaterial = surface.SetMaterial
local SetColor = surface.SetDrawColor
local SetAlpha = surface.SetAlphaMultiplier
local GetAlpha = surface.GetAlphaMultiplier
local lerp = math.Approach
local PICKUPED_HISTORY = {}
local offset = 0.5

local PICKUP_ICONS = {
    ["weapon_nh_hatchet"] = {
        Icon = Material("vgui/hud/slot1_icon.png"),
        W = 256
    },
    ["weapon_nh_pistol"] = {
        Icon = Material("vgui/hud/slot2_icon.png"),
        W = 256
    },
    ["weapon_nh_revolver"] = {
        Icon = Material("vgui/hud/slot3_icon.png"),
        W = 256
    },
    ["weapon_nh_smg"] = {
        Icon = Material("vgui/hud/slot4_icon.png"),
        W = 256
    },
    ["weapon_nh_shotgun"] = {
        Icon = Material("vgui/hud/slot5_icon.png"),
        W = 256
    },
    ["item_healthkit"] = {
        Icon = Material("vgui/hud/medkit.png"),
        W = 128
    },
    ["item_healthvial"] = {
        Icon = Material("vgui/hud/bandage.png"),
        W = 128
    },
}

function HUDWeaponPickedUp(weapon)
    row = {}
    row.ShowTime = CurTime()
    if not PICKUP_ICONS[weapon:GetClass()] then return end
    row.Icon = PICKUP_ICONS[weapon:GetClass()].Icon
    row.IsDying = false
    row.SizeX = PICKUP_ICONS[weapon:GetClass()].W
    row.Alpha = 0
    table.insert(PICKUPED_HISTORY, 1, row)

    return false
end

function HUDItemPickedUp(item)
    row = {}
    row.ShowTime = CurTime()
    if not PICKUP_ICONS[item] then return end
    row.Icon = PICKUP_ICONS[item].Icon
    row.IsDying = false
    row.SizeX = PICKUP_ICONS[item].W
    row.Alpha = 0
    table.insert(PICKUPED_HISTORY, 1, row)

    return false
end

function HUDDrawPickupHistory()
    return false
end

hook.Add("HUDItemPickedUp", "NH2COOP_ItemPickuped", HUDItemPickedUp)
hook.Add("HUDWeaponPickedUp", "NH2COOP_WeaponPickuped", HUDWeaponPickedUp)
hook.Add("HUDDrawPickupHistory", "NH2COOP_HUDDrawPickupHistory", HUDDrawPickupHistory)

local function Paint(size)
    offset = 0.5

    for i = 1, #PICKUPED_HISTORY do
        offset = offset - 0.08
    end

    for i = 1, #PICKUPED_HISTORY do
        local row = PICKUPED_HISTORY[i]
        row.PosY = row.PosY or ScrH() * offset + (auto(128) * i)
        row.PosY = lerp(row.PosY, ScrH() * offset + (auto(128) * i), FrameTime() * auto(500))

        if CurTime() < row.ShowTime + 5 then
            row.Alpha = lerp(row.Alpha, 255, FrameTime() * 300)
        else
            row.Alpha = lerp(row.Alpha, 0, FrameTime() * 300)
        end

        if row.Alpha == 0 then
            PICKUPED_HISTORY[i] = nil
        end

        SetColor(255, 255, 255, row.Alpha)
        SetMaterial(row.Icon)
        DrawTexture(ScrW() - auto(row.SizeX + 30), row.PosY, auto(row.SizeX), auto(128))
    end
end

DECLARE_HUD_ELEMENT("HudResourceHistory", Paint, HUD_NOTINSPECTATOR)