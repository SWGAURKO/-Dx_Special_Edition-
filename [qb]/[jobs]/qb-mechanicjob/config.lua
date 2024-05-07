Config = {}

-- **** IMPORTANT ****
-- UseTarget should only be set to true when using qb-target
Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'
Config.Targets = {}

Config.AttachedVehicle = nil

Config.AuthorizedIds = {
    -- "insertcitizenidhere",    
}

Config.MaxStatusValues = {
    ["engine"] = 1000.0,
    ["body"] = 1000.0,
    ["radiator"] = 100,
    ["axle"] = 100,
    ["brakes"] = 100,
    ["clutch"] = 100,
    ["fuel"] = 100,
}

Config.ValuesLabels = {
    ["engine"] = Lang:t('labels.engine'),
    ["body"] = Lang:t('labels.body'),
    ["radiator"] = Lang:t('labels.radiator'),
    ["axle"] = Lang:t('labels.axle'),
    ["brakes"] = Lang:t('labels.brakes'),
    ["clutch"] = Lang:t('labels.clutch'),
    ["fuel"] = Lang:t('labels.fuel'),
}

Config.RepairCost = {
    ["body"] = "plastic",
    ["radiator"] = "plastic",
    ["axle"] = "steel",
    ["brakes"] = "iron",
    ["clutch"] = "aluminum",
    ["fuel"] = "plastic",
}

Config.RepairCostAmount = {
    ["engine"] = {
        item = "metalscrap",
        costs = 2,
    },
    ["body"] = {
        item = "plastic",
        costs = 3,
    },
    ["radiator"] = {
        item = "steel",
        costs = 5,
    },
    ["axle"] = {
        item = "aluminum",
        costs = 7,
    },
    ["brakes"] = {
        item = "copper",
        costs = 5,
    },
    ["clutch"] = {
        item = "copper",
        costs = 6,
    },
    ["fuel"] = {
        item = "plastic",
        costs = 5,
    },
}

Config.Businesses = {
    "Auto Repair",
}

Config.Plates = {
    [1] = {
        coords = vector4(-6.81, -1674.94, 29.83, 203.47),
        boxData = {
            heading = 200,
            length = 5,
            width = 2.5,
            debugPoly = false
        },
        AttachedVehicle = nil,
    },
    [2] = {
        coords = vector4(-10.73, -1676.97, 29.83, 200.13),
        boxData = {
            heading = 200,
            length = 6.5,
            width = 5,
            debugPoly = false
        },
        AttachedVehicle = nil,
    },
}

Config.Blip = {
    ['showBlip'] = false, -- change to false if you want to disable blip
    ['sprite'] = 446,
    ['display'] = 4,
    ['scale'] = 0.65,
    ['asShortRange'] = true,
    ['colour'] = 2,
    ['alpha'] = 0.7
}

Config.Locations = {
    ["exit"] = vector3(0, 0, 0),
    ["duty"] = vector3(0, 0, 0),
    ["stash"] = vector3(0, 0, 0),
    ["vehicle"] = vector4(0, 0, 0, 0),
}

Config.Vehicles = {
    ["flatbed"] = "Flatbed",
    ["towtruck"] = "Towtruck",
    ["minivan"] = "Minivan (Rental Car)",
    ["blista"] = "Blista",
}

Config.MinimalMetersForDamage = {
    [1] = {
        min = 8000,
        max = 12000,
        multiplier = {
            min = 1,
            max = 8,
        }
    },
    [2] = {
        min = 12000,
        max = 16000,
        multiplier = {
            min = 8,
            max = 16,
        }
    },
    [3] = {
        min = 12000,
        max = 16000,
        multiplier = {
            min = 16,
            max = 24,
        }
    },
}

Config.Damages = {
    ["radiator"] = "Radiator",
    ["axle"] = "Drive Shaft",
    ["brakes"] = "Brakes",
    ["clutch"] = "Clutch",
    ["fuel"] = "Fuel Tank",
}
