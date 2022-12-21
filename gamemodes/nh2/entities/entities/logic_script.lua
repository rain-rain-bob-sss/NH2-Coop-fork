-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

-- Handles Source Engine like's vscripts but on Lua
-- lua_run is a shit!

ENT.Spawnable = false
ENT.Type = "point"

if SERVER then
    ENT.CachedFile = ""
    ENT.CachedChunk = ""

    local COLOR_SCRIPT_SCOPE = Color(87,241,216)

    function ENT:KeyValue(k,v)
        if k == "spawnflags" then
            self.SpawnFlags = tonumber(v)
        end

        -- First, load files
        if k == "scriptFile" then
            self.CachedFile = "mapscripts/" .. v .. ".lua"
            if bit.band(self.SpawnFlags, 1) ~= 0 then
                timer.Simple(0.0, function()
                    include(self.CachedFile)
                    MsgC(COLOR_SCRIPT_SCOPE, "logic_script executed " .. self.CachedFile .. " script\n")
                end)
            end
        end

        -- It's required to call chunk after file (so we can load any function and etc.)
        if k == "scriptChunk" then
            self.CachedChunk = v
            if bit.band(self.SpawnFlags, 1) ~= 0 then
                RunString(self.CachedChunk)
            end
        end

        -- Think hook
        if k == "thinkHook" then
            self.CallThinkHook = tobool(v)
        end
    end

    function ENT:Think()
        if self.CallThinkHook and Think then
            Think()
        end
    end

    function ENT:AcceptInput(name, activator, caller, data)
        if name == "LoadFile" then
            if v == "" then
                include(self.CachedFile)
                MsgC(COLOR_SCRIPT_SCOPE, "logic_script executed " .. self.CachedFile .. " script\n")
            else
                include(data)
                MsgC(COLOR_SCRIPT_SCOPE, "logic_script executed " .. data .. ".lua script\n")
            end
        end

        if name == "LoadChunk" then
            if v == "" then
                RunString(self.CachedChunk)
            else
                RunString(data)
            end
        end
    end
end