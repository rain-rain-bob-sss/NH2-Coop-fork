-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

ENT.Base 			= "npc_zombie"
ENT.Spawnable       = true

if SERVER then
    ENT.IsTorso = true
    ENT.HullType = HULL_TINY
    ENT.Model = { "models/zombie/classic_torso.mdl"}

    function ENT:CustomOnInitialize()
        self:SetName(self.RestoredTargetName)
        self.AttackProps = false
        self:SetHullSizeNormal(true)

        if self.IsTorso then
            self.TimeUntilMeleeAttackDamage = 0.5
            self.FootStepTimeWalk = 0.5
            self.FootStepTimeRun = 0.5
        end

        self:SetHullType(HULL_SMALL_CENTERED)     
    end
end