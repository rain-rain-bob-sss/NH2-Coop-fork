-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

ENT.Type = "brush"
ENT.Spawnable = false

local StopBacktracking = {
    nightmare_house2 = "nightmare_house1",
    nightmare_house3 = "nightmare_house2",
    nightmare_house4 = "nightmare_house3"
}

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
            if v == StopBacktracking[game.GetMap()] then self:Remove() return end
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
            self.TouchedMe[ent:EntIndex()] = ent

            if #self.TouchedMe >= player.GetCount() then
                Msg("Changing level to " .. self.NextMap .. " from custom trigger_changelevel\n")
                RunConsoleCommand("changelevel", self.NextMap)
            end
        end
    end
end