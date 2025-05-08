-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

include("shared.lua")
include("networks.lua")
include("cl_spawnmenu.lua")
include("cl_notice.lua")
include("cl_hints.lua")
include("cl_worldtips.lua")
include("cl_search_models.lua")
include("cl_hud.lua")

-- NH2 Sound scripts
include("soundscripts/announcer_soundfiles.lua")
include("soundscripts/captionsample.lua")
include("soundscripts/emily_soundfiles.lua")
include("soundscripts/game_sounds.lua")
include("soundscripts/game_sounds_ambient_generic.lua")
include("soundscripts/game_sounds_weapons.lua")
include("soundscripts/nh2sounds.lua")
include("soundscripts/npc_sounds_nh_guard.lua")
include("soundscripts/npc_sounds_nhdemon.lua")
include("soundscripts/npc_sounds_nhzombie.lua")
include("soundscripts/npc_sounds_stalker.lua")
include("soundscripts/romero_soundfiles.lua")
include("soundscripts/swat_soundfiles.lua")

--
-- Make BaseClass available
--
DEFINE_BASECLASS("gamemode_base")

local physgun_halo = CreateConVar("physgun_halo", "1", {FCVAR_ARCHIVE}, "Draw the physics gun halo?")

CreateClientConVar("nh2coop_cl_playermodel", "", true, true, "Sets player's model")

function GM:Initialize()
    BaseClass.Initialize(self)
end

function GM:LimitHit(name)
    self:AddNotify("#SBoxLimit_" .. name, NOTIFY_ERROR, 6)
    surface.PlaySound("buttons/button10.wav")
end

function GM:OnUndo(name, strCustomString)
    if not strCustomString then
        local str = "#Undone_" .. name
        local translated = language.GetPhrase(str)

        if str == translated then
            -- No translation available, apply our own
            translated = string.format(language.GetPhrase("hint.undoneX"), language.GetPhrase(name))
        else
            -- Try to translate some of this
            local strmatch = string.match(translated, "^Undone (.*)$")

            if strmatch then
                translated = string.format(language.GetPhrase("hint.undoneX"), language.GetPhrase(strmatch))
            end
        end

        self:AddNotify(translated, NOTIFY_UNDO, 2)
    else
        -- This is a hack for SWEPs, etc, to support #translations from server
        local str = string.match(strCustomString, "^Undone (.*)$")

        if str then
            strCustomString = string.format(language.GetPhrase("hint.undoneX"), language.GetPhrase(str))
        end

        self:AddNotify(strCustomString, NOTIFY_UNDO, 2)
    end

    -- Find a better sound :X
    --surface.PlaySound("buttons/button15.wav")
end

function GM:OnCleanup(name)
    self:AddNotify("#Cleaned_" .. name, NOTIFY_CLEANUP, 5)
    -- Find a better sound :X
    --surface.PlaySound("buttons/button15.wav")
end

function GM:UnfrozeObjects(num)
    self:AddNotify(string.format(language.GetPhrase("hint.unfrozeX"), num), NOTIFY_GENERIC, 3)
    -- Find a better sound :X
    --surface.PlaySound("npc/roller/mine/rmine_chirp_answer1.wav")
end

function GM:HUDPaint()
    self:PaintWorldTips()
    -- Draw all of the default stuff
    BaseClass.HUDPaint(self)
    self:PaintNotes()

    NH2_HUD.HUDPaint()
end

function GM:HUDPaintBackground()
    BaseClass.HUDPaintBackground(self)
    
    NH2_HUD.HUDPaintBackground()
end

--
--	Draws on top of VGUI..
--
function GM:PostRenderVGUI()
    BaseClass.PostRenderVGUI(self)
end

local PhysgunHalos = {}
local SWATInTable = {}
local SWATCOLOR = Color(0,255,0,255)

--
--	Name: gamemode:DrawPhysgunBeam()
--	Desc: Return false to override completely
--
function GM:DrawPhysgunBeam(ply, weapon, bOn, target, boneid, pos)
    if physgun_halo:GetInt() == 0 then return true end

    if IsValid(target) then
        PhysgunHalos[ply] = target
    end

    return true
end

local ipairs = ipairs

