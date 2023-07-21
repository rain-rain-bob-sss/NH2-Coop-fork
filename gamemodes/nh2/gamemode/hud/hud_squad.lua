-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy
local DrawTexture = surface.DrawTexturedRect
local DrawTextureUV = surface.DrawTexturedRectUV
local SetMaterial = surface.SetMaterial
local SetColor = surface.SetDrawColor
local clamp = math.Clamp
local bg = Material("vgui/hud/bar_bg.png")
local mask = Material("vgui/hud/swat.png")
local ipairs = ipairs
local ByClass = ents.FindByClass

local targetnames = {
    ["SWATL"] = true,
    ["SWAT1"] = true,
    ["SWAT2"] = true,
    ["SWAT3"] = true
}

local function Paint(size)
    local count = GetGlobal2Int("NH2_CITIZEN_MEMBERS_COUNT", 0)
    count = clamp(count, 0, 4)
    if count == 0 then return end
    SetColor(255, 255, 255, 255)
    SetMaterial(bg)
    DrawTexture(auto(33), size.y - auto(170), auto(292), auto(75))
    SetMaterial(mask)

    for i = 1, count do
        DrawTexture(auto(-20) + i * auto(66), size.y - auto(165), auto(64), auto(64))
    end
end

DECLARE_HUD_ELEMENT("HudSquad", Paint, HUD_SUITONLY + HUD_ALIVEONLY + HUD_NOTINSPECTATOR)