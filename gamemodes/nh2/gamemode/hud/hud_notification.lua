-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

local DrawTexture = surface.DrawTexturedRect
local DrawTextureUV = surface.DrawTexturedRectUV
local SetMaterial = surface.SetMaterial
local SetColor = surface.SetDrawColor
local SetFont = surface.SetFont
local GetTextSize = surface.GetTextSize
local select = select
local lerp = math.Approach
local clamp = math.Clamp
local floor = math.floor

local GetAlpha = surface.GetAlphaMultiplier
local SetAlpha = surface.SetAlphaMultiplier

local DrawText = draw.SimpleText

local GetTextWidth = function(text)
    SetFont("NH_Notification")
    
    return select(1, GetTextSize(text))
end

local SelectedIcon = 2
local SelectedMessage = ""
local SelectedTime = 0
local alpha = 0

local INSTRUCTOR_ICONS = {
    [2] = Material("vgui/hud/gameinstructor_icon_2.png"),
    [3] = Material("vgui/hud/gameinstructor_icon_3.png"),
}

local bg = Material("vgui/hud/bar_bg.png")

net.Receive("_NH2_Notify", function(len, ply)
    SelectedIcon = net.ReadInt(8)
    SelectedMessage = language.GetPhrase(net.ReadString())
    SelectedTime = CurTime()
end)

local function Paint(size)
    if #SelectedMessage == 0 then return end
    
    local width = GetTextWidth(SelectedMessage)

    local backup_alpha = GetAlpha()

    SetAlpha(alpha)

    surface.SetDrawColor(255,255,255,255)

    if CurTime() < SelectedTime + (1 * clamp(floor(#SelectedMessage * 0.5), 3, 10)) then
        alpha = lerp(alpha, 1, FrameTime() * 5)
    else
        alpha = lerp(alpha, 0, FrameTime() * 5)
    end

    SetMaterial(bg)
    DrawTexture(size.x / 2 - (width + auto(150)) / 2, size.y * 0.2, width + auto(100), auto(85))

    DrawText(SelectedMessage, "NH_Notification", size.x / 2, size.y * 0.225, color_white, TEXT_ALIGN_CENTER)

    SetMaterial(INSTRUCTOR_ICONS[SelectedIcon])
    DrawTexture(size.x / 2 - auto(64) - width / 2, size.y * 0.21, auto(64), auto(64))

    SetAlpha(backup_alpha)
end

DECLARE_HUD_ELEMENT("HudNotifications", Paint, HUD_NOTINSPECTATOR)