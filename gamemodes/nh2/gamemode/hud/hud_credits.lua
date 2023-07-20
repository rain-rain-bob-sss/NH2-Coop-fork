-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

-- Actually VGUI panel to render them even if HUD is hidden
-- by map

local SetColor = surface.SetDrawColor
local SetTextColor = surface.SetTextColor
local DrawRect = surface.DrawRect
local DrawTexture = surface.DrawTexturedRect
local SetMaterial = surface.SetMaterial
local DrawText = function( text, font, x, y, xalign, yalign )
    text	= tostring( text )
	font	= font		or "DermaDefault"
	x		= x			or 0
	y		= y			or 0
	xalign	= xalign	or TEXT_ALIGN_LEFT
	yalign	= yalign	or TEXT_ALIGN_TOP

	surface.SetFont( font )
	local w, h = surface.GetTextSize( text )

	if ( xalign == TEXT_ALIGN_CENTER ) then
		x = x - w / 2
	elseif ( xalign == TEXT_ALIGN_RIGHT ) then
		x = x - w
	end

	if ( yalign == TEXT_ALIGN_CENTER ) then
		y = y - h / 2
	elseif ( yalign == TEXT_ALIGN_BOTTOM ) then
		y = y - h
	end

	surface.SetTextPos( math.ceil( x ), math.ceil( y ) )
	surface.DrawText( text )

	return w, h
end

local lerp = math.Approach
local min = math.min

local nextCreditsTime = CurTime()
local currentCreditsIndex = 1
local currentAlpha = 0
local currentActive = false
local currentStartTime = CurTime()

CREDITS_PANEL = nil

