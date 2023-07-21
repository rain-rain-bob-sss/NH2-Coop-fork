-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy
local Rect = surface.DrawRect
local SetColor = surface.SetDrawColor
local abs = math.abs
local lerp = math.Approach
local DrawText = draw.SimpleText
local offset = 0
local leftBracket, rightBracket = '(', ')'
local color = Color(255, 255, 255)

local function Paint(size)
    local velocity = LocalPlayer():GetViewPunchVelocity()
    local wep = LocalPlayer():GetActiveWeapon()
    if not IsValid(wep) then return end
    local clip1 = LocalPlayer():GetActiveWeapon():Clip1()
    if clip1 == -1 then return end
    offset = abs(velocity.x + velocity.y)

    if wep:GetInternalVariable("m_bInReload") == true or (GetGlobalBool("IsSpeedModifiedSoNoAttack", false) and not GetGlobal2Bool("OverrideCrosshairAndAttack", false)) then
        color.a = lerp(color.a, 0, FrameTime() * 2900)
    else
        color.a = lerp(color.a, 255, FrameTime() * 2900)
    end

    if LocalPlayer().PointingAlly then
        color.r = 0
        color.g = 200
        color.b = 0
    else
        color.r = 255
        color.g = 255
        color.b = 255
    end

    if wep:GetPrimaryAmmoType() ~= 7 then
        SetColor(color)

        -- Vertical 
        if wep:GetPrimaryAmmoType() ~= 3 and wep:GetPrimaryAmmoType() ~= 5 then
            Rect(ScrW() / 2, ScrH() / 2 - auto(30) - offset, auto(1), auto(24))
        end

        Rect(ScrW() / 2, ScrH() / 2 + auto(8) + offset, auto(1), auto(24))
        -- Horizontal 
        Rect(ScrW() / 2 - auto(30) - offset, ScrH() / 2, auto(24), auto(1))
        Rect(ScrW() / 2 + auto(8) + offset, ScrH() / 2, auto(24), auto(1))
    else
        DrawText(leftBracket, "NH_Icons", ScrW() / 2 - auto(60) - offset, ScrH() / 2 - auto(30), color)
        DrawText(rightBracket, "NH_Icons", ScrW() / 2 + auto(45) + offset, ScrH() / 2 - auto(30), color)
    end
end

DECLARE_HUD_ELEMENT("HudCrosshair", Paint, HUD_SUITONLY + HUD_ALIVEONLY)