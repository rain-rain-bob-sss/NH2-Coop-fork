

-- These files get sent to the client
AddCSLuaFile("networks.lua")
AddCSLuaFile("cl_hints.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_notice.lua")
AddCSLuaFile("cl_search_models.lua")
AddCSLuaFile("cl_spawnmenu.lua")
AddCSLuaFile("cl_worldtips.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("persistence.lua")
AddCSLuaFile("player_extension.lua")
AddCSLuaFile("save_load.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("gui/IconEditor.lua")
include("shared.lua")
include("networks.lua")
include("commands.lua")
include("nh2_player.lua")
include("player.lua")
include("spawnmenu/init.lua")

-- Hud Files
AddCSLuaFile("hud/hud_blur.lua")
AddCSLuaFile("hud/hud_closecaption.lua")
AddCSLuaFile("hud/hud_nh2video.lua")
AddCSLuaFile("hud/hud_reference.lua")

AddCSLuaFile("hud/hud_health.lua")
AddCSLuaFile("hud/hud_flashlight.lua")
AddCSLuaFile("hud/hud_suitpower.lua")
AddCSLuaFile("hud/hud_ammo.lua")
AddCSLuaFile("hud/hud_weapon_selector.lua")
AddCSLuaFile("hud/hud_resource_history.lua")
AddCSLuaFile("hud/hud_squad.lua")
AddCSLuaFile("hud/hud_crosshair.lua")
AddCSLuaFile("hud/hud_notification.lua")
AddCSLuaFile("hud/hud_spectator.lua")

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

local ipairs = ipairs

-- Place them here
-- All checkpoint positions
HARDCODED_CHECKPOINTS = {
    ["nh1remake1_v2"] = {
        distance = 768,
        
        [0] = {
            [1] = { Vector(-2908, -326, -4), Angle(0, 0, 0) },
            [2] = { Vector(-2927, -265, -2), Angle(0, 0, 0) },
            [3] = { Vector(-3012, -351, -4), Angle(0, 0, 0) },
            [4] = { Vector(-3043, -297, -4), Angle(0, 0, 0) },
        },
        [1] = {
            Distance = 390,

            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol"
            },
            
            [1] = { Vector(331, 20, -362), Angle(0, 0, 0) },
            [2] = { Vector(277, 20, -362), Angle(0, 0, 0) },
            [3] = { Vector(238, 20, -362), Angle(0, 0, 0) },
            [4] = { Vector(194, 20, -362), Angle(0, 0, 0) },
        },  
        [2] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol"
            },

            [1] = { Vector(651, -1210, -236), Angle(0, -90, 0) },
            [2] = { Vector(649, -1164, -236), Angle(0, -90, 0) },
            [3] = { Vector(648, -1126, -236), Angle(0, -90, 0) },
            [4] = { Vector(646, -1076, -236), Angle(0, -90, 0) },
        },
        [3] = {            
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_shotgun"
            },

            [1] = { Vector(1724, -880, -672), Angle(0, -90, 0) },
            [2] = { Vector(1724, -833, -672), Angle(0, -90, 0) },
            [3] = { Vector(1724, -794, -672), Angle(0, -90, 0) },
            [4] = { Vector(1724, -729, -672), Angle(0, -90, 0) },
        },
        [4] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_shotgun"
            },
            Distance = 230,

            [1] = { Vector(1449, -1077, -567), Angle(1, -180, 0) },
            [2] = { Vector(1519, -1077, -604), Angle(1, -180, 0) },
            [3] = { Vector(1572, -1077, -650), Angle(1, -180, 0) },
            [4] = { Vector(1600, -1077, -650), Angle(1, -180, 0) },
        },
        [5] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_shotgun"
            },

            [1] = { Vector(-268, -439, 8), Angle(0, -180, 0) },
            [2] = { Vector(-198, -481, 8), Angle(0, -180, 0) },
            [3] = { Vector(-197, -547, 8), Angle(0, -180, 0) },
            [4] = { Vector(-140, -596, 8), Angle(0, -180, 0) },
        }               
    },
    ["nh2c1_v2"] = {
        distance = 512,

        [0] = {
            [1] = { Vector(-124.27363586426, -34.30139541626, 0.03125), Angle(0, -32, 0) },
            [2] = { Vector(260.31228637695, -97.609771728516, 0.03125), Angle(0, 150, 0) },
            [3] = { Vector(257.06195068359, 168.42236328125, 0.015739440917969), Angle(1, 150, 0) },
            [4] = { Vector(-130.07118225098, 226.79965209961, 0.03125), Angle(0, -32, 0) },
        },
        [1] = {
            Distance = 1024,

            Suit = true,
            Weapons = {
                "weapon_nh_hatchet"
            },

            [1] = { Vector(706.47015380859, 1148.7501220703, 0.03125), Angle(0, -180, 0) },
            [2] = { Vector(812.90545654297, 1152.8975830078, 0.03125), Angle(0, -180, 0) },
            [3] = { Vector(889.81781005859, 1155.89453125, 0.03125), Angle(0, -180, 0) },
            [4] = { Vector(975.81414794922, 1159.2454833984, 0.03125), Angle(0, -180, 0) },
        },
        [2] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet"
            },
            
            [1] = { Vector(-689.47772216797, 927.26489257813, 0.03125), Angle(0, 90, 0) },
            [2] = { Vector(-687.38464355469, 832.13610839844, 0.03125), Angle(0, 90, 0) },
            [3] = { Vector(-685.84143066406, 762.00103759766, 0.03125), Angle(0, 90, 0) },
            [4] = { Vector(-612.61004638672, 798.66314697266, 0.03125), Angle(0, 120, 0) },
        },
        [3] = {
            Distance = 225,

            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol"
            },

            [1] = { Vector(-1519.6239013672, 309.50411987305, 0.03125), Angle(0, -177, 0) },
            [2] = { Vector(-1481.1042480469, 283.30349731445, 0.03125), Angle(0, -177, 0) },
            [3] = { Vector(-1459.1457519531, 340.16491699219, 0.03125), Angle(0, -177, 0) },
            [4] = { Vector(-1425.6412353516, 311.95901489258, 0.03125), Angle(0, -177, 0) },
        },
    },
    ["nh2c2_v2"] = {
        distance = 768,
        
        [0] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol"
            },
            
            [1] = { Vector(-1498.6109619141, -176.26156616211, 2.4324722290039), Angle(0, 90, 0) },
            [2] = { Vector(-1446.3387451172, -175.67723083496, 2.4324722290039), Angle(0, 90, 0) },
            [3] = { Vector(-1445.8670654297, -218.08396911621, 1.2996292114258), Angle(0, 90, 0) },
            [4] = { Vector(-1500.4119873047, -218.69371032715, 1.2996292114258), Angle(0, 90, 0) },
        },   
        [1] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol"
            },
            
            [1] = { Vector(-1524.7529296875, -44.90983581543, 2560.03125), Angle(0, 138, 0) },
            [2] = { Vector(-1450.3697509766, -31.344432830811, 2560.03125), Angle(0, -180, 0) },
            [3] = { Vector(-1450.2230224609, -81.042213439941, 2560.03125), Angle(0, -180, 0) },
            [4] = { Vector(-1401.3244628906, -50.768238067627, 2560.03125), Angle(0, -180, 0) },
        },
        [2] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol"
            },
            
            [1] = { Vector(-3362.4916992188, -1740.3166503906, 2561.03125), Angle(0, 0, 0) },
            [2] = { Vector(-3434.8779296875, -1707.7854003906, 2560.03125), Angle(0, 0, 0) },
            [3] = { Vector(-3434.7502441406, -1756.8984375, 2560.03125), Angle(0, 0, 0) },
            [4] = { Vector(-3486.0993652344, -1741.3182373047, 2560.03125), Angle(0, 0, 0) },
        },
        [3] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol"
            },
            
            [1] = { Vector(-2931.9738769531, -1865.177734375, 2560.03125), Angle(2, -34, 0) },
            [2] = { Vector(-2982.2048339844, -1880.2055664063, 2560.03125), Angle(4, -18, 0) },
            [3] = { Vector(-2984.603515625, -1840.3465576172, 2560.03125), Angle(4, -18, 0) },
            [4] = { Vector(-3023.96875, -1854.6627197266, 2560.03125), Angle(4, -18, 0) },
        },
        [4] = {
            [1] = { Vector(-2175.3356933594, -1994.5720214844, 2560.0310058594), Angle(2, -90, 0) },
            [2] = { Vector(-2149.8276367188, -1947.4958496094, 2560.0310058594), Angle(2, -90, 0) },
            [3] = { Vector(-2208.6159667969, -1947.8049316406, 2560.0310058594), Angle(2, -90, 0) },
            [4] = { Vector(-2187.5029296875, -1888.1580810547, 2560.0310058594), Angle(2, -90, 0) },
        }                    
    },
    ["nh2c3_v2"] = {
        distance = 768,
        
        [0] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol"
            },
            
            [1] = { Vector(-5028, -4148, 0), Angle(0, 15, 0) },
            [2] = { Vector(-5063.3671875, -4141.1264648438, 0.03125), Angle(0, 0, 0) },
            [3] = { Vector(-5062.1997070313, -4171.0454101563, 0.03125), Angle(0, 0, 0) },
            [4] = { Vector(-5103.9912109375, -4151.150390625, 0.03125), Angle(0, 0, 0) },
        },
        [1] = {
            Distance = 390,
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver"
            },
            
            [1] = { Vector(-4890.63671875, -5791.705078125, 0.03125), Angle(-16, -46, 0) },
            [2] = { Vector(-4935.826171875, -5781.0610351563, 0.03125), Angle(-16, -46, 0) },
            [3] = { Vector(-4928.9663085938, -5731.1259765625, 0.03125), Angle(-16, -46, 0) },
            [4] = { Vector(-5009.2358398438, -5745.8056640625, 0.03125), Angle(-8, -32, 0) },
        },
        [2] = {
            Distance = 128,
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver"                
            },
            
            [1] = { Vector(-7058.71484375, -6031.4755859375, -127.96875), Angle(1, -59, 0) },
            [2] = { Vector(-7071.9814453125, -5964.466796875, -127.96875), Angle(4, -61, 0) },
            [3] = { Vector(-7121.55078125, -6010.0864257813, -127.96875), Angle(6, -50, 0) },
            [4] = { Vector(-7108.5766601563, -5920.2998046875, -127.96875), Angle(1, -70, 0) },
        },
        [3] = {
            Distance = 456,
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver"                
            },

            [1] = { Vector(-6565.8305664063, -4285.1254882813, -7.96875), Angle(0, 0, 0) },
            [2] = { Vector(-6633.6879882813, -4286.818359375, -7.96875), Angle(0, 0, 0) },
            [3] = { Vector(-6632.517578125, -4333.6782226563, -7.96875), Angle(0, 0, 0) },
            [4] = { Vector(-6564.66015625, -4331.9853515625, -7.96875), Angle(0, 0, 0) },
        },
        [4] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver"                
            },
            
            [1] = { Vector(-7678.6723632813, -4129.333984375, 0.03125), Angle(0, 90, 0) },
            [2] = { Vector(-7622.2036132813, -4126.9892578125, 0.03125), Angle(0, 90, 0) },
            [3] = { Vector(-7620.0473632813, -4178.916015625, 0.03125), Angle(0, 90, 0) },
            [4] = { Vector(-7676.5161132813, -4181.2607421875, 0.03125), Angle(0, 90, 0) },
        }
    },
    ["nh2c4_v2"] = {
        distance = 512,
        
        [0] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver"
            },
            
            [1] = { Vector(-8246.16015625, -5696.6513671875, 0.03125), Angle(0, -180, 0) },
            [2] = { Vector(-8202.017578125, -5720.8388671875, 0.03125), Angle(0, -180, 0) },
            [3] = { Vector(-8202.7333984375, -5677.6411132813, 0.03125), Angle(0, -180, 0) },
            [4] = { Vector(-8138.7529296875, -5691.45703125, 0.03125), Angle(0, -180, 0) },
        },
        [1] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver"
            },
            
            [1] = { Vector(-8615.162109375, -4803.8935546875, 64.03125), Angle(0, 180, 0) },
            [2] = { Vector(-8574.291015625, -4764.998046875, 64.03125), Angle(0, 180, 0) },
            [3] = { Vector(-8519.9326171875, -4810.2573242188, 64.03125), Angle(0, 180, 0) },
            [4] = { Vector(-8468.142578125, -4781.779296875, 64.03125), Angle(0, 180, 0) },
        },
        [2] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver"
            },
            
            [1] = { Vector(-9332.2685546875, -4439.9677734375, 48.03125), Angle(0, 0, 0) },
            [2] = { Vector(-9334.0791015625, -4507.8237304688, 48.03125), Angle(0, 0, 0) },
            [3] = { Vector(-9406.470703125, -4505.8935546875, 48.03125), Angle(0, 0, 0) },
            [4] = { Vector(-9404.5390625, -4433.4936523438, 48.03125), Angle(0, 0, 0) },
        },
        [3] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver"
            },
            
            [1] = { Vector(-5449.955078125, -1801.9154052734, 64.03125), Angle(1, 0, 0) },
            [2] = { Vector(-5449.2661132813, -1844.7897949219, 64.03125), Angle(1, 0, 0) },
            [3] = { Vector(-5508.046875, -1845.7337646484, 64.03125), Angle(1, 0, 0) },
            [4] = { Vector(-5523.5971679688, -1796.65625, 64.03125), Angle(1, 0, 0) },
        },
        [4] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_smg"
            },
            
            [1] = { Vector(-3946.8034667969, -3013.5617675781, 64.03125), Angle(0, -91, 0) },
            [2] = { Vector(-3927.3137207031, -2950.0417480469, 64.03125), Angle(0, -91, 0) },
            [3] = { Vector(-3995.1926269531, -2949.6098632813, 64.03125), Angle(0, -91, 0) },
            [4] = { Vector(-3953.2905273438, -2890.2060546875, 64.03125), Angle(0, -91, 0) },
        },
        [5] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_smg"
            },
            
            [1] = { Vector(-3899.1022949219, -4282.75390625, 59.912879943848), Angle(2, -90, 0) },
            [2] = { Vector(-3934.7058105469, -4283.2431640625, 59.912879943848), Angle(2, -90, 0) },
            [3] = { Vector(-3935.3041992188, -4240.103515625, 61.826766967773), Angle(2, -90, 0) },
            [4] = { Vector(-3892.1228027344, -4239.5190429688, 97.826766967773), Angle(2, -90, 0) },
        }
    },
    ["nh2c5_v2"] = {
        distance = 512,
        
        [0] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_smg"
            },

            [1] = { Vector(-3888.1701660156, -4697.6826171875, -255.96875), Angle(0, 0, 0) },
            [2] = { Vector(-3890.3857421875, -4655.3857421875, -255.96875), Angle(0, 0, 0) },
            [3] = { Vector(-3935.96875, -4657.7827148438, -255.96875), Angle(0, 0, 0) },
            [4] = { Vector(-3934.0053710938, -4695.25390625, -255.96875), Angle(0, 0, 0) },
        },
        [1] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_smg"
            },

            [1] = { Vector(-1752.1491699219, -4461.3203125, -311.96875), Angle(0, 90, 0) },
            [2] = { Vector(-1694.4578857422, -4460.7397460938, -311.96875), Angle(0, 90, 0) },
            [3] = { Vector(-1763.5502929688, -4547.771484375, -311.96875), Angle(0, 90, 0) },
            [4] = { Vector(-1691.5411376953, -4547.0473632813, -311.96875), Angle(0, 90, 0) },
        },
        [2] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_smg"
            },

            [1] = { Vector(-1449.5085449219, -4988.146484375, -255.96875), Angle(0, 164, 0) },
            [2] = { Vector(-1394.4251708984, -5018.697265625, -255.96875), Angle(0, 123, 0) },
            [3] = { Vector(-1429.5045166016, -5064.4204101563, -255.96875), Angle(0, 123, 0) },
            [4] = { Vector(-1392.03125, -5103.9697265625, -255.96875), Angle(0, 123, 0) },
        },
        [3] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_smg"
            },

            [1] = { Vector(-2989.2937011719, -5249.408203125, -287.96875), Angle(0, -90, 0) },
            [2] = { Vector(-2986.7553710938, -5188.3974609375, -287.96875), Angle(0, -90, 0) },
            [3] = { Vector(-2845.2919921875, -5252.1225585938, -287.96875), Angle(0, -90, 0) },
            [4] = { Vector(-2842.7536621094, -5191.1118164063, -287.96875), Angle(0, -90, 0) },
        },
        [4] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_smg"
            },

            [1] = { Vector(-2175.3073730469, -5393.130859375, -287.96908569336), Angle(0, 0, 0) },
            [2] = { Vector(-2116.7810058594, -5301.40625, -287.96908569336), Angle(0, -46, 0) },
            [3] = { Vector(-2192.9812011719, -5316.2124023438, -287.96875), Angle(0, -26, 0) },
            [4] = { Vector(-2227.3452148438, -5362.9731445313, -287.96875), Angle(0, -26, 0) },
        },
        [5] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_smg"
            },

            [1] = { Vector(-1922.5595703125, -5961.3393554688, -287.96875), Angle(0, -180, 0) },
            [2] = { Vector(-1861.2811279297, -5925.3491210938, -287.96875), Angle(0, -180, 0) },
            [3] = { Vector(-1769.5900878906, -5977.546875, -287.96875), Angle(0, -180, 0) },
            [4] = { Vector(-1720.3931884766, -5923.0263671875, -287.96875), Angle(0, -180, 0) },
        },
        [6] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_smg"
            },

            [1] = { Vector(-184.97387695313, -5217.4365234375, -255.96875), Angle(1, -19, 0) },
            [2] = { Vector(-244.52453613281, -5161.1376953125, -255.96875), Angle(2, -28, 0) },
            [3] = { Vector(-297.37271118164, -5236.2592773438, -255.96875), Angle(3, -3, 0) },
            [4] = { Vector(-223.53239440918, -5302.0170898438, -255.96875), Angle(4, 9, 0) },
        },
        [7] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_smg"
            },

            [1] = { Vector(-1794.1124267578, -6555.822265625, 128.03125), Angle(0, -90, 0) },
            [2] = { Vector(-1794.5832519531, -6485.673828125, 128.03125), Angle(0, -90, 0) },
            [3] = { Vector(-1741.5076904297, -6460.3989257813, 128.03125), Angle(0, -90, 0) },
            [4] = { Vector(-1832.3480224609, -6439.0288085938, 128.03125), Angle(0, -90, 0) },
        },
        [8] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_smg"
            },

            [1] = { Vector(-1372.7954101563, -8356.78125, 65), Angle(19, -73, 0) },
            [2] = { Vector(-1351.4128417969, -8282.8623046875, 64.03125), Angle(19, -73, 0) },
            [3] = { Vector(-1344.4439697266, -8203.8349609375, 64.03125), Angle(11, -91, 0) },
            [4] = { Vector(-1343.9346923828, -8104.1440429688, 64.03125), Angle(11, -91, 0) },
        }
    },
    ["nh2c6_v2"] = {
        distance = 512,
        
        [0] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_smg"
            },

            [1] = { Vector(-73.823921203613, -9129.33984375, 768.02838134766), Angle(0, -180, 0) },
            [2] = { Vector(-74.293930053711, -9075.099609375, 768.02838134766), Angle(0, -180, 0) },
            [3] = { Vector(-26.728494644165, -9164.1337890625, 768.02838134766), Angle(0, -180, 0) },
            [4] = { Vector(-27.474212646484, -9078.0791015625, 768.02838134766), Angle(0, -180, 0) },
        },
        [1] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_smg"
            },

            [1] = { Vector(-4059.6193847656, -13379.224609375, 768.03125), Angle(1, -1, 0) },
            [2] = { Vector(-4111.587890625, -13378.65234375, 768.03125), Angle(1, -1, 0) },
            [3] = { Vector(-4170.3715820313, -13378.00390625, 768.03125), Angle(1, -1, 0) },
            [4] = { Vector(-4229.1552734375, -13377.35546875, 768.03125), Angle(1, -1, 0) },
        },
        [2] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_smg"
            },

            [1] = { Vector(-2813.796875, -11546.501953125, 896.03033447266), Angle(7, 40, 0) },
            [2] = { Vector(-2770.9296875, -11509.666015625, 896.03033447266), Angle(7, 40, 0) },
            [3] = { Vector(-2797.6586914063, -11441.135742188, 896.03033447266), Angle(6, -6, 0) },
            [4] = { Vector(-2710.712890625, -11482.520507813, 896.03033447266), Angle(6, -6, 0) },
        },
        [3] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_smg"
            },

            [1] = { Vector(-1918.4345703125, -11713.274414063, 896.03033447266), Angle(1, -90, 0) },
            [2] = { Vector(-1854.1683349609, -11626.579101563, 896.03033447266), Angle(1, -102, 0) },
            [3] = { Vector(-1977.4870605469, -11645.981445313, 896.03033447266), Angle(1, -69, 0) },
            [4] = { Vector(-1966.1765136719, -11560.505859375, 896.03033447266), Angle(0, -89, 0) },
        },
        [4] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_smg"
            },

            [1] = { Vector(1047.8063964844, -13701.759765625, 768.03125), Angle(0, 0, 0) },
            [2] = { Vector(1046.0948486328, -13787.809570313, 768.03125), Angle(0, 0, 0) },
            [3] = { Vector(991.8623046875, -13786.732421875, 768.03125), Angle(0, 0, 0) },
            [4] = { Vector(993.57495117188, -13700.682617188, 768.03125), Angle(0, 0, 0) },
        },
        [5] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_smg"
            },

            [1] = { Vector(2632.5217285156, -14498.708007813, 1280.03125), Angle(1, 0, 0) },
            [2] = { Vector(2633.0676269531, -14566.583007813, 1280.03125), Angle(1, 0, 0) },
            [3] = { Vector(2569.7346191406, -14567.095703125, 1280.03125), Angle(1, 0, 0) },
            [4] = { Vector(2569.0788574219, -14485.5859375, 1280.03125), Angle(1, 0, 0) },
        }
    },
    ["nh2c7_v2"] = {
        distance = 850,

        [0] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_smg"
            },

            [1] = { Vector(-2452.0698242188, 673.17529296875, 1280.03125), Angle(0, 160, 0) },
            [2] = { Vector(-2533.6899414063, 678.84838867188, 1280.03125), Angle(0, 154, 0) },
            [3] = { Vector(-2570.9055175781, 743.74932861328, 1280.03125), Angle(0, 161, 0) },
            [4] = { Vector(-2624.7016601563, 717.11639404297, 1280.03125), Angle(0, 155, 0) },
        },
        [1] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_smg",
                "weapon_nh_shotgun"
            },

            [1] = { Vector(-2515.8591308594, 455.10623168945, -1727.96875), Angle(0, 0, 0) },
            [2] = { Vector(-2563.2839355469, 454.89907836914, -1727.96875), Angle(0, 0, 0) },
            [3] = { Vector(-2602.74609375, 502.435546875, -1727.96875), Angle(0, 0, 0) },
            [4] = { Vector(-2602.4211425781, 428.2887878418, -1727.96875), Angle(0, 0, 0) },
        },
        [2] = {
            Suit = true,
            Weapons = {
                "weapon_nh_hatchet",
                "weapon_nh_pistol",
                "weapon_nh_revolver",
                "weapon_nh_smg",
                "weapon_nh_shotgun"
            },

            [1] = { Vector(-2391.6342773438, -1113.4313964844, -2047.96875), Angle(0, 90, 0) },
            [2] = { Vector(-2460.9558105469, -1113.9416503906, -2047.96875), Angle(0, 90, 0) },
            [3] = { Vector(-2365.8046875, -1113.2416992188, -2047.96875), Angle(0, 90, 0) },
            [4] = { Vector(-2401.732421875, -1164.3817138672, -2047.96875), Angle(0, 90, 0) },
        }
    }
}

