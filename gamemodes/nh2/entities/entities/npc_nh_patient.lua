-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

ENT.Base 			= "npc_nh_basezombie"
ENT.Spawnable       = false

if SERVER then
    function ENT:CustomOnInitialize()
        self:CustomOnInitialize_Base()

        self:SetModel("models/nh2zombies/patient0" .. math.random(1,3) .. ".mdl")

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