function GM:PreDrawHalos()
    if GetGlobal2Int("NH2_CITIZEN_MEMBERS_COUNT", 0) == 0 then return end

    SWATInTable = {}

    for i, ent in ipairs(ents.FindByClass("npc_citizen*")) do
        if ent:GetClass() ~= "npc_citizen" then
            continue
        end

        local allowedModels = {
            "models/lua_replace/humans/group01/male_02.mdl",
            "models/lua_replace/humans/group01/male_03.mdl",
            "models/lua_replace/humans/group01/male_04.mdl",
            "models/lua_replace/humans/group01/male_05.mdl"
        }

        if not table.HasValue(allowedModels, ent:GetModel()) then
            continue
        end

        local tr = util.TraceLine( {
            start = ent:GetPos() + ent:GetAngles():Up() * 32,
            endpos = LocalPlayer():EyePos(),
            filter = { LocalPlayer(), ent },
            mask = MASK_OPAQUE
        } )

        if not tr.Hit then continue end

        SWATInTable[#SWATInTable + 1] = ent
    end

    halo.Add( SWATInTable, SWATCOLOR, 2, 2, 1, true, true )
end

--
--	Name: gamemode:NetworkEntityCreated()
--	Desc: Entity is created over the network
--
function GM:NetworkEntityCreated(ent)
    --
    -- If the entity wants to use a spawn effect
    -- then create a propspawn effect if the entity was
    -- created within the last second (this function gets called
    -- on every entity when joining a server)
    --
    if ent:GetSpawnEffect() and ent:GetCreationTime() > (CurTime() - 1.0) then
        local ed = EffectData()
        ed:SetOrigin(ent:GetPos())
        ed:SetEntity(ent)
        util.Effect("propspawn", ed, true, true)
    end
end

local tohide = {
    ["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true,
    ["CHudCrosshair"] = true,
    ["CHudQuickInfo"] = true,
    ["CHudSuitPower"] = true,
    ["CHudSquadStatus"] = true,
}

--
-- Draw element?
--
function GM:HUDShouldDraw(name)
    if not IsValid(LocalPlayer()) then return end

    if tohide[name] then
        return false
    end

    return self.BaseClass.HUDShouldDraw(self, name)
end

local plyMeta = FindMetaTable("Player")

local _HEADLIGHT = NULL
local _HEADLIGHT_POS = Vector(0,0,0)

local offset_light = 0
local offset_light_back = 0
local state_light = false

local FLASHLIGHT_TRACE = {}
local FLASHLIGHT_TRACE_BACK = {}

local forceflicker = CreateClientConVar("r_flashlightforceflicker", "0", false, false)
local flick_time = 0

local clamp = math.Clamp

plyMeta.FlashlightState = function() return state_light end

net.Receive("_NH2_Flashlight", function()
    state_light = net.ReadBool()

    if state_light == false then
        forceflicker:SetBool(false)
    end
end)

net.Receive("_NH2_ForceFlicker", function()
    forceflicker:SetBool(net.ReadBool())
end)

function GM:Think()
    local ply = LocalPlayer()
    local origin = ply:EyePos()
    local angles = ply:EyeAngles()

    FLASHLIGHT_TRACE = util.TraceLine({
        start = LocalPlayer():EyePos(),
        endpos = origin + angles:Forward() * 100,
        filter = function( ent ) return ent ~= LocalPlayer() end
    })

    FLASHLIGHT_TRACE_BACK = util.TraceLine({
        start = LocalPlayer():EyePos(),
        endpos = origin - angles:Forward() * 72,
        filter = function( ent ) return ent ~= LocalPlayer() end
    })

    if state_light == true then
        if not IsValid(_HEADLIGHT) then
            _HEADLIGHT = ProjectedTexture()
            _HEADLIGHT:SetPos(origin)
            _HEADLIGHT:SetAngles(angles)
            _HEADLIGHT:SetFarZ(768)
            _HEADLIGHT:SetFOV(60)
            _HEADLIGHT:SetShadowFilter(2)
            _HEADLIGHT:SetTexture("effects/flashlight001_nh2")
            _HEADLIGHT:Update()
        else
            offset_light = math.floor(math.Remap(math.sqrt(FLASHLIGHT_TRACE.HitPos:DistToSqr(origin)), 4, 100, 100, 4))
            offset_light_back = math.floor(math.Remap(math.sqrt(FLASHLIGHT_TRACE_BACK.HitPos:DistToSqr(origin)), 4, 72, 72, 4))

            if forceflicker:GetBool() then
                if CurTime() > flick_time then
                    if _HEADLIGHT:GetBrightness() == 1 then
                        _HEADLIGHT:SetBrightness(0)
                    else
                        _HEADLIGHT:SetBrightness(1)
                    end
                    flick_time = CurTime() + math.Rand(0.005, 0.35)
                end
            else
                _HEADLIGHT:SetBrightness(1)
            end

            --print("Forward: " .. offset_light)
            --print("Back: " .. offset_light_back)

            if ply:GetViewEntity() == ply then
                _HEADLIGHT:SetPos(origin)
                _HEADLIGHT:SetAngles(LerpAngle(0.1, _HEADLIGHT:GetAngles(), angles))
            else
                _HEADLIGHT:SetPos(ply:GetBonePosition(0) + ply:EyeAngles():Forward() * 10)
                _HEADLIGHT:SetAngles(ply:EyeAngles())
            end
            _HEADLIGHT:Update()
        end
    else
        if IsValid(_HEADLIGHT) then
            _HEADLIGHT:SetBrightness(0)
            _HEADLIGHT:Update()
        end
    end
end

--
-- Used to control buttons of player and bot (same as server)
--
function GM:StartCommand(ply, cmd)
    if bit.bor(cmd:GetButtons(), IN_ATTACK) ~= 0 then
        local tr = util.TraceLine( {
            start = ply:EyePos(),
            endpos = ply:EyePos() + ply:EyeAngles():Forward() * 8192,
            filter = function( ent ) return ( ent ~= ply ) end
        } )

        if tr.Hit and (tr.Entity:IsNPC() and (tr.Entity:GetClass() == "npc_citizen" or tr.Entity:GetClass() == "generic_actor") and not tr.Entity:GetNWBool("NH2COOP_IM_CRAZY_NOW", false)) or tr.Entity:IsPlayer() then
            ply.PointingAlly = true
            cmd:RemoveKey(IN_ATTACK)
        else
            ply.PointingAlly = false
        end
    end
end

--
--
--
function GM:HUDDrawTargetID()
end


--
--
--
function GM:DrawDeathNotice( x, y )
end

--
--
--
function GM:PlayerTick(ply, mv)
    if ply:GetViewEntity() ~= ply then
        ply:AddEffects(EF_NODRAW)
    else
        ply:RemoveEffects(EF_NODRAW)
    end
end

local explosion_blast_mul = 0
local lerp = math.Approach
local remap = math.Remap

--
--
--
function GM:EntityEmitSound(data)
    if (data.OriginalSoundName == "BaseExplosionEffect.Sound") then
        local blast_wave_distance = data.Pos:Distance(LocalPlayer():EyePos())
        local blast_wave_delay = remap(blast_wave_distance, 0, 4096, 0, 1)

        timer.Simple(blast_wave_delay, function()
            explosion_blast_mul = clamp(1 - blast_wave_delay, 0, 1)
        end)
    end
end

--
--
--
function GM:GetMotionBlurValues( h, v, f, r )
    f = LocalPlayer():GetVelocity():Length() * 0.00001 + (0.1 * explosion_blast_mul)

    explosion_blast_mul = lerp(explosion_blast_mul, 0, FrameTime() * 2)

    return h, v, f, 0.003 * explosion_blast_mul
end

--
--
--
function GM:Move(ply, mv)
    if input.WasKeyReleased(KEY_F3) and ply:IsAdmin() then
        ply:ConCommand("nh2coop_teleport_swats")
    end
end

--
--
--
net.Receive(NH2NET.CC, function(len, ply)
    local name = net.ReadString()
    local filen = net.ReadString()
    local text = language.GetPhrase(name)

    if text == name or text == '' or text == ' ' then return end
    if string.find(text, "<sfx>") then return end

    text = string.gsub(text, "<sfx>", "")

    -- Extract duration from <len:DURATION>
    local duration = SoundDuration(filen)
    local lenTag = string.match(text, "<len:([%d%.]+)>")
    if lenTag then
        duration = tonumber(lenTag) or duration
    end
    
    gui.AddCaption(text, duration, false)
end)


-- From:https://steamcommunity.com/sharedfiles/filedetails/?id=1146104662
-- I edited it.

local cl_vm_lag_enabled = CreateClientConVar("cl_nh2_vm_lag_enabled", "1", true)
local cl_vm_lag_scale = CreateClientConVar("cl_nh2_vm_lag_scale", "1.5", true)

local function VectorMA( start, scale, direction, dest )
	dest.x = start.x + direction.x * scale
	dest.y = start.y + direction.y * scale
	dest.z = start.z + direction.z * scale
end

local function CalcViewModelLag(vm, origin, angles, original_angles)
	local vOriginalOrigin = Vector(origin.x, origin.y, origin.z);
	local vOriginalAngles = Angle(angles.x, angles.y, angles.z);

	vm.m_vecLastFacing = vm.m_vecLastFacing or angles:Forward()

	local forward = angles:Forward();

	if (FrameTime() != 0.0) then
		local vDifference = forward - vm.m_vecLastFacing;

		local flSpeed = 2.5;

		local flDiff = vDifference:Length();
		if ( (flDiff > cl_vm_lag_scale:GetFloat()) and (cl_vm_lag_scale:GetFloat() > 0.0) ) then
			local flScale = flDiff / cl_vm_lag_scale:GetFloat();
			flSpeed = flSpeed * flScale;
		end

		VectorMA(vm.m_vecLastFacing, flSpeed * FrameTime(), vDifference, vm.m_vecLastFacing);

		vm.m_vecLastFacing:Normalize()
		VectorMA(origin, 5.0, vDifference * -1.0, origin);
	end

	local right, up;
	right = original_angles:Right()
	up = original_angles:Up()

	local pitch = original_angles[1];

	if (pitch > 180.0) then
		pitch = pitch - 360.0;
	elseif (pitch < -180.0) then
		pitch = pitch + 360.0;
	end

	if (cl_vm_lag_scale:GetFloat() == 0.0) then
		origin = vOriginalOrigin;
		angles = vOriginalAngles;
	end

	VectorMA(origin, -pitch * 0.035, forward, origin);
	VectorMA(origin, -pitch * 0.03, right,	origin);
	VectorMA(origin, -pitch * 0.02, up, origin);
end


do
	local function doLag(weapon, vm, oldPos, oldAng, pos, ang)
		if (IsValid(weapon) and weapon.GetIronSights and weapon:GetIronSights()) then
			vm.m_vecLastFacing = ang:Forward()
		else
			CalcViewModelLag(vm, pos, ang, oldAng)
		end
	end

	if (cl_vm_lag_enabled:GetInt() != 0) then
		hook.Add("CalcViewModelView", "HL2ViewModelSway", doLag)
	end

	cvars.AddChangeCallback("cl_nh2_vm_lag_enabled", function(var, old, new)
		if (tonumber(new) != 0) then
			hook.Add("CalcViewModelView", "HL2ViewModelSway", doLag)
		else
			hook.Remove("CalcViewModelView", "HL2ViewModelSway")
		end
	end)
end

spawnmenu.AddContentType("nh2_video",function(container,obj)
    if not obj.text then return end
    if not obj.vidname then return end
    
    if not NH2_CACHED_VIDEOS[obj.vidname] then return end
    local frames = NH2_CACHED_VIDEOS[obj.vidname]
    if not frames[1] then return end
	local image = vgui.Create("ContentIcon",container)
    image:SetWide(128)
    image:SetTall(128)
    image:InvalidateLayout( true )
    image.DoClick = function( s )
		RunConsoleCommand("nh2_playvideo",obj.vidname)
	end

    image.Image:SetMaterial(frames[1])

    local frame = 1
    local frametime = 0
    local midframe = math.floor(#frames / 2)
    local h = false
    function image:Think()
        if self:IsHovered() then 
            if not h then frame = 1 h = true end
            if frame < #frames then
                if CurTime() > frametime then 
                    frame = frame + 1
                    frametime = CurTime() + 0.03
                end
            else 
                frame = 1
            end
        else
            h = false
            frame = midframe
        end
        
        self.Image:SetMaterial(frames[frame])
    end

    image:SetName(obj.text)

    container:Add(image)

    return image
end)


hook.Add("PopulatePropMenu", "nh2_video", function()

    local contents = {}
    local addvid = function(vid,name)
        table.insert(contents,{
            type = "nh2_video",
            text = name,
            vidname = vid
        })
    end


    addvid("flashback_ceiling","FLASHBACK CEILING")
    addvid("flashback_cell","FLASHBACK CELL")
    addvid("flashback_ceilclose","FLASHBACK CELL CLOSE")
    addvid("flashback_core","FLASHBACK THE CORE")
    addvid("flashback_hang","FLASHBACK HANG")
    addvid("flashback_house","FLASHBACK HOUSE")
	spawnmenu.AddPropCategory( "nh2_videos", "NH2 Videos", contents, "icon16/box.png" )
end )