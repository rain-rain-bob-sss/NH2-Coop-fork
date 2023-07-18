-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

NH2_Player = {}

local this = NH2_Player

util.AddNetworkString("_NH2_SendAntiSingleplayer")
util.AddNetworkString("_NH2_Notify")

local CHECKPOINT_INDEX = 0

-- Called from init.lua
function this.Spawn(player, isTransition)
    player:SetNWBool("NH2COOP_SUITPICKUPED", false)

    player:SetNWFloat("FlashlightNH2Power", 100)
    player:SetNWBool("NH2COOP_FLASHLIGHT_ISON", false)
end

function this.SetCheckpointIndex(index)
    CHECKPOINT_INDEX = index
end

function this.MoveToCheckpoint(force)
    if GetConVar("nh2coop_sv_disable_checkpoints"):GetBool() then return end
    
    for i, ply in ipairs(player.GetAll()) do
        local info = HARDCODED_CHECKPOINTS[game.GetMap()][CHECKPOINT_INDEX][ply:EntIndex()]
        
        if not info then return end

        local distanceCheck = HARDCODED_CHECKPOINTS[game.GetMap()][CHECKPOINT_INDEX].Distance or HARDCODED_CHECKPOINTS[game.GetMap()].distance
        local ignoreOnSurvival = HARDCODED_CHECKPOINTS[game.GetMap()][CHECKPOINT_INDEX].ignoreOnSurvival

        if force then
            distanceCheck = 32768
        end

        if ply:Alive() and ply:GetPos():Distance(info[1]) > distanceCheck then
            net.Start("_NH2_Notify")
                net.WriteInt(2, 8)
                net.WriteString("NH2.FarTeleport")
            net.Send(ply)

            ply:SetPos(info[1])
            ply:SetEyeAngles(info[2])
        elseif GetConVar("nh2coop_sv_survival_mode"):GetBool() and not ignoreOnSurvival then
            ply.CanRespawn = true
        end
    end
end

function this.SelectSpawnPoint(ply, isTransition)
    if game.SinglePlayer() then
        net.Start("_NH2_SendAntiSingleplayer")
        net.Send(ply)
    end

    local mapinfo = HARDCODED_CHECKPOINTS[game.GetMap()]

    if mapinfo == nil then
        local spawns = ents.FindByClass("info_player_start")
        local random_entry = math.random(#spawns)

        local spawn = spawns[random_entry]

        if #spawns == 0 then
            ply:SetPos(vector_origin)
        end

        ply:SetPos(spawn:GetPos())
        return
    end

    local info = mapinfo[CHECKPOINT_INDEX]
    local weps = info.Weapons
    local hasSuit = info.Suit

    if (info[ply:EntIndex()]) then
        ply:SetPos(info[ply:EntIndex()][1])
        ply:SetEyeAngles(info[ply:EntIndex()][2])
    else
        ply:SetPos(info[1][1])
        ply:SetEyeAngles(info[1][2])
    end

    if weps then
        for i = 1, #weps do
            ply:Give(weps[i])
        end
    end

    if hasSuit then
        timer.Simple(0.0, function()
            ply:SetNWBool("NH2COOP_SUITPICKUPED", true)

            ply:SetWalkSpeed(150)
            ply:SetRunSpeed(230)
        end)
    end
end