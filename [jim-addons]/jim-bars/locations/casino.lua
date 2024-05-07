
Config.Locations["casino"] = {
	zoneEnable = true,
	job = "casino",
	--gang = "lostmc",
	label = "Casino",
	logo = "",
	autoClockOut = true,
	zones = { 
		vector2(990.71, -66.31),
		vector2(873.52, 13.31),
		vector2(1075.83, 269.18),
		vector2(1155.01, 220.65)
	},
	Blip = {
		showBlip = true,
		coords = vector3(934.41, 40.52, 81.1),
		color = 0,
		sprite = 679,
	}, 
	Targets = {
		Clockin = {
			{ coords = vector3(831.62, -111.69, 79.77), h = 340.0, l = 0.5, w = 0.5, bottom = 79.82, top = 80.42, },
		},
		Cocktails = {
			{ coords = vector3(978.97, 23.16, 71.46), h = 320.0, l = 0.4, w = 1.0, bottom = 68.77, top = 75.17, }, --upstair bar L
		},
		Shop = { 
			{ coords = vector3(979.92, 23.35, 71.46), h = 40.0, l = 1.0, w = 1.0, bottom = 68.77, top = 74.92, }, --upstair bar
			
		},
		Tap = {
			{ coords = vector3(355.4, 281.87, 94.19), h = 345, l = 1.45, w = 0.5, bottom = 93.77, top = 99.77 }, --upstair bar
			
		},
		Coffee = {
			{ coords = vector3(355.21, 280.77, 94.19), h = 345.0, l = 0.5, w = 0.5, bottom = 92.67, top = 96.47, },
		},
		HandWash = {
			{ coords = vector3(842.38, -122.33, 79.77), h = 328.0, l = 0.7, w = 0.5, bottom = 79.37, top = 80.37, },
			
		},
		Payment = {
			{ coords = vector3(834.53, -115.76, 79.77), h = 330.0, l = 0.5, w = 0.4, bottom = 79.62, top = 80.27, },
		},
		Tray = {
			{ coords = vector3(979.7, 21.32, 71.46), h = 90, l = 1.0, w = 1.0, bottom = 68.07, top = 75.10, prop = true }, --upstair bar
		},
	},
	--Custom DJ Booth Stuff
	Booth = {
		enableBooth = true, -- Set false if using external DJ/Music stuff.
		DefaultVolume = 0.1, -- 0.01 is lowest, 1.0 is max
		radius = 35, -- The radius of the sound from the booth
		coords = vector3(374.73, 276.05, 92.4), -- Where the booth is located
		playing = false, -- No touch.
	},
}