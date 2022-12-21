-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

SWEP.Category           = "Nightmare House 2"
SWEP.PrintName          = "#NH_SMG"
SWEP.Slot               = 2
SWEP.SlotPos            = 0
SWEP.Spawnable          = true

SWEP.ViewModel			= "models/weapons/v_smg.mdl"
SWEP.WorldModel			= "models/weapons/w_smg.mdl"

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SMG1"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

function SWEP:Initialize()
    self:SetDeploySpeed(1)
    self:SetHoldType("smg")
end

function SWEP:SetIdleAnim(delay)
    if timer.Exists("Weapon_Idle_Delay_" .. self:EntIndex()) then
        timer.Stop("Weapon_Idle_Delay_" .. self:EntIndex())
        timer.Remove("Weapon_Idle_Delay_" .. self:EntIndex())
    end

    timer.Create("Weapon_Idle_Delay_" .. self:EntIndex(), delay, 1, function()
        self:SendWeaponAnim(ACT_VM_IDLE)
    end)
end


function SWEP:PrimaryAttack()
    if not self:CanPrimaryAttack() then return end
    
    if SERVER then
        self:GetOwner():EmitSound("Weapon_NH_SMG1.Single")
        self:TakePrimaryAmmo(1)

        self:SetNextPrimaryFire(CurTime() + 0.09)

        if self:GetOwner():IsPlayer() then
            self:GetOwner():ViewPunch(Angle(math.Rand(-0.05,0.05), math.Rand(-0.5,0.5), 0))
        end

        self:GetOwner():MuzzleFlash()
        self:GetOwner():SetAnimation(PLAYER_ATTACK1)
    end

    self:ShootBullet(13, 1, 0.05, self.Primary.Ammo)
end

function SWEP:Reload()
    if self:Clip1() == self:GetMaxClip1() or self:Ammo1() == 0 then return end

    self:DefaultReload(ACT_VM_RELOAD)
    self:EmitSound("Weapon_NH_SMG1.Reload")
end

function SWEP:GetNPCBurstSettings()
    return 1, 5, 0
end