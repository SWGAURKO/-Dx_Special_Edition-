print("^2Jim^7-^2Consumables ^7v^41^7.^45 ^7- ^2Consumables Script by ^1Jimathy^7")

-- If you need support I now have a discord available, it helps me keep track of issues and give better support.

-- https://discord.gg/xKgQZ6wZvS

Config = {
	Debug = false,
	Core = "qb-core",

	Inv = "ox", -- set to "ox" if using ox_inventory
	Notify = "qb",  -- set to "ox" if using ox_lib

	UseProgbar = true,
	ProgressBar = "qb", -- set to "ox" if using ox_lib

	Consumables = {
		["vodka"] = { 			emote = "vodkab", 		canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "alcohol", stats = { effect = "stress", time = 5000, amount = 2, thirst = math.random(10,20), canOD = true }},
		["beer"] = { 			emote = "beer", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10,20), canOD = true }},
		["whiskey"] = { 		emote = "whiskey",  	canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10,20), canOD = true }},

		["sandwich"] = { 		emote = "sandwich", 	canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,20), }},
		["twerks_candy"] = { 	emote = "egobar", 		canRun = true, 		time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,20), }},
		["snikkel_candy"] = { 	emote = "egobar", 		canRun = true, 		time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,20), }},
		["tosti"] = { 			emote = "sandwich", 	canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,20), }},

		["coffee"] = { 			emote = "coffee", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { effect = "stamina", time = 10000, thirst = math.random(10,20), }},
		["water_bottle"] = { 	emote = "drink", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(10,20), }},
		["kurkakola"] = { 		emote = "ecola", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(10,20), }},
		["joint"] = { 			emote = "smoke3",	time = math.random(5000, 6000), stress = math.random(12, 24), heal = 0, armor = 10, type = "drug", stats = { screen = "weed", effect = "armor", widepupils = false, canOD = false } },
		["cokebaggy"] = { 		emote = "coke",		time = math.random(5000, 6000), stress = math.random(12, 24), heal = 0, armor = 0, type = "drug", stats = { screen = "focus", effect = "stamina", widepupils = false, canOD = true } },
		["xtcbaggy"] = { 		emote = "oxy",		time = math.random(5000, 6000), stress = math.random(12, 24), heal = 0, armor = 10, type = "drug", stats = { effect = "strength", widepupils = true, canOD = true } },
		["oxy"] = { 			emote = "oxy",		time = math.random(5000, 6000), stress = math.random(12, 24), heal = 0, armor = 0, type = "drug", stats = { effect = "heal", widepupils = false, canOD = false } },
		["meth"] = { 			emote = "coke",		time = math.random(5000, 6000), stress = math.random(12, 24), heal = 0, armor = 10, type = "drug", stats = { effect = "stamina", widepupils = false, canOD = true } },
        -- Jim Popsdinner Drinks
	   ["ecola"] = { emote = "ecola", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(20,30), }},
	   ["ecolalight"] = { emote = "ecola", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(20,30), }},
	   ["sprunk"] = { emote = "sprunk", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(20,30), }},
	   ["sprunklight"] = { emote = "sprunk", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(20,30), }},
   
	   -- Jim Popsdinner Food
	   ["crisps"] = { emote = "crisps", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
   
	   ["carrotcake"] = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	   ["cheesecake"] = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	   ["jelly"] = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	   ["chocpudding"] = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	   ["popdonut"] = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	   ["popicecream"] = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	   ["chocolate"] = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	   ["baconeggs"] = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	   ["bltsandwich"] = { emote = "sandwich", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	   ["cheeseburger"] = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	   ["cheesesandwich"] = { emote = "sandwich", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	   ["eggsandwich"] = { emote = "sandwich", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	   ["grilledwrap"] = { emote = "sandwich", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	   ["hamburger"] = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	   ["hamcheesesandwich"] = { emote = "sandwich", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	   ["hamsandwich"] = { emote = "sandwich", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	   ["ranchwrap"] = { emote = "sandwich", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	   ["sausageeggs"] = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	   ["steakburger"] = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	   ["toastbacon"] = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	   ["tunasandwich"] = { emote = "sandwich", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	   ["veggiewrap"] = { emote = "sandwich", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
      --Jim-Pizzathis-Alcohol
	  ["amarone"] = { emote = "redwine", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(20, 30), canOD = true }},
	  ["barbera"] = { emote = "redwine", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(20, 30), canOD = true }},
	  ["dolceto"] = { emote = "whitewine", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(20, 30), canOD = true }},
	  ["housered"] = { emote = "redwine", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(20, 30), canOD = true }},
	  ["housewhite"] = { emote = "whitewine", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(20, 30), canOD = true }},
	  ["rosso"] = { emote = "redwine", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(20, 30), canOD = true }},
  
	  ["ambeer"] = { emote = "beer3", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10, 20), canOD = true }},
	  ["dusche"] = { emote = "beer1", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10, 20), canOD = true }},
	  ["logger"] = { emote = "beer2", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10, 20), canOD = true }},
	  ["pisswasser"] = { emote = "beer4", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10, 20), canOD = true }},
	  ["pisswasser2"] = { emote = "beer5", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10, 20), canOD = true }},
	  ["pisswasser3"] = { emote = "beer6", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10, 20), canOD = true }},
	  --Jim-Pizzathis-Food
	  ["tiramisu"] = { emote = "bowl", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10, 20), }},
	  ["gelato"] = { emote = "bowl", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10, 20), }},
	  ["medfruits"] = { emote = "pineapple", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10, 20), }},
  
	  ["bolognese"] = { emote = "foodbowl", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	  ["calamari"] = { emote = "foodbowl", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	  ["meatball"] = { emote = "foodbowl", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	  ["alla"] = { emote = "foodbowl", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	  ["pescatore"] = { emote = "foodbowl", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
  
	  ["capricciosa"] = { emote = "pizza", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10, 20), }},
	  ["diavola"] = { emote = "pizza", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10, 20), }},
	  ["marinara"] = { emote = "pizza", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10, 20), }},
	  ["margherita"] = { emote = "pizza", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10, 20), }},
	  ["prosciuttio"] = { emote = "pizza", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10, 20), }},
	  ["vegetariana"] = { emote = "pizza", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10, 20), }},	
	--VANILLA UNICORN
	--Drink Ingredients
	["midori"] = { emote = "beer3", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10, 20), canOD = true }},
	["prosecco"] = { emote = "beer3", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10, 20), canOD = true }},
	["tequila"] = { emote = "beer3", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10, 20), canOD = true }},
	["triplsec"] = { emote = "beer3", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10, 20), canOD = true }},
	["gin"] = { emote = "ginb", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10, 20), canOD = true }},
	["rum"] = { emote = "rumb", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10, 20), canOD = true }},

	["amaretto"] = { emote = "whiskey", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10, 20), canOD = true }},
	["amarettosour"] = { emote = "whiskey", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(40, 50), canOD = true }},
	["bellini"] = { emote = "whiskey", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(40, 50), canOD = true }},
	["cosmopolitan"] = { emote = "whiskey", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(40, 50), canOD = true }},
	["longisland"] = { emote = "whiskey", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(40, 50), canOD = true }},
	["margarita"] = { emote = "whiskey", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(40, 50), canOD = true }},
	["pinacolada"] = { emote = "whiskey", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(40, 50), canOD = true }},
	["sangria"] = { emote = "whiskey", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(40, 50), canOD = true }},
	["screwdriver"] = { emote = "whiskey", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(40, 50), canOD = true }},
	["strawdaquiri"] = { emote = "whiskey", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(40, 50), canOD = true }},
	["strawmargarita"] = { emote = "whiskey", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(40, 50), canOD = true }},

	["ambeer"] = { emote = "beer3", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10, 20), canOD = true }},
	["dusche"] = { emote = "beer1", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10, 20), canOD = true }},
	["logger"] = { emote = "beer2", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10, 20), canOD = true }},
	["pisswasser"] = { emote = "beer4", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10, 20), canOD = true }},
	["pisswasser2"] = { emote = "beer5", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10, 20), canOD = true }},
	["pisswasser3"] = { emote = "beer6", canRun = true,  time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10, 20), canOD = true }},

	--Jim-VanillaUnicorn-Drinks
	["cranberry"] = { emote = "wine", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(20, 20), }},
	["pinejuice"] = { emote = "wine", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(40, 50), }},
	["ecola"] = { emote = "ecola", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(10, 20), }},
	["ecolalight"] = { emote = "ecola", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(10, 20), }},
	["sprunk"] = { emote = "sprunk", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(10, 20), }},
	["sprunklight"] = { emote = "sprunk", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(10, 20), }},

	--Jim-VanillaUnicorn-Food
	["chocolate"] = { emote = "egobar", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10, 20), }},
	["crisps"] = { emote = "crisps", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	["cubasil"] = { emote = "burger", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	["mintleaf"] = { emote = "burger", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	["peach"] = { emote = "burger", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	["strawberry"] = { emote = "burger", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},
	["chocolate"] = { emote = "egobar", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(20, 30), }},

	["nplate"] = { emote = "burger", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(40, 50), }},
	["vusliders"] = { emote = "burger", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(40, 50), }},
	["vutacos"] = { emote = "burger", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(40, 50), }},
	["tots"] = { emote = "burger", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(40, 50), }},
	["nachos"] = { emote = "burger", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(40, 50), }},
	
	},

	Emotes = {		
		["drink"] = {"mp_player_intdrink", "loop_bottle", "Drink", AnimationOptions =
			{ Prop = "prop_ld_flow_bottle", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
				EmoteMoving = true, EmoteLoop = true, }},
		["coffee"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Coffee", AnimationOptions =
			{ Prop = 'p_amb_coffeecup_01', PropBone = 28422, PropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
				EmoteLoop = true, EmoteMoving = true }},
		["burger"] = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Burger",	AnimationOptions =
			{ Prop = 'prop_cs_burger_01', PropBone = 18905, PropPlacement = {0.13,0.05,0.02,-50.0,16.0,60.0},
				EmoteMoving = true }},
		["beer"] = {"amb@world_human_drinking@beer@male@idle_a", "idle_c", "Beer", AnimationOptions =
			{ Prop = 'prop_amb_beer_bottle', PropBone = 28422, PropPlacement = {0.0,0.0,0.06,0.0,15.0,0.0},
				EmoteLoop = true, EmoteMoving = true }},
		["egobar"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger","Ego Bar", AnimationOptions =
			{ Prop = 'prop_choc_ego', PropBone = 60309, PropPlacement ={0.0,0.0,0.0,0.0,0.0,0.0},
				EmoteMoving = true }},
		["sandwich"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Sandwich", AnimationOptions =
			{ Prop = 'prop_sandwich_01', PropBone = 18905, PropPlacement = {0.13,0.05,0.02,-50.0,16.0,60.0},
				EmoteMoving = true }},
		["smoke3"] = { "amb@world_human_aa_smoke@male@idle_a", "idle_b", "Smoke 3", AnimationOptions =
			{ Prop = 'prop_cs_ciggy_01', PropBone = 28422, PropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
				EmoteLoop = true, EmoteMoving = true }},
		["whiskey"] = { "amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Whiskey", AnimationOptions =
			{ Prop = 'prop_drink_whisky', PropBone = 28422, PropPlacement = {0.01,-0.01,-0.06,0.0,0.0,0.0},
				EmoteLoop = true, EmoteMoving = true } },
		["vodkab"] = {"mp_player_intdrink", "loop_bottle", "(Don't Use) Vodka Bottle", AnimationOptions =
			{ Prop = 'prop_vodka_bottle', PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0},
				EmoteMoving = true, EmoteLoop = true }},
		["ecola"] = {"mp_player_intdrink", "loop_bottle", "E-cola", AnimationOptions =
			{ Prop = "prop_ecola_can", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
				EmoteMoving = true, EmoteLoop = true, }},
		["crisps"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Chrisps", AnimationOptions =
			{ Prop = 'v_ret_ml_chips2', PropBone = 28422, PropPlacement = {0.01, -0.05, -0.1, 0.0, 0.0, 90.0},
				EmoteLoop = true, EmoteMoving = true, }},		
		--Drugs
		["coke"] = { "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", "Coke", AnimationOptions =
			{ EmoteLoop = true, EmoteMoving = true, }},
		["oxy"] = { "mp_suicide", "pill", "Oxy", AnimationOptions =
			{ EmoteLoop = true, EmoteMoving = true, }},
				["cigar"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cigar", AnimationOptions =
			{ Prop = 'prop_cigar_02', PropBone = 47419, PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
				EmoteMoving = true, EmoteDuration = 2600 }},
		["cigar2"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cigar 2", AnimationOptions =
			{ Prop = 'prop_cigar_01', PropBone = 47419, PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
				EmoteMoving = true, EmoteDuration = 2600 }},
		["joint"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Joint", AnimationOptions =
			{ Prop = 'p_cs_joint_02', PropBone = 47419, PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
				EmoteMoving = true, EmoteDuration = 2600 }},
		["cig"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cig", AnimationOptions =
			{ Prop = 'prop_amb_ciggy_01', PropBone = 47419, PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
			EmoteMoving = true, EmoteDuration = 2600 }},
        	--Jim-PizzaThis
		["redwine"] = {"mp_player_intdrink", "loop_bottle", "Red Wine Bottle", AnimationOptions =
		{    Prop = "prop_wine_rose", PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0},
			 EmoteMoving = true, EmoteLoop = true, }},
		["whitewine"] = {"mp_player_intdrink", "loop_bottle", "White Wine Bottle", AnimationOptions =
		{    Prop = "prop_wine_white", PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0},
			 EmoteMoving = true, EmoteLoop = true, }},
		["beer1"] = {"mp_player_intdrink", "loop_bottle", "Dusche", AnimationOptions =
		{    Prop = "prop_beerdusche", PropBone = 18905, PropPlacement = {0.04, -0.14, 0.10, 240.0, -60.0},
			 EmoteMoving = true, EmoteLoop = true, }},
		["beer2"] = {"mp_player_intdrink", "loop_bottle", "Logger", AnimationOptions =
		{    Prop = "prop_beer_logopen", PropBone = 18905, PropPlacement = {0.03, -0.18, 0.10, 240.0, -60.0},
			 EmoteMoving = true, EmoteLoop = true, }},
		["beer3"] = {"mp_player_intdrink", "loop_bottle", "AM Beer", AnimationOptions =
		{    Prop = "prop_beer_amopen", PropBone = 18905, PropPlacement = {0.03, -0.18, 0.10, 240.0, -60.0},
			 EmoteMoving = true, EmoteLoop = true, }},
		["beer4"] = {"mp_player_intdrink", "loop_bottle", "Pisswasser1", AnimationOptions =
		{    Prop = "prop_beer_pissh", PropBone = 18905, PropPlacement = {0.03, -0.18, 0.10, 240.0, -60.0},
			 EmoteMoving = true, EmoteLoop = true, }},
		["beer5"] = {"mp_player_intdrink", "loop_bottle", "Pisswasser2", AnimationOptions =
		{    Prop = "prop_amb_beer_bottle", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
			 EmoteMoving = true, EmoteLoop = true, }},
		["beer6"] = {"mp_player_intdrink", "loop_bottle", "Pisswasser3", AnimationOptions =
		{    Prop = "prop_cs_beer_bot_02", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
			 EmoteMoving = true, EmoteLoop = true, }},
		["ecola"] = {"mp_player_intdrink", "loop_bottle", "e-cola", AnimationOptions =
		{    Prop = "prop_ecola_can", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
			 EmoteMoving = true, EmoteLoop = true, }},
		["sprunk"] = {"mp_player_intdrink", "loop_bottle", "sprunk", AnimationOptions =
		{    Prop = "v_res_tt_can03", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
			 EmoteMoving = true, EmoteLoop = true, }},
		["pizza"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger_fp", "Pizza", AnimationOptions =
		{    Prop = "v_res_tt_pizzaplate", PropBone = 18905, PropPlacement = {0.20, 0.038, 0.051, 15.0, 155.0},
			 EmoteMoving = true, EmoteLoop = true, }},
		["bowl"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "bowl", AnimationOptions =
		{    Prop = "h4_prop_h4_coke_plasticbowl_01", PropBone = 28422, PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
			 EmoteMoving = true, EmoteLoop = true, }},
		["pineapple"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger_fp", "Pizza", AnimationOptions =
		{    Prop = "prop_pineapple", PropBone = 18905, PropPlacement = {0.10, 0.038, 0.03, 15.0, 50.0},
			 EmoteMoving = true, EmoteLoop = true, }},
		["foodbowl"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "bowl", AnimationOptions =
		{    Prop = "prop_cs_bowl_01", PropBone = 28422, PropPlacement = {0.0, 0.0, 0.050, 0.0, 0.0, 0.0},
			 EmoteMoving = true, EmoteLoop = true, }},
		["ecola"] = {"mp_player_intdrink", "loop_bottle", "E-cola", AnimationOptions =
		{ Prop = "prop_ecola_can", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
			EmoteMoving = true, EmoteLoop = true, }},
		["sprunk"] = {"mp_player_intdrink", "loop_bottle", "Sprunk", AnimationOptions =
		{ Prop = "v_res_tt_can03", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
			EmoteMoving = true, EmoteLoop = true, }},
		["crisps"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Crisps", AnimationOptions =
		{ Prop = 'v_ret_ml_chips2', PropBone = 28422, PropPlacement = {0.01, -0.05, -0.1, 0.0, 0.0, 90.0},
		   EmoteLoop = true, EmoteMoving = true, }},
		["bmcoffee1"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Coffee2", AnimationOptions =
		{ Prop = 'prop_fib_coffee', PropBone = 28422, PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		   EmoteLoop = true, EmoteMoving = true, }},
		["bmcoffee2"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Coffee3", AnimationOptions =
		{ Prop = 'ng_proc_coffee_01a', PropBone = 28422, PropPlacement = {0.0, 0.0, -0.06, 0.0, 0.0, 0.0},
		   EmoteLoop = true, EmoteMoving = true, }},
		["bmcoffee3"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Coffee3", AnimationOptions =
		{ Prop = 'v_club_vu_coffeecup', PropBone = 28422, PropPlacement = {0.0, 0.0, -0.06, 0.0, 0.0, 0.0},
		   EmoteLoop = true, EmoteMoving = true, }},
		["milk"] = {"mp_player_intdrink", "loop_bottle", "Milk", AnimationOptions =
		{ Prop = "v_res_tt_milk", PropBone = 18905, PropPlacement = {0.10, 0.008, 0.07, 240.0, -60.0},
			EmoteMoving = true, EmoteLoop = true, }},
		["donut2"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Donut2", AnimationOptions =
		{ Prop = 'prop_donut_02', PropBone = 18905, PropPlacement = {0.13, 0.05, 0.02, -50.0, 100.0, 270.0},
		   EmoteMoving = true, EmoteLoop = true, }},	 
	--Jim-VanillaUnicorn
	["whiskeyb"] = {"mp_player_intdrink", "loop_bottle", "(Don't Use) Whiskey Bottle", AnimationOptions =
	{    Prop = "prop_cs_whiskey_bottle", PropBone = 60309, PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0},
		EmoteMoving = true, EmoteLoop = true }},
	["rumb"] = {"mp_player_intdrink", "loop_bottle", "(Don't Use) Rum Bottle", AnimationOptions =
	{    Prop = "prop_rum_bottle", PropBone = 18905, PropPlacement = {0.03, -0.18, 0.10, 240.0, -60.0},
		EmoteMoving = true, EmoteLoop = true }},
	["icream"] = {"mp_player_intdrink", "loop_bottle", "Irish Cream Bottle", AnimationOptions =
	{    Prop = "prop_bottle_brandy", PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0},
		EmoteMoving = true, EmoteLoop = true }},
	["ginb"] =  {"mp_player_intdrink", "loop_bottle", "(Don't Use) Gin Bottle", AnimationOptions =
	{    Prop = "prop_tequila_bottle", PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0},
		EmoteMoving = true, EmoteLoop = true }},
	["vodkab"] = {"mp_player_intdrink", "loop_bottle", "(Don't Use) Vodka Bottle", AnimationOptions =
	{   Prop = 'prop_vodka_bottle', PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0},
		EmoteMoving = true, EmoteLoop = true }},

   ["crisps"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Chrisps", AnimationOptions =
   {   Prop = 'v_ret_ml_chips2', PropBone = 28422, PropPlacement = {0.01, -0.05, -0.1, 0.0, 0.0, 90.0},
       EmoteLoop = true, EmoteMoving = true, }},
   ["beer1"] = {"mp_player_intdrink", "loop_bottle", "Dusche", AnimationOptions =
   {    Prop = "prop_beerdusche", PropBone = 18905, PropPlacement = {0.04, -0.14, 0.10, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["beer2"] = {"mp_player_intdrink", "loop_bottle", "Logger", AnimationOptions =
   {    Prop = "prop_beer_logopen", PropBone = 18905, PropPlacement = {0.03, -0.18, 0.10, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["beer3"] = {"mp_player_intdrink", "loop_bottle", "AM Beer", AnimationOptions =
   {    Prop = "prop_beer_amopen", PropBone = 18905, PropPlacement = {0.03, -0.18, 0.10, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["beer4"] = {"mp_player_intdrink", "loop_bottle", "Pisswasser1", AnimationOptions =
   {    Prop = "prop_beer_pissh", PropBone = 18905, PropPlacement = {0.03, -0.18, 0.10, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["beer5"] = {"mp_player_intdrink", "loop_bottle", "Pisswasser2", AnimationOptions =
   {    Prop = "prop_amb_beer_bottle", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["beer6"] = {"mp_player_intdrink", "loop_bottle", "Pisswasser3", AnimationOptions =
   {    Prop = "prop_cs_beer_bot_02", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["ecola"] = {"mp_player_intdrink", "loop_bottle", "E-cola", AnimationOptions =
   {    Prop = "prop_ecola_can", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["sprunk"] = {"mp_player_intdrink", "loop_bottle", "Sprunk", AnimationOptions =
   {    Prop = "v_res_tt_can03", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
	--Jim-Bars
	["whiskeyb"] = {"mp_player_intdrink", "loop_bottle", "(Don't Use) Whiskey Bottle", AnimationOptions =
	{    Prop = "prop_cs_whiskey_bottle", PropBone = 60309, PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0},
		EmoteMoving = true, EmoteLoop = true }},
	["rumb"] = {"mp_player_intdrink", "loop_bottle", "(Don't Use) Rum Bottle", AnimationOptions =
	{    Prop = "prop_rum_bottle", PropBone = 18905, PropPlacement = {0.03, -0.18, 0.10, 240.0, -60.0},
		EmoteMoving = true, EmoteLoop = true }},
	["icream"] = {"mp_player_intdrink", "loop_bottle", "Irish Cream Bottle", AnimationOptions =
	{    Prop = "prop_bottle_brandy", PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0},
		EmoteMoving = true, EmoteLoop = true }},
	["ginb"] =  {"mp_player_intdrink", "loop_bottle", "(Don't Use) Gin Bottle", AnimationOptions =
	{    Prop = "prop_tequila_bottle", PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0},
		EmoteMoving = true, EmoteLoop = true }},
	["vodkab"] = {"mp_player_intdrink", "loop_bottle", "(Don't Use) Vodka Bottle", AnimationOptions =
	{   Prop = 'prop_vodka_bottle', PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0},
		EmoteMoving = true, EmoteLoop = true }},

   ["crisps"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Chrisps", AnimationOptions =
   {   Prop = 'v_ret_ml_chips2', PropBone = 28422, PropPlacement = {0.01, -0.05, -0.1, 0.0, 0.0, 90.0},
       EmoteLoop = true, EmoteMoving = true, }},
   ["beer1"] = {"mp_player_intdrink", "loop_bottle", "Dusche", AnimationOptions =
   {    Prop = "prop_beerdusche", PropBone = 18905, PropPlacement = {0.04, -0.14, 0.10, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["beer2"] = {"mp_player_intdrink", "loop_bottle", "Logger", AnimationOptions =
   {    Prop = "prop_beer_logopen", PropBone = 18905, PropPlacement = {0.03, -0.18, 0.10, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["beer3"] = {"mp_player_intdrink", "loop_bottle", "AM Beer", AnimationOptions =
   {    Prop = "prop_beer_amopen", PropBone = 18905, PropPlacement = {0.03, -0.18, 0.10, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["beer4"] = {"mp_player_intdrink", "loop_bottle", "Pisswasser1", AnimationOptions =
   {    Prop = "prop_beer_pissh", PropBone = 18905, PropPlacement = {0.03, -0.18, 0.10, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["beer5"] = {"mp_player_intdrink", "loop_bottle", "Pisswasser2", AnimationOptions =
   {    Prop = "prop_amb_beer_bottle", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["beer6"] = {"mp_player_intdrink", "loop_bottle", "Pisswasser3", AnimationOptions =
   {    Prop = "prop_cs_beer_bot_02", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["ecola"] = {"mp_player_intdrink", "loop_bottle", "E-cola", AnimationOptions =
   {    Prop = "prop_ecola_can", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["sprunk"] = {"mp_player_intdrink", "loop_bottle", "Sprunk", AnimationOptions =
   {    Prop = "v_res_tt_can03", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
	}, 
}
