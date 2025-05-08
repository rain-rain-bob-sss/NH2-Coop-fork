-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

SWEP.Category              = "Nightmare House 2"
SWEP.PrintName             = "#NH_SMG"
SWEP.Slot                  = 2
SWEP.SlotPos               = 0
SWEP.Spawnable             = true

SWEP.ViewModel             = "models/weapons/v_smg.mdl"
SWEP.WorldModel            = "models/weapons/w_smg.mdl"

SWEP.Primary.ClipSize      = 30
SWEP.Primary.DefaultClip   = 30
SWEP.Primary.Automatic     = true
SWEP.Primary.Ammo          = "SMG1"

SWEP.Secondary.ClipSize    = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic   = false
SWEP.Secondary.Ammo        = "none"

SWEP.ViewModelFOV          = 54

if SERVER then
    SWEP.m_fFireDuration = 0
    SWEP.LastFireTime = 0
    SWEP.Attacking = false
end

function SWEP:Active()
    return self:GetOwner():GetActiveWeapon() == self
end

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

local function UTIL_ClipPunchAngleOffset(inAngles, punchAngles, clipAngles)
    local finalAngles = inAngles + punchAngles

    for i = 1, 3 do
        if finalAngles[i] > clipAngles[i] then
            finalAngles[i] = clipAngles[i]
        elseif finalAngles[i] < -clipAngles[i] then
            finalAngles[i] = -clipAngles[i]
        end

        inAngles[i] = finalAngles[i] - punchAngles[i]
    end
end

function SWEP:DoMachineGunKick(ply, dampEasy, maxVerticleKickAngle, fireDurationTime, slideLimitTime)
    if not SERVER then return end

    local KICK_MIN_X = 0.2 -- Degrees
    local KICK_MIN_Y = 0.2 -- Degrees
    local KICK_MIN_Z = 0.1 -- Degrees

    local vecScratch = Angle(0, 0, 0)

    local kickPerc = fireDurationTime / 2

    ply:ViewPunchReset()

    vecScratch.x = -(KICK_MIN_X + (maxVerticleKickAngle * kickPerc))
    vecScratch.y = -(KICK_MIN_Y + (maxVerticleKickAngle * kickPerc)) / 3
    vecScratch.z = KICK_MIN_Z + (maxVerticleKickAngle * kickPerc) / 8

    if math.random(-1, 1) >= 0 then
        vecScratch.y = -vecScratch.y
    end

    if math.random(-1, 1) >= 0 then
        vecScratch.z = -vecScratch.z
    end

    if game.GetSkillLevel() == 1 then
        for i = 1, 3 do
            vecScratch[i] = vecScratch[i] * dampEasy
        end
    end

    UTIL_ClipPunchAngleOffset(vecScratch, ply:GetViewPunchAngles(), Angle(24.0, 3.0, 1.0))

    for i = 1, 3 do
        if vecScratch[i] ~= vecScratch[i] then
            vecScratch[i] = 0
        end
    end

    ply:ViewPunch(vecScratch * 1)
end

function SWEP:AddViewKick()
    local EASY_DAMPEN       = 0.5
    local MAX_VERTICAL_KICK = 1     -- Degrees
    local SLIDE_LIMIT       = 2     -- Seconds

    self:DoMachineGunKick(self:GetOwner(), EASY_DAMPEN, MAX_VERTICAL_KICK, SLIDE_LIMIT, self.m_fFireDuration)
end

function SWEP:PrimaryAttack()
    if self:GetOwner():IsPlayer() and GetGlobalBool("IsSpeedModifiedSoNoAttack", false) and not GetGlobal2Bool("OverrideCrosshairAndAttack", false) then return end
    if not self:CanPrimaryAttack() then return end

    if SERVER then
        self:GetOwner():EmitSound("Weapon_NH_SMG1.Single")
        self:TakePrimaryAmmo(1)

        self:SetNextPrimaryFire(CurTime() + 0.09)

        self:GetOwner():MuzzleFlash()
        self:GetOwner():SetAnimation(PLAYER_ATTACK1)

        if self.Attacking and timer.Exists(self:EntIndex() .. "attacking_event") then
            timer.Remove(self:EntIndex() .. "attacking_event")
        end

        timer.Create(self:EntIndex() .. "attacking_event", 0.5, 1, function()
            self.Attacking = false
        end)

        if not self.Attacking then
            self.m_fFireDuration = 0
            self.LastFireTime = CurTime()
            self.Attacking = true
        end

        if self:GetOwner():IsPlayer() then
            self:AddViewKick()
        end

        self.m_fFireDuration = CurTime() - self.LastFireTime;
    end

    self:ShootBullet(13, 1, 0.05, self.Primary.Ammo)

    local effectdata = EffectData()
    effectdata:SetOrigin(self:GetOwner():EyePos())
    effectdata:SetEntity(self)
    util.Effect("gun_light", effectdata)
end

function SWEP:Reload()
    if self:Clip1() == self:GetMaxClip1() or self:Ammo1() == 0 then return end

    self:DefaultReload(ACT_VM_RELOAD)
    self:EmitSound("Weapon_NH_SMG1.Reload")

    if SERVER then
        self.Attacking = false
    end
end

function SWEP:GetNPCBurstSettings()
    return 1, 5, 0
end
