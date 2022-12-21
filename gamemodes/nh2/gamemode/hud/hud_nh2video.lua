-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

-- Video hud element for fake "nh2_playvideo" command

-- Current playing frame
local CACHED_VIDEOS = {}

local frame = 1
local frameTime = CurTime()
local audio = NULL

local isPlayingVideo = false
local currentVideo = ""
local extension = ".png"
local audioExtension = ".mp3"

local DrawColor = surface.SetDrawColor
local DrawTexture = surface.DrawTexturedRect
local SetVideo = surface.SetMaterial
local SetMaterial = surface.SetMaterial

local ScreenWidth = ScrW()
local ScreenHeight = ScrH()

do
    local files, dirs = file.Find("media/*", "GAME")

    for _, dir in ipairs(dirs) do
        local frames = file.Find("media/" .. dir .. "/*.png", "GAME")
        
        for i, frame in pairs(frames) do
            CACHED_VIDEOS[dir] = CACHED_VIDEOS[dir] or {}
            CACHED_VIDEOS[dir][i] = Material("media/" .. dir .. "/" .. i .. ".png")
        end
    end
end

-- Whacky i know...
net.Receive("_NH2_StartPlayingVideo", function(len, ply)
    local vidName = net.ReadString()
    
    -- To get num of files
    local vidFrames = CACHED_VIDEOS[vidName]

    if (vidFrames) then
        frame = 1

        if ScreenWidth ~= ScrW() and ScreenHeight ~= ScrH() then
            ScreenWidth = ScrW()
            ScreenHeight = ScrH()
        end

        local audioName = "media/" .. vidName .. audioExtension
        audio = CreateSound(LocalPlayer(), audioName)

        currentVideo = vidName
        isPlayingVideo = true
    else
        MsgC(Color(245, 90, 90), "Failed to load video " .. vidName .. " - group of files missing from disk/repository\n")
    end
end)

local function Paint(size)
    if isPlayingVideo then
        if audio and not audio:IsPlaying() then
            audio:Play()
        end
        
        if frame < #CACHED_VIDEOS[currentVideo] then
            if (CurTime() > frameTime) then
                frame = frame + 1
                frameTime = CurTime() + 0.03
            end
    
            SetMaterial(CACHED_VIDEOS[currentVideo][frame])
            DrawColor(255, 255, 255, 255)
            DrawTexture(0, 0, ScreenWidth, ScreenHeight)
        else
            isPlayingVideo = false
        end
    end
end

DECLARE_HUD_ELEMENT("HudNH2Video", Paint)