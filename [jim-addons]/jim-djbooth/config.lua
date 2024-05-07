print("^2Jim^7-^2DJBooth ^7v^41^7.^43^7.^42 ^2by ^1Jimathy^7")

Config = {
	Lan = "en",
	Debug = false, -- Set to true to show target locations

	Core = "qb-core",
	Menu = "qb",
	Notify = "qb",

	Locations = {
		{ -- Bahamas Club
			job = "public", -- Set this to required job role
			enableBooth = true, -- option to disable rather than deleting code
			DefaultVolume = 1.0, -- 0.01 is lowest, 1.0 is max
			radius = 55, -- The radius of the sound from the booth
			coords = vec3(-1377.49, -608.06, 30.79), -- Where the booth is located
		},
		{ -- Henhouse (smokeys MLO coords)
			job = "public",
			enableBooth = true,
			DefaultVolume = 0.1,
			radius = 25,
			coords = vec3(831.85, -112.49, 79.77),
		},
		{ -- Tequilala bar (ingame mlo)
			job = "tequilala",
			enableBooth = false,
			DefaultVolume = 0.1,
			radius = 30,
			coords = vec3(-549.68, 282.64, 82.98),
		},
		{ -- GabzTuners Radio Prop
			job = "public",
			enableBooth = true,
			DefaultVolume = 1.0,
			radius = 40,
			coords = 
			vec3(-2.06, -1811.72, 20.35),

									-- (can be changed to any prop, coords determine wether its placed correctly)
		},
		{ -- Gabz Popsdiner Radio Prop
			job = "public",
			enableBooth = true,
			DefaultVolume = 1.0,
			radius = 15,
			coords = vec3(-12.25, -1808.37, 20.34),
		},
		{ -- LostMC compound next to Casino
			gang = "lostmc",
			enableBooth = true,
			DefaultVolume = 0.1,
			radius = 20,
			coords = vec3(983.14, -133.17, 79.59),
			soundLoc = vec3(988.79, -131.62, 78.89), -- Add sound origin location if you don't want the music to play from the dj booth
		},
	},
}

Loc = {}