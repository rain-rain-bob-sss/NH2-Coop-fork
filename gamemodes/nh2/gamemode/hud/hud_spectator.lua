-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy
local DrawBox = surface.DrawRect
local DrawTexture = surface.DrawTexturedRect
local DrawTextureUV = surface.DrawTexturedRectUV
local SetMaterial = surface.SetMaterial
local SetColor = surface.SetDrawColor
local SetFont = surface.SetFont
local DrawText = draw.SimpleText
local GetTextSize = surface.GetTextSize

local GetTextWidth = function(text, font)
    SetFont(font)

    return select(1, GetTextSize(text))
end

local BottomBoxHeight = 140
local LeftClick, RightClick = Material("vgui/hud/gameinstructor_icon_0.png"), Material("vgui/hud/gameinstructor_icon_1.png")
local ScrollClick = Material("vgui/hud/gameinstructor_icon_8.png")
local ScrollUp, ScrollDown = Material("vgui/hud/gameinstructor_icon_6.png"), Material("vgui/hud/gameinstructor_icon_7.png")
local ButtonClick = Material("vgui/hud/gameinstructor_icon_4.png")
local ButtonLongClick = Material("vgui/hud/gameinstructor_icon_5.png")
local NoBind = Material("vgui/hud/gameinstructor_icon_9.png")
local fgWhite = Material("vgui/hud/bar_fg_white.png")
local bgBig = Material("vgui/hud/bigbar.png")
local bar_bg = Material("vgui/hud/bar_bg.png")
local lerp = math.Approach
local remap = math.Remap
local clamp = math.Clamp
local upper = string.upper
local L = language.GetPhrase

local GRAPHIC_BINDS = {
    ["MOUSE1"] = LeftClick,
    ["MOUSE2"] = RightClick,
    ["MOUSE3"] = ScrollClick,
    ["MWHEELUP"] = ScrollUp,
    ["MWHEELDOWN"] = ScrollDown
}

local ChapterNames = {
    ["nh1remake1_v2"] = "#NH2COOP.Chapter0",
    ["nh2c1_v2"] = "#NH2COOP.Chapter1",
    ["nh2c2_v2"] = "#NH2COOP.Chapter2",
    ["nh2c3_v2"] = "#NH2COOP.Chapter3",
    ["nh2c4_v2"] = "#NH2COOP.Chapter4",
    ["nh2c5_v2"] = "#NH2COOP.Chapter5",
    ["nh2c6_v2"] = "#NH2COOP.Chapter6",
    ["nh2c7_v2"] = "#NH2COOP.Chapter7",
    ["nightmare_house1"] = "NH1",
    ["nightmare_house2"] = "NH1",
    ["nightmare_house3"] = "NH1",
    ["nightmare_house4"] = "NH1",
    ["gm_flatgrass"] = "FLATGRASS",
}

