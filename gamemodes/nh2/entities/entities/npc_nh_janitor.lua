-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

ENT.Base = "npc_nh_basezombie"
ENT.Spawnable = false

if SERVER then
    local GENDER_MALE = 1
    local GENDER_FEMALE = 2

    ENT.NoHeadBody = {1, 9}
    ENT.KV_Head = 1

    function ENT:CustomKeyValue(k, v)
        if k == "headmodel" then
            if v == "10" then
                self.RandomHeadModel = true
            else
                if v == "8" or v == "9" then
                    self.HeadIsBroken = true
                end

                self.KV_Head = tonumber(v)
            end
        end

        if k == "gender" then
            if v == "0" then
                self.RandomGender = true
            else
                self.Gender = tonumber(v)
            end
        end
    end

    function ENT:CustomOnInitialize()
        self:CustomOnInitialize_Base()

        if self.RandomGender then
            self.Gender = math.random(1, 2)
        end

        if self.Gender == GENDER_MALE then
            self.Model = {"models/nh2zombies/janitor_male.mdl"}
        else
            self.Model = {"models/nh2zombies/janitor_female.mdl"}
        end

        self:SetModel(self.Model[1])

        timer.Simple(0, function()
            if self.Gender == GENDER_MALE then
                if self.RandomHeadModel then
                    self:SetBodygroup(1, math.random(0, 7))
                else
                    self:SetBodygroup(1, self.KV_Head)
                end
            else
                if self.RandomHeadModel then
                    self:SetBodygroup(1, math.random(0, 5))
                else
                    self:SetBodygroup(1, self.KV_Head)
                end

                -- Change their voice
                self.IdleSoundPitch = VJ_Set(115,115)
                self.AlertSoundPitch = VJ_Set(115,115)
                self.PainSoundPitch = VJ_Set(115,115)
                self.DeathSoundPitch = VJ_Set(115,115)
                self.BeforeMeleeAttackSoundPitch = VJ_Set(115,115)

                -- Special bodygroup for womens
                self.NoHeadBody = {1,7}
            end

            if not self.HeadIsBroken then
                self:SetBodygroup(2, math.random(0, 1))
            else
                self:SetBodygroup(2, math.random(1))
            end

            if self.Gender == GENDER_MALE and (self:GetBodygroup(1) == 0 or self:GetBodygroup(1) == 2) or
            self.Gender == GENDER_FEMALE and (self:GetBodygroup(1) == 2 or self:GetBodygroup(1) == 5) then
                self:SetBodygroup(3, 1)
            else
                self:SetBodygroup(3, 0)
            end

            self:SetBodygroup(4, math.random(0, 1))
            self:SetBodygroup(5, math.random(0, 1))
        end)
    end

    function ENT:CustomOnHeadExplosion()
        -- This bitch lost his hat
        self:SetBodygroup(2, 1)
    end
end