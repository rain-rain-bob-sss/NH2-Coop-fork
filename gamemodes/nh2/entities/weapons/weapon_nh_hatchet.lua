-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

SWEP.Category           = "Nightmare House 2"
SWEP.PrintName          = "#NH_Hatchet"
SWEP.Slot               = 0
SWEP.SlotPos            = 1
SWEP.Spawnable          = true

SWEP.ViewModel			= "models/weapons/v_hatchet.mdl"
SWEP.WorldModel			= "models/weapons/w_hatchet.mdl"

SWEP.ViewModelFOV = 54

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

local zero_vector = Vector(0, 0, 0)

SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true
SWEP.HasHitTarget = false
SWEP.PerformingHeavySwing = false

local HATCHET_RANGE = 40

function SWEP:SendIdleAnimation(delay)
    if not IsValid(self) then return end

    if timer.Exists("Weapon_Idle_Delay_" .. self:EntIndex()) then
        timer.Stop("Weapon_Idle_Delay_" .. self:EntIndex())
        timer.Remove("Weapon_Idle_Delay_" .. self:EntIndex())
    end

    timer.Create("Weapon_Idle_Delay_" .. self:EntIndex(), delay, 1, function()
        if not IsValid(self) then return end
        self:SendWeaponAnim(ACT_VM_IDLE)
    end)
end

function SWEP:ValidateHitPos()
    local tr = util.TraceLine( {
        start = self:GetOwner():EyePos(),
        endpos = self:GetOwner():EyePos() + self:GetOwner():EyeAngles():Forward() * HATCHET_RANGE,
        filter = function( ent ) return ent ~= self:GetOwner() end
    } )

    if tr.Hit and IsValid(tr.Entity) then 
        return 2, tr.Entity
    elseif tr.Hit and not IsValid(tr.Entity) then
        return 1
    else
        return 0
    end
end  

function SWEP:Initialize()
    self:SetHoldType("melee2")
    self:SetDeploySpeed(1)   

    if SERVER then
        self:SendIdleAnimation(1)
    end
end

function SWEP:Deploy()
    if self:GetOwner():IsPlayer() then
        self:GetOwner():SetNWBool("NH2COOP_SUITPICKUPED", true)
        self:GetOwner():SetWalkSpeed(150)
        self:GetOwner():SetRunSpeed(230)
    end
end

function SWEP:PrimaryAttack()
    if self:GetOwner():IsPlayer() and self:GetOwner():GetLaggedMovementValue() < 1 then return end
    local status, target = self:ValidateHitPos()

    self:GetOwner():DoAttackEvent()

    if status > 0 then
        local HATCHET_BULLET = {}
        HATCHET_BULLET.Num    = 1
        HATCHET_BULLET.Spread = zero_vector
        HATCHET_BULLET.Tracer = 0
        HATCHET_BULLET.Force  = 10
        HATCHET_BULLET.Hullsize = 0
        HATCHET_BULLET.Distance = HATCHET_RANGE
        HATCHET_BULLET.Damage = 25  
        HATCHET_BULLET.Src = self.Owner:GetShootPos()
        HATCHET_BULLET.Dir = self:GetOwner():EyeAngles():Forward():GetNormalized()
        
        self:SetNextPrimaryFire(CurTime() + 0.75)
        self:SetNextSecondaryFire(CurTime() + 0.75)
        self:SendIdleAnimation(0.5)

        self:SendWeaponAnim(ACT_VM_HITCENTER)
        if SERVER then
            if status == 2 then
                if (target:GetClass() == "func_breakable" 
                or target:GetClass() == "func_physbox") and bit.band(target:GetInternalVariable("spawnflags"), 1) == 0 then
                    target:Fire("SetHealth", target:Health() - 25)
                end
                
                if target:GetClass() == "prop_physics" then
                    HATCHET_BULLET.Damage = 1
                    for k, v in pairs(util.KeyValuesToTable(util.GetModelInfo(target:GetModel()).KeyValues)) do                        
                        if k == "break" then
                            local dmg = DamageInfo()
                            dmg:SetDamageType(DMG_CLUB)
                            dmg:SetDamage(25)

                            target:TakeDamageInfo(dmg)
                            break
                        end
                    end
                end
                self:GetOwner():EmitSound("Weapon_NH_Hatchet.Stab")           
            else
                self:GetOwner():EmitSound("Weapon_NH_Hatchet.Slash")
            end
        end

        self.Owner:FireBullets(HATCHET_BULLET)
    else
        self:SetNextPrimaryFire(CurTime() + 1.25)
        self:SetNextSecondaryFire(CurTime() + 1.25)
        self:SendIdleAnimation(1.25)

        self:SendWeaponAnim(ACT_VM_MISSCENTER)
        self:GetOwner():EmitSound("Weapon_NH_Hatchet.Swing")
    end
