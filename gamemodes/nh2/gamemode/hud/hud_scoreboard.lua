local DrawBox = surface.DrawRect
local DrawOutline = surface.DrawOutlinedRect
local DrawTexture = surface.DrawTexturedRect
local DrawTextureUV = surface.DrawTexturedRectUV
local SetMaterial = surface.SetMaterial
local SetColor = surface.SetDrawColor
local SetFont = surface.SetFont
local DrawText = draw.SimpleText
local GetTextSize = surface.GetTextSize
local color_white = Color(255,255,255)

local GetTextSize = function(text, font)
    SetFont(font)

    return GetTextSize(text)
end

local barbg = Material("vgui/hud/bar_bg.png")
local barfgwhite = Material("vgui/hud/bar_fg_white.png")

local function Paint(size)
    if not GAMEMODE.ScoreboardOn then return end

    SetColor(0,0,0,127)
    DrawBox(0,0,size.x,size.y)

    local centerx,centery = size.x * 0.1,size.y * 0.08
    local x,y = centerx,centery
    local biggestw,biggesth = 0,0
    local font = "NH_ScoreBoard"
    local renders = {}
    for _,ply in ipairs(player.GetAll())do 
        local name = ply:Nick()
        local w,h = GetTextSize(name,font)
        w = w * 1.125
        h = h * 1.125
        if w > biggestw then 
            biggestw = w
        end
        if h > biggesth then 
            biggesth = h
        end
        renders[#renders+1] = {
            name = name,
            ply = ply,
        }
    end
    
    local maxcol = math.floor(ScrH() * (0.92 - 0.27) / biggesth)
    local ccol = 0
    for _,d in ipairs(renders) do 
        ccol = ccol + 1
        local w,h = biggestw,biggesth
        if ccol >= maxcol then 
            y = centery 
            ccol = 0
            x = x + w * 1.1
        end

        SetColor(0,0,0,127)
        DrawBox(x - w * 0.5,y - h * 0.5,w,h)

        SetColor(255,255,255,255)
        DrawOutline(x - w * 0.5,y - h * 0.5,w,h,6)

        SetMaterial(barbg)
        SetColor(255,255,255)
        DrawTexture(x - w * 0.5,y - h * 0.5,w,h)

        if not d.ply:Alive() then 
            SetMaterial(barfgwhite)
            SetColor(255,0,0,65)
            DrawTexture(x - w * 0.5,y - h * 0.5,w,h)
        end
        DrawText(d.name,font,x,y,color_white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)   
        y = y + h * 1.125
    end
end

DECLARE_HUD_ELEMENT("HudScoreboard", Paint)

function GM:ScoreboardShow()
    self.ScoreboardOn = true
    return true
end

function GM:ScoreboardHide()
    self.ScoreboardOn = false
    return true
end 