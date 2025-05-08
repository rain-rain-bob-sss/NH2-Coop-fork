-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

ENT.Base 			= "npc_nh_basezombie"
ENT.Spawnable       = true

if SERVER then
    ENT.Model = {"models/nh2zombies/surgeon01.mdl", "models/nh2zombies/surgeon02.mdl"}
    ENT.NoHeadBody = {1, 1}

    function ENT:CustomOnInitialize()
        self:CustomOnInitialize_Base()

        timer.Simple(0, function()
            self:SetBodygroup(1, math.random(3, 11))
            self:SetBodygroup(2, math.random(1, 3))
        end)
    end
end