local function InitCreditsPanel()
    currentCreditsIndex = 1
    currentAlpha = 0
    currentActive = false
    currentStartTime = CurTime()
    nextCreditsTime = CurTime()

    local credits_data = {
        {
            kind = "Logo",
            material = Material("vgui/hud/logo_t.png"),
            duration = 10,
            fadeIn = 5,
            fadeOut = 5
        },
        {
            kind = "CenterText",
            duration = 7,
            text = "NH2COOP.Credits.Team"
        },
        {
            kind = "TwoColumns",
            duration = 7,
            title = "NH2COOP.Credits.OriginalTeamTitle",
            items = {
                "NH2COOP.Credits.Team.Hen",
                "NH2COOP.Credits.Team.Harry"
            },
        },
        {
            kind = "TwoColumns",
            duration = 7,
            items = {
                "NH2COOP.Credits.Team.Carlos",
                "NH2COOP.Credits.Team.Christopher"
            },
        },
        {
            kind = "TwoColumns",
            duration = 7,
            items = {
                "NH2COOP.Credits.Team.Viktor",
                "NH2COOP.Credits.Team.Pedro"
            },
        },
        {
            kind = "TwoColumns",
            duration = 7,
            items = {
                "NH2COOP.Credits.Team.Damon",
                "NH2COOP.Credits.Team.Yoav"
            },
        },
        {
            kind = "TwoColumns",
            duration = 7,
            items = {
                "NH2COOP.Credits.Team.Aidin",
                "NH2COOP.Credits.Team.Joel"
            },
        },
        {
            kind = "TwoColumns",
            duration = 7,
            items = {
                "NH2COOP.Credits.Team.David",
                "NH2COOP.Credits.Team.Daniele"
            },
        },
        {
            kind = "CenterText",
            duration = 5,
            text = "NH2COOP.Credits.Team.Ido"
        },
        {
            kind = "CenterText",
            duration = 5,
            text = "NH2COOP.Credits.URAKOLOUY5"
        },
        {
            kind = "CenterText",
            duration = 5,
            text = "NH2COOP.Credits.Thanks"
        },
        {
            kind = "CenterText",
            duration = 5,
            text = "NH2COOP.Credits.Thanks.Valve"
        },
        {
            kind = "CenterText",
            duration = 5,
            text = "NH2COOP.Credits.Thanks.Facepunch"
        },
        {
            kind = "CenterText",
            duration = 5,
            text = "NH2COOP.Credits.Thanks.ZeqMacaw"
        },
        {
            kind = "CenterText",
            duration = 5,
            text = "NH2COOP.Credits.Thanks.ficool"
        },
        {
            kind = "CenterText",
            duration = 5,
            text = "NH2COOP.Credits.Thanks.DrVrej"
        },
    }

    for i, ply in ipairs(player.GetAll()) do
        if i > 5 then break end

        local data = {}

        data.kind = "CenterText"
        data.duration = 5
        data.text = ply:Name() .. language.GetPhrase("NH2COOP.Credits.Thanks.Player" .. i)

        credits_data[#credits_data + 1] = data
    end

    local elapsed = 0

    if CREDITS_PANEL or IsValid(CREDITS_PANEL) then
        CREDITS_PANEL:Remove()
    end

    CREDITS_PANEL = vgui.Create("DPanel")
    
    local credits = CREDITS_PANEL
    credits:SetSize(ScrW(), ScrH())

    function credits:Paint(width, height)
        SetColor(0,0,0,255)
        DrawRect(0,0,width,height)

        if credits_data[currentCreditsIndex] then
            local data = credits_data[currentCreditsIndex]
            local kind = data.kind or "CenterText"

            local duration = data.duration or 3

            -- Get start time to calculate times relatively
            if not currentActive then
                currentStartTime = CurTime()
                currentActive = true
                --print("Transition to view index" .. currentCreditsIndex)
            end

            -- Select kind to do stuff with credit's data
            if kind == "Logo" then
                local texture = data.material

                if not texture then
                    error("Expected material in " .. currentCreditsIndex .. " data (type" .. kind .. "), maybe you forgot to specify material?")
                end

                local fadeIn = data.fadeIn or 1
                local fadeOut = data.fadeOut or 1

                elapsed = CurTime() - currentStartTime

                -- Duration now is sum of fade durations end duration
                duration = fadeIn + duration + fadeOut
                nextCreditsTime = currentStartTime + duration

                local ffactor = min(elapsed / duration, 1)

                if elapsed < fadeIn then
                    currentAlpha = lerp(currentAlpha, 255, FrameTime() * (100 / fadeIn))
                elseif elapsed > duration - fadeOut then
                    currentAlpha = lerp(currentAlpha, 0, FrameTime() * (100 / fadeOut))
                end

                --print("Alpha ->" .. currentAlpha)

                local l_w, l_h = width * 0.73, height * 0.35

                SetColor(255,255,255,currentAlpha)
                SetMaterial(data.material)
                DrawTexture(width / 2 - l_w / 2, height / 2 - l_h / 2, l_w, l_h)
            elseif kind == "TwoColumns" then
                elapsed = CurTime() - currentStartTime
                
                local left = data.items[1] or ""
                local right = data.items[2] or ""

                local fadeIn, fadeOut = 3, 3

                SetTextColor(255,255,255,currentAlpha)
                DrawText(language.GetPhrase(left):upper(), "NH_Numbers", width * 0.5, height * 0.4, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                DrawText(language.GetPhrase(right):upper(), "NH_Numbers", width * 0.5, height * 0.6, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

                if elapsed < fadeIn then
                    currentAlpha = lerp(currentAlpha, 255, elapsed / fadeIn)
                elseif elapsed > duration - fadeOut then
                    currentAlpha = lerp(currentAlpha, 0, elapsed / fadeOut)
                end

                nextCreditsTime = currentStartTime + duration + 0.7
            elseif kind == "CenterText" then
                elapsed = CurTime() - currentStartTime
                
                local text = data.text or ""

                local fadeIn, fadeOut = 3, 3

                SetTextColor(255,255,255,currentAlpha)
                DrawText(language.GetPhrase(text), "NH_Numbers", width * 0.5, height * 0.5, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

                if elapsed < fadeIn then
                    currentAlpha = lerp(currentAlpha, 255, elapsed / fadeIn)
                elseif elapsed > duration - fadeOut then
                    currentAlpha = lerp(currentAlpha, 0, elapsed / fadeOut)
                end

                nextCreditsTime = currentStartTime + duration + 0.7
            end
        end

        //print("Current index:", currentCreditsIndex)
        //print("Current alpha:", currentAlpha)

        if CurTime() > nextCreditsTime and currentActive then
            currentAlpha = 0
            currentStartTime = CurTime()
            currentCreditsIndex = currentCreditsIndex + 1
            currentActive = false

            if currentCreditsIndex > #credits_data then
                self:Remove()
                if LocalPlayer() == player.GetAll()[1] then
                    LocalPlayer():ConCommand("disconnect")
                end
            end
        end
    end
end

net.Receive("_NH2_StartCredits", function()
    InitCreditsPanel()
end)