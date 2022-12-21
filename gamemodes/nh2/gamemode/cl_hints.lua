-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

CreateClientConVar("cl_showhints", "1", true, false)

-- A list of hints we've already done so we don't repeat ourselves`
local ProcessedHints = {}

local cl_showhints = GetConVar("cl_showhints")

--
-- Throw's a Hint to the screen
--
local function ThrowHint(name)
    local show = cl_showhints:GetBool()
    if not show then return end
    if engine.IsPlayingDemo() then return end
    local text = language.GetPhrase("Hint_" .. name)
    local s, e, group = string.find(text, "%%([^%%]+)%%")

    while s do
        local key = input.LookupBinding(group)

        if not key then
            key = "<NOT BOUND>"
        end

        text = string.gsub(text, "%%([^%%]+)%%", "'" .. key:upper() .. "'")
        s, e, group = string.find(text, "%%([^%%]+)%%")
    end

    GAMEMODE:AddNotify(text, NOTIFY_HINT, 20)
    surface.PlaySound("ambient/water/drip" .. math.random(1, 4) .. ".wav")
end

--
-- Adds a hint to the queue
--
function GM:AddHint(name, delay)
    if ProcessedHints[name] then return end

    timer.Create("HintSystem_" .. name, delay, 1, function()
        ThrowHint(name)
    end)

    ProcessedHints[name] = true
end

--
-- Removes a hint from the queue
--
function GM:SuppressHint(name)
    timer.Remove("HintSystem_" .. name)
end