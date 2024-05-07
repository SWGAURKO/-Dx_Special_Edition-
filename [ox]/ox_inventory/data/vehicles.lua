return {
	-- 0	vehicle has no storage
	-- 1	vehicle has no trunk storage
	-- 2	vehicle has no glovebox storage
	-- 3	vehicle has trunk in the hood
	Storage = {
		[`jester`] = 3,
		[`adder`] = 3,
		[`osiris`] = 1,
		[`pfister811`] = 1,
		[`penetrator`] = 1,
		[`autarch`] = 1,
		[`bullet`] = 1,
		[`cheetah`] = 1,
		[`cyclone`] = 1,
		[`voltic`] = 1,
		[`reaper`] = 3,
		[`entityxf`] = 1,
		[`t20`] = 1,
		[`taipan`] = 1,
		[`tezeract`] = 1,
		[`torero`] = 3,
		[`turismor`] = 1,
		[`fmj`] = 1,
		[`infernus`] = 1,
		[`italigtb`] = 3,
		[`italigtb2`] = 3,
		[`nero2`] = 1,
		[`vacca`] = 3,
		[`vagner`] = 1,
		[`visione`] = 1,
		[`prototipo`] = 1,
		[`zentorno`] = 1,
		[`trophytruck`] = 0,
		[`trophytruck2`] = 0,
	},

	-- slots, maxWeight; default weight is 8000 per slot
	glovebox = {
		[0] = {11, 5000},		-- Compact
		[1] = {11, 5000},		-- Sedan
		[2] = {11, 5000},		-- SUV
		[3] = {11, 5000},		-- Coupe
		[4] = {11, 5000},		-- Muscle
		[5] = {11, 5000},		-- Sports Classic
		[6] = {11, 5000},		-- Sports
		[7] = {11, 3000},		-- Super
		[8] = {5, 1000},		-- Motorcycle
		[9] = {11, 5000},		-- Offroad
		[10] = {11, 5000},		-- Industrial
		[11] = {11, 5000},		-- Utility
		[12] = {11, 5000},		-- Van
		[14] = {31, 1000},		-- Boat
		[15] = {31, 8000},		-- Helicopter
		[16] = {51, 8000},		-- Plane
		[17] = {11, 5000},		-- Service
		[18] = {11, 5000},		-- Emergency
		[19] = {11, 5000},		-- Military
		[20] = {11, 5000},		-- Commercial (trucks)
		models = {
			[`xa21`] = {11, 5000}
		}
	},

	trunk = {
		[0] = {21, 35000},		-- Compact
		[1] = {41, 45000},		-- Sedan
		[2] = {51, 50000},		-- SUV
		[3] = {31, 40000},		-- Coupe
		[4] = {41, 30000},		-- Muscle
		[5] = {31, 25000},		-- Sports Classic
		[6] = {31, 15000},		-- Sports
		[7] = {21, 10000},		-- Super
		[8] = {5,  2000},		-- Motorcycle
		[9] = {51, 40000},		-- Offroad
		[10] = {51, 80000},	-- Industrial
		[11] = {41, 80000},	-- Utility
		[12] = {61, 80000},	-- Van
		-- [14] -- Boat
		-- [15] -- Helicopter
		-- [16] -- Plane
		[17] = {41, 40000},	-- Service
		[18] = {41, 40000},	-- Emergency
		[19] = {41, 40000},	-- Military
		[20] = {61, 40000},	-- Commercial
		models = {
			[`xa21`] = {11, 40000}
		},
	}
}
