-- Zones for Menues
Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.BossMenus = {
    ['police'] = {
        vector3(441.67, -975.05, 35.06),
    },
    ['police'] = {
        vector3(359.62, -1591.22, 29.97),
    },
    ['police'] = {
        vector3(387.42, 797.96, 190.43),
    },
    ['police'] = {
        vector3(1847.79, 3679.43, 38.79),
    },
    ['police'] = {
        vector3(-432.89, 6005.01, 36.8),
    },
    ['ambulance'] = {
        vector3(329.55, -601.72, 43.15),
    },
    ['ambulance'] = {
        vector3(1777.64, 3664.6, 34.45),
    },
    ['ambulance'] = {
        vector3(-265.27, 6323.04, 31.28),
    },
    ['realestate'] = {
        vector3(-716.17, 261.29, 83.34),
    },
    ['taxi'] = {
        vector3(907.24, -150.19, 74.17),
    },
    ['cardealer'] = {
        vector3(-35.18, -1669.67, 29.48),
    },
    ['mechanic'] = {
        vector3(-339.53, -156.44, 44.59),
    },
    ['cookies'] = {
        vector3(-934.1, -1168.34, 5.11),
    },
    ['bestbuds'] = {
        vector3(374.27, -823.49, 29.3),
    },    
    ['uwu'] = {
        vector3(-577.5565, -1067.565, 26.614078),
    },
}

Config.BossMenuZones = {
    ['police'] = {
        { coords = vector3(441.67, -975.05, 35.06), length = 2.0, width = 2.0, heading = 0, minZ = 31.86, maxZ = 35.86 },
    },
    ['police'] = {
        { coords = vector3(359.62, -1591.22, 30.80), length = 2.0, width = 2.0, heading = 0, minZ = 0.0, maxZ = 100.0 },
    },
    ['police'] = {
        { coords = vector3(387.42, 798.0, 190.43), length = 2.0, width = 2.0, heading = 0, minZ = 0.0, maxZ = 300.0 },
    },
    ['police'] = {
        { coords = vector3(1847.79, 3679.43, 38.79), length = 2.0, width = 2.0, heading = 0, minZ = 0.0, maxZ = 300.0 },
    },
    ['police'] = {
        { coords = vector3(-432.89, 6005.01, 36.8), length = 2.0, width = 2.0, heading = 0, minZ = 0.0, maxZ = 300.0 },
    },
    ['ambulance'] = {
        { coords = vector3(329.55, -601.72, 43.15), length = 1.2, width = 0.6, heading = 341.0, minZ = 43.13, maxZ = 43.73 },
    },
    ['ambulance'] = {
        { coords = vector3(1777.64, 3664.6, 34.45), length = 1.2, width = 0.6, heading = 341.0, minZ = 0.0, maxZ = 300.0  },
    },
    ['ambulance'] = {
        { coords = vector3(-265.27, 6323.04, 31.28), length = 1.2, width = 0.6, heading = 341.0, minZ = 0.0, maxZ = 300.0  },
    },
    ['taxi'] = {
        { coords = vector3(907.24, -150.19, 74.17), length = 1.0, width = 3.4, heading = 327.0, minZ = 73.17, maxZ = 74.57 },
    },
    ['cardealer'] = {
        { coords = vector3(-35.18, -1669.67, 29.48), length = 2.2, width = 2.0, heading = 140.0, minZ = 26.28, maxZ = 30.28 },
    },
    ['mechanic'] = {
        { coords = vector3(-339.53, -156.44, 44.59), length = 1.15, width = 2.6, heading = 353.0, minZ = 43.59, maxZ = 44.99 },
    },
    ['uwu'] = {
        { coords = vector3(-578.36, -1066.95, 26.614078), length = 0.35, width = 0.45, heading = 351.0, minZ = 26.33, maxZ = 27.38 }, -- DONE
    },
}    

Config.GangMenus = {
     ['alcapone'] = {
        vector3(-1529.14, 149.61, 61.28),
     },
     ['yakuza'] = {
         vector3(-1877.59, 2059.48, 145.57),
     },
}

Config.GangMenuZones = {
     ['alcapone'] = {
         { coords = vector3(-1529.14, 149.61, 61.28), length = 1.0, width = 1.0, heading = 45.0, minZ = 58.0, maxZ = 63.0 },
     },
     ['yakuza'] = {
         { coords = vector3(-1877.59, 2059.48, 145.57), length = 1.0, width = 1.0, heading = 1.0, minZ = 142.97, maxZ = 146.97 },
     },
    -- ['families'] = {
    --     { coords = vector3(-138.12, -1608.25, 35.03), length = 2.0, width = 2.0, heading = 340.0, minZ = 32.23, maxZ = 36.23 },
    -- },
    -- ['lostmc'] = {
    --     { coords = vector3(917.79, 3577.56, 29.92), length = 5.0, width = 1.0, heading = 0.0, minZ = 26.32, maxZ = 30.32 },
    -- },
    -- ['marabunta'] = {
    --     { coords = vector3(1440.01, -1489.83, 66.62), length = 2.0, width = 2.0, heading = 160.0, minZ = 64.02, maxZ = 68.02 },
    -- },
    -- ['bloods'] = {
    --     { coords = vector3(-1566.25, -409.02, 51.49), length = 1.5, width = 1.5, heading = 320.0, minZ = 46.69, maxZ = 53.69 },
    -- },
}
