-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

SWEP.Category           = "Nightmare House 2"
SWEP.PrintName          = "#NH_Revolver"
SWEP.Slot               = 1
SWEP.SlotPos            = 2
SWEP.Spawnable          = true

SWEP.ViewModel			= "models/weapons/v_revolver.mdl"
SWEP.WorldModel			= "models/weapons/w_revolver.mdl"

SWEP.ViewModelFOV = 54

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "357"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

function SWEP:Initialize()
    self:SetDeploySpeed(1)
end

function SWEP:PrimaryAttack()
    if self:GetOwner():IsPlayer() and GetGlobalBool("IsSpeedModifiedSoNoAttack", false) and not GetGlobal2Bool("OverrideCrosshairAndAttack", false) then return end
    if not self:CanPrimaryAttack() then return end
    
    if SERVER then
        self:GetOwner():EmitSound("Weapon_NH_Revolver.Single")
        self:TakePrimaryAmmo(1)

        self:SetNextPrimaryFire(CurTime() + 0.7)

        -- Disorient the player
        local angles = self:GetOwner():EyeAngles()

        angles.x = angles.x + math.Rand(-1, 1)
        angles.y = angles.y + math.Rand(-1, 1)
        angles.z = 0

        self:GetOwner():ViewPunch(Angle(-6, math.Rand(-2,-2), 0))

        self:GetOwner():SetEyeAngles(angles)

        self:GetOwner():MuzzleFlash()
        self:GetOwner():SetAnimation(PLAYER_ATTACK1)
    end

    self:ShootBullet(30, 1, 0.01, self.Primary.Ammo)

    local effectdata = EffectData()
    effectdata:SetOrigin(self:GetOwner():EyePos())
    effectdata:SetEntity(self)
    util.Effect( "gun_light", effectdata)
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
    if self:Clip1() == self:GetMaxClip1() or self:Ammo1() == 0 then return end

    self:DefaultReload(ACT_VM_RELOAD)
    self:EmitSound("Weapon_NH_Revolver.Reload")
end