end

function SWEP:SecondaryAttack()
    if self:GetOwner():IsPlayer() and self:GetOwner():GetLaggedMovementValue() < 1 and not GetGlobal2Bool("OverrideCrosshairAndAttack", false) then return end
    if SERVER then
        self:SetNextPrimaryFire(CurTime() + 2)
        self:SetNextSecondaryFire(CurTime() + 2)
        self:SendWeaponAnim(ACT_VM_MISSCENTER2)

        timer.Simple(0.25, function()
            self:GetOwner():EmitSound("Weapon_NH_Hatchet.Heavy_Swing")
        end)

        if timer.Exists("Weapon_Attack2_Delay_" .. self:EntIndex()) then
            timer.Stop("Weapon_Attack2_Delay_" .. self:EntIndex())
            timer.Remove("Weapon_Attack2_Delay_" .. self:EntIndex())
        end


        if timer.Exists("Weapon_Attack2_Remove_Delay_" .. self:EntIndex()) then
            timer.Stop("Weapon_Attack2_Remove_Delay_" .. self:EntIndex())
            timer.Remove("Weapon_Attack2_Remove_Delay_" .. self:EntIndex())
        end


        local status, target = self:ValidateHitPos()

        timer.Create("Weapon_Attack2_Delay_" .. self:EntIndex(), 1, 1, function()
            self.PerformingHeavySwing = true
        end)

        timer.Create("Weapon_Attack2_Remove_Delay_" .. self:EntIndex(), 1.2, 1, function()
            self.PerformingHeavySwing = false
        end)        
    end
end

function SWEP:Think()
    if self.PerformingHeavySwing then
        local status,target = self:ValidateHitPos()

        if status > 0 then
            self:SetNextPrimaryFire(CurTime() + 0.75)
            self:SetNextSecondaryFire(CurTime() + 0.75)
            self:SendIdleAnimation(0.5)

            self:SendWeaponAnim(ACT_VM_HITCENTER)
            
            local HATCHET_BULLET = {}
            HATCHET_BULLET.Num    = 1
            HATCHET_BULLET.Spread = zero_vector
            HATCHET_BULLET.Tracer = 0
            HATCHET_BULLET.Force  = 10
            HATCHET_BULLET.Hullsize = 0
            HATCHET_BULLET.Distance = HATCHET_RANGE
            HATCHET_BULLET.Damage = 40
            HATCHET_BULLET.Callback = function(att, tr, dmginfo)
                if IsValid(tr.Entity) then
                    dmginfo:SetDamageForce(self:GetOwner():EyeAngles():Right() * -5555)
                end
            end
            HATCHET_BULLET.Src = self:GetOwner():GetShootPos()
            HATCHET_BULLET.Dir = self:GetOwner():EyeAngles():Forward():GetNormalized()

            self.Owner:FireBullets(HATCHET_BULLET)

            if status == 2 then
                if (target:GetClass() == "func_breakable" 
                or target:GetClass() == "func_physbox") and bit.band(target:GetInternalVariable("spawnflags"), 1) == 0 then
                    target:Fire("SetHealth", target:Health() - 25)
                    return
                end
                
                if target:GetClass() == "prop_physics" then
                    HATCHET_BULLET.Damage = 1
                    for k, v in pairs(util.KeyValuesToTable(util.GetModelInfo(target:GetModel()).KeyValues)) do                        
                        if k == "break" then
                            target:Fire("SetHealth", target:Health() - 25)
                            break
                        end
                    end
                else
                    self.Owner:FireBullets(HATCHET_BULLET)
                end
                self:GetOwner():EmitSound("Weapon_NH_Hatchet.Stab") 
            else
                self:GetOwner():EmitSound("Weapon_NH_Hatchet.Slash")
            end

            self.PerformingHeavySwing = false
        end
    end
end