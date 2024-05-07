-- Gabz Arcade
Config.Locations["arcade"] = {
    zoneEnable = true,
    job = "arcade",
    --gang = "lostmc",
    label = "GameOn Arcade Bar",
    logo = "https://i.imgur.com/8GsSPk6.png",
    autoClockOut = true,
    zones = {
        vector2(-1665.6278076172, -1065.5640869141),
        vector2(-1664.9411621094, -1073.7185058594),
        vector2(-1663.7576904297, -1075.7833251953),
        vector2(-1659.2349853516, -1079.5570068359),
        vector2(-1652.6213378906, -1082.9216308594),
        vector2(-1645.4473876953, -1075.0373535156),
        vector2(-1640.4466552734, -1067.1678466797),
        vector2(-1649.3873291016, -1060.9467773438),
        vector2(-1675.998046875, -1049.1500244141)
    },
    Blip = {
        showBlip = true,
        coords = vector3(-1653.78, -1074.01, 12.16),
        color = 15,
        sprite = 740,
    },
    Targets = {
        Clockin = {
            { coords = vector3(-1648.53, -1069.92, 13.55), h = 50.0, l = 0.5, w = 0.5, bottom = 13.55, top = 13.95 },
        },
        Cocktails = {
            { coords = vector3(-1659.1, -1060.79, 12.16), h = 50.0, l = 0.4, w = 0.6, bottom = 12.21, top = 12.41, prop = true },
            { coords = vector3(-1658.46, -1060.02, 12.16), h = 50.0, l = 0.4, w = 0.6, bottom = 12.21, top = 12.41, prop = true },
        },
        Shop = {
            { coords = vector3(-1654.58, -1060.0, 12.16), h = 50.0, l = 1.35, w = 0.5, bottom = 11.11, top = 12.11 },
            { coords = vector3(-1652.05, -1062.15, 12.16), h = 50.0, l = 1.35, w = 0.5, bottom = 11.11, top = 12.11 },
            { coords = vector3(-1658.65, -1060.57, 12.16), h = 320.0, l = 2.5, w = 0.5, bottom = 11.11, top = 12.11 },
        },
        Tap = {
            { coords = vector3(-1653.58, -1060.61, 12.16), h = 320.0, l = 0.4, w = 0.7, bottom = 12.16, top = 12.91 },
            { coords = vector3(-1652.93, -1061.16, 12.16), h = 320.0, l = 0.4, w = 0.7, bottom = 12.16, top = 12.91 },
        },
        Coffee = {
            { coords = vector3(-1660.02, -1061.86, 12.16), h = 320.0, l = 0.7, w = 0.6, bottom = 12.16, top = 12.76 },
        },
        HandWash = {
            { coords = vector3(-1647.75, -1068.69, 13.75), h = 50.0, l = 0.7, w = 0.6, bottom = 12.75, top = 13.75 },
        },
        Payment = {
            { coords = vector3(-1659.55, -1061.3, 12.16), h = 325.0, l = 0.6, w = 0.55, bottom = 12.16, top = 12.76 },
        },
        Tray = {
            { coords = vector3(-1652.9, -1063.86, 12.19), h = 320.0, l = 0.4, w = 0.6, bottom = 12.16, top = 12.36, prop = true},
            { coords = vector3(-1654.13, -1062.84, 12.19), h = 320.0, l = 0.4, w = 0.6, bottom = 12.16, top = 12.36, prop = true},
            { coords = vector3(-1655.62, -1061.52, 12.19), h = 320.0, l = 0.4, w = 0.6, bottom = 12.16, top = 12.36, prop = true},
            { coords = vector3(-1657.55, -1061.96, 12.19), h = 50.0, l = 0.4, w = 0.6, bottom = 12.16, top = 12.36, prop = true},
            { coords = vector3(-1658.28, -1062.84, 12.19), h = 50.0, l = 0.4, w = 0.6, bottom = 12.16, top = 12.36, prop = true},
        },
    },
    --Custom DJ Booth Stuff
    Booth = {
        enableBooth = true, -- Set false if using external DJ/Music stuff.
        DefaultVolume = 0.2, -- 0.01 is lowest, 1.0 is max
        radius = 28, -- The radius of the sound from the booth
        coords = vector3(-1648.7, -1062.2, 12.35), -- Where the booth is located
        playing = false, -- No touch.
    },
}