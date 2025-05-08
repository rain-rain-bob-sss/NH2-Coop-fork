-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

ENT.Base 			= "npc_nh_basezombie"
ENT.Spawnable       = true

if SERVER then
    ENT.IsTorso = true
    ENT.HullType = HULL_TINY
    ENT.Model = {"models/NH2Zombies/gibs/janitor_torso.mdl"}

    function ENT:CustomOnInitialize()
        self:CustomOnInitialize_Base()

        timer.Simple(0, function()
            self:SetBodygroup(1, math.random(2, 14))
        end)
    end
end