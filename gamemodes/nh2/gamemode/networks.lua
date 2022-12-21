-- NIGHTMARE HOUSE 2 PORT TO GMOD
-- Den Urakolouy

NH2NET = {
    CC = "NH2COOP_Closecaptions"
}

if SERVER then
    for k, v in pairs(NH2NET) do
        util.AddNetworkString(v)
    end
end