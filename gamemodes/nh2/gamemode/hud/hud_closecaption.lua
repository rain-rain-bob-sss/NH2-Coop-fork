-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy
-- Limited recreation for Source Engine's closecaptions
-- Lack of multicoloring and multistyling
local CC_ENTRIES = {}
local CC_NOREPEAT = {}
local closecaptions_black = Color(0, 0, 0, 128)
local closecaptions_alpha = 0
local SetFont = surface.SetFont
local GetTextSize = surface.GetTextSize
local ExplodeString = string.Explode
local pairs = pairs
local closecaptions_height = 25

local function Wrap(font, text, width)
    SetFont(font)
    local sw = GetTextSize(' ')
    local ret = {}
    local w = 0
    local s = ''
    local t = ExplodeString('\n', text)

    for i = 1, #t do
        local t2 = ExplodeString(' ', t[i], false)

        for i2 = 1, #t2 do
            local neww = GetTextSize(t2[i2])

            if w + neww >= width then
                table.insert(ret, 1, s)
                w = neww + sw
                s = t2[i2] .. ' '
            else
                s = s .. t2[i2] .. ' '
                w = w + neww + sw
            end
        end

        table.insert(ret, 1, s)
        w = 0
        s = ''
    end

    if s ~= '' then
        table.insert(ret, 1, s)
    end

    return ret
end

net.Receive(NH2NET.CC, function(len, ply)
    local name = net.ReadString()
    local filen = net.ReadString()
    local localize = language.GetPhrase(name)
    local font = "NH_CloseCaption"
    if localize == name then return end
    if localize == '' or localize == ' ' then return end
    -- Don't repeat if already we've got an block
    if CC_NOREPEAT[name] then return end
    -- Strip SFX entries if we're don't want them
    if string.find(localize, "<sfx>") then return false end --and cc_subtitles:GetBool() 
    localize = string.Replace(localize, "<sfx>", '')
    local norepeat = tonumber(string.match(localize, "<norepeat:(%d+)>"))

    -- Don't repeat next sounds
    if norepeat and norepeat > 0 and not CC_NOREPEAT[name] then
        local no_repeat_entry = {}
        no_repeat_entry.duration = CurTime() + norepeat
        --print("Added to norepeat table:\nNo Repeat During: ", norepeat, "\nName: ", name)
        CC_NOREPEAT[name] = no_repeat_entry
    end

    localize = string.gsub(localize, "<norepeat:(%d+)>", '')
    local entry = {}

    if string.find(localize, "<clr:(%d+),(%d+),(%d+)>") then
        local r, g, b = string.match(localize, "<clr:(%d+),(%d+),(%d+)>")
        entry.color = Color(r, g, b)
    else
        entry.color = Color(255, 255, 255)
    end

    if string.find(localize, "<B>") or string.find(localize, "<b>") then
        font = "NH_CloseCaption"
    end

    if string.find(localize, "<I>") or string.find(localize, "<i>") then
        font = "NH_CloseCaptionItalic"
    end

    localize = string.gsub(localize, "<clr:(%d+),(%d+),(%d+)>", '')
    localize = string.gsub(localize, "<B>", '')
    localize = string.gsub(localize, "<I>", '')
    localize = string.gsub(localize, "<b>", '')
    localize = string.gsub(localize, "<i>", '')
    entry.text = language.GetPhrase(localize)
    entry.time = CurTime()
    entry.duration = SoundDuration(filen)
    entry.alpha = 0
    entry.dying = false
    entry.font = font
    table.insert(CC_ENTRIES, 1, entry)
end)

local function Paint(size)
    local closecaptions_width = ScrW() * 0.587
    surface.SetFont("NH_CloseCaption")
    closecaptions_black.a = closecaptions_alpha
    draw.RoundedBox(7, ScrW() * 0.207, (ScrH() * 0.859) - closecaptions_height, ScrW() * 0.587, closecaptions_height, closecaptions_black)

    if #CC_ENTRIES == 0 then
        closecaptions_alpha = math.Approach(closecaptions_alpha, 0, FrameTime() * 500)
    end

    local ac_y = 0
    local base_y = ScrH() * 0.847
    local mutual_height_of_items = 0

    for i = 1, #CC_ENTRIES do
        local entry = CC_ENTRIES[i]
        if not entry then continue end
        entry.warp = Wrap(entry.font, language.GetPhrase(entry.text), ScrW() * 0.56)

        if not entry.dying then
            entry.alpha = math.Approach(entry.alpha, 1, FrameTime() * 2)

            if CurTime() > entry.time + entry.duration then
                entry.dying = true
            end

            closecaptions_alpha = math.Approach(closecaptions_alpha, 128, FrameTime() * 500)
        else
            entry.alpha = math.Approach(entry.alpha, 0, FrameTime() * 4)

            if entry.alpha == 0 then
                table.remove(CC_ENTRIES, i)
            end
        end

        local alpha_backup = surface.GetAlphaMultiplier()
        surface.SetAlphaMultiplier(entry.alpha)

        for i1, wrapped in pairs(entry.warp) do
            ac_y = ac_y - select(2, surface.GetTextSize(wrapped))
            mutual_height_of_items = mutual_height_of_items + select(2, surface.GetTextSize(wrapped))
            surface.SetTextColor(entry.color)
            surface.SetTextPos(ScrW() * 0.216, base_y + ac_y)
            surface.DrawText(wrapped)
        end

        surface.SetAlphaMultiplier(alpha_backup)
    end

    closecaptions_height = math.Approach(closecaptions_height, ScrW() * 0.014 + mutual_height_of_items, FrameTime() * 400)
end

DECLARE_HUD_ELEMENT("HudClosecaptions", Paint)