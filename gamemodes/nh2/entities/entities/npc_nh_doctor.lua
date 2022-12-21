-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

ENT.Base 			= "npc_nh_basezombie"
ENT.Spawnable       = false

if SERVER then
    ENT.Model = {"models/nh2zombies/doctor01.mdl"}
    ENT.NoHeadBody = {1, 1}

    function ENT:CustomOnInitialize()
        self:CustomOnInitialize_Base()

        timer.Simple(0, function()
            self:SetBodygroup(1, math.random(2, 12))
            self:SetBodygroup(2, math.random(0, 2))
        end)
    end
end