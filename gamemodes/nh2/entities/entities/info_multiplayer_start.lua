-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

ENT.Type = "point"

if SERVER then
    ENT.ID = 0

    function ENT:KeyValue(k, v)
        if k == "playerID" then
            self.ID = tonumber(v)
        end
    end

    function ENT:GetID()
        return self.ID
    end
end