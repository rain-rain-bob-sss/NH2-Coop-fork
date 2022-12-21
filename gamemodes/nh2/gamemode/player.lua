--
--    Name: gamemode:PlayerSpawnObject( ply )
--    Desc: Called to ask whether player is allowed to spawn any objects
--
function GM:PlayerSpawnObject(ply)
    return true
end

local FLASHLIGHT_DRAIN_TIME = 1.1111 -- 100 units / 90 secs
local FLASHLIGHT_REGEN_DELAY = 0.1
local FLASHLIGHT_UPDATE_TIME = 0
local FLASHLIGHT_REGEN_TIME = 0

function GM:PlayerTick(ply, mv)
    -- Custom flashlight drain&regen stuff
    if ply:GetNWBool("NH2COOP_FLASHLIGHT_ISON") and CurTime() > FLASHLIGHT_UPDATE_TIME then
        ply:SetNWFloat("FlashlightNH2Power", ply:GetNWFloat("FlashlightNH2Power", 100) - 1)
        FLASHLIGHT_UPDATE_TIME = CurTime() + FLASHLIGHT_DRAIN_TIME

        if ply:GetNWFloat("FlashlightNH2Power", 100) <= 0 then
            ply:SetNWBool("NH2COOP_FLASHLIGHT_ISON", false)
            ply:EmitSound("NH2.Flashlight")
            net.Start("_NH2_Flashlight")
                net.WriteBool(ply:GetNWBool("NH2COOP_FLASHLIGHT_ISON"))
            net.Send(ply)

            -- Disable flicker on zero power, since i saw that in sources of NH2
            net.Start("_NH2_ForceFlicker")
                net.WriteBool(false)
            net.Send(ply)

            ply:SetNWFloat("FlashlightNH2Power", 0)
        end
    elseif ply:GetNWFloat("FlashlightNH2Power", 100) < 100 and CurTime() > FLASHLIGHT_REGEN_TIME and not ply:GetNWBool("NH2COOP_FLASHLIGHT_ISON") then
        ply:SetNWFloat("FlashlightNH2Power", ply:GetNWFloat("FlashlightNH2Power", 100) + 1)
        FLASHLIGHT_REGEN_TIME = CurTime() + FLASHLIGHT_REGEN_DELAY
    end

        local model = ply:GetInfo("nh2coop_cl_playermodel")
    
    ply.CachedModel = ply.CachedModel or ""
    
    if ply.CachedModel ~= "models/humans/nh2/" .. model .. ".mdl" then
        ply.CachedModel = "models/humans/nh2/" .. ply:GetInfo("nh2coop_cl_playermodel") .. ".mdl"
        ply:SetModel(ply.CachedModel)
        ply:GetHands():SetModel("models/weapons/c_arms_citizen.mdl")

        print(model)
    end

    if IsValid(ply:GetActiveWeapon()) and string.StartWith(ply:GetActiveWeapon():GetClass(), "weapon_nh") then
        if model == "male_01" or model == "male_03" then
            ply:GetViewModel(0):SetSkin(1)
        else
            ply:GetViewModel(0):SetSkin(0)
        end
    end
end

--
--    Name: gamemode:CanPlayerUnfreeze( )
--    Desc: Can the player unfreeze this entity & physobject
--
function GM:CanPlayerUnfreeze(ply, entity, physobject)
    if entity:GetPersistent() and GetConVarString("sbox_persist"):Trim() ~= "" then return false end

    return true
end

--
--    Name: LimitReachedProcess
--
local function LimitReachedProcess(ply, str)
    if not IsValid(ply) then return true end

    return ply:CheckLimit(str)
end

--
--    Name: gamemode:PlayerSpawnRagdoll( ply, model )
--    Desc: Return true if it's allowed 
--
function GM:PlayerSpawnRagdoll(ply, model)
    return LimitReachedProcess(ply, "ragdolls")
end

--
--    Name: gamemode:PlayerSpawnProp( ply, model )
--    Desc: Return true if it's allowed 
--
function GM:PlayerSpawnProp(ply, model)
    return LimitReachedProcess(ply, "props")
end

--
--    Name: gamemode:PlayerSpawnEffect( ply, model )
--    Desc: Return true if it's allowed 
--
function GM:PlayerSpawnEffect(ply, model)
    return LimitReachedProcess(ply, "effects")
end

--
--    Name: gamemode:PlayerSpawnVehicle( ply, model, vname, vtable )
--    Desc: Return true if it's allowed 
--
function GM:PlayerSpawnVehicle(ply, model, vname, vtable)
    return LimitReachedProcess(ply, "vehicles")
