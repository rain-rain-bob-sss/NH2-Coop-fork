-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

ENT.Type = "brush"
ENT.Spawnable = false

if SERVER then
    ENT.TouchedMe = {}

    function ENT:Initialize()
        self:SetTrigger(true)
    end

    function ENT:StartTouch(ent)
        if ent:IsPlayer() then
            if not self.TouchedMe[ent] then self.TouchedMe[ent] = true end

            if #self.TouchedMe == game.MaxPlayers() then
                self:TriggerOutput("OnStartTouch")
                self:TriggerOutput("OnTrigger")
            end
        end
    end
end