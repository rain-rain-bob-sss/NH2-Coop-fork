-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

-- Limited recreation of wep selection from HL2

local DrawTexture = surface.DrawTexturedRect
local SetMaterial = surface.SetMaterial
local SetTexture = surface.SetTexture
local SetColor = surface.SetDrawColor
local SetAlpha = surface.SetAlphaMultiplier
local GetAlpha = surface.GetAlphaMultiplier

local fastSwitch = GetConVar("hud_fastswitch")
local selectedSlot = 1
local selectTime = CurTime() - 1

local alpha = 0

local box = Material("vgui/hud/weaponboxbig.png")
local boxSmall = Material("vgui/hud/weaponboxsmall.png")

local smallBoxSize = auto(105)
local bigBoxSize = auto(130)

local offset = 0.4
local scale = 0

local clamp = math.Clamp
local remap = math.Remap

local lerp = math.Approach

local WEAPONS = {
    ["weapon_nh_hatchet"] = Material("vgui/hud/slot1_icon.png"),
    ["weapon_nh_pistol"] = Material("vgui/hud/slot2_icon.png"),
    ["weapon_nh_revolver"] = Material("vgui/hud/slot3_icon.png"),
    ["weapon_nh_smg"] = Material("vgui/hud/slot4_icon.png"),
    ["weapon_nh_shotgun"] = Material("vgui/hud/slot5_icon.png")
}

local function Paint(size)
    local weapons = LocalPlayer():GetWeapons()

    local backupAlpha = GetAlpha()
    
    if CurTime() > selectTime + 1 then
        alpha = lerp(alpha, 0, FrameTime() * 1.5)
    else
        alpha = lerp(alpha, 1, FrameTime() * 3)
    end

    SetAlpha(alpha)

    if #weapons > 0 then
        offset = 0.55
        scale = 0
        
        for i = 1, clamp(#weapons, 0, 5) do
            offset = offset - 0.06
        end
        
        for i = 1, clamp(#weapons, 0, 5) do
            local weapon = weapons[i]  
            if not IsValid(weapon) then continue end

            weapon.iconsize = weapon.iconsize or auto(105)

            if selectedSlot == i then
                weapon.iconsize = lerp(weapon.iconsize, auto(130), FrameTime() * 200)
            else
                weapon.iconsize = lerp(weapon.iconsize, auto(105), FrameTime() * 200)
            end

            SetMaterial(box)
            SetColor(255,255,255,255)

            DrawTexture(auto(30), ScrH() * offset + scale, weapon.iconsize * 2, weapon.iconsize)
            
            -- This one acts like original mod
            if WEAPONS[weapon:GetClass()] then
                SetMaterial(WEAPONS[weapon:GetClass()])
            elseif (weapon.WepSelectIcon) then
                SetTexture(weapon.WepSelectIcon)
            end

            DrawTexture(auto(30) + weapon.iconsize * 0.2, ScrH() * offset + scale + weapon.iconsize * 0.15, weapon.iconsize * 1.5, weapon.iconsize * 0.6)

            scale = scale + weapon.iconsize
        end
    end

    SetAlpha(backupAlpha)
end

hook.Add("PlayerBindPress", "NH2COOP_StartCommand_WeaponSelector", function(ply, bind, pressed)
    if not fastSwitch:GetBool() then
        if string.StartWith(bind, "slot") then
            local slot = tonumber(string.match(bind, "slot(%d+)"))
            if slot > 5 then return true end

            if ply:GetNWBool("NH2COOP_SUITPICKUPED") and pressed and selectedSlot ~= slot and ply:GetWeapons()[slot] then
                selectedSlot = slot
                selectTime = CurTime()
                surface.PlaySound("common_nh2/wpn_moveselect.wav")

                input.SelectWeapon(ply:GetWeapons()[slot])
            end
            return true
        end

        local weapons = ply:GetWeapons()

        if bind == "invnext" then
            if ply:GetNWBool("NH2COOP_SUITPICKUPED") and pressed then
                if selectedSlot ~= 5 then
                    selectedSlot = selectedSlot + 1
                else
                    selectedSlot = 1
                end

                selectTime = CurTime()
    
                if ply:GetWeapons()[selectedSlot] then
                    surface.PlaySound("common_nh2/wpn_moveselect.wav")
                    input.SelectWeapon(ply:GetWeapons()[selectedSlot])
                end
            end

            return true
        end

        if bind == "invprev" then
            if ply:GetNWBool("NH2COOP_SUITPICKUPED") and pressed then
                if selectedSlot ~= 1 then
                    selectedSlot = selectedSlot - 1
                else
                    selectedSlot = 5
                end

                selectTime = CurTime()
    
                if ply:GetWeapons()[selectedSlot] then
                    surface.PlaySound("common_nh2/wpn_moveselect.wav")
                    input.SelectWeapon(ply:GetWeapons()[selectedSlot])
                end
            end

            return true
        end        
    end
end)

DECLARE_HUD_ELEMENT("HudWeaponSelection", Paint, HUD_SUITONLY + HUD_ALIVEONLY + HUD_NOTINSPECTATOR)