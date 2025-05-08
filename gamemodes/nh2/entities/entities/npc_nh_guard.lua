-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

ENT.Base = "npc_vj_creature_base"
ENT.Type = "ai"

ENT.Spawnable       = true

if SERVER then
    ENT.Model = { "models/nh2zombies/security01.mdl" }
    ENT.HullType = HULL_WIDE_HUMAN

    ENT.VJ_NPC_Class = { "CLASS_ZOMBIE" }
    ENT.BloodColor = "Red"
    ENT.HasMeleeAttack = true

    ENT.MeleeAttackDistance = 32
    ENT.MeleeAttackDamageDistance = 85
    ENT.MeleeAttackDamageType = DMG_SLASH
    ENT.MeleeAttackDamage = 30
    ENT.HasExtraMeleeAttackSounds = true

    ENT.TimeUntilMeleeAttackDamage = 1
    ENT.NextAnyAttackTime_Melee = 0.8

    ENT.FootStepTimeRun = 0.4
    ENT.FootStepTimeWalk = 0.6

    ENT.Flinches = 1
    ENT.FlinchingChance = 14
    ENT.FlinchingSchedules = { SCHED_FLINCH_PHYSICS }

    ENT.SoundTbl_FootStep = { "nh_guard.ScuffLeft", "nh_guard.ScuffRight" }
    ENT.SoundTbl_Idle = "nh_guard.Idle"
    ENT.SoundTbl_Alert = "nh_guard.Alert"
    ENT.SoundTbl_Pain = "nh_guard.Pain"
    ENT.SoundTbl_Death = "nh_guard.Die"

    ENT.RestoredTargetName = ""
    ENT.PlayedChargeSound = false
    ENT.PlayedChargeSound_Delay = 0

    -- sk_zombie_soldier_health
    ENT.StartHealth = 100

    ENT.SlowPlayerOnMeleeAttack = true

    function ENT:KeyValue(k, v)
        if string.Left(k, 2) == "On" then
            self:StoreOutput(k, v)
        end

        if k == "targetname" then
            self.RestoredTargetName = v
        end
    end

    function ENT:CustomOnInitialize_Base()
        self:SetName(self.RestoredTargetName)
    end

    function ENT:CustomOnThink()
        if not self.PlayedChargeSound and (IsValid(self:GetEnemy()) and self:GetPos():Distance(self:GetEnemy():GetPos()) < 128 ) and self:IsMoving() then
            self.PlayedChargeSound = true
            self.PlayedChargeSound_Delay = CurTime() + 5
            self:EmitSound("nh_guard.Charge")
        end

        if CurTime() > self.PlayedChargeSound_Delay and self.PlayedChargeSound then
            self.PlayedChargeSound = false
        end
    end

    function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo)
        dmginfo:ScaleDamage(0.5)

        self:SetEnemy(Entity(1))
        self:UpdateEnemyMemory(dmginfo:GetAttacker(), dmginfo:GetAttacker():GetPos())
    end
end