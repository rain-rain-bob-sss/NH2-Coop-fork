-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

AddCSLuaFile()

ENT.Type = "anim"
ENT.Spawnable = "true"
ENT.PrintName = "#item_suit"

if SERVER then
    function ENT:Initialize()
        self:SetRenderMode(RENDERMODE_NORMAL)
        self:SetModel("models/items/hevsuit.mdl")
        self:UseTriggerBounds(true, 0)
        self:SetTrigger(true)
    end

    function ENT:Touch(activator)
        if activator:IsPlayer() then
            activator:SetNWBool("NH2COOP_SUITPICKUPED", true)
            activator:SetWalkSpeed(150)
            activator:SetRunSpeed(230)
            --self:Remove()
        end
    end
end