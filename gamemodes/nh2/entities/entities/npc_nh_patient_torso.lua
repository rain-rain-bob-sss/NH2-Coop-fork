-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

ENT.Base 			= "npc_nh_basezombie"
ENT.Spawnable       = false

if SERVER then
    ENT.IsTorso = true
    ENT.HullType = HULL_TINY
    ENT.Model = {"models/nh2zombies/gibs/patient_torso.mdl"}

    function ENT:CustomOnInitialize()
        self:CustomOnInitialize_Base()

        timer.Simple(0, function()
            self:SetBodygroup(1, math.random(2, 14))

            -- for those who is not n-word
            if self:GetBodygroup(1) ~= 2 then
                self:SetBodygroup(2, 1)
            end

            self:SetBodygroup(3, math.random(0,1))
            self:SetBodygroup(4, math.random(0,1))
        end)
    end
end