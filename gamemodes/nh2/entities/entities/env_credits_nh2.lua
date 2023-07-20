-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()
ENT.Type = "point"

function ENT:AcceptInput(name, activator, caller, data)
    if name == "Start" then
        net.Start("_NH2_StartCredits")
        net.Broadcast()
        print("Starting credits")
    end
end