print("^2Jim^7-^2JobGarage ^7v^41^7.^44^7.^43 ^7- ^2Job Garage Script by ^1Jimathy^7")

Loc = {}

--[[	LIST OF POSSIBLE VEHICLE MODIFIERS   ]]--
-- Using these will change how each vehicle spawns
-- This can be used for making sure the vehicles comes out exactly how you want it to

-- CustomName = "Police Car", this will show a custom override name for your vehicles so you don't need to add them to your vehicles.lua
-- rank = { 2, 4 }, -- This specifes which grades can see it, and only these grades
-- grade = 4, -- This specifies the lowest grade and above that can see the vehicle
-- colors = { 136, 137 }, -- This is the colour index id of the vehicle, Primary and Secondary in that order
-- bulletproof = true, -- This determines if the tyres are bullet proof (don't ask me why, I was asked to add this)
-- livery = 6, -- This sets the livery id of the vehicle, (most mod menus would number them or have them in number order) 0 = stock
-- extras = { 1, 5 }, -- This enables the selected extras on the vehicle
-- performance = "max", this sets the stats to max if available
-- performance = { 2, 3, 3, 2, 4, true }, -- This allows more specific settings for each upgrade level, in order: engine, brakes, suspension, transmission, armour, turbo
-- trunkItems = { }, -- Use this to add items to the trunk of the vehicle when it is spawned

-- ANY VEHICLE, BOATS, POLICE CARS, EMS VEHICLES OR EVEN PLANES CAN BE ADDED.

Config = {
	Debug = false,  -- Enable to use debug features
	Lan = "en",

	Core = "qb-core",
	Menu = "qb",
	Notify = "qb",

	Fuel = "cdn-fuel", -- Set this to your fuel script folder

	CarDespawn = true, -- Sends the vehicle to hell (removal animation)

	DistCheck = false, -- Require the vehicle to be near by to remove it

	Locations = {
		{ 	zoneEnable = true,
			job = "mechanic",
			garage = {
				spawn = vec4(863.54, -2125.43, 30.55, 352.78),  -- Where the car will spawn
				out = vec4(869.48, -2117.82, 30.54, 87.44),	-- Where the parking stand is
				list = {
					["cheburek"] = {
						colors = { 136, 137 },
						grade = 4,
						livery = 5,
						bulletproof = true,
						extras = { 1, 4 },
					},
					["flatbed"] = { },
					["towtruck"] = { },
				},
			},
		},
		{ 	zoneEnable = true,
			job = "police",
			garage = {
				spawn = vec4(441.03, -981.34, 25.7, 92.13),
				out = vec4(441.47, -974.7, 25.7, 180.1),
				list = {
					["pd1"] = {
						CustomName = "Ford Crown",
						colors = { 0, 0 },
						livery = 6,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "max",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},
					},
					["Explorer"] = {
						CustomName = "Ford Explorer",
						livery = 1,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "max",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},
					},
					["socharger"] = {
						CustomName = "Dodge Charger",
						livery = 6,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "max",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},
					},
					["sodurango"] = {
						CustomName = "Dodge Durango",
						livery = 6,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "max",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},
					},
					["soexplorer"] = {
						CustomName = "Ford Explorer",
						livery = 6,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "max",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},
					},
					["sotaurus"] = {
						CustomName = "Ford Taurus",
						livery = 6,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "max",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},
					},
					["sotruck"] = {
						CustomName = "Ford F150",
						livery = 6,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "max",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},					
					},
				},
			},
		},
		{ 	zoneEnable = true,
			job = "police",
			garage = {
				spawn = vec4(830.79, -1263.01, 26.29, 92.23),
				out = vec4(831.0, -1276.33, 26.42, 358.04),
				list = {
					["mach1rb"] = {
						CustomName = "Ford Mustang",
						livery = 1,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "max",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},
					},
					["socharger"] = {
						CustomName = "Dodge Charger",
						livery = 3,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "stock",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},
					},
					["soexplorer"] = {
						CustomName = "Ford Explorer",
						livery = 2,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "max",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},
					},
					["sotaurus"] = {
						CustomName = "Ford Taurus",
						livery = 3,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "max",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},
					},
					["sotruck"] = {
						CustomName = "Ford F150",
						livery = 3,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "max",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},					
					},
				},
			},
		},
		{ 	zoneEnable = true,
			job = "police",
			garage = {
				spawn = vec4(373.26, 788.43, 186.93, 160.4),
				out = vec4(376.14, 793.33, 187.49, 86.72),
				list = {
					["sotruck"] = {
						CustomName = "Ford F150",
						livery = 2,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "max",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},					
					},
					["soexplorer"] = {
						CustomName = "Ford Explorer",
						livery = 3,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "max",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},
					},
					["sotaurus"] = {
						CustomName = "Ford Taurus",
						livery = 2,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "max",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},
					},
				},
			},
		},
		{ 	zoneEnable = true,
			job = "police",
			garage = {
				spawn = vec4(1819.3, 3672.21, 34.2, 25.59),
				out = vec4(1821.95, 3684.35, 34.34, 119.74),
				list = {
					["socharger"] = {
						CustomName = "Dodge Charger",
						livery = 1,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "max",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},					
					},
					["sotruck"] = {
						CustomName = "Ford F150",
						livery = 1,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "max",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},					
					},
					["soexplorer"] = {
						CustomName = "Ford Explorer",
						livery = 1,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "max",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},
					},
					["sotaurus"] = {
						CustomName = "Ford Taurus",
						livery = 1,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "max",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},
					},
				},
			},
		},
		{ 	zoneEnable = true,
			job = "police",
			garage = {
				spawn = vec4(-471.11, 6022.45, 31.34, 225.98),
				out = vec4(-462.55, 6026.1, 31.45, 134.82),
				list = {
					["socharger"] = {
						CustomName = "Dodge Charger",
						livery = 1,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "max",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},					
					},
					["sotruck"] = {
						CustomName = "Ford F150",
						livery = 1,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "max",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},					
					},
					["soexplorer"] = {
						CustomName = "Ford Explorer",
						livery = 1,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "max",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},
					},
					["sotaurus"] = {
						CustomName = "Ford Taurus",
						livery = 1,
						extras = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 },
						performance = "max",
						trunkItems = {
							{ name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1, },
							{ name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2, },
							{ name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3, },
						},
					},
				},
			},
		},		
		{ 	zoneEnable = true,
			job = "ambulance",
			garage = {
				spawn = vec4(294.95, -606.92, 43.24, 64.84),
				out = vec4(294.54, -599.52, 43.28, 159.68),
				list = {
					["lsfdambo"] = {
						CustomName = "LSF EMS",
						livery = 1,
						extras = { 0, 1, 2, 3, 4 },
						livery = 1,
						extras = { 0, 1, 2, 3, 4 }
					},
					["alstahoe"] = {
						CustomName = "Chevy Tahoe"
					},
					["3gator"] = {
						CustomName = "Gator"
					},
				},
			},
		},
		{ 	zoneEnable = true,
			job = "ambulance",
			garage = {
				spawn = vec4(1764.69, 3625.92, 34.74, 161.95),
				out = vec4(1772.02, 3635.86, 34.76, 207.77),
				list = {
					["lsfdambo"] = {
						CustomName = "LSF EMS",
						livery = 1,
						extras = { 0, 1, 2, 3, 4 }
					},
					["alstahoe"] = {
						CustomName = "Chevy Tahoe"
					},
					["3gator"] = {
						CustomName = "Gator"
					},
				},
			},
		},
		{ 	zoneEnable = true,
			job = "ambulance",
			garage = {
				spawn = vec4(-261.25, 6340.03, 32.33, 135.03),
				out = vec4(-253.58, 6338.63, 32.43, 45.68),
				list = {
					["lsfdambo"] = {
						CustomName = "LSF EMS",
						livery = 1,
						extras = { 0, 1, 2, 3, 4 }
					},
					["alstahoe"] = {
						CustomName = "Chevy Tahoe"
					},
					["3gator"] = {
						CustomName = "Gator"
					},
				},
			},
		},		
	},
}
