-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

NH2_HUD = {}
NH2_HUD.HUD_ELEMENTS = {}
NH2_HUD.HUD_BG_ELEMENTS = {}
NH2_HUD.Size = 0

HUD_SUITONLY = 1
HUD_ALIVEONLY = 2
HUD_NOTINSPECTATOR = 4

local W, H = ScrW(), ScrH()

auto = function(val)
    return H * (val / 1080)
end

autoInversed = function(val)
    return H / (val / 1080)
end

--
-- Add element to render it on screen
--
DECLARE_HUD_ELEMENT = function(name, func, flags)
    if not name or not func then return end

    flags = flags or 0

    local element = {}
    element.name = name
    element.paint = func
    element.flags = flags

    table.insert(NH2_HUD.HUD_ELEMENTS, 1, element)
    --MsgC(Color(0,255,0), "Added and initialized element on screen \"" .. name .. "\"\n")
end

--
-- Add element to render it on screen (behind of hud)
--
DECLARE_BACKGROUND_HUD_ELEMENT = function(name, func, flags)
    if not name or not func then return end

    flags = flags or 0

    local element = {}
    element.name = name
    element.paint = func
    element.flags = flags

    table.insert(NH2_HUD.HUD_BG_ELEMENTS, 1, element)
    --MsgC(Color(0,255,0), "Added and initialized background element on screen \"" .. name .. "\"\n")
end


--
-- Create fonts
--
function NH2_HUD.CreateFonts()
    surface.CreateFont("NH_Icons", {
        font = "HL2cross",
        size = auto(60),
        weight = 500
    })

    surface.CreateFont("NH_Numbers", {
        font = "Bebas Neue Cyrillic",
        size = ScrH() * 0.05,
        weight = 500,
        extended = true
    })

    surface.CreateFont("NH_Notification", {
        font = "Bebas Neue Cyrillic",
        size = auto(30),
        weight = 500,
        extended = true
    })

    surface.CreateFont("NH_NumbersSmaller", {
        font = "Bebas Neue Cyrillic",
        size = ScrH() * 0.041,
        weight = 500,
        extended = true
    })

    surface.CreateFont("NH_NumbersBigger", {
        font = "Bebas Neue Cyrillic",
        size = ScrH() * 0.06,
        weight = 500
    })

    surface.CreateFont("NH_AmmoIcon", {
        font = "HalfLife2",
        size = ScrH() * 0.08,
        weight = 500
    })    

    surface.CreateFont("NH_MapTitle", {
        font = "Bebas Neue Cyrillic",
        size = auto(45),
        weight = 500,
        extended = true
    })

    surface.CreateFont("NH_MapTitleSmaller", {
        font = "Bebas Neue Cyrillic",
        size = auto(32),
        weight = 500,
        extended = true
    })

    surface.CreateFont("NH_MapTitleSmall", {
        font = "Bebas Neue Cyrillic",
        size = auto(25),
        weight = 500,
        extended = true
    })

    surface.CreateFont("NH_BindSmall", {
        font = "Bebas Neue Cyrillic",
        size = auto(15),
        weight = 500,
        extended = true
    })
end

NH2_HUD.CreateFonts()

hook.Add("OnScreenSizeChanged", "NH2_ScreenResChanged", function(oldW, oldW)
    NH2_HUD.CreateFonts()

    W = ScrW()
    H = ScrH()
end)

---
--- Render HUD
---
function NH2_HUD.HUDPaint()
    --if IsValid(LocalPlayer()) then return end
    
    NH2_HUD.Size = {
        x = ScrW(),
        y = ScrH()
    }
    
    for i = 1, #NH2_HUD.HUD_ELEMENTS do
        local element = NH2_HUD.HUD_ELEMENTS[i]

        if bit.band(element.flags, HUD_SUITONLY) ~= 0 and not LocalPlayer():GetNWBool("NH2COOP_SUITPICKUPED") then continue end
        if bit.band(element.flags, HUD_ALIVEONLY) ~= 0 and not LocalPlayer():Alive() then continue end
        if bit.band(element.flags, HUD_NOTINSPECTATOR) ~= 0 and LocalPlayer():GetObserverMode() > 0 then continue end

        element.paint(NH2_HUD.Size)
    end
end

function NH2_HUD.HUDPaintBackground()
    NH2_HUD.Size = {
        x = ScrW(),
        y = ScrH()
    }
    
    for i = 1, #NH2_HUD.HUD_BG_ELEMENTS do
        local element = NH2_HUD.HUD_BG_ELEMENTS[i]

        if bit.band(element.flags, HUD_SUITONLY) ~= 0 and not LocalPlayer():GetNWBool("NH2COOP_SUITPICKUPED") then continue end
        if bit.band(element.flags, HUD_ALIVEONLY) ~= 0 and not LocalPlayer():Alive() then continue end

        element.paint(NH2_HUD.Size)
    end
end

local SetMaterial = surface.SetMaterial
local DrawOutline = surface.DrawOutlinedRect
local DrawBox = surface.DrawRect
local DrawTexture = surface.DrawTexturedRect
local SetColor = surface.SetDrawColor
local DrawText = draw.SimpleText

local NH2COOP_PLY_MODELS = {
    "male_01",
    "male_02",
    "male_03",
    "male_04",
    "male_05",
    "male_06",
    "male_07",
    "male_08",
    "male_09"
}

