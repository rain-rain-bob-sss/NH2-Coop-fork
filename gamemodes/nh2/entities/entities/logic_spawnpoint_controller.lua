-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

-- Handles spawnpoints

ENT.Type = "point"
ENT.Spawnable = false

if SERVER then
    function ENT:AcceptInput(name, activator, caller, data)
        name = string.lower(name)
        
        if name == "setspawnpointindex" then
            NH2_Player.SetCheckpointIndex(tonumber(data))
            NH2_Player.MoveToCheckpoint()
        end

        if name == "setforcedspawnpointindex" then
            NH2_Player.SetCheckpointIndex(tonumber(data))
            NH2_Player.MoveToCheckpoint(true)
        end        
    end
end