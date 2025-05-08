-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

ENT.Base 			= "npc_nh_basezombie"
ENT.Spawnable       = true

if SERVER then
    ENT.IsTorso = true
    ENT.HullType = HULL_TINY
    ENT.Model = {"models/nh2zombies/gibs/doctor_torso.mdl"}

    function ENT:CustomOnInitialize()
        self:CustomOnInitialize_Base()

        timer.Simple(0, function()
            self:SetBodygroup(1, math.random(2, 12))
            self:SetBodygroup(2, math.random(0, 2))
        end)
    end
end