local NH2COOL_PLY_ICONS = {
    Material("vgui/hud/icon_01.png"),
    Material("vgui/hud/icon_02.png"),
    Material("vgui/hud/icon_03.png"),
    Material("vgui/hud/icon_04.png"),
    Material("vgui/hud/icon_05.png"),
    Material("vgui/hud/icon_06.png"),
    Material("vgui/hud/icon_07.png"),
    Material("vgui/hud/icon_08.png"),
    Material("vgui/hud/icon_09.png")
}

local male_placeholder = Material("vgui/hud/male_placeholder.png")

local function ShowMOTD()
    --if GetConVar("nh2coop_cl_playermodel"):GetString() ~= "" then return end

    local frame = vgui.Create("DFrame")
    
    frame:SetTitle("")
    frame:MakePopup()
    frame:SetSize(ScrW() * 0.7, ScrH() * 0.7)
    frame:Center()
    frame:SetDraggable(false)
    frame:ShowCloseButton(false)

    function frame:Paint(w,h)
        SetColor(0,0,0,176)
        DrawBox(0,0,w,h * 0.1)

        DrawBox(0,h * 0.105,w,h * 0.9)
        DrawText("Nightmare House 2 Coop", "NH_Numbers", auto(30), auto(10))
    end

    local fW, fH = frame:GetSize()

    local playerModel = vgui.Create("DButton", frame)
    playerModel:SetText("OK")
    playerModel:SetPos(fW * 0.03, fH * 0.9)
    playerModel:SetFont("NH_MapTitleSmall")
    playerModel:SizeToContentsX(auto(64))
    playerModel:SetHeight(auto(40))
    playerModel:SetTextColor(color_white)

    function playerModel:Paint(w,h)
        SetColor(0,0,0,64)
        DrawBox(0,0,w,h)

        SetColor(255,255,255,255)
        DrawOutline(0,0,w,h,auto(2))
    end

    function playerModel:DoClick()
        frame:Close()
    end

    for i = 1, 3 do
        local model = NH2COOP_PLY_MODELS[i]
        local mat = NH2COOL_PLY_ICONS[i]

        local button = vgui.Create("DButton", frame)
        button:SetText("")
        button:SetPos(fW * -0.25 + i * fW * 0.3, fH * 0.15)
        button:SetSize(fW * 0.3, fH * 0.2)

        function button:Paint(w,h)
            SetColor(0,0,0,64)
            DrawBox(0,0,w,h)

            SetColor(255,255,255,255)
            SetMaterial(mat)
            DrawTexture(0, 0, w, h)

            SetColor(255,255,255,255)
            DrawOutline(0,0,w,h,auto(2))   
        end

        function button:DoClick()
            GetConVar("nh2coop_cl_playermodel"):SetString(model)
        end
    end

    for i = 4, 6 do
        local model = NH2COOP_PLY_MODELS[i]
        local mat = NH2COOL_PLY_ICONS[i]

        i = math.Remap(i, 4, 6, 1, 3)        

        local button = vgui.Create("DButton", frame)
        button:SetText("")
        button:SetPos(fW * -0.25 + i * fW * 0.3, fH * 0.36)
        button:SetSize(fW * 0.3, fH * 0.2)

        function button:Paint(w,h)
            SetColor(0,0,0,64)
            DrawBox(0,0,w,h)
    
            SetColor(255,255,255,255)
            SetMaterial(mat)
            DrawTexture(0, 0, w, h)

            SetColor(255,255,255,255)
            DrawOutline(0,0,w,h,auto(2))
        end

        function button:DoClick()
            GetConVar("nh2coop_cl_playermodel"):SetString(model)
        end
    end

    for i = 7, 9 do        
        local model = NH2COOP_PLY_MODELS[i]
        local mat = NH2COOL_PLY_ICONS[i]

        i = math.Remap(i, 7, 9, 1, 3)

        local button = vgui.Create("DButton", frame)
        button:SetText("")
        button:SetPos(fW * -0.25 + i * fW * 0.3, fH * 0.57)
        button:SetSize(fW * 0.3, fH * 0.2)

        function button:Paint(w,h)
            SetColor(0,0,0,64)
            DrawBox(0,0,w,h)

            SetColor(255,255,255,255)
            SetMaterial(mat)
            DrawTexture(0, 0, w, h)
            
            SetColor(255,255,255,255)
            DrawOutline(0,0,w,h,auto(2))            
        end

        function button:DoClick()
            GetConVar("nh2coop_cl_playermodel"):SetString(model)
        end
    end    
end

concommand.Add("nh2coop_motd", ShowMOTD)

net.Receive("_NH2_MOTD", function(len, ply)
    ShowMOTD()
end)

include("hud/hud_blur.lua")
include("hud/hud_weins.lua")
include("hud/hud_credits.lua")
include("hud/hud_nh2video.lua")
include("hud/hud_reference.lua")

include("hud/hud_health.lua")
include("hud/hud_flashlight.lua")
include("hud/hud_suitpower.lua")
include("hud/hud_ammo.lua")
include("hud/hud_weapon_selector.lua")
include("hud/hud_resource_history.lua")
include("hud/hud_squad.lua")
include("hud/hud_crosshair.lua")
include("hud/hud_notification.lua")
include("hud/hud_spectator.lua")