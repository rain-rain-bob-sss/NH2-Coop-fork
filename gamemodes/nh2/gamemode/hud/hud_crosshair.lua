-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

local Rect = surface.DrawRect
local SetColor = surface.SetDrawColor
local abs = math.abs
local lerp = math.Approach
local DrawText = draw.SimpleText

local offset = 0

local leftBracket, rightBracket = '(', ')'

local color_green = Color(0,200,0,255)
local color = color_white

local function Paint(size)
    local velocity = LocalPlayer():GetViewPunchVelocity()

    local wep = LocalPlayer():GetActiveWeapon()
    if not IsValid(wep) then return end

    local clip1 = LocalPlayer():GetActiveWeapon():Clip1()
    if clip1 == -1 then return end

    offset = abs(velocity.x + velocity.y)
       
    if LocalPlayer().PointingAlly then
        color = color_green
    else
        color = color_white
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