-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

SWEP.Category           = "Nightmare House 2"
SWEP.PrintName          = "#NH_Pistol"
SWEP.Slot               = 1
SWEP.SlotPos            = 1
SWEP.Spawnable          = true

SWEP.ViewModel			= "models/weapons/v_colt.mdl"
SWEP.WorldModel			= "models/weapons/w_colt.mdl"

SWEP.ViewModelFOV = 54

SWEP.Primary.ClipSize		= 9
SWEP.Primary.DefaultClip	= 9
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Pistol"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

function SWEP:Initialize()
    self:SetDeploySpeed(1)
end

function SWEP:PrimaryAttack()
    if self:GetOwner():IsPlayer() and self:GetOwner():GetLaggedMovementValue() < 1 and not GetGlobal2Bool("OverrideCrosshairAndAttack", false) then return end
    if not self:CanPrimaryAttack() then return end

    if SERVER then
        self:GetOwner():EmitSound("Weapon_NH_Pistol.Single")
        self:TakePrimaryAmmo(1)
    
        self:SetNextPrimaryFire(CurTime() + 0.15)
    
        self:GetOwner():ViewPunch(Angle(math.Rand(0.25,0.5), math.Rand(-0.6,0.6), 0))
    
        self:GetOwner():MuzzleFlash()
        self:GetOwner():SetAnimation(PLAYER_ATTACK1)

        self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    end

    self:ShootBullet(15, 1, 0.01, self.Primary.Ammo)
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
    self:EmitSound("Weapon_NH_Pistol.Reload")
end