local function Paint(size)
    if LocalPlayer():GetObserverMode() == 0 then return end
    if GetGlobal2Bool("NH2COOP_RESTARTING_LEVEL", false) then return end
    SetColor(255, 255, 255, 255)
    SetMaterial(bgBig)
    DrawTexture(0, 0, size.x, auto(BottomBoxHeight))
    DrawTexture(0, size.y - auto(BottomBoxHeight), size.x, auto(BottomBoxHeight))
    local space = input.LookupBinding("+jump")
    local spaceWidth = 32
    local spaceGraphics = false

    if ChapterNames[game.GetMap()] then
        DrawText("#NH2COOP.ChapterTitle", "NH_MapTitleSmaller", 50, 35)
        DrawText(ChapterNames[game.GetMap()], "NH_MapTitle", 50, 60)
    end

    SetColor(255, 255, 255, 255)
    local attack1 = input.LookupBinding("+attack")
    local attack1Width = 32
    local attack1Graphics = false
    local attack2 = input.LookupBinding("+attack2")
    local attack2Width = 32
    local attack2Graphics = false

    if IsValid(LocalPlayer():GetObserverTarget()) and (LocalPlayer():GetObserverMode() == OBS_MODE_IN_EYE or LocalPlayer():GetObserverMode() == OBS_MODE_CHASE) then
        if attack1 then
            if GRAPHIC_BINDS[attack1] then
                SetMaterial(GRAPHIC_BINDS[attack1])
                attack1Graphics = true
            elseif #attack1 == 1 then
                SetMaterial(ButtonClick)
            else
                SetMaterial(ButtonLongClick)
                attack1Width = 96
            end
        else
            attack1Graphics = true
            SetMaterial(NoBind)
            attack1Width = 96
        end

        DrawTexture(size.x - auto(attack1Width) - auto(50), auto(15), auto(attack1Width), auto(32))
        DrawText("#NH2COOP.PreviousPlayer", "NH_MapTitleSmall", size.x - auto(attack1Width) - auto(50), auto(19), color_white, TEXT_ALIGN_RIGHT)

        if not attack1Graphics then
            DrawText(upper(attack1), "NH_BindSmall", size.x - auto(50) - auto(attack1Width) / 2, auto(23), color_black, TEXT_ALIGN_CENTER)
        end

        if attack2 then
            if GRAPHIC_BINDS[attack2] then
                SetMaterial(GRAPHIC_BINDS[attack2])
                attack2Graphics = true
            elseif #attack1 == 1 then
                SetMaterial(ButtonClick)
            else
                SetMaterial(ButtonLongClick)
                attack2Width = 96
            end
        else
            attack2Graphics = true
            SetMaterial(NoBind)
            attack2Width = 96
        end

        DrawTexture(size.x - auto(attack2Width) - auto(50), auto(50), auto(attack2Width), auto(32))
        DrawText("#NH2COOP.NextPlayer", "NH_MapTitleSmall", size.x - auto(attack2Width) - auto(50), auto(54), color_white, TEXT_ALIGN_RIGHT)

        if not attack2Graphics then
            DrawText(upper(attack2), "NH_BindSmall", size.x - auto(50) - auto(attack2Width) / 2, auto(58), color_black, TEXT_ALIGN_CENTER)
        end

        local target = LocalPlayer():GetObserverTarget()
        target.healthWidth = target.healthWidth or clamp(remap(target:Health(), 0, target:GetMaxHealth(), 0, 210), 0, 210)
        target.healthWidth = lerp(target.healthWidth, clamp(remap(target:Health(), 0, target:GetMaxHealth(), 0, 210), 0, 210), FrameTime() * auto(120))
        SetMaterial(fgWhite)
        SetColor(255, 255, 255, 128)
        DrawTextureUV(size.x / 2 - auto(210) / 2 + auto(25), size.y - auto(75), auto(target.healthWidth), auto(45), 0, 0, target.healthWidth / auto(210), 1)
        DrawText(clamp(target:Health(), 0, target:GetMaxHealth()), "NH_Numbers", size.x / 2 - auto(110) + auto(25), size.y - auto(80), color_white, TEXT_ALIGN_RIGHT)
        DrawText(L"#NH2COOP.Spectating" .. target:Nick(), "NH_MapTitleSmaller", size.x / 2, size.y - auto(125), color_white, TEXT_ALIGN_CENTER)
        SetMaterial(bar_bg)
        SetColor(0, 0, 0, 196)
        DrawTexture(size.x / 2 - auto(110) + auto(25) - GetTextWidth(target:Health(), "NH_Numbers"), size.y - auto(80), GetTextWidth(target:Health(), "NH_Numbers"), auto(55))
        DrawTexture(size.x / 2 - GetTextWidth(L"#NH2COOP.Spectating" .. target:Nick(), "NH_MapTitleSmaller") / 2, size.y - auto(125), GetTextWidth(L"#NH2COOP.Spectating" .. target:Nick(), "NH_MapTitleSmaller"), auto(30))
    end

    SetColor(255, 255, 255, 255)

    if space then
        if GRAPHIC_BINDS[space] then
            SetMaterial(GRAPHIC_BINDS[space])
            spaceGraphics = true
        elseif #attack1 == 1 then
            SetMaterial(ButtonClick)
        else
            SetMaterial(ButtonLongClick)
            spaceWidth = 96
        end
    else
        spaceGraphics = true
        SetMaterial(NoBind)
        spaceWidth = 96
    end

    DrawTexture(size.x - auto(spaceWidth) - auto(50), auto(85), auto(spaceWidth), auto(32))
    DrawText(L"NH2COOP.SpectatorMode", "NH_MapTitleSmall", size.x - auto(spaceWidth) - auto(50), auto(88), color_white, TEXT_ALIGN_RIGHT)

    if not spaceGraphics then
        DrawText(upper(space), "NH_BindSmall", size.x - auto(50) - auto(spaceWidth) / 2, auto(93), color_black, TEXT_ALIGN_CENTER)
    end
end

DECLARE_HUD_ELEMENT("HudSpectator", Paint)