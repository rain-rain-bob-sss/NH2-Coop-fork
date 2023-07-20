-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

local weins = Material("vgui/hud/veins.vmt")

local SetMaterial = surface.SetMaterial
local SetDrawColor = surface.SetDrawColor
local DrawTexturedRect = surface.DrawTexturedRect
local SurfSound = surface.PlaySound

local NextHeartBeatTime = CurTime()

local function Paint(size)
    if not IsValid(LocalPlayer()) then return end

    if LocalPlayer():Health() > 20 then
        LocalPlayer():SetDSP(0)
        return
    end

    SetMaterial(weins)
    SetDrawColor(255,255,255,255)
    DrawTexturedRect(0,0,size.x, size.y)

    LocalPlayer():SetDSP(LocalPlayer():Health() <= 10 and 16 or 14)

    if CurTime() > NextHeartBeatTime then
        SurfSound("player/heartbeat3.wav")
        NextHeartBeatTime = CurTime() + 0.8
    end
end

DECLARE_BACKGROUND_HUD_ELEMENT("HudWeins", Paint)