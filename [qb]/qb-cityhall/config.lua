Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.AvailableJobs = { -- Only used when not using qb-jobs.
    ["trucker"] = {["label"] = "Trucker", ["isManaged"] = false},
    ["taxi"] = {["label"] = "Taxi", ["isManaged"] = false},
    ["tow"] = {["label"] = "Tow Truck", ["isManaged"] = false},
    ["reporter"] = {["label"] = "News Reporter", ["isManaged"] = false},
    ["garbage"] = {["label"] = "Garbage Collector", ["isManaged"] = false},
    ["bus"] = {["label"] = "Bus Driver", ["isManaged"] = false},
    ["hotdog"] = {["label"] = "Hot Dog Stand", ["isManaged"] = false}
}

Config.Cityhalls = {
    { -- Cityhall 1
        coords = vec3(-552.7, -193.62, 38.22),
        showBlip = true,
        blipData = {
            sprite = 438,
            display = 4,
            scale = 0.85,
            colour = 25,
            title = "City Services"
        },
        licenses = {
            ["id_card"] = {
                label = "ID Card",
                cost = 50,
            },
            ["driver_license"] = {
                label = "Driver License",
                cost = 50,
                metadata = "driver"
            },
            ["weaponlicense"] = {
                label = "Weapon License",
                cost = 50,
                metadata = "weapon"
            },
        }
    },
}

Config.DrivingSchools = {
    { -- Driving School 1
        coords = vec3(240.3, -1379.89, 33.74),
        showBlip = true,
        blipData = {
            sprite = 764,
            display = 4,
            scale = 0.75,
            colour = 3,
            title = "Driving School"
        },
        instructors = {
            "DJD56142",
            "DXT09752",
            "SRI85140",
        }
    },
}

Config.Peds = {
    -- Cityhall Ped
    {
        model = 'a_m_m_hasjew_01',
        coords = vec4(-552.7, -193.62, 37.22, 210.34),
        scenario = 'WORLD_HUMAN_STAND_MOBILE',
        cityhall = true,
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0,
            debugPoly = false
        }
    },
    -- Driving School Ped
    {
        model = 'a_m_m_eastsa_02',
        coords = vec4(217.73, -1398.89, 29.60, 49.84),
        scenario = 'WORLD_HUMAN_STAND_MOBILE',
        drivingschool = true,
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0
        }
    }
}
