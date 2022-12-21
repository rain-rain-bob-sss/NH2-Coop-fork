-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

NH2_Player = {}

local this = NH2_Player

util.AddNetworkString("_NH2_SendAntiSingleplayer")
util.AddNetworkString("_NH2_NotifyCheckpointChangeIfFarFromIt")

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
            net.Start("_NH2_NotifyCheckpointChangeIfFarFromIt")
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

    --                                 Current map  -      Index       - Player's index
    local info = HARDCODED_CHECKPOINTS[game.GetMap()][CHECKPOINT_INDEX][ply:EntIndex()]
    local weps = HARDCODED_CHECKPOINTS[game.GetMap()][CHECKPOINT_INDEX].Weapons
    local hasSuit = HARDCODED_CHECKPOINTS[game.GetMap()][CHECKPOINT_INDEX].Suit

    ply:SetPos(info[1])
    ply:SetEyeAngles(info[2])

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