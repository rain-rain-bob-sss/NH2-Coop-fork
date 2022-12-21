-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

-- Makes random fuse spawn
-- Called from nh2c3_v2 map -> random_spawn_position entity -> Execute on spawn SF

-- Keep in mind that everything here is SERVERSIDE

local FUSES = {}

-- Add all fuses to table
for index = 1, ents.GetCount() do
    local ent = Entity(index)
    if not IsValid(ent) then continue end

    if string.StartWith(ent:GetName(), "fuse_new") then
        FUSES[#FUSES + 1] = ent
    end
end

-- Remove extra fuses from table (and world)
while #FUSES > 3 do
    local random_fuse = math.random(1, #FUSES)

    local fuse = FUSES[random_fuse]

    fuse:Remove()
    table.remove(FUSES, random_fuse)
end

-- Fix their names
for index = 1, #FUSES do
    local fuse = FUSES[index]

    fuse:SetName("fuse_new" .. index)
end