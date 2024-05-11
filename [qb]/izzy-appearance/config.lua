Config = {}

Config.Framework = "qb" -- esx/qb

Config.WomanPlayerModel = 'mp_f_freemode_01'
Config.ManPlayerModel = 'mp_m_freemode_01'

Config.ClothingShopPrice = 200

Config.ShowClothingStoresBlip = true

Config.BlipType = {
    ["clothing"] = {
        showBlip = true,
        sprite = 73,
        color = 0,
        scale = 0.7,
        name = "Clothing Store"
    },
    ["barber"] = {
        showBlip = true,
        sprite = 71,
        color = 0,
        scale = 0.7,
        name = "Barber Store"
    },
    ["surgery"] = {
        showBlip = true,
        sprite = 73,
        color = 0,
        scale = 0.7,
        name = "Surgery Store"
    }
}

Config.Stores = {
    {
        type = "clothing_room",
        coords = vector3(235.2687, 706.2150, 188.5984),
        job =  'ambulance'
    },
    {
        type = "clothing_room",
        coords = vector3(-1098.45, 1751.71, 23.35),
        job =  'ambulance'
    },
    {
        type = "clothing_room",
        coords = vector3(-77.59, -129.17, 5.03),
        job =  'police'
    },
    {
        type = "clothing_room",
        coords = vector3(454.68, -990.89, 29.69),
        job =  'police'
    },
    {
        type = "clothing_room",
        coords = vector3(342.47, -586.15, 43.32),
        job =  'ambulance'
    },
    {
        type = "clothing_room",
        coords = vector3(314.76, 671.78, 14.73),
        job =  'police'
    },
    {
        type = "clothing",
        coords = vector4(1693.2, 4828.11, 42.07, 188.66),
    },
    {
        type = "clothing",
        coords = vector4(-705.5, -149.22, 37.42, 122),
    },
    {
        type = "clothing",
        coords = vector4(-1192.61, -768.4, 17.32, 216.6),
    },
    {
        type = "clothing",
        coords = vector4(425.91, -801.03, 29.49, 177.79),
    },
    {
        type = "clothing",
        coords = vector4(-168.73, -301.41, 39.73, 238.67),
    },
    {
        type = "clothing",
        coords = vector4(75.39, -1398.28, 29.38, 6.73),
    },
    {
        type = "clothing",
        coords = vector4(-827.39, -1075.93, 11.33, 294.31),
    },
    {
        type = "clothing",
        coords = vector4(-1445.86, -240.78, 49.82, 36.17),
    },
    {
        type = "clothing",
        coords = vector4(9.22, 6515.74, 31.88, 131.27),
    },
    {
        type = "clothing",
        coords = vector4(615.35, 2762.72, 42.09, 170.51),
    },
    {
        type = "clothing",
        coords = vector4(1191.61, 2710.91, 38.22, 269.96),
    },
    {
        type = "clothing",
        coords = vector4(-3171.32, 1043.56, 20.86, 334.3),
    },
    {
        type = "clothing",
        coords = vector4(-1105.52, 2707.79, 19.11, 317.19),
    },
    {
        type = "clothing",
        coords = vector4(-1119.24, -1440.6, 5.23, 300.5),
    },
    {
        type = "clothing",
        coords = vector4(124.82, -224.36, 54.56, 335.41),
    },
    {
        type = "barber",
        coords = vector4(-814.22, -183.7, 37.57, 116.91),
    },
    {
        type = "barber",
        coords = vector4(136.78, -1708.4, 29.29, 144.19),
    },
    {
        type = "barber",
        coords = vector4(-1282.57, -1116.84, 6.99, 89.25),
    },
    {
        type = "barber",
        coords = vector4(1931.41, 3729.73, 32.84, 212.08),
    },
    {
        type = "barber",
        coords = vector4(1212.8, -472.9, 65.2, 60.94),
    },
    {
        type = "barber",
        coords = vector4(-32.9, -152.3, 56.1, 335.22),
    },
    {
        type = "barber",
        coords = vector4(-278.1, 6228.5, 30.7, 49.32),
    },
    {
        type = "surgery",
        coords = vector4(298.78, -572.81, 43.26, 114.27),
    }
}