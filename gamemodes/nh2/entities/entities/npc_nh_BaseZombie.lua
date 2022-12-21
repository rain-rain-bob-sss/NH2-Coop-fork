-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

ENT.Base = "npc_vj_creature_base"
ENT.Type = "ai"

ENT.Spawnable       = false

if SERVER then
    util.AddNetworkString("_NH2_BaseZombie_BloodStream")

    ENT.RestoredTargetName = ""

    ENT.MoveType = MOVETYPE_STEP

    ENT.VJ_NPC_Class = { "CLASS_ZOMBIE" }
    ENT.BloodColor = "Red"
    ENT.HasMeleeAttack = true

    ENT.AnimTbl_MeleeAttack = { ACT_MELEE_ATTACK1 }

    ENT.MeleeAttackDistance = 32
    ENT.MeleeAttackDamageDistance = 60
    ENT.TimeUntilMeleeAttackDamage = 1
    ENT.NextAnyAttackTime_Melee = 0.8
    ENT.MeleeAttackDamage = 25
    ENT.MeleeAttackDamageType = DMG_SLASH
    ENT.FootStepTimeRun = 1
    ENT.FootStepTimeWalk = 1
    ENT.HasExtraMeleeAttackSounds = true
    ENT.GibOnDeathDamagesTable = { "All" }

    ENT.Flinches = 1
    ENT.FlinchingChance = 14

    ENT.FlinchingSchedules = { SCHED_FLINCH_PHYSICS }

    ENT.SoundTbl_FootStep = { "nhzombie.FootstepLeft", "nhzombie.FootstepRight" }
    ENT.SoundTbl_Idle = "nhzombie.Idle"
    ENT.SoundTbl_Alert = "nhzombie.Alert"
    ENT.SoundTbl_BeforeMeleeAttack = "nhzombie.Attack"
    ENT.SoundTbl_MeleeAttackMiss = "nhzombie.AttackMiss"
    ENT.SoundTbl_Pain = "nhzombie.Pain"
    ENT.SoundTbl_Death = "nhzombie.Die"

    ENT.BloodParticle = NULL
    ENT.NoHeadBody = {1,0}

    ENT.IsTorso = false

    function ENT:KeyValue(k, v)
        if string.Left(k, 2) == "On" then
            self:StoreOutput(k, v)
        end

        if k == "targetname" then
            self.RestoredTargetName = v
        end

        self:CustomKeyValue(k, v)
    end

    function ENT:CustomKeyValue(k, v)
    end

    function ENT:CustomOnInitialize_Base()
        self:SetName(self.RestoredTargetName)
        self.AttackProps = false

        if self.IsTorso then
            self.TimeUntilMeleeAttackDamage = 0.5
            self.FootStepTimeWalk = 0.5
            self.FootStepTimeRun = 0.5
        end
    end

    function ENT:Use(activator, caller, useType, value)
    end

    function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
        if dmginfo:GetInflictor():GetClass() == "prop_physics" then
            dmginfo:SetDamage(0)
        end
    end

    function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
        if hitgroup == HITGROUP_HEAD and not self.HeadIsBroken then
            net.Start("_NH2_BaseZombie_BloodStream")
                net.WriteEntity(self)
            net.Broadcast()
            self:SetBodygroup(self.NoHeadBody[1], self.NoHeadBody[2])
            self:EmitSound("nhzombie.headexplode_jet")
            self.HeadIsBroken = true
            self:CustomOnHeadExplosion()
        end
    end

    function ENT:CustomOnHeadExplosion()
    end

    function ENT:CustomOnKilled(dmginfo, hitgroup)
        self:TriggerOutput("OnDeath")
        self:TriggerOutput("OnKilled")
    end

    function ENT:SetAnimIdle(activity)
        self.AnimTbl_IdleStand = activity
    end

    function ENT:SetAnimMovement(activity)
        self.AnimTbl_Walk = activity
        self.AnimTbl_Run = activity
        self:SetMovementActivity(activity)
    end

    function ENT:EnableMovement(bool)
        self.DisableWandering = not bool
        self.DisableChasingEnemy = not bool
        self.ConstantlyFaceEnemy_IfVisible = bool
        if bool then
            self.Behaviour = VJ_BEHAVIOR_AGGRESSIVE
        else
            self.Behaviour = VJ_BEHAVIOR_PASSIVE
        end

        self.HasMeleeAttack = bool
    end

    function ENT:CustomOnThink()
        -- Play fire anim
        if not self.IsTorso then
            if self:IsOnFire() then
                self.AnimTbl_Walk = { ACT_WALK_ON_FIRE }
                self.AnimTbl_Run = { ACT_WALK_ON_FIRE }
                self:SetMovementActivity(ACT_WALK_ON_FIRE)
            else
                self.AnimTbl_Walk = { ACT_WALK }
                self.AnimTbl_Run = { ACT_WALK }
                self:SetMovementActivity(ACT_WALK)
            end
        end

        -- Stop emiting sounds if we don't bothered by someome
        if not self:HasEnemyMemory() then
            self.HasIdleSounds = false
        else
            self.HasIdleSounds = true
        end

        if (self:GetCurrentSchedule() == SCHED_SCRIPTED_CUSTOM_MOVE
        or self:GetCurrentSchedule() == SCHED_SCRIPTED_FACE
        or self:GetCurrentSchedule() == SCHED_SCRIPTED_RUN
        or self:GetCurrentSchedule() == SCHED_SCRIPTED_WAIT
        or self:GetCurrentSchedule() == SCHED_AISCRIPT)
        then
            self.ConstantlyFaceEnemy_IfVisible = false
            self.HasMeleeAttack = false
        else
            self.ConstantlyFaceEnemy_IfVisible = true
            self.HasMeleeAttack = true
        end
    end
end

if CLIENT then
    ENT.BloodParticle = NULL

    function ENT:StartBloodStream()
        self.BloodParticle = CreateParticleSystem(self, "blood_advisor_puncture_withdraw", PATTACH_POINT_FOLLOW, 4)
    end

    net.Receive("_NH2_BaseZombie_BloodStream", function(len, ply)
        local ent = net.ReadEntity()
        if ent.StartBloodStream and IsValid(ent) then
            ent:StartBloodStream()
        end
    end)
end