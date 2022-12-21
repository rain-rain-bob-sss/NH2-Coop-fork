-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

ENT.Type = "brush"
ENT.Spawnable = false

if SERVER then
    ENT.TouchedMe = {}

    ENT.NextMap = ""
    ENT.Enabled = true

    function ENT:Initialize()
        self:SetTrigger(true)
    end

    function ENT:KeyValue(k,v)
        if k == "map" then
            self.NextMap = v
        end

        if k == "StartDisabled" then
            self.Enabled = not tobool(v)
        end
    end

    function ENT:AcceptInput(name, activator, caller, data)
        if name == "Enabled" then
            self.Enabled = true
        end

        if name == "Disable" then
            self.Enabled = false
        end

        if name == "Toggle" then
            self.Enabled = not self.Enabled
        end
    end

    function ENT:StartTouch(ent)
        if not self.Enabled then return end
        
        if ent:IsPlayer() then
            self.TouchedMe[1] = ent

            if #self.TouchedMe == player.GetCount() then
                Msg("Changing level to " .. self.NextMap .. " from custom trigger_changelevel\n")
                RunConsoleCommand("changelevel", self.NextMap)
            end
        end
    end
end