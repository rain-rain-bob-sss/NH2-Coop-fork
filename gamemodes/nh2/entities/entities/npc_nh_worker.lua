-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

ENT.Base 			= "npc_nh_basezombie"
ENT.Spawnable       = true

if SERVER then
    ENT.Model = {"models/nh2zombies/worker01.mdl"}
    ENT.NoHeadBody = {1, 1}

    function ENT:CustomOnInitialize()
        self:CustomOnInitialize_Base()

        timer.Simple(0, function()
            self:SetBodygroup(1, math.random(2, 15))
            self:SetBodygroup(2, math.random(0, 1))
            self:SetBodygroup(3, math.random(0, 1))
            self:SetBodygroup(4, math.random(0, 1))
            self:SetBodygroup(5, math.random(0, 1))
        end)
    end
end