local CREATION_TOOL_SELECTED_CH_INDEX = 0
local CREATION_TOOL_CH = {}
local CREATION_TOOL_CURRENT_CHECKPOINT = {}

concommand.Add("nh2coop_getpos_as_table", function(ply)
    if not ply:IsAdmin() then return end
    local pos = ply:GetPos()
    local ang = ply:EyeAngles()
    local x, y, z = math.floor(ang.x), math.floor(ang.y), math.floor(ang.z)

    if #CREATION_TOOL_CURRENT_CHECKPOINT > 3 then
        Msg("[" .. CREATION_TOOL_SELECTED_CH_INDEX .. "] = {")
        
        for ch, data in ipairs(CREATION_TOOL_CH[CREATION_TOOL_SELECTED_CH_INDEX]) do
            Msg("\n\t[" .. ch .. "] = { " .. data .. " },")
        end

        Msg("\n}\n")
    
        CREATION_TOOL_SELECTED_CH_INDEX = CREATION_TOOL_SELECTED_CH_INDEX + 1
        CREATION_TOOL_CURRENT_CHECKPOINT = {}
    else
        CREATION_TOOL_CURRENT_CHECKPOINT[#CREATION_TOOL_CURRENT_CHECKPOINT + 1] = "Vector(" .. pos.x .. ", " .. pos.y .. ", " .. pos.z .. "), Angle(" .. x .. ", " .. y .. ", " .. z .. ")"
        CREATION_TOOL_CH[CREATION_TOOL_SELECTED_CH_INDEX] = CREATION_TOOL_CURRENT_CHECKPOINT
    end
end)

--
-- Make BaseClass available
--
DEFINE_BASECLASS("gamemode_base")

--
-- 	Name: gamemode:PlayerSpawn()
-- 	Desc: Called when a player spawns
--
function GM:PlayerSpawn(pl, transiton)
    player_manager.SetPlayerClass(pl, "player_nh2")
    BaseClass.PlayerSpawn(self, pl, transiton)

    pl:UnSpectate()

    -- Custom stuff for NH2 Players
    NH2_Player.Spawn(pl, isTransition)

    -- I don't want to fuck with player_manager and other stuff!
    local model = pl:GetInfo("nh2coop_cl_playermodel")

    pl.CachedModel = pl.CachedModel or "models/humans/nh2/" .. model .. ".mdl"
    pl:SetModel(pl.CachedModel)
    pl:GetHands():SetModel("models/weapons/c_arms_citizen.mdl")

    if not (model == "male_01" or model == "male_03") then
        pl:GetHands():SetSkin(0)
    else
        pl:GetHands():SetSkin(1)
    end
end

util.AddNetworkString("_NH2_MOTD")

--
-- Called to determine a spawn point for a player to spawn at.
--
function GM:PlayerSelectSpawn(ply, transition)
    NH2_Player.SelectSpawnPoint(ply, transition)
end

--
-- 	Name: gamemode:OnPhysgunFreeze( weapon, phys, ent, player )
-- 	Desc: The physgun wants to freeze a prop
--
function GM:OnPhysgunFreeze(weapon, phys, ent, ply)
    -- Don't freeze persistent props (should already be frozen)
    if ent:GetPersistent() and GetConVarString("sbox_persist"):Trim() ~= "" then return false end
    BaseClass.OnPhysgunFreeze(self, weapon, phys, ent, ply)
    ply:SendHint("PhysgunUnfreeze", 0.3)
    ply:SuppressHint("PhysgunFreeze")
end

--
-- 	Name: gamemode:OnPhysgunReload( weapon, player )
-- 	Desc: The physgun wants to unfreeze
--
function GM:OnPhysgunReload(weapon, ply)
    local num = ply:PhysgunUnfreeze()

    if num > 0 then
        ply:SendLua("GAMEMODE:UnfrozeObjects(" .. num .. ")")
    end

    ply:SuppressHint("PhysgunUnfreeze")
end

--
-- 	Name: gamemode:PlayerShouldTakeDamage
-- 	Return true if this player should take damage from this attacker
-- 	Note: This is a shared function - the client will think they can
-- 		damage the players even though they can't. This just means the
-- 		prediction will show blood.
--
function GM:PlayerShouldTakeDamage(ply, attacker)
    if attacker:IsPlayer() then
        return false
    end

    return true
end

--
-- 	Show the search when f1 is pressed.
--
function GM:ShowHelp(ply)
    ply:SendLua("hook.Run( 'StartSearch' )")
end

--
-- 	Called once on the player's first spawn.
--
function GM:PlayerInitialSpawn(ply, transiton)
    BaseClass.PlayerInitialSpawn(self, ply, transiton)

    timer.Simple(0, function()
        if not transiton then
            net.Start("_NH2_MOTD")
            net.Send(ply)
        end
    end)
end

--
-- 	A ragdoll of an entity has been created.
--
function GM:CreateEntityRagdoll(entity, ragdoll)
    -- Replace the entity with the ragdoll in cleanups etc
    undo.ReplaceEntity(entity, ragdoll)
    cleanup.ReplaceEntity(entity, ragdoll)
end

--
-- 	Player unfroze an object.
--
function GM:PlayerUnfrozeObject(ply, entity, physobject)
    local effectdata = EffectData()
    effectdata:SetOrigin(physobject:GetPos())
    effectdata:SetEntity(entity)
    util.Effect("phys_unfreeze", effectdata, true, true)
end

--
-- 	Player froze an object.
--
function GM:PlayerFrozeObject(ply, entity, physobject)
    if DisablePropCreateEffect then return end
    local effectdata = EffectData()
    effectdata:SetOrigin(physobject:GetPos())
    effectdata:SetEntity(entity)
    util.Effect("phys_freeze", effectdata, true, true)
end

--
-- Who can edit variables?
-- If you're writing prop protection or something, you'll
-- probably want to hook or override this function.
--
function GM:CanEditVariable(ent, ply, key, val, editor)
    -- Only allow admins to edit admin only variables!
    local isAdmin = ply:IsAdmin() or game.SinglePlayer()
    if editor.AdminOnly and not isAdmin then return false end
    -- This entity decides who can edit its variables
    if isfunction(ent.CanEditVariables) then return ent:CanEditVariables(ply) end
    -- default in sandbox is.. anyone can edit anything.

    return true
end

--
-- Sound emited on serverside.
--
function GM:EntityEmitSound(data)
    local name = data.OriginalSoundName
    local filen = data.SoundName
    local level = data.SoundLevel
    local pos = data.Pos

    if not IsValid(data.Entity) then return end

    if data.Entity:GetClass() == "npc_citizen" then
        if string.StartWith(name, "npc_citizen") or string.StartWith(name, "ep1_citizen") then
            return false
        end
    end

    net.Start(NH2NET.CC)
        net.WriteString(name)
        net.WriteString(filen)
    net.Broadcast()
end

local TO_OVERRIDE = {
    "models/blackout.mdl",
    "models/combine_helicopter.mdl",
    "models/healthvial.mdl",
    "models/stalker.mdl",
    "models/humans/group01/male_01.mdl",
    "models/humans/group01/male_02.mdl",
    "models/humans/group01/male_03.mdl",
    "models/humans/group01/male_04.mdl",
    "models/humans/group01/male_05.mdl"
}

local function OverrideModels()
    for _, to_override in pairs(TO_OVERRIDE) do
        for _, ent in ipairs(ents.GetAll()) do
            if ent:GetModel() == to_override then
                ent:SetModel(string.Replace(to_override, "models/", "models/LUA_REPLACE/"))
            end
        end
    end
end

local function OverrideKeyValues()
    for _, ent in ipairs(ents.GetAll()) do
        if ent:GetClass() == "npc_citizen" then
            ent:SetHealth(131072)
        end
    end
end

local function StartScriptedSequences()
    local scripted = ents.FindByClass("scripted_sequence")

    for _, ent in ipairs(scripted) do
        local target_name = ent:GetInternalVariable("m_iszEntity")

        local targets = ents.FindByName(target_name)

        for i, target in ipairs(targets) do
            timer.Simple(i / 10, function()
                if string.StartWith(target:GetClass(), "npc_nh_") and bit.band(ent:GetInternalVariable("spawnflags"), 16) ~= 0 then
                    target:VJ_SetSchedule(SCHED_AISCRIPT)
                end
            end)
        end
    end
end

---
--- Called after all the entities are initialized.
---
function GM:InitPostEntity()
    OverrideModels()
    OverrideKeyValues()
    StartScriptedSequences()
end

---
--- Called after map cleanup
---
function GM:PostCleanupMap()
    OverrideModels()
    OverrideKeyValues()
    StartScriptedSequences()
end

---
--- Called when new entity is created.
---
function GM:OnEntityCreated(ent)
    if not IsValid(ent) then return end

    OverrideModels()
    OverrideKeyValues()
end

util.AddNetworkString("_NH2_StartPlayingVideo")

---
--- Called when entity gets an input
---
function GM:AcceptInput(ent, input, activator, caller, value)
    if ent:GetClass() == "point_clientcommand" and input == "Command" then
        if value == "give item_suit" then
            if activator:IsPlayer() then
                activator:SetNWBool("NH2COOP_SUITPICKUPED", true)
                activator:SetRunSpeed(230)
            end
        elseif value == "r_flashlightforceflicker 1" then
            net.Start("_NH2_ForceFlicker")
                net.WriteBool(true)
            net.Broadcast()
        elseif value == "r_flashlightforceflicker 0" then
            net.Start("_NH2_ForceFlicker")
                net.WriteBool(false)
            net.Broadcast()
        elseif string.match(value, "nh2_playvideo %a+") then
            local vid = string.match(value, "nh2_playvideo (.+)")

            net.Start("_NH2_StartPlayingVideo")
                net.WriteString(vid)
            net.Broadcast()
        elseif value == "enable_godmod 1" then
            for _, ply in ipairs(player.GetAll()) do
                ply:GodEnable()
            end
        elseif value == "enable_godmod 0" then
            for _, ply in ipairs(player.GetAll()) do
                ply:GodDisable()
            end
        elseif value == "RemoveSuit" then
            for _, ply in ipairs(player.GetAll()) do
                ply:SetNWBool("NH2COOP_SUITPICKUPED", false)
            end            
        end
    end

    if ent:GetClass() == "scripted_sequence" and input == "BeginSequence" then
        local target_name = tostring(ent:GetInternalVariable("m_iszEntity"))

        local targets = ents.FindByName(target_name)

        for _, target in ipairs(targets) do
            if string.StartWith(target:GetClass(), "npc_nh_") then
                --target:VJ_ACT_PLAYACTIVITY(sequence_name)
                target:VJ_SetSchedule(SCHED_AISCRIPT) -- BUG: They can teleport to player sometimes
            end
        end
    end

    if ent:GetClass() == "player_speedmod" and input == "ModifySpeed" then
        if tonumber(value) < 1 then
            if tonumber(value) == 0 then
                for _, ply in ipairs(player.GetAll()) do
                    ply:SetVelocity(Vector(0,0,0))
                end
            end
            
            SetGlobalBool("IsSpeedModified", true)
            -- Disable flashlight for everyone
            for _, ply in ipairs(player.GetAll()) do
                ply:SetNWBool("NH2COOP_FLASHLIGHT_ISON", false)
                ply:EmitSound("NH2.Flashlight")
                net.Start("_NH2_Flashlight")
                    net.WriteBool(false)
                net.Send(ply)
            end
        else
            SetGlobalBool("IsSpeedModified", false) -- Don't care about >1 cases
            for _, ply in ipairs(player.GetAll()) do
                ply:SetLaggedMovementValue(1)
            end
        end
    end

    if string.lower(input) == "setmodel" then
        ent:SetModel(value)
    end

    if string.lower(input) == "sethulltype" then
        ent:SetHullType(value)
    end

    if ent:GetName() == "swat3_Hate" then
        local swat3 = ents.FindByName("SWAT3")[1]
        swat3:SetNWBool("NH2COOP_IM_CRAZY_NOW", true)
    end
end

---
--- Called when an entity takes damage.
---
function GM:EntityTakeDamage(ent, dmg)
    if ent:GetClass() == "npc_citizen" and not ent:GetNWBool("NH2COOP_IM_CRAZY_NOW", false) then
        if dmg:GetAttacker():IsPlayer() then
            return true
        else
            ent:SetBloodColor(BLOOD_COLOR_RED)
        end
    end
end

local function TeleportAllSWATSToHost(ply)
    if not ply:IsAdmin() then return end
    
    local swatID = 0
    local traceLen = 0

    -- Get count to check length
    for i = 1, #ents.FindByClass("npc_citizen") do
        traceLen = traceLen + 50
    end

    local tr = util.TraceLine( {
        start = ply:EyePos(),
        endpos = ply:EyePos() + -ply:EyeAngles():Forward() * traceLen,
        filter = function( ent ) return ( ent ~= ply ) end
    } )

    if tr.Hit then
        MsgC(Color(245, 90, 90), "There's no room for bringing SWATs, try to find more space in back of you to bring them\n")
        return
    end

    for _, citizen in ipairs(ents.FindByClass("npc_citizen")) do
        if string.StartWith(string.lower(citizen:GetName()), "swat") then
            swatID = swatID + 50
            citizen:SetPos(ply:GetPos() + -ply:GetAngles():Forward() * swatID)
        end
    end
end

concommand.Add( "nh2coop_teleport_swats", TeleportAllSWATSToHost)

local CMoveData = FindMetaTable("CMoveData")

function CMoveData:RemoveKeys(keys)
	-- Using bitwise operations to clear the key bits.
	local newbuttons = bit.band(self:GetButtons(), bit.bnot(keys))
	self:SetButtons(newbuttons)
end

--
-- Used to control buttons of player and bot
--
function GM:StartCommand(ply, cmd)    
    if bit.bor(cmd:GetButtons(), IN_ATTACK) ~= 0 then
        local tr = util.TraceLine( {
            start = ply:EyePos(),
            endpos = ply:EyePos() + ply:EyeAngles():Forward() * 8192,
            filter = function( ent ) return ( ent ~= ply ) end
        } )

        if tr.Hit and (tr.Entity:IsNPC() and (tr.Entity:GetClass() == "npc_citizen" or tr.Entity:GetClass() == "generic_actor") and not tr.Entity:GetNWBool("NH2COOP_IM_CRAZY_NOW", false)) or tr.Entity:IsPlayer() then
            cmd:RemoveKey(IN_ATTACK)
        end
    end
end

CITIZENS_IN_SQUAD = {}
local player_squad = "player_squad"
local citizen_members = "NH2_CITIZEN_MEMBERS_COUNT"

--
-- Global think hook
--
function GM:Think()
    SetGlobal2Int(citizen_members, ai.GetSquadMemberCount(player_squad))

    for i = 1, ents.GetCount() do
        local ent = Entity(i)
        if not IsValid(ent) then continue end
    end
end

local SURVIVAL_MODE = GetConVar("nh2coop_sv_survival_mode")

--
-- Called when player dies.
--
function GM:PlayerDeath(ply, weapon, attacker)
    ply.DEATH_TIME = CurTime()

    -- Survival Mode feature
    ply.CanRespawn = false

    player_manager.RunClass( ply, "Death", weapon, attacker )
end

local CUR_SPECTATE_INDEX = 1
local RESTARTING_LEVEL = false
local RESTARTING_TIME = 0

--
-- Called every think while the player is dead. The return value will determine if the player respawns.
--
function GM:PlayerDeathThink(ply)
    if SURVIVAL_MODE:GetBool() then
        if not ply.CanRespawn then
            if CurTime() > ply.DEATH_TIME + 2 then
                ply.SpectatorMode = ply.SpectatorMode or OBS_MODE_CHASE
                ply:Spectate(ply.SpectatorMode)
    
                local alives = 0
    
                for i = 1, player.GetCount() do
                    local ply = Entity(i)
    
                    if not IsValid(ply) then continue end
                    if not ply:Alive() then continue end
                    alives = alives + 1
                end
    
                if ply:KeyPressed(IN_JUMP) then
                    if ply.SpectatorMode > 4 then
                        ply.SpectatorMode = ply.SpectatorMode - 1
                    else
                        ply.SpectatorMode = OBS_MODE_CHASE
                    end
                end
               
                if alives == 0 then
                    if ply:GetObserverMode() ~= OBS_MODE_ROAMING then
                        ply:SetObserverMode(OBS_MODE_ROAMING)
                    end
    
                    if not RESTARTING_LEVEL then
                        ply:ScreenFade(bit.bor(SCREENFADE.OUT, SCREENFADE.STAYOUT), color_black, 2, 0)
                        RESTARTING_LEVEL = true
                        SetGlobal2Bool("NH2COOP_RESTARTING_LEVEL", true)
                        RESTARTING_TIME = CurTime()
                    elseif CurTime() > RESTARTING_TIME + 3 then
                        RunConsoleCommand("changelevel", game.GetMap())
                    end
                end
    
                if ply:KeyPressed(IN_ATTACK) then
                    if CUR_SPECTATE_INDEX > 1 then
                        CUR_SPECTATE_INDEX = CUR_SPECTATE_INDEX - 1
    
                        if player.GetAll()[CUR_SPECTATE_INDEX] == ply then
                            CUR_SPECTATE_INDEX = CUR_SPECTATE_INDEX - 1
    
                            if CUR_SPECTATE_INDEX < 1 then
                                CUR_SPECTATE_INDEX = player.GetCount()
                            end
    
                            ply:SpectateEntity(player.GetAll()[CUR_SPECTATE_INDEX])
                        end
    
                        ply:SpectateEntity(player.GetAll()[CUR_SPECTATE_INDEX])
                    else
                        CUR_SPECTATE_INDEX = player.GetCount()
                        ply:SpectateEntity(player.GetAll()[CUR_SPECTATE_INDEX])
                    end
                end
    
                if ply:KeyPressed(IN_ATTACK2) then
                    if CUR_SPECTATE_INDEX < player.GetCount() then
                        CUR_SPECTATE_INDEX = CUR_SPECTATE_INDEX + 1
    
                        ply:SpectateEntity(player.GetAll()[CUR_SPECTATE_INDEX])
                    else
                        CUR_SPECTATE_INDEX = 1
    
                        if player.GetAll()[CUR_SPECTATE_INDEX] == ply then
                            CUR_SPECTATE_INDEX = CUR_SPECTATE_INDEX + 1
    
                            
                            if CUR_SPECTATE_INDEX > player.GetCount() then
                                CUR_SPECTATE_INDEX = player.GetCount()
                            end
                        end
    
                        ply:SpectateEntity(player.GetAll()[CUR_SPECTATE_INDEX])
                    end
                end
    
                --print(ply:GetObserverTarget())
            end
        else
            ply:UnSpectate()
            ply:Spawn()            
        end
    else
        if CurTime() > ply.DEATH_TIME + 1 and (ply:KeyPressed(IN_ATTACK) or ply:KeyPressed(IN_JUMP)) then
            ply:UnSpectate()
            ply:Spawn()
        end
    end
end