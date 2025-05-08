-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

ENT.Base 			= "npc_nh_basezombie"
ENT.Spawnable       = true

if SERVER then
    function ENT:CustomOnInitialize()
        self:CustomOnInitialize_Base()

        self:SetModel("models/nh2zombies/cook.mdl")

        timer.Simple(0, function()
            self:SetBodygroup(1, 2)
        end)
    end
end