-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

SWEP.Category           = "Nightmare House 2"
SWEP.PrintName          = "#NH_SHOTGUN"
SWEP.Slot               = 3
SWEP.SlotPos            = 0
SWEP.Spawnable          = true

SWEP.ViewModel			= "models/weapons/v_shotgun1.mdl"
SWEP.WorldModel			= "models/weapons/w_shotgun1.mdl"

SWEP.ViewModelFOV = 54

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Buckshot"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

function SWEP:Initialize()
    self:SetDeploySpeed(1)
    self:SetHoldType("shotgun")
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
    if self:GetOwner():GetLaggedMovementValue() < 1 then return end
    if not self:CanPrimaryAttack() then return end
    
    self:ShootBullet(15, 5, 0.1, self.Primary.Ammo)

    if SERVER then
        if self:GetNWBool("ISRELOADING", false) then
            self:SetNWBool("ISRELOADING", false)
        end

        -- Remove reload timers
        for i = 1, 8 do
            if timer.Exists("Weapon_Idle_ReloadAmmo_" .. self:EntIndex() .. i) then
                timer.Stop("Weapon_Idle_ReloadAmmo_" .. self:EntIndex() .. i)
                timer.Remove("Weapon_Idle_ReloadAmmo_" .. self:EntIndex() .. i)
            end
        end

        self:GetOwner():EmitSound("Weapon_NH_Shotgun.Single")
        self:TakePrimaryAmmo(1)

        self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())

        if self:GetOwner():IsPlayer() then
            -- Disorient the player
            local angles = self:GetOwner():EyeAngles()

            angles.x = angles.x + 1
            angles.y = angles.y + math.Rand(0, 2)
            angles.z = 0

            self:GetOwner():ViewPunch(Angle(-6, math.Rand(-2,-2), 0))
            self:GetOwner():SetEyeAngles(angles)
        end

        self:GetOwner():MuzzleFlash()
        self:GetOwner():SetAnimation(PLAYER_ATTACK1)

        self:SetIdleAnim(self:SequenceDuration() - 0.05)
    end

    local effectdata = EffectData()
    effectdata:SetOrigin(self:GetOwner():EyePos())
    effectdata:SetEntity(self)
    util.Effect( "gun_light", effectdata)
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
    if SERVER then
        if self:Clip1() == self:GetMaxClip1() or self:Ammo1() == 0 or self.Reloading then return end
        if self:GetNWBool("ISRELOADING", false) then return end

        if timer.Exists("Weapon_Idle_Delay_" .. self:EntIndex()) then
            timer.Stop("Weapon_Idle_Delay_" .. self:EntIndex())
            timer.Remove("Weapon_Idle_Delay_" .. self:EntIndex())
        end

        self:SetNWBool("ISRELOADING", true)
        local needed = math.abs(self:GetMaxClip1() - self:Clip1()) + 1
    
        self:SetNextPrimaryFire(CurTime() + 1)
    
        //self:EmitSound("Weapon_NH_Shotgun.Reload")
        self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
        
        timer.Simple(0.05, function() 
            -- Repeat inserting n-times
            for i = 1, needed do
                    timer.Create("Weapon_Idle_ReloadAmmo_" .. self:EntIndex() .. i, i * 0.6, 1, function()
                    
                    if not (self and IsValid(self) and IsValid(self:GetOwner())) then return end
                    self:SendWeaponAnim(ACT_VM_RELOAD)
                    self:SetNextPrimaryFire(CurTime() + 0.5)
    
                    if i == needed then
                        self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
                        self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())
                        self:SetNWBool("ISRELOADING", false)
                    else
                        if self:GetOwner():GetAmmo()[7] then
                            self:SetClip1(self:Clip1() + 1)
                            self:GetOwner():SetAmmo(self:GetOwner():GetAmmo()[7] - 1, 7)
                        else
                            self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
                            self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())
                            self:SetNWBool("ISRELOADING", false)

                            -- Remove reload timers
                            for i = 1, 8 do
                                if timer.Exists("Weapon_Idle_ReloadAmmo_" .. self:EntIndex() .. i) then
                                    timer.Stop("Weapon_Idle_ReloadAmmo_" .. self:EntIndex() .. i)
                                    timer.Remove("Weapon_Idle_ReloadAmmo_" .. self:EntIndex() .. i)
                                end
                            end                            
                        end
                    end
                end)
            end
        end)
    end
end -- bruh those ends