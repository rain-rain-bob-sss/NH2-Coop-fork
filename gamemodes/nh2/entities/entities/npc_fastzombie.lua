-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

ENT.Base 			= "npc_nh_demon"
ENT.Spawnable       = false

ENT.StartHealth = 50

ENT.SoundTbl_FootStep = { "NPC_FastZombie.FootstepLeft", "NPC_FastZombie.FootstepRight" }
ENT.SoundTbl_DefBreath = "NPC_FastZombie.Moan1"
ENT.SoundTbl_Alert = "NPC_FastZombie.AlertFar"
ENT.SoundTbl_BeforeMeleeAttack = "NPC_FastZombie.RangeAttack"
ENT.SoundTbl_LeapAttackJump = "NPC_FastZombie.Scream"
ENT.SoundTbl_MeleeAttackExtra = "NPC_FastZombie.AttackHit"
ENT.SoundTbl_MeleeAttackMiss = "NPC_FastZombie.AttackMiss"
ENT.SoundTbl_Pain = "NPC_FastZombie.Pain"
ENT.SoundTbl_DeathFollow = "NPC_FastZombie.Die"

if SERVER then
    ENT.Model = {"models/Zombie/Fast.mdl"}
end