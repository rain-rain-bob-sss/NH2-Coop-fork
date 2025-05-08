-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

ENT.Base = "npc_vj_creature_base"
ENT.Spawnable       = true

if SERVER then
    ENT.RestoredTargetName = ""

    ENT.Model = {"models/nh2zombies/friendly.mdl"}
    ENT.StartHealth = 90

    ENT.MoveType = MOVETYPE_STEP

    ENT.VJ_NPC_Class = { "CLASS_ZOMBIE" }
    ENT.BloodColor = "Red"
    ENT.HasMeleeAttack = true

    ENT.AnimTbl_MeleeAttack = { ACT_MELEE_ATTACK1 }

    ENT.MeleeAttackDistance = 48
    ENT.MeleeAttackDamageDistance = 20
    ENT.TimeUntilMeleeAttackDamage = 0.4
    ENT.NextAnyAttackTime_Melee = 0.7
    ENT.MeleeAttackDamage = 11
    ENT.MeleeAttackDamageType = DMG_SLASH
    ENT.FootStepTimeRun = 1
    ENT.FootStepTimeWalk = 1
    ENT.HasExtraMeleeAttackSounds = true
    ENT.GibOnDeathDamagesTable = { "All" }
    ENT.GibOnDeathDamagesTable = { "All" }

    ENT.CallForHelpDistance = 5000
    ENT.NextCallForHelpTime = 3.4
    ENT.HasCallForHelpAnimation = true
    ENT.AnimTbl_CallForHelp = { ACT_IDLE_ON_FIRE }
    ENT.CallForHelpStopAnimationsTime = 2

    ENT.Flinches = 1
    ENT.FlinchingChance = 14

    ENT.FlinchingSchedules = { SCHED_FLINCH_PHYSICS }

    ENT.HasLeapAttack = true
    ENT.AnimTbl_LeapAttack = { "leapstrike" }
    ENT.LeapDistance = 600
    ENT.LeapToMeleeDistance = 150
    ENT.TimeUntilLeapAttackDamage = 0.2
    ENT.NextLeapAttackTime = 3
    ENT.NextAnyAttackTime_Leap = 0.4
    ENT.LeapAttackExtraTimers = { 0.4,0.6,0.8,1}
    ENT.TimeUntilLeapAttackVelocity = 0.2
    ENT.LeapAttackVelocityForward = 500
    ENT.LeapAttackVelocityUp = 200
    ENT.LeapAttackDamage = 10
    ENT.LeapAttackDamageDistance = 65

    ENT.SoundTbl_FootStep = { "NPC_nhdemon.FootstepLeft", "NPC_nhdemon.FootstepRight" }
    ENT.SoundTbl_DefBreath = "NPC_nhdemon.Moan1"
    ENT.SoundTbl_Alert = "NPC_nhdemon.AlertFar"
    ENT.SoundTbl_BeforeMeleeAttack = "NPC_nhdemon.RangeAttack"
    ENT.SoundTbl_LeapAttackJump = "NPC_nhdemon.Scream"
    ENT.SoundTbl_MeleeAttackExtra = "NPC_nhdemon.AttackHit"
    ENT.SoundTbl_MeleeAttackMiss = "NPC_nhdemon.AttackMiss"
    ENT.SoundTbl_Pain = "NPC_nhdemon.Pain"
    ENT.SoundTbl_DeathFollow = "NPC_nhdemon.Die"

    function ENT:KeyValue(k, v)
        if string.Left(k, 2) == "On" then
            self:StoreOutput(k, v)
        end

        if k == "targetname" then
            self.RestoredTargetName = v
        end

        if k == "removeLeapAttackOnSpawn" and v == "1" then
            self.HasLeapAttack = false
        end

        self:CustomKeyValue(k, v)
    end

    function ENT:CustomKeyValue(k, v)
    end

    function ENT:CustomOnInitialize()
        self:SetName(self.RestoredTargetName)

        if self.Slump then
            self:SetSlump(true)
        else
            self.SoundTbl_Breath = self.SoundTbl_DefBreath
        end

        self.IsLeaping = false
        self.LeapDelay = 0
        self.LeapLoop = ACT_LEAP
        self.TotalHits = 0
        self.LastHitT = 0
    end

    function ENT:CustomOnLeapAttack_AfterStartTimer(seed)
        self.IsLeaping = true
        self.LeapDelay = CurTime() + 0.25
    end

    function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt)
        if CurTime() > self.LastHitT then
            self.TotalHits = 0
        end

        self.TotalHits = self.TotalHits + 1
        self.LastHitT = CurTime() + 0.6

        if self.TotalHits >= 8 then
            self:EmitSound("NPC_nhdemon.Frenzy")
            self:VJ_ACT_PLAYACTIVITY("BR2_Roar", true, false, true)
        end

        return false
    end
end