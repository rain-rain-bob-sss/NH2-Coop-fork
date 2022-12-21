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
            ent:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)          
        end
    end

    function ENT:EndTouch(ent)
        if ent:IsPlayer() then
            ent:SetCollisionGroup(COLLISION_GROUP_NONE)
        end
    end    
end