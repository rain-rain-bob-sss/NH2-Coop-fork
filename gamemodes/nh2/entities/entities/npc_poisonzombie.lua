-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

ENT.Base 			= "npc_zombie"
ENT.Spawnable       = true

ENT.MeleeAttackDamage = 32
ENT.SlowPlayerOnMeleeAttack = true
ENT.StartHealth = 230

ENT.SoundTbl_FootStep = { "NPC_PoisonZombie.FootstepLeft", "NPC_PoisonZombie.FootstepRight" }
ENT.SoundTbl_Idle = "NPC_PoisonZombie.Idle"
ENT.SoundTbl_Alert = "NPC_PoisonZombie.Alert"
ENT.SoundTbl_BeforeMeleeAttack = "NPC_PoisonZombie.Attack"
ENT.SoundTbl_MeleeAttackMiss = "NPC_PoisonZombie.AttackMiss"
ENT.SoundTbl_Pain = "NPC_PoisonZombie.Pain"
ENT.SoundTbl_Death = "NPC_PoisonZombie.Die"

if SERVER then
    ENT.Model = {"models/Zombie/Poison.mdl"}

    function ENT:CustomOnInitialize()
        self:SetName(self.RestoredTargetName)
        self.AttackProps = false
        self:SetHullSizeNormal(true)

        if self.IsTorso then
            self.TimeUntilMeleeAttackDamage = 0.5
            self.FootStepTimeWalk = 0.5
            self.FootStepTimeRun = 0.5
        end  
    end
end