end

--
--    Name: gamemode:PlayerSpawnSWEP( ply, wname, wtable )
--    Desc: Return true if it's allowed 
--
function GM:PlayerSpawnSWEP(ply, wname, wtable)
    return LimitReachedProcess(ply, "sents")
end

--
--    Name: gamemode:PlayerGiveSWEP( ply, wname, wtable )
--    Desc: Return true if it's allowed 
--
function GM:PlayerGiveSWEP(ply, wname, wtable)
    return true
end

--
--    Name: gamemode:PlayerSpawnSENT( ply, name )
--    Desc: Return true if player is allowed to spawn the SENT
--
function GM:PlayerSpawnSENT(ply, name)
    return LimitReachedProcess(ply, "sents")
end

--
--    Name: gamemode:PlayerSpawnNPC( ply, npc_type )
--    Desc: Return true if player is allowed to spawn the NPC
--
function GM:PlayerSpawnNPC(ply, npc_type, equipment)
    return LimitReachedProcess(ply, "npcs")
end

--
--    Name: gamemode:PlayerSpawnedRagdoll( ply, model, ent )
--    Desc: Called after the player spawned a ragdoll
--
function GM:PlayerSpawnedRagdoll(ply, model, ent)
    ply:AddCount("ragdolls", ent)
end

--
--    Name: gamemode:PlayerSpawnedProp( ply, model, ent )
--    Desc: Called after the player spawned a prop
--
function GM:PlayerSpawnedProp(ply, model, ent)
    ply:AddCount("props", ent)
end

--
--    Name: gamemode:PlayerSpawnedEffect( ply, model, ent )
--    Desc: Called after the player spawned an effect
--
function GM:PlayerSpawnedEffect(ply, model, ent)
    ply:AddCount("effects", ent)
end

--
--    Name: gamemode:PlayerSpawnedVehicle( ply, ent )
--    Desc: Called after the player spawned a vehicle
--
function GM:PlayerSpawnedVehicle(ply, ent)
    ply:AddCount("vehicles", ent)
end

--
--    Name: gamemode:PlayerSpawnedNPC( ply, ent )
--    Desc: Called after the player spawned an NPC
--
function GM:PlayerSpawnedNPC(ply, ent)
    ply:AddCount("npcs", ent)
end

--
--    Name: gamemode:PlayerSpawnedSENT( ply, ent )
--    Desc: Called after the player has spawned a SENT
--
function GM:PlayerSpawnedSENT(ply, ent)
    ply:AddCount("sents", ent)
end

--
--    Name: gamemode:PlayerSpawnedWeapon( ply, ent )
--    Desc: Called after the player has spawned a Weapon
--
function GM:PlayerSpawnedSWEP(ply, ent)
    -- This is on purpose..
    ply:AddCount("sents", ent)
end

--
--    Name: gamemode:PlayerEnteredVehicle( player, vehicle, role )
--    Desc: Player entered the vehicle fine
--
function GM:PlayerEnteredVehicle(player, vehicle, role)
    player:SendHint("VehicleView", 2)
end

--
-- 	These are buttons that the client is pressing. They're used
-- 	in Sandbox mode to control things like wheels, thrusters etc.
--
function GM:PlayerButtonDown(ply, btn)
    numpad.Activate(ply, btn)
end

--
-- 	These are buttons that the client is pressing. They're used
-- 	in Sandbox mode to control things like wheels, thrusters etc.
--
function GM:PlayerButtonUp(ply, btn)
    numpad.Deactivate(ply, btn)
end

util.AddNetworkString("_NH2_Flashlight")
util.AddNetworkString("_NH2_ForceFlicker")

---
--- Called whenever a player attempts to either turn on or off their 
--  flashlight, returning `false` will deny the change.
--
function GM:PlayerSwitchFlashlight(ply, enabled)
    if not ply:GetNWBool("NH2COOP_SUITPICKUPED") then return false end
    if GetGlobalBool("IsSpeedModified", false) then return false end

    ply:EmitSound("NH2.Flashlight")
    ply:SetNWBool("NH2COOP_FLASHLIGHT_ISON", not ply:GetNWBool("NH2COOP_FLASHLIGHT_ISON"))
    net.Start("_NH2_Flashlight")
        net.WriteBool(ply:GetNWBool("NH2COOP_FLASHLIGHT_ISON"))
    net.Send(ply)

    return false
end