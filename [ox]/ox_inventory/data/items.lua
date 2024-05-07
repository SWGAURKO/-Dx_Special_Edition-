return {
	['testburger'] = {
		label = 'Test Burger',
		weight = 220,
		degrade = 60,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			export = 'ox_inventory_examples.testburger'
		},
		server = {
			export = 'ox_inventory_examples.testburger',
			test = 'what an amazingly delicious burger, amirite?'
		},
		buttons = {
			{
				label = 'Lick it',
				action = function(slot)
					print('You licked the burger')
				end
			},
			{
				label = 'Squeeze it',
				action = function(slot)
					print('You squeezed the burger :(')
				end
			},
			{
				label = 'What do you call a vegan burger?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('A misteak.')
				end
			},
			{
				label = 'What do frogs like to eat with their hamburgers?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('French flies.')
				end
			},
			{
				label = 'Why were the burger and fries running?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('Because they\'re fast food.')
				end
			}
		},
		consume = 0.3
	},

	['bandage'] = {
		label = 'Bandage',
		weight = 115,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
		}
	},

	['black_money'] = {
		label = 'Dirty Money',
	},

	['burger'] = {
		label = 'Burger',
		weight = 220,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'You ate a delicious burger'
		},
	},

	['cola'] = {
		label = 'eCola',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with cola'
		}
	},

	['parachute'] = {
		label = 'Parachute',
		weight = 8000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 1500
		}
	},

	['garbage'] = {
		label = 'Garbage',
	},

	['paperbag'] = {
		label = 'Paper Bag',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},

	['identification'] = {
		label = 'Identification',
	},

	['panties'] = {
		label = 'Knickers',
		weight = 10,
		consume = 0,
		client = {
			status = { thirst = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
			usetime = 2500,
		}
	},

	--[[ ['phone'] = {
		label = 'Phone',
		weight = 190,
		stack = false,
		consume = 0,
		client = {
			add = function(total)
				if total > 0 then
					pcall(function() return exports.npwd:setPhoneDisabled(false) end)
				end
			end,

			remove = function(total)
				if total < 1 then
					pcall(function() return exports.npwd:setPhoneDisabled(true) end)
				end
			end
		}
	}, ]]

	['money'] = {
		label = 'Money',
	},

	['mustard'] = {
		label = 'Mustard',
		weight = 500,
		client = {
			status = { hunger = 25000, thirst = 25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
			usetime = 2500,
			notification = 'You.. drank mustard'
		}
	},

	-- ['water'] = {
	-- 	label = 'Water',
	-- 	weight = 500,
	-- 	client = {
	-- 		status = { thirst = 200000 },
	-- 		anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
	-- 		prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
	-- 		usetime = 2500,
	-- 		cancel = true,
	-- 		notification = 'You drank some refreshing water'
	-- 	}
	-- },

	['radio'] = {
		label = 'Radio',
		weight = 1000,
		stack = false,
		allowArmed = true
	},

	['c4'] = {
		label = 'C4 Bomb',
		weight = 1000,
		stack = true,
		description = "Bomb to detonaite big things",
	},

	['armour'] = {
		label = 'Bulletproof Vest',
		weight = 3000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 3500
		}
	},

	['clothing'] = {
		label = 'Clothing',
		consume = 0,
	},

	['mastercard'] = {
		label = 'Mastercard',
		stack = false,
		weight = 10,
	},

	['scrapmetal'] = {
		label = 'Scrap Metal',
		weight = 80,
	},

	["tablet"] = {
		label = "Tablet",
		weight = 2000,
		stack = true,
		close = true,
		description = "Expensive tablet",
		client = {
			image = "tablet.png",
		}
	},

	["coffee"] = {
		label = "Coffee",
		weight = 200,
		stack = true,
		close = true,
		description = "Pump 4 Caffeine",
		client = {
			image = "coffee.png",
		}
	},

	["veh_exterior"] = {
		label = "Exterior",
		weight = 1000,
		stack = true,
		close = true,
		description = "Upgrade vehicle exterior",
		client = {
			image = "veh_exterior.png",
		}
	},

	["veh_wheels"] = {
		label = "Wheels",
		weight = 1000,
		stack = true,
		close = true,
		description = "Upgrade vehicle wheels",
		client = {
			image = "veh_wheels.png",
		}
	},

	["oxy"] = {
		label = "Prescription Oxy",
		weight = 0,
		stack = true,
		close = true,
		description = "The Label Has Been Ripped Off",
		client = {
			image = "oxy.png",
		}
	},

	["binoculars"] = {
		label = "Binoculars",
		weight = 600,
		stack = true,
		close = true,
		description = "Sneaky Breaky...",
		client = {
			image = "binoculars.png",
		}
	},

	["thermalscope_attachment"] = {
		label = "Thermal Scope",
		weight = 1000,
		stack = true,
		close = true,
		description = "A thermal scope for a weapon",
		client = {
			image = "thermalscope_attachment.png",
		}
	},

	["veh_interior"] = {
		label = "Interior",
		weight = 1000,
		stack = true,
		close = true,
		description = "Upgrade vehicle interior",
		client = {
			image = "veh_interior.png",
		}
	},

	["weaponlicense"] = {
		label = "Weapon License",
		weight = 0,
		stack = false,
		close = true,
		description = "Weapon License",
		client = {
			image = "weapon_license.png",
		}
	},

	["advscope_attachment"] = {
		label = "Advanced Scope",
		weight = 1000,
		stack = true,
		close = true,
		description = "An advanced scope for a weapon",
		client = {
			image = "advscope_attachment.png",
		}
	},

	["gatecrack"] = {
		label = "Gatecrack",
		weight = 0,
		stack = true,
		close = true,
		description = "Handy software to tear down some fences",
		client = {
			image = "usb_device.png",
		}
	},

	["cryptostick"] = {
		label = "Crypto Stick",
		weight = 200,
		stack = false,
		close = true,
		description = "Why would someone ever buy money that doesn't exist.. How many would it contain..?",
		client = {
			image = "cryptostick.png",
		}
	},

	["whiskey"] = {
		label = "Whiskey",
		weight = 500,
		stack = true,
		close = true,
		description = "For all the thirsty out there",
		client = {
			image = "whiskey.png",
		}
	},

	["veh_plates"] = {
		label = "Plates",
		weight = 1000,
		stack = true,
		close = true,
		description = "Install vehicle plates",
		client = {
			image = "veh_plates.png",
		}
	},

	["tactical_muzzle_brake"] = {
		label = "Tactical Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brakee for a weapon",
		client = {
			image = "tactical_muzzle_brake.png",
		}
	},

	["veh_suspension"] = {
		label = "Suspension",
		weight = 1000,
		stack = true,
		close = true,
		description = "Upgrade vehicle suspension",
		client = {
			image = "veh_suspension.png",
		}
	},

	["pinger"] = {
		label = "Pinger",
		weight = 1000,
		stack = true,
		close = true,
		description = "With a pinger and your phone you can send out your location",
		client = {
			image = "pinger.png",
		}
	},

	["slanted_muzzle_brake"] = {
		label = "Slanted Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "slanted_muzzle_brake.png",
		}
	},

	["nitrous"] = {
		label = "Nitrous",
		weight = 1000,
		stack = true,
		close = true,
		description = "Speed up, gas pedal! :D",
		client = {
			image = "nitrous.png",
		}
	},

	["empty_evidence_bag"] = {
		label = "Empty Evidence Bag",
		weight = 0,
		stack = true,
		close = false,
		description = "Used a lot to keep DNA from blood, bullet shells and more",
		client = {
			image = "evidence.png",
		}
	},

	["heavyarmor"] = {
		label = "Heavy Armor",
		weight = 5000,
		stack = true,
		close = true,
		description = "Some protection won't hurt... right?",
		client = {
			image = "armor.png",
		}
	},

	["diamond_ring"] = {
		label = "Diamond Ring",
		weight = 1500,
		stack = true,
		close = true,
		description = "A diamond ring seems like the jackpot to me!",
		client = {
			image = "diamond_ring.png",
		}
	},

	["weed_amnesia"] = {
		label = "Amnesia 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "A weed bag with 2g Amnesia",
		client = {
			image = "weed_baggy.png",
		}
	},

	["weed_whitewidow"] = {
		label = "White Widow 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "A weed bag with 2g White Widow",
		client = {
			image = "weed_baggy.png",
		}
	},

	["heavy_duty_muzzle_brake"] = {
		label = "HD Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "heavy_duty_muzzle_brake.png",
		}
	},

	["drum_attachment"] = {
		label = "Drum",
		weight = 1000,
		stack = true,
		close = true,
		description = "A drum for a weapon",
		client = {
			image = "drum_attachment.png",
		}
	},

	["security_card_01"] = {
		label = "Security Card A",
		weight = 0,
		stack = true,
		close = true,
		description = "A security card... I wonder what it goes to",
		client = {
			image = "security_card_01.png",
		}
	},

	["fat_end_muzzle_brake"] = {
		label = "Fat End Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "fat_end_muzzle_brake.png",
		}
	},

	["precision_muzzle_brake"] = {
		label = "Precision Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "precision_muzzle_brake.png",
		}
	},

	["copper"] = {
		label = "Copper",
		weight = 100,
		stack = true,
		close = false,
		description = "Nice piece of metal that you can probably use for something",
		client = {
			image = "copper.png",
		}
	},

	["xtcbaggy"] = {
		label = "Bag of XTC",
		weight = 0,
		stack = true,
		close = true,
		description = "Pop those pills baby",
		client = {
			image = "xtc_baggy.png",
		}
	},

	["holoscope_attachment"] = {
		label = "Holo Scope",
		weight = 1000,
		stack = true,
		close = true,
		description = "A holo scope for a weapon",
		client = {
			image = "holoscope_attachment.png",
		}
	},

	["aluminum"] = {
		label = "Aluminium",
		weight = 100,
		stack = true,
		close = false,
		description = "Nice piece of metal that you can probably use for something",
		client = {
			image = "aluminum.png",
		}
	},

	["firework4"] = {
		label = "Weeping Willow",
		weight = 1000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework4.png",
		}
	},

	["veh_toolbox"] = {
		label = "Toolbox",
		weight = 1000,
		stack = true,
		close = true,
		description = "Check vehicle status",
		client = {
			image = "veh_toolbox.png",
		}
	},

	["veh_engine"] = {
		label = "Engine",
		weight = 1000,
		stack = true,
		close = true,
		description = "Upgrade vehicle engine",
		client = {
			image = "veh_engine.png",
		}
	},

	["clip_attachment"] = {
		label = "Clip",
		weight = 1000,
		stack = true,
		close = true,
		description = "A clip for a weapon",
		client = {
			image = "clip_attachment.png",
		}
	},

	["newscam"] = {
		label = "News Camera",
		weight = 100,
		stack = false,
		close = true,
		description = "A camera for the news",
		client = {
			image = "newscam.png",
		}
	},

	["iphone"] = {
		label = "iPhone",
		weight = 1000,
		stack = true,
		close = true,
		description = "Very expensive phone",
		client = {
			image = "iphone.png",
		}
	},

	["perseuscamo_attachment"] = {
		label = "Perseus Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A perseus camo for a weapon",
		client = {
			image = "perseuscamo_attachment.png",
		}
	},

	["bank_card"] = {
		label = "Bank Card",
		weight = 0,
		stack = false,
		close = true,
		description = "Used to access ATM",
		client = {
			image = "security_card_04.png",
		}
	},

	["cokebaggy"] = {
		label = "Bag of Coke",
		weight = 0,
		stack = true,
		close = true,
		description = "To get happy real quick",
		client = {
			image = "cocaine_baggy.png",
		}
	},

	["rolex"] = {
		label = "Golden Watch",
		weight = 1000,
		stack = true,
		close = true,
		description = "A golden watch seems like the jackpot to me!",
		client = {
			image = "rolex.png",
		}
	},

	["vodka"] = {
		label = "Vodka",
		weight = 500,
		stack = true,
		close = true,
		description = "For all the thirsty out there",
		client = {
			image = "vodka.png",
		}
	},

	["weed_ak47"] = {
		label = "AK47 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "A weed bag with 2g AK47",
		client = {
			image = "weed_baggy.png",
		}
	},

	["boomcamo_attachment"] = {
		label = "Boom Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A boom camo for a weapon",
		client = {
			image = "boomcamo_attachment.png",
		}
	},

	["tirerepairkit"] = {
		label = "Tire Repair Kit",
		weight = 1000,
		stack = true,
		close = true,
		description = "A kit to repair your tires",
		client = {
			image = "tirerepairkit.png",
		}
	},

	["twerks_candy"] = {
		label = "Twerks",
		weight = 100,
		stack = true,
		close = true,
		description = "Some delicious candy :O",
		client = {
			image = "twerks_candy.png",
		}
	},

	["brushcamo_attachment"] = {
		label = "Brushstroke Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A brushstroke camo for a weapon",
		client = {
			image = "brushcamo_attachment.png",
		}
	},

	["id_card"] = {
		label = "ID Card",
		weight = 0,
		stack = false,
		close = false,
		description = "A card containing all your information to identify yourself",
		client = {
			image = "id_card.png",
		}
	},

	["tosti"] = {
		label = "Grilled Cheese Sandwich",
		weight = 200,
		stack = true,
		close = true,
		description = "Nice to eat",
		client = {
			image = "tosti.png",
		}
	},

	["goldbar"] = {
		label = "Gold Bar",
		weight = 1000,
		stack = true,
		close = true,
		description = "Looks pretty expensive to me",
		client = {
			image = "goldbar.png",
		}
	},

	["firstaid"] = {
		label = "First Aid",
		weight = 2500,
		stack = true,
		close = true,
		description = "You can use this First Aid kit to get people back on their feet",
		client = {
			image = "firstaid.png",
		}
	},

	["metalscrap"] = {
		label = "Metal Scrap",
		weight = 100,
		stack = true,
		close = false,
		description = "You can probably make something nice out of this",
		client = {
			image = "metalscrap.png",
		}
	},

	["split_end_muzzle_brake"] = {
		label = "Split End Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "split_end_muzzle_brake.png",
		}
	},

	["veh_turbo"] = {
		label = "Turbo",
		weight = 1000,
		stack = true,
		close = true,
		description = "Install vehicle turbo",
		client = {
			image = "veh_turbo.png",
		}
	},

	["kurkakola"] = {
		label = "Cola",
		weight = 500,
		stack = true,
		close = true,
		description = "For all the thirsty out there",
		client = {
			image = "cola.png",
		}
	},

	["grip_attachment"] = {
		label = "Grip",
		weight = 1000,
		stack = true,
		close = true,
		description = "A grip for a weapon",
		client = {
			image = "grip_attachment.png",
		}
	},

	["thermite"] = {
		label = "Thermite",
		weight = 1000,
		stack = true,
		close = true,
		description = "Sometimes you'd wish for everything to burn",
		client = {
			image = "thermite.png",
		}
	},

	["coke_brick"] = {
		label = "Coke Brick",
		weight = 1000,
		stack = false,
		close = true,
		description = "Heavy package of cocaine, mostly used for deals and takes a lot of space",
		client = {
			image = "coke_brick.png",
		}
	},

	["snikkel_candy"] = {
		label = "Snikkel",
		weight = 100,
		stack = true,
		close = true,
		description = "Some delicious candy",
		client = {
			image = "snikkel_candy.png",
		}
	},

	["printerdocument"] = {
		label = "Document",
		weight = 500,
		stack = false,
		close = true,
		description = "A nice document",
		client = {
			image = "printerdocument.png",
		}
	},

	["10kgoldchain"] = {
		label = "10k Gold Chain",
		weight = 1000,
		stack = true,
		close = true,
		description = "10 carat golden chain",
		client = {
			image = "10kgoldchain.png",
		}
	},

	["markedbills"] = {
		label = "Marked Money",
		weight = 1000,
		stack = false,
		close = true,
		description = "Money?",
		client = {
			image = "markedbills.png",
		}
	},

	["weed_brick"] = {
		label = "Weed Brick",
		weight = 1000,
		stack = true,
		close = true,
		description = "1KG Weed Brick to sell to large customers.",
		client = {
			image = "weed_brick.png",
		}
	},

	["stickynote"] = {
		label = "Sticky note",
		weight = 0,
		stack = false,
		close = false,
		description = "Sometimes handy to remember something :)",
		client = {
			image = "stickynote.png",
		}
	},

	["weed_ogkush"] = {
		label = "OGKush 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "A weed bag with 2g OG Kush",
		client = {
			image = "weed_baggy.png",
		}
	},

	["weed_purplehaze"] = {
		label = "Purple Haze 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "A weed bag with 2g Purple Haze",
		client = {
			image = "weed_baggy.png",
		}
	},

	["laptop"] = {
		label = "Laptop",
		weight = 4000,
		stack = true,
		close = true,
		description = "Expensive laptop",
		client = {
			image = "laptop.png",
		}
	},

	["lawyerpass"] = {
		label = "Lawyer Pass",
		weight = 0,
		stack = false,
		close = false,
		description = "Pass exclusive to lawyers to show they can represent a suspect",
		client = {
			image = "lawyerpass.png",
		}
	},

	["firework2"] = {
		label = "Poppelers",
		weight = 1000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework2.png",
		}
	},

	["certificate"] = {
		label = "Certificate",
		weight = 0,
		stack = true,
		close = true,
		description = "Certificate that proves you own certain stuff",
		client = {
			image = "certificate.png",
		}
	},

	["water_bottle"] = {
		label = "Bottle of Water",
		weight = 500,
		stack = true,
		close = true,
		description = "For all the thirsty out there",
		client = {
			image = "water_bottle.png",
		}
	},

	["leopardcamo_attachment"] = {
		label = "Leopard Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A leopard camo for a weapon",
		client = {
			image = "leopardcamo_attachment.png",
		}
	},

	["veh_armor"] = {
		label = "Armor",
		weight = 1000,
		stack = true,
		close = true,
		description = "Upgrade vehicle armor",
		client = {
			image = "veh_armor.png",
		}
	},

	["ironoxide"] = {
		label = "Iron Powder",
		weight = 100,
		stack = true,
		close = false,
		description = "Some powder to mix with.",
		client = {
			image = "ironoxide.png",
		}
	},

	["zebracamo_attachment"] = {
		label = "Zebra Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A zebra camo for a weapon",
		client = {
			image = "zebracamo_attachment.png",
		}
	},

	["weed_purplehaze_seed"] = {
		label = "Purple Haze Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "A weed seed of Purple Haze",
		client = {
			image = "weed_seed.png",
		}
	},

	["geocamo_attachment"] = {
		label = "Geometric Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A geometric camo for a weapon",
		client = {
			image = "geocamo_attachment.png",
		}
	},

	["drill"] = {
		label = "Drill",
		weight = 5000,
		stack = true,
		close = false,
		description = "The real deal...",
		client = {
			image = "drill.png",
		}
	},

	["ifaks"] = {
		label = "ifaks",
		weight = 200,
		stack = true,
		close = true,
		description = "ifaks for healing and a complete stress remover.",
		client = {
			image = "ifaks.png",
		}
	},

	["diamond"] = {
		label = "Diamond",
		weight = 1000,
		stack = true,
		close = true,
		description = "A diamond seems like the jackpot to me!",
		client = {
			image = "diamond.png",
		}
	},

	["diving_gear"] = {
		label = "Diving Gear",
		weight = 30000,
		stack = false,
		close = true,
		description = "An oxygen tank and a rebreather",
		client = {
			image = "diving_gear.png",
		}
	},

	["patriotcamo_attachment"] = {
		label = "Patriot Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A patriot camo for a weapon",
		client = {
			image = "patriotcamo_attachment.png",
		}
	},

	["advancedlockpick"] = {
		label = "Advanced Lockpick",
		weight = 500,
		stack = true,
		close = true,
		description = "If you lose your keys a lot this is very useful... Also useful to open your beers",
		client = {
			image = "advancedlockpick.png",
		}
	},

	["beer"] = {
		label = "Beer",
		weight = 500,
		stack = true,
		close = true,
		description = "Nothing like a good cold beer!",
		client = {
			image = "beer.png",
		}
	},

	["weed_skunk_seed"] = {
		label = "Skunk Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "A weed seed of Skunk",
		client = {
			image = "weed_seed.png",
		}
	},

	["veh_xenons"] = {
		label = "Xenons",
		weight = 1000,
		stack = true,
		close = true,
		description = "Upgrade vehicle xenons",
		client = {
			image = "veh_xenons.png",
		}
	},

	["crack_baggy"] = {
		label = "Bag of Crack",
		weight = 0,
		stack = true,
		close = true,
		description = "To get happy faster",
		client = {
			image = "crack_baggy.png",
		}
	},


	["armor"] = {
		label = "Armor",
		weight = 5000,
		stack = true,
		close = true,
		description = "Some protection won't hurt... right?",
		client = {
			image = "armor.png",
		}
	},

	["newsmic"] = {
		label = "News Microphone",
		weight = 100,
		stack = false,
		close = true,
		description = "A microphone for the news",
		client = {
			image = "newsmic.png",
		}
	},

	["rubber"] = {
		label = "Rubber",
		weight = 100,
		stack = true,
		close = false,
		description = "Rubber, I believe you can make your own rubber ducky with it :D",
		client = {
			image = "rubber.png",
		}
	},

	["skullcamo_attachment"] = {
		label = "Skull Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A skull camo for a weapon",
		client = {
			image = "skullcamo_attachment.png",
		}
	},

	["firework3"] = {
		label = "WipeOut",
		weight = 1000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework3.png",
		}
	},

	["empty_weed_bag"] = {
		label = "Empty Weed Bag",
		weight = 0,
		stack = true,
		close = true,
		description = "A small empty bag",
		client = {
			image = "weed_baggy_empty.png",
		}
	},

	["radioscanner"] = {
		label = "Radio Scanner",
		weight = 1000,
		stack = true,
		close = true,
		description = "With this you can get some police alerts. Not 100% effective however",
		client = {
			image = "radioscanner.png",
		}
	},

	["flashlight_attachment"] = {
		label = "Flashlight",
		weight = 1000,
		stack = true,
		close = true,
		description = "A flashlight for a weapon",
		client = {
			image = "flashlight_attachment.png",
		}
	},

	["flat_muzzle_brake"] = {
		label = "Flat Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "flat_muzzle_brake.png",
		}
	},

	["coke_small_brick"] = {
		label = "Coke Package",
		weight = 350,
		stack = false,
		close = true,
		description = "Small package of cocaine, mostly used for deals and takes a lot of space",
		client = {
			image = "coke_small_brick.png",
		}
	},

	["woodcamo_attachment"] = {
		label = "Woodland Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A woodland camo for a weapon",
		client = {
			image = "woodcamo_attachment.png",
		}
	},

	["aluminumoxide"] = {
		label = "Aluminium Powder",
		weight = 100,
		stack = true,
		close = false,
		description = "Some powder to mix with",
		client = {
			image = "aluminumoxide.png",
		}
	},

	["screwdriverset"] = {
		label = "Toolkit",
		weight = 1000,
		stack = true,
		close = false,
		description = "Very useful to screw... screws...",
		client = {
			image = "screwdriverset.png",
		}
	},

	["smallscope_attachment"] = {
		label = "Small Scope",
		weight = 1000,
		stack = true,
		close = true,
		description = "A small scope for a weapon",
		client = {
			image = "smallscope_attachment.png",
		}
	},

	["veh_tint"] = {
		label = "Tints",
		weight = 1000,
		stack = true,
		close = true,
		description = "Install vehicle tint",
		client = {
			image = "veh_tint.png",
		}
	},

	["moneybag"] = {
		label = "Money Bag",
		weight = 0,
		stack = false,
		close = true,
		description = "A bag with cash",
		client = {
			image = "moneybag.png",
		}
	},

	["weed_nutrition"] = {
		label = "Plant Fertilizer",
		weight = 2000,
		stack = true,
		close = true,
		description = "Plant nutrition",
		client = {
			image = "weed_nutrition.png",
		}
	},

	["samsungphone"] = {
		label = "Samsung S10",
		weight = 1000,
		stack = true,
		close = true,
		description = "Very expensive phone",
		client = {
			image = "samsungphone.png",
		}
	},

	["iron"] = {
		label = "Iron",
		weight = 100,
		stack = true,
		close = false,
		description = "Handy piece of metal that you can probably use for something",
		client = {
			image = "iron.png",
		}
	},

	["trojan_usb"] = {
		label = "Trojan USB",
		weight = 0,
		stack = true,
		close = true,
		description = "Handy software to shut down some systems",
		client = {
			image = "usb_device.png",
		}
	},

	["grape"] = {
		label = "Grape",
		weight = 100,
		stack = true,
		close = false,
		description = "Mmmmh yummie, grapes",
		client = {
			image = "grape.png",
		}
	},

	["glass"] = {
		label = "Glass",
		weight = 100,
		stack = true,
		close = false,
		description = "It is very fragile, watch out",
		client = {
			image = "glass.png",
		}
	},

	["electronickit"] = {
		label = "Electronic Kit",
		weight = 100,
		stack = true,
		close = true,
		description = "If you've always wanted to build a robot you can maybe start here. Maybe you'll be the new Elon Musk?",
		client = {
			image = "electronickit.png",
		}
	},

	["driver_license"] = {
		label = "Drivers License",
		weight = 0,
		stack = false,
		close = false,
		description = "Permit to show you can drive a vehicle",
		client = {
			image = "driver_license.png",
		}
	},

	["painkillers"] = {
		label = "Painkillers",
		weight = 0,
		stack = true,
		close = true,
		description = "For pain you can't stand anymore, take this pill that'd make you feel great again",
		client = {
			image = "painkillers.png",
		}
	},

	["weed_amnesia_seed"] = {
		label = "Amnesia Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "A weed seed of Amnesia",
		client = {
			image = "weed_seed.png",
		}
	},

	["meth"] = {
		label = "Meth",
		weight = 100,
		stack = true,
		close = true,
		description = "A baggie of Meth",
		client = {
			image = "meth_baggy.png",
		}
	},

	["walkstick"] = {
		label = "Walking Stick",
		weight = 1000,
		stack = true,
		close = true,
		description = "Walking stick for ya'll grannies out there.. HAHA",
		client = {
			image = "walkstick.png",
		}
	},

	["wine"] = {
		label = "Wine",
		weight = 300,
		stack = true,
		close = false,
		description = "Some good wine to drink on a fine evening",
		client = {
			image = "wine.png",
		}
	},

	["sandwich"] = {
		label = "Sandwich",
		weight = 200,
		stack = true,
		close = true,
		description = "Nice bread for your stomach",
		client = {
			image = "sandwich.png",
		}
	},

	["filled_evidence_bag"] = {
		label = "Evidence Bag",
		weight = 200,
		stack = false,
		close = false,
		description = "A filled evidence bag to see who committed the crime >:(",
		client = {
			image = "evidence.png",
		}
	},

	["nvscope_attachment"] = {
		label = "Night Vision Scope",
		weight = 1000,
		stack = true,
		close = true,
		description = "A night vision scope for a weapon",
		client = {
			image = "nvscope_attachment.png",
		}
	},

	["security_card_02"] = {
		label = "Security Card B",
		weight = 0,
		stack = true,
		close = true,
		description = "A security card... I wonder what it goes to",
		client = {
			image = "security_card_02.png",
		}
	},

	["barrel_attachment"] = {
		label = "Barrel",
		weight = 1000,
		stack = true,
		close = true,
		description = "A barrel for a weapon",
		client = {
			image = "barrel_attachment.png",
		}
	},

	["joint"] = {
		label = "Joint",
		weight = 0,
		stack = true,
		close = true,
		description = "Sidney would be very proud at you",
		client = {
			image = "joint.png",
		}
	},

	["dendrogyra_coral"] = {
		label = "Dendrogyra",
		weight = 1000,
		stack = true,
		close = true,
		description = "Its also known as pillar coral",
		client = {
			image = "dendrogyra_coral.png",
		}
	},

	["plastic"] = {
		label = "Plastic",
		weight = 100,
		stack = true,
		close = false,
		description = "RECYCLE! - Greta Thunberg 2019",
		client = {
			image = "plastic.png",
		}
	},

	["veh_transmission"] = {
		label = "Transmission",
		weight = 1000,
		stack = true,
		close = true,
		description = "Upgrade vehicle transmission",
		client = {
			image = "veh_transmission.png",
		}
	},

	["fitbit"] = {
		label = "Fitbit",
		weight = 500,
		stack = false,
		close = true,
		description = "I like fitbit",
		client = {
			image = "fitbit.png",
		}
	},

	["rolling_paper"] = {
		label = "Rolling Paper",
		weight = 0,
		stack = true,
		close = true,
		description = "Paper made specifically for encasing and smoking tobacco or cannabis.",
		client = {
			image = "rolling_paper.png",
		}
	},

	["medscope_attachment"] = {
		label = "Medium Scope",
		weight = 1000,
		stack = true,
		close = true,
		description = "A medium scope for a weapon",
		client = {
			image = "medscope_attachment.png",
		}
	},

	["casinochips"] = {
		label = "Casino Chips",
		weight = 0,
		stack = true,
		close = false,
		description = "Chips For Casino Gambling",
		client = {
			image = "casinochips.png",
		}
	},

	["weed_ak47_seed"] = {
		label = "AK47 Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "A weed seed of AK47",
		client = {
			image = "weed_seed.png",
		}
	},

	["squared_muzzle_brake"] = {
		label = "Squared Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "squared_muzzle_brake.png",
		}
	},

	["firework1"] = {
		label = "2Brothers",
		weight = 1000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework1.png",
		}
	},

	["goldchain"] = {
		label = "Golden Chain",
		weight = 1000,
		stack = true,
		close = true,
		description = "A golden chain seems like the jackpot to me!",
		client = {
			image = "goldchain.png",
		}
	},


	["steel"] = {
		label = "Steel",
		weight = 100,
		stack = true,
		close = false,
		description = "Nice piece of metal that you can probably use for something",
		client = {
			image = "steel.png",
		}
	},

	["veh_brakes"] = {
		label = "Brakes",
		weight = 1000,
		stack = true,
		close = true,
		description = "Upgrade vehicle brakes",
		client = {
			image = "veh_brakes.png",
		}
	},

	["digicamo_attachment"] = {
		label = "Digital Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A digital camo for a weapon",
		client = {
			image = "digicamo_attachment.png",
		}
	},

	["handcuffs"] = {
		label = "Handcuffs",
		weight = 100,
		stack = true,
		close = true,
		description = "Comes in handy when people misbehave. Maybe it can be used for something else?",
		client = {
			image = "handcuffs.png",
		}
	},

	["weed_whitewidow_seed"] = {
		label = "White Widow Seed",
		weight = 0,
		stack = true,
		close = false,
		description = "A weed seed of White Widow",
		client = {
			image = "weed_seed.png",
		}
	},

	["lighter"] = {
		label = "Lighter",
		weight = 0,
		stack = true,
		close = true,
		description = "On new years eve a nice fire to stand next to",
		client = {
			image = "lighter.png",
		}
	},

	["comp_attachment"] = {
		label = "Compensator",
		weight = 1000,
		stack = true,
		close = true,
		description = "A compensator for a weapon",
		client = {
			image = "comp_attachment.png",
		}
	},

	["bellend_muzzle_brake"] = {
		label = "Bellend Muzzle Brake",
		weight = 1000,
		stack = true,
		close = true,
		description = "A muzzle brake for a weapon",
		client = {
			image = "bellend_muzzle_brake.png",
		}
	},

	["suppressor_attachment"] = {
		label = "Suppressor",
		weight = 1000,
		stack = true,
		close = true,
		description = "A suppressor for a weapon",
		client = {
			image = "suppressor_attachment.png",
		}
	},

	["jerry_can"] = {
		label = "Jerrycan 20L",
		weight = 20000,
		stack = true,
		close = true,
		description = "A can full of Fuel",
		client = {
			image = "jerry_can.png",
		}
	},

	["grapejuice"] = {
		label = "Grape Juice",
		weight = 200,
		stack = true,
		close = false,
		description = "Grape juice is said to be healthy",
		client = {
			image = "grapejuice.png",
		}
	},

	["antipatharia_coral"] = {
		label = "Antipatharia",
		weight = 1000,
		stack = true,
		close = true,
		description = "Its also known as black corals or thorn corals",
		client = {
			image = "antipatharia_coral.png",
		}
	},

	["sessantacamo_attachment"] = {
		label = "Sessanta Nove Camo",
		weight = 1000,
		stack = true,
		close = true,
		description = "A sessanta nove camo for a weapon",
		client = {
			image = "sessantacamo_attachment.png",
		}
	},

	["luxuryfinish_attachment"] = {
		label = "Luxury Finish",
		weight = 1000,
		stack = true,
		close = true,
		description = "A luxury finish for a weapon",
		client = {
			image = "luxuryfinish_attachment.png",
		}
	},

	["weed_ogkush_seed"] = {
		label = "OGKush Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "A weed seed of OG Kush",
		client = {
			image = "weed_seed.png",
		}
	},

	["weed_skunk"] = {
		label = "Skunk 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "A weed bag with 2g Skunk",
		client = {
			image = "weed_baggy.png",
		}
	},

	["tunerlaptop"] = {
		label = "Tunerchip",
		weight = 2000,
		stack = false,
		close = true,
		description = "With this tunerchip you can get your car on steroids... If you know what you're doing",
		client = {
			image = "tunerchip.png",
		}
	},

	["largescope_attachment"] = {
		label = "Large Scope",
		weight = 1000,
		stack = true,
		close = true,
		description = "A large scope for a weapon",
		client = {
			image = "largescope_attachment.png",
		}
	},

	["labkey"] = {
		label = "Key",
		weight = 500,
		stack = false,
		close = true,
		description = "Key for a lock...?",
		client = {
			image = "labkey.png",
		}
	},

	["diving_fill"] = {
		label = "Diving Tube",
		weight = 3000,
		stack = false,
		close = true,
		client = {
			image = "diving_tube.png",
		}
	},

	["veh_neons"] = {
		label = "Neons",
		weight = 1000,
		stack = true,
		close = true,
		description = "Upgrade vehicle neons",
		client = {
			image = "veh_neons.png",
		}
	},

	["newsbmic"] = {
		label = "Boom Microphone",
		weight = 100,
		stack = false,
		close = true,
		description = "A Useable BoomMic",
		client = {
			image = "newsbmic.png",
		}
	},

	["police_stormram"] = {
		label = "Stormram",
		weight = 18000,
		stack = true,
		close = true,
		description = "A nice tool to break into doors",
		client = {
			image = "police_stormram.png",
		}
	},

	['forceps'] = {
		label = 'forceps',
		description = "",
		weight = 30,
		stack = true
	},
	['gauze'] = {
		label = 'gauze',
		description = "",
		weight = 30,
		stack = true
	},
	['iodine'] = {
		label = 'iodine',
		description = "",
		weight = 30,
		stack = true
	},
	['bandageg'] = {
		label = 'Bandage',
		description = "Stops Bleeding",
		weight = 30,
		stack = true
	},
	['pill'] = {
		label = 'pill',
		description = "",
		weight = 30,
		stack = true
	},
	['surgical-gloves'] = {
		label = 'surgical gloves',
		description = "",
		weight = 30,
		stack = true
	},
	['surgical-staple'] = {
		label = 'surgical staple',
		description = "",
		weight = 30,
		stack = true
	},
	['surgical-tray'] = {
		label = 'surgical tray',
		description = "",
		weight = 30,
		stack = true
	},
	['syringe'] = {
		label = 'Syringe',
		description = "",
		weight = 30,
		stack = true
	},
	['tape'] = {
		label = 'Tape',
		description = "",
		weight = 30,
		stack = true
	},

	['medikit'] = { -- Make sure not already a medikit
			label = 'Medikit',
			weight = 165,
			stack = true,
			close = true,
		},
	['medbag'] = {
		label = 'Medical Bag',
		weight = 165,
		stack = false,
		close = true,
	},

	['tweezers'] = {
		label = 'Tweezers',
		weight = 2,
		stack = true,
		close = true,
	},

	['suturekit'] = {
		label = 'Suture Kit',
		weight = 15,
		stack = true,
		close = true,
	},

	['icepack'] = {
		label = 'Ice Pack',
		weight = 29,
		stack = true,
		close = true,
	},

	['burncream'] = {
		label = 'Burn Cream',
		weight = 19,
		stack = true,
		close = true,
	},

	['defib'] = {
		label = 'Defibrillator',
		weight = 225,
		stack = false,
		close = true,
	},

	['sedative'] = {
		label = 'Sedative',
		weight = 15,
		stack = true,
		close = true,
	},

	['morphine30'] = {
		label = 'Morphine 30MG',
		weight = 2,
		stack = true,
		close = true,
	},

	['morphine15'] = {
		label = 'Morphine 15MG',
		weight = 2,
		stack = true,
		close = true,
	},

	['perc30'] = {
		label = 'Percocet 30MG',
		weight = 2,
		stack = true,
		close = true,
	},

	['perc10'] = {
		label = 'Percocet 10MG',
		weight = 2,
		stack = true,
		close = true,
	},

	['perc5'] = {
		label = 'Percocet 5MG',
		weight = 2,
		stack = true,
		close = true,
	},

	['vic10'] = {
		label = 'Vicodin 10MG',
		weight = 2,
		stack = true,
		close = true,
	},

	['vic5'] = {
		label = 'Vicodin 5MG',
		weight = 2,
		stack = true,
		close = true,
	},

	['recoveredbullet'] = {
		label = 'Recovered Bullet',
		weight = 1,
		stack = true,
		close = false,
	},

	['motel_key'] = {
        label = "Motel Key",
        weight = 1,
        stack = false,
        close = true
    },

	['hack_laptop'] = {
		label = 'Hacking Laptop',
		description = "",
		weight = 20,
		stack = true
	},

	['loot_bag'] = {
		label = 'Duffle bag',
		description = "",
		weight = 50,
		stack = true
	},

	['printer'] = {
		label = 'Printer',
		description = "",
		weight = 190,
		stack = true
	},

	['npc_phone'] = {
		label = 'Phone',
		description = "",
		weight = 10,
		stack = true
	},

	['monitor'] = {
		label = 'Monitor',
		description = "",
		weight = 50,
		stack = true
	},

	['television'] = {
		label = 'TV',
		description = "",
		weight = 155,
		stack = true
	},

	['flat_television'] = {
		label = 'Flat TV',
		description = "",
		weight = 155,
		stack = true
	},

	['radio_alarm'] = {
		label = 'Radio',
		description = "",
		weight = 30,
		stack = true
	},

	['fan'] = {
		label = 'Fan',
		description = "",
		weight = 20,
		stack = true
	},

	['lockpick'] = {
		label = 'Lockpick',
		description = "Can lockpick any doors if you have enough skill!",
		weight = 165,
		stack = true
	},

	['shoebox'] = {
		label = 'Shoe box',
		description = "",
		weight = 45,
		stack = true
	},

	['dj_deck'] = {
		label = 'DJ Deck',
		description = "",
		weight = 95,
		stack = true
	},

	['console'] = {
		label = 'Console',
		description = "",
		weight = 55,
		stack = true
	},

	['boombox'] = {
		label = 'Boombox',
		description = "",
		weight = 85,
		stack = true
	},

	['bong'] = {
		label = 'Bong',
		description = "",
		weight = 25,
		stack = true
	},

	['coffemachine'] = {
		label = 'Coffe machine',
		description = "",
		weight = 55,
		stack = true
	},

	['tapeplayer'] = {
		label = 'Tape Player',
		description = "",
		weight = 55,
		stack = true
	},

	['hairdryer'] = {
		label = 'Hairdryer',
		description = "",
		weight = 55,
		stack = true
	},

	['j_phone'] = {
		label = 'Phone',
		description = "",
		weight = 55,
		stack = true
	},

	['sculpture'] = {
		label = 'Sculpture',
		description = "",
		weight = 55,
		stack = true
	},

	['toiletry'] = {
		label = 'Toiletry',
		description = "",
		weight = 10,
		stack = true
	},

	['pogo'] = {
		label = 'Art Piece',
		description = "Pogo Statue",
		weight = 155,
		stack = true
	},

	['powder'] = {
		label = 'Bag with powder',
		description = "Good for discovering lasers that are not visible",
		weight = 50,
		stack = true
	},

	['bracelet'] = {
		label = 'Bracelet',
		description = "",
		weight = 25,
		stack = true
	},

	['book'] = {
		label = 'Book',
		description = "",
		weight = 25,
		stack = true
	},

	['earings'] = {
		label = 'Earings',
		description = "",
		weight = 25,
		stack = true
	},

	['gold_bracelet'] = {
		label = 'Gold bracelet',
		description = "",
		weight = 45,
		stack = true
	},

	['gold_watch'] = {
		label = 'Gold watch',
		weight = 55,
		stack = true
	},

	['house_locator'] = {
		label = 'House locator',
		weight = 55,
		stack = true
	},

	--[[ ['necklace'] = {
		label = 'Necklace',
		weight = 55,
		stack = true
	}, ]]

	['notepad'] = {
		label = 'Notepad',
		weight = 5,
		stack = true
	},

	['pencil'] = {
		label = 'Pencil',
		weight = 25,
		stack = true
	},

	['romantic_book'] = {
		label = 'Romantic book',
		weight = 25,
		stack = true
	},

	['shampoo'] = {
		label = 'Shampoo',
		weight = 25,
		stack = true
	},

	['soap'] = {
		label = 'Soap',
		weight = 25,
		stack = true
	},

	['toothpaste'] = {
		label = 'Toothpaste',
		weight = 15,
		stack = true
	},

	['watch'] = {
		label = 'Watch',
		weight = 35,
		stack = true
	},
		
	['skull'] = {
		label = 'Skull Art with diamonds',
		weight = 95,
		stack = true
	},


	["cuffkeys"] = {
		label = "Cuff Keys",
		weight = 75,
		stack = true,
		close = true,
		description = "Set them free !",
		client = {
			image = "cuffkeys.png",
		}
	},

	["ziptie"] = {
		label = "ZipTie",
		weight = 50,
		stack = true,
		close = true,
		description = "Comes in handy when people misbehave. Maybe it can be used for something else?",
		client = {
			image = "ziptie.png",
		}
	},

	["leo_gps"] = {
		label = "LEO GPS",
		weight = 2000,
		stack = false,
		close = true,
		description = "Show your gps location to others",
		client = {
			image = "leo-gps.png",
		}
	},

	["cuff_cutter"] = {
		label = "Cuff Cutter",
		weight = 50,
		stack = true,
		close = true,
		description = "Wanna cut some metal items ?",
		client = {
			image = "cuff_cutter.png",
		}
	},

	["broken_handcuffs"] = {
		label = "Broken Handcuffs",
		weight = 100,
		stack = true,
		close = true,
		description = "It's broken, maybe you can repair it?",
		client = {
			image = "broken_handcuffs.png",
		}
	},

	["flush_cutter"] = {
		label = "Flush Cutter",
		weight = 50,
		stack = true,
		close = true,
		description = "Comes in handy when you want to cut zipties..",
		client = {
			image = "flush_cutter.png",
		}
	},

	--BurgerShot

	["slicedpotato"] = {
		label = "Sliced Potatoes",
		weight = 500,
		stack = true,
		close = true,
		description = "Sliced Potato",
		client = {
			image = "potatoes.png",
		}
	},

	["slicedonion"] = {
		label = "Sliced Onions",
		weight = 500,
		stack = true,
		close = true,
		description = "Sliced Onion",
		client = {
			image = "burger-slicedonion.png",
		}
	},

	["icecream"] = {
		label = "Ice Cream",
		weight = 500,
		stack = true,
		close = true,
		description = "Ice Cream",
		client = {
			image = "burger-icecream.png",
		}
	},

	["milk"] = {
		label = "Milk",
		weight = 500,
		stack = true,
		close = true,
		description = "Carton of Milk",
		client = {
			image = "burger-milk.png",
		}
	},

	["lettuce"] = {
		label = "Lettuce",
		weight = 500,
		stack = true,
		close = true,
		description = "Some big taco brother",
		client = {
			image = "lettuce.png",
		}
	},
	["sauce"] = {
		label = "sauce",
		weight = 500,
		stack = true,
		close = true,
		description = "Some",
		client = {
			image = "sauce.png",
		}
	},

	["frozennugget"] = {
		label = "Frozen Nuggets",
		weight = 500,
		stack = true,
		close = true,
		description = "Bag of Frozen Nuggets",
		client = {
			image = "burger-frozennugget.png",
		}
	},

	["cheddar"] = {
		label = "Cheddar Slice",
		weight = 500,
		stack = true,
		close = true,
		description = "Slice of Cheese",
		client = {
			image = "cheddar.png",
		}
	},

	["burgerbun"] = {
		label = "Burger Bun",
		weight = 100,
		stack = true,
		close = true,
		description = "Some big burger brother",
		client = {
			image = "burgerbun.png",
		}
	},

	["burgerpatty"] = {
		label = "Burger Patty",
		weight = 500,
		stack = true,
		close = true,
		description = "Raw Patty",
		client = {
			image = "burgerpatty.png",
		}
	},

	["burgermeat"] = {
		label = "Burger Meat",
		weight = 500,
		stack = true,
		close = true,
		description = "Cooked Burger Meat",
		client = {
			image = "burgermeat.png",
		}
	},
	-- End BurgerShot
	-- Start VL-catcafe
	

	["boba"] = {
		label = "Boba",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "boba.png",
		}
	},

	["flour"] = {
		label = "Flour",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "flour.png",
		}
	},

	["rice"] = {
		label = "Bowl of Rice",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "rice.png",
		}
	},

	["sugar"] = {
		label = "Sugar",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "sugar.png",
		}
	},

	["nori"] = {
		label = "Nori",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "nori.png",
		}
	},

	["blueberry"] = {
		label = "Blueberry",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "blueberry.png",
		}
	},

	["strawberry"] = {
		label = "Strawberry",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "strawberry.png",
		}
	},

	["orange"] = {
		label = "Orange",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "orange.png",
		}
	},

	["mint"] = {
		label = "Matcha",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "matcha.png",
		}
	},

	["tofu"] = {
		label = "Tofu",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "boba.png",
		}
	},

	["mocha"] = {
		label = "Mocha Meow",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "mochameow.png",
		}
	},

	["cakepop"] = {
		label = "Cat Cake-Pop",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cakepop.png",
		}
	},

	["pancake"] = {
		label = "PawCake",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pawcakes.png",
		}
	},

	["pizza"] = {
		label = "Kitty Pizza",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "catpizza.png",
		}
	},

	["purrito"] = {
		label = "Purrito",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "purrito.png",
		}
	},

	["noodlebowl"] = {
		label = "Bowl of Noodles",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "noodlebowl.png",
		}
	},

	["noodles"] = {
		label = "Instant Noodles",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "noodles.png",
		}
	},

	["ramen"] = {
		label = "Bowl of Ramen",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "ramen.png",
		}
	},

	["nightvision"] = {
		label = "Night Vision Goggles",
		weight = 6000,
		stack = true,
		close = false,
		description = "These allow you to see in the dark",
		client = {
			image = "nightvision.png",
		}
	},

	["recyclablematerial"] = {
		label = "Recycle Box",
		weight = 100,
		stack = true,
		close = false,
		description = "A box of Recyclable Materials",
		client = {
			image = "recyclablematerial.png",
		}
	},

	["usb_red"] = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		description = "A red USB flash drive",
		client = {
			image = "usb_red.png",
		}
	},

	["bottle"] = {
		label = "Empty Bottle",
		weight = 10,
		stack = true,
		close = false,
		description = "A glass bottle",
		client = {
			image = "bottle.png",
		}
	},

	["usb_gold"] = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		description = "A gold USB flash drive",
		client = {
			image = "usb_gold.png",
		}
	},

	["laptop_red"] = {
		label = "Laptop",
		weight = 2500,
		stack = false,
		close = true,
		description = "A laptop that you got from Plague",
		client = {
			image = "laptop_red.png",
		}
	},

	["usb_blue"] = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		description = "A blue USB flash drive",
		client = {
			image = "usb_blue.png",
		}
	},

	["laptop_gold"] = {
		label = "Laptop",
		weight = 2500,
		stack = false,
		close = true,
		description = "A laptop that you got from Trinity",
		client = {
			image = "laptop_gold.png",
		}
	},

	["usb_grey"] = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		description = "A grey USB flash drive",
		client = {
			image = "usb_grey.png",
		}
	},

	["laptop_blue"] = {
		label = "Laptop",
		weight = 2500,
		stack = false,
		close = true,
		description = "A laptop that you got from Ramsay",
		client = {
			image = "laptop_blue.png",
		}
	},

	["laptop_green"] = {
		label = "Laptop",
		weight = 2500,
		stack = false,
		close = true,
		description = "A laptop that you got from Ph03nix",
		client = {
			image = "laptop_green.png",
		}
	},

	["explosive"] = {
		label = "Explosive",
		weight = 5000,
		stack = true,
		close = true,
		description = "An improvised explosive of fireworks and thermite",
		client = {
			image = "explosive.png",
		}
	},

	["usb_green"] = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		description = "A green USB flash drive",
		client = {
			image = "usb_green.png",
		}
	},

	["can"] = {
		label = "Empty Can",
		weight = 10,
		stack = true,
		close = false,
		description = "An empty can, good for recycling",
		client = {
			image = "can.png",
		}
	},

	["casino_luckypotion"] = {
		label = "Casino Lucky Potion",
		weight = 0,
		stack = false,
		close = false,
		description = "Casino Lucky Potion",
		client = {
			image = "casino_luckypotion.png",
		}
	},

	["casino_burger"] = {
		label = "Casino Burger",
		weight = 0,
		stack = false,
		close = false,
		description = "Casino Burger",
		client = {
			image = "casino_burger.png",
		}
	},

	["casino_coffee"] = {
		label = "Casino Coffee",
		weight = 0,
		stack = false,
		close = false,
		description = "Casino Coffee",
		client = {
			image = "casino_coffee.png",
		}
	},

	["casino_donut"] = {
		label = "Casino Donut",
		weight = 0,
		stack = false,
		close = false,
		description = "Casino Donut",
		client = {
			image = "casino_donut.png",
		}
	},

	["casino_psqs"] = {
		label = "Casino Ps & Qs",
		weight = 0,
		stack = false,
		close = false,
		description = "Casino Ps & Qs",
		client = {
			image = "casino_psqs.png",
		}
	},

	["casino_beer"] = {
		label = "Casino Beer",
		weight = 0,
		stack = false,
		close = false,
		description = "Casino Beer",
		client = {
			image = "casino_beer.png",
		}
	},

	["casino_ego_chaser"] = {
		label = "Casino Ego Chaser",
		weight = 0,
		stack = false,
		close = false,
		description = "Casino Ego Chaser",
		client = {
			image = "casino_ego_chaser.png",
		}
	},

	["casino_sandwitch"] = {
		label = "Casino Sandwitch",
		weight = 0,
		stack = false,
		close = false,
		description = "Casino Sandwitch",
		client = {
			image = "casino_sandwitch.png",
		}
	},

	["casino_sprite"] = {
		label = "Casino Sprite",
		weight = 0,
		stack = false,
		close = false,
		description = "Casino Sprite",
		client = {
			image = "casino_sprite.png",
		}
	},

	["casino_chips"] = {
		label = "Casino Chips",
		weight = 0,
		stack = false,
		close = false,
		description = "Casino Chips",
		client = {
			image = "casino_chips.png",
		}
	},

	["casino_coke"] = {
		label = "Casino Kofola",
		weight = 0,
		stack = false,
		close = false,
		description = "Casino Kofola",
		client = {
			image = "casino_coke.png",
		}
	},


	["turfspray"] = {
		label = "Gang Spray",
		weight = 0,
		stack = false,
		close = true,
		description = "Gang Spray",
		client = {
			image = "spray.png",
		}
	},

	["spray_remover"] = {
		label = "Spray Remover",
		weight = 0,
		stack = false,
		close = true,
		description = "Gang Spray Remover",
		client = {
			image = "spray_remover.png",
		}
	},
	-- Phone
	
	["classic_phone"] = {
		label = "Classic Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Smartphone",
		client = {
			image = "classic_phone.png",
		}
	},

	["black_phone"] = {
		label = "Black Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Smartphone",
		client = {
			image = "black_phone.png",
		}
	},

	["blue_phone"] = {
		label = "Blue Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Smartphone",
		client = {
			image = "blue_phone.png",
		}
	},

	["gold_phone"] = {
		label = "Gold Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Smartphone",
		client = {
			image = "gold_phone.png",
		}
	},

	["red_phone"] = {
		label = "Red Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Smartphone",
		client = {
			image = "red_phone.png",
		}
	},

	["green_phone"] = {
		label = "Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Smartphone",
		client = {
			image = "green_phone.png",
		}
	},

	["greenlight_phone"] = {
		label = "Green Light Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Smartphone",
		client = {
			image = "greenlight_phone.png",
		}
	},

	["pink_phone"] = {
		label = "Pink Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Smartphone",
		client = {
			image = "pink_phone.png",
		}
	},

	["white_phone"] = {
		label = "White Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Smartphone",
		client = {
			image = "white_phone.png",
		}
	},

	["wet_phone"] = {
		label = "Wet Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Smartphone",
		client = {
			image = "wet_classic_phone.png",
		}
	},

	["wet_classic_phone"] = {
		label = "Wet Classic Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Smartphone",
		client = {
			image = "wet_classic_phone.png",
		}
	},

	["wet_black_phone"] = {
		label = "Wet Black Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Smartphone",
		client = {
			image = "wet_black_phone.png",
		}
	},

	["wet_blue_phone"] = {
		label = "Wet Blue Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Smartphone",
		client = {
			image = "wet_blue_phone.png",
		}
	},

	["wet_gold_phone"] = {
		label = "Wet Gold Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Smartphone",
		client = {
			image = "wet_gold_phone.png",
		}
	},

	["wet_red_phone"] = {
		label = "Wet Red Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Smartphone",
		client = {
			image = "wet_red_phone.png",
		}
	},

	["wet_green_phone"] = {
		label = "Wet Green Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Smartphone",
		client = {
			image = "wet_green_phone.png",
		}
	},

	["wet_greenlight_phone"] = {
		label = "Wet Green Light Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Smartphone",
		client = {
			image = "wet_greenlight_phone.png",
		}
	},

	["wet_pink_phone"] = {
		label = "Wet Pink Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Smartphone",
		client = {
			image = "wet_pink_phone.png",
		}
	},

	["wet_white_phone"] = {
		label = "Wet White Phone",
		weight = 700,
		stack = false,
		close = true,
		description = "Smartphone",
		client = {
			image = "wet_white_phone.png",
		}
	},

	["phone_hack"] = {
		label = "Phone Hack",
		weight = 700,
		stack = false,
		close = true,
		description = "Phone Hack",
		client = {
			image = "phone_hack.png",
		}
	},

	["phone_module"] = {
		label = "Phone Module",
		weight = 700,
		stack = false,
		close = true,
		description = "Phone Module",
		client = {
			image = "phone_module.png",
		}
	},

	["powerbank"] = {
		label = "Power Bank",
		weight = 700,
		stack = false,
		close = true,
		description = "Power Bank",
		client = {
			image = "powerbank.png",
		}
	},

	-- rtx_gym
	
	["protein"] = {
		label = "Protein",
		weight = 1000,
		stack = false,
		close = true,
		description = "Protein",
		client = {
			image = "protein.png",
		}
	},
	
	["creatine"] = {
		label = "Creatine",
		weight = 1000,
		stack = false,
		close = true,
		description = "Creatine",
		client = {
			image = "creatine.png",
		}
	},
	
	["preworkout"] = {
		label = "Preworkout",
		weight = 1000,
		stack = false,
		close = true,
		description = "Preworkout",
		client = {
			image = "preworkout.png",
		}
	},
	
	["testosterone"] = {
		label = "Testosterone",
		weight = 1000,
		stack = false,
		close = true,
		description = "Testosterone",
		client = {
			image = "testosterone.png",
		}
	},

	-- kq_smash_n_grab
	
	["kq_expensive_laptop"] = {
		label = "Expensive laptop",
		weight = 2000,
		stack = false,
		close = true,
		description = "Expensive laptop. Looks used",
		client = {
			image = "kq_expensive_laptop.png",
		}
	},
	
	["kq_expensive_watch"] = {
		label = "Expensive watch",
		weight = 250,
		stack = false,
		close = true,
		description = "Expensive wristwatch. Looks used",
		client = {
			image = "kq_expensive_watch.png",
		}
	},
	
	["kq_expensive_bag"] = {
		label = "Designer bag",
		weight = 2000,
		stack = false,
		close = true,
		description = "Designer bag. Looks used",
		client = {
			image = "kq_expensive_bag.png",
		}
	},
	
	["kq_expensive_sneakers"] = {
		label = "Designer sneakers",
		weight = 250,
		stack = false,
		close = true,
		description = "Designer shoes. Look used",
		client = {
			image = "kq_expensive_sneakers.png",
		}
	},

--rcore_radiocar
	['radiocar_dismounter'] = {
		label = 'radiocar_dismounter',
		weight = 250,
		close = true,
		consume = 0,
		client = {},
		server = {
			export = 'rcore_itemradio.radiocar_dismounter',
		},
	},
	['radiocar'] = {
		label = 'radiocar',
		weight = 250,
		close = true,
		consume = 0,
		client = {},
		server = {
			export = 'rcore_itemradio.radiocar',
		},
	},
	-- envi-sabotage
	['spanner'] = {
		label = 'Spanner',
		weight = 1000,
		stack = true,
		close = true,
		description = nil
	},
	['firelighter'] = {
		label = 'Firelighters',
		weight = 500,
		stack = false,
		close = true,
		description = nil
	},
	['adjustable_spanner'] = {
		label = 'Spanner',
		weight = 1000,
		stack = true,
		close = true,
		description = nil
	},

	['buzz_saw'] = {
		label = 'Buzz Saw',
		weight = 6000,
		stack = true,
		close = true,
		description = nil
	},
	['impact_driver'] = {
		label = 'Impact Driver',
		weight = 4000,
		stack = true,
		close = true,
		description = nil
	},
	['pliers'] = {
		label = 'Pliers',
		weight = 1000,
		stack = true,
		close = true,
		description = nil
	},
	['impact_bomb'] = {
		label = 'Impact Explosive',
		weight = 3000,
		stack = true,
		close = true,
		description = nil
	},
	['ignition_bomb'] = {
		label = 'Ignition Explosive',
		weight = 3000,
		stack = true,
		close = true,
		description = nil
	},
	['remote_bomb'] = {
		label = 'Remote Explosive',
		weight = 3000,
		stack = true,
		close = true,
		description = nil
	},
	['phone_bomb'] = {
		label = 'Detonator Device',
		weight = 1000,
		stack = false,
		close = true,
		description = nil
	},
	["trap_phone"] = {
		label = "V Phone",
		weight = 1000,
		stack = false,
		close = true,
		description = "Trap Phone",
		client = {
			image = "v_phone.png",
		}
	},

	["hotel_card"] = {
		label = "Room Access",
		weight = 5000,
		stack = false,
		close = true,
		description = "Hotel Room Access",
		client = {
			image = "hotel_card.png",
		}
	},

	['backpack'] = {
		label = 'Backpack',
		weight = 220,
		stack = false,
		consume = 0,
		client = {
			export = 'VL-backpack.openBackpack'
		}
	},

	['gps_tracker'] = {
		label = 'GPS Tracker',
		weight = 1000,
		stack = false,
	},

		
	["greenchip"] = {
		label = "USB CHIP",
		weight = 1000,
		stack = false,
		close = true,
		description = "A green USB flash drive",
		client = {
			image = "greenchip.png",
		}
	},
		
	["redchip"] = {
		label = "USB CHIP",
		weight = 1000,
		stack = false,
		close = true,
		description = "A red USB flash drive",
		client = {
			image = "redchip.png",
		}
	},	

	["bluechip"] = {
		label = "USB CHIP",
		weight = 1000,
		stack = false,
		close = true,
		description = "A blue USB flash drive",
		client = {
			image = "bluechip.png",
		}
	},

	["fishingtin"] = {
		label = "Fishing Tin",
		weight = 2500,
		stack = true,
		close = false,
		description = "Fishing Tin",
		client = {
			image = "fishingtin.png",
		}
	},

	["fishingrod3"] = {
		label = "Fishingrod Level 3",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cananivel3.png",
		}
	},

	["sole"] = {
		label = "Sole",
		weight = 25,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "linguado.png",
		}
	},

	["conch"] = {
		label = "Conch",
		weight = 500,
		stack = true,
		close = false,
		description = "A cute little seashell that can be sold to someone interested!",
		client = {
			image = "conch.png",
		}
	},

	["dolphin"] = {
		label = "Dolphin",
		weight = 15000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "golfinho.png",
		}
	},

	["fishnet2"] = {
		label = "Fishing net Nivel 2",
		weight = 20,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "rededepescanivel2.png",
		}
	},

	["catfish"] = {
		label = "Catfish",
		weight = 25,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "peixegato.png",
		}
	},

	["starfish"] = {
		label = "Starfish",
		weight = 500,
		stack = true,
		close = false,
		description = "A cute little seashell that can be sold to someone interested!",
		client = {
			image = "starfish.png",
		}
	},

	["seabass"] = {
		label = "Sea Bass",
		weight = 25,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "robalo.png",
		}
	},

	["shell"] = {
		label = "Shell",
		weight = 500,
		stack = true,
		close = false,
		description = "A cute little seashell that can be sold to someone interested!",
		client = {
			image = "shell.png",
		}
	},

	["fishnet4"] = {
		label = "Fishing net Nivel 4",
		weight = 20,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "rededepescanivel4.png",
		}
	},

	["hammershark"] = {
		label = "Hammer shark",
		weight = 5000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "tubaraomartelo.png",
		}
	},

	["fishingboot"] = {
		label = "Fishing Boot",
		weight = 2500,
		stack = true,
		close = false,
		description = "Fishing Boot",
		client = {
			image = "fishingboot.png",
		}
	},

	["fishnet3"] = {
		label = "Fishing net Nivel 3",
		weight = 20,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "rededepescanivel3.png",
		}
	},

	["tunafish"] = {
		label = "Tuna fish",
		weight = 25,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "atum.png",
		}
	},

	["fishingrod5"] = {
		label = "Fishingrod Level 5",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cananivel5.png",
		}
	},

	["fishingrod4"] = {
		label = "Fishingrod Level 4",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cananivel4.png",
		}
	},

	["mackerel"] = {
		label = "Mackerel",
		weight = 25,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "cavala.png",
		}
	},

	["beach_shovel"] = {
		label = "Beach Shovel",
		weight = 2000,
		stack = true,
		close = false,
		description = "A beach shovel. Can be used to dig things in the sand.",
		client = {
			image = "beach_shovel.png",
		}
	},

	["stingray"] = {
		label = "Stingray",
		weight = 25,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "raia.png",
		}
	},
	["squid"] = {
		label = "squid",
		weight = 25,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "squid.png",
		}
	},
	["flourbm"] = {
		label = "flourbm",
		weight = 25,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "flourbm.png",
		}
	},
	["tempura"] = {
		label = "tempura",
		weight = 25,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "tempura.png",
		}
	},
	["coal"] = {
		label = "coal",
		weight = 25,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "coal.png",
		}
	},
	["tuna"] = {
		label = "tuna",
		weight = 25,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "tuna.png",
		}
	},
	["sea_snail"] = {
		label = "Sea Snail",
		weight = 500,
		stack = true,
		close = false,
		description = "A cute little seashell that can be sold to someone interested!",
		client = {
			image = "sea_snail.png",
		}
	},

	["fishingrod1"] = {
		label = "Fishingrod Level 1",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cananivel1.png",
		}
	},

	["salmoncooked"] = {
		label = "Cooked Salmon",
		weight = 20,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "salmaocozido.png",
		}
	},

	["fishingkey"] = {
		label = "Corroded Key",
		weight = 100,
		stack = true,
		close = true,
		description = "A weathered key that looks usefull",
		client = {
			image = "fishingkey.png",
		}
	},

	["monkfish"] = {
		label = "Monkfish",
		weight = 25,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "tamboril.png",
		}
	},

	["sardine"] = {
		label = "Sardine",
		weight = 25,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sardinha.png",
		}
	},

	["fishinglootbig"] = {
		label = "Treasure Chest",
		weight = 2500,
		stack = true,
		close = true,
		description = "The lock seems to be intact, Might need a key",
		client = {
			image = "fishinglootbig.png",
		}
	},

	["sardinecooked"] = {
		label = "Cooked Sardines",
		weight = 20,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "sardinhacozida.png",
		}
	},

	["bonfire"] = {
		label = "Campfire",
		weight = 20,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fogueira.png",
		}
	},

	["mackerelcooked"] = {
		label = "Cooked Mackerel",
		weight = 20,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cavalacozida.png",
		}
	},

	["anchor"] = {
		label = "Boat Anchor",
		weight = 2500,
		stack = true,
		close = true,
		description = "Boat Anchor",
		client = {
			image = "anchor.png",
		}
	},

	["tigershark"] = {
		label = "Tiger shark",
		weight = 5000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "tubaraotigre.png",
		}
	},

	["salmon"] = {
		label = "Salmon",
		weight = 25,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "salmao.png",
		}
	},

	["shell_2"] = {
		label = "Shell",
		weight = 500,
		stack = true,
		close = false,
		description = "A cute little seashell that can be sold to someone interested!",
		client = {
			image = "shell_2.png",
		}
	},

	["cookedcod"] = {
		label = "Cooked Cod",
		weight = 20,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "bacalhaucozido.png",
		}
	},

	["fishingloot"] = {
		label = "Metal Box",
		weight = 500,
		stack = true,
		close = true,
		description = "Seems to be a corroded from the salt water, Should be easy to open",
		client = {
			image = "fishingloot.png",
		}
	},

	["cod"] = {
		label = "Cod",
		weight = 25,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "bacalhau.png",
		}
	},

	["whale"] = {
		label = "Whale",
		weight = 5000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "baleia.png",
		}
	},

	["fishbaitilegal"] = {
		label = "Fish Bait Ilegal",
		weight = 400,
		stack = true,
		close = true,
		description = "Fishing bait",
		client = {
			image = "fishbaitilegal.png",
		}
	},

	["fishingrod2"] = {
		label = "Fishingrod Level 2",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cananivel2.png",
		}
	},

	["fishbait"] = {
		label = "Fish Bait",
		weight = 400,
		stack = true,
		close = true,
		description = "Fishing bait",
		client = {
			image = "fishbait.png",
		}
	},

	["fishnet5"] = {
		label = "Fishing net Nivel 5",
		weight = 20,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "rededepescanivel5.png",
		}
	},

	["fishnet1"] = {
		label = "Fishing net Nivel 1",
		weight = 20,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "rededepescanivel1.png",
		}
	},
	
	-- UP ATOMS (UtshoBoy)
	["beef"] = {
		label = "Beef",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "beefh.png",
		}
	},
	["chicken"] = {
		label = "Chicken",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "chickenh.png",
		}
	},
	["veg"] = {
		label = "Veg",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "vegh.png",
		}
	},
	["butter"] = {
		label = "Butter",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "butterh.png",
		}
	},
	["lemon"] = {
		label = "Lemon",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "lemonh.png",
		}
	},
	["oil"] = {
		label = "Oil",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "oilh.png",
		}
	},
	["salt"] = {
		label = "salth",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "salth.png",
		}
	},
	["vinegar"] = {
		label = "vinegarh",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "vinegarh.png",
		}
	},
	["sprunk"] = {
		label = "sprunk",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "sprunk.png",
		}
	},
	["bread"] = {
		label = "burgerbun",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "burgerbun.png",
		}
	},
	-- Pearls (Utsho)
	["coconutcurrymussels"] = {
		label = "Coconut Curry Mussels",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "coconutcurrymussels.png",
		}
	},
	["crispycalamari"] = {
		label = "Orange Hawaii",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "crispycalamari.png",
		}
	},
	["grilledsalmonsupreme"] = {
		label = "Grilled Salmon Supreme",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "grilledsalmonsupreme.png",
		}
	},
	["lobstertempura"] = {
		label = "lobstertempura",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "lobstertempura.png",
		}
	},
	["oceandelightplatter"] = {
		label = "Ocean Delight Platter",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "oceandelightplatter.png",
		}
	},
	["redsnappergrill"] = {
		label = "Red Snapper grill",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "redsnappergrill.png",
		}
	},
	["shrimpparadise"] = {
		label = "Shrimp Paradise",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "shrimpparadise.png",
		}
	},
	["tunaloittafusion"] = {
		label = "Tuna loitta Fusion",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "tunaloittafusion.png",
		}
	},
	["coconutmilk"] = {
		label = "Coconut Milk",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "coconutmilk.png",
		}
	},
	["garlic"] = {
		label = "Garlic",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "garlic.png",
		}
	},
	["lobster"] = {
		label = "Lobster",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "lobster.png",
		}
	},
	["loitta"] = {
		label = "Loitta",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "loitta.png",
		}
	},
	["mussel"] = {
		label = "Mussel",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "mussel.png",
		}
	},
	["oceanmasala"] = {
		label = "Ocean masala",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "oceanmasala.png",
		}
	},
	["octopus"] = {
		label = "Octopus",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "octopus.png",
		}
	},
	["oliveoil"] = {
		label = "Olive oil",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "oliveoil.png",
		}
	},
	["redsnapper"] = {
		label = "Red Snapper",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "redsnapper.png",
		}
	},

	["shrimp"] = {
		label = "Shrimp",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "shrimp.png",
        }
    },

	["gruppesechstablet"] = {
		label = "Gruppe Sechs Tablet",
		weight = 500,
		stack = false,
		close = true,
		description = "A nice device that allows you to rob the gruppe sechs transports",
		client = {
			image = "gruppesechstablet.png",
		}
	},
	
	["opium"] = {
		label = "Opium Sap",
		weight = 100,
		stack = true,
		close = true,
		description = "Opium, do you know how to refine it?",
		client = {
			image = "opium.png",
		}
	},

	["weed_purple-haze_seed_f"] = {
		label = "Purple-Haze: Seed (F)",
		weight = 1,
		stack = true,
		close = true,
		description = "A feminized purple-haze seed.",
		client = {
			image = "weed_purple-haze_seed_f.png",
		}
	},

	["weed_skunk_crop"] = {
		label = "Skunk: Crop",
		weight = 400,
		stack = true,
		close = false,
		description = "A freshly harvested crop of the finest skunk flower!",
		client = {
			image = "weed_skunk_crop.png",
		}
	},

	["weed_zkittlez_seed_m"] = {
		label = "Zkittlez: Seed (M)",
		weight = 1,
		stack = true,
		close = true,
		description = "A male zkittlez seed!",
		client = {
			image = "weed_zkittlez_seed_m.png",
		}
	},

	["drug_shears"] = {
		label = "Trimming Shears",
		weight = 200,
		stack = true,
		close = false,
		description = "A set of high quality trimming shears.",
		client = {
			image = "drug_shears.png",
		}
	},

	["morphine"] = {
		label = "Morphine",
		weight = 10,
		stack = true,
		close = true,
		description = "Morphine. Good for pain but also a good time!",
		client = {
			image = "morphine.png",
		}
	},

	["morphinebase"] = {
		label = "Morphine Base",
		weight = 1000,
		stack = true,
		close = true,
		description = "Morphine base. You can turn this into morphine or heroin.",
		client = {
			image = "morphinebase.png",
		}
	},

	["benzocaine"] = {
		label = "Benzocaine",
		weight = 500,
		stack = true,
		close = true,
		description = "Benzo? You got a toothache mate?",
		client = {
			image = "benzocaine.png",
		}
	},

	["tracker_remover"] = {
		label = "Tracking Chip Remover",
		weight = 1000,
		stack = false,
		close = true,
		description = "A tracking chip remover!",
		client = {
			image = "tracker_remover.png",
		}
	},

	["weed_ak47_seed_m"] = {
		label = "AK47: Seed (M)",
		weight = 1,
		stack = true,
		close = true,
		description = "A male ak47 seed!",
		client = {
			image = "weed_ak47_seed_m.png",
		}
	},

	["drug_scales"] = {
		label = "Scale",
		weight = 1500,
		stack = true,
		close = false,
		description = "A set of premium scales for weighing out decimals..",
		client = {
			image = "drug_scales.png",
		}
	},

	["meth_1oz"] = {
		label = "Ounce of Meth",
		weight = 280,
		stack = true,
		close = true,
		description = "A ounce of the finest teeth rotting goodness!",
		client = {
			image = "meth_1oz.png",
		}
	},

	["weed_gelato_seed_m"] = {
		label = "Gelato: Seed (M)",
		weight = 1,
		stack = true,
		close = true,
		description = "A male gelato seed!",
		client = {
			image = "weed_gelato_seed_m.png",
		}
	},

	["coke_1oz"] = {
		label = "Ounce of Cocaine",
		weight = 280,
		stack = true,
		close = true,
		description = "A ounce of the finest nose candy!",
		client = {
			image = "coke_1oz.png",
		}
	},

	["weed_purple-haze_crop"] = {
		label = "Purple-Haze: Crop",
		weight = 400,
		stack = true,
		close = false,
		description = "A freshly harvested crop of the finest purple-haze flower!",
		client = {
			image = "weed_purple-haze_crop.png",
		}
	},

	["sterilewater"] = {
		label = "Sterile Water",
		weight = 50,
		stack = true,
		close = true,
		description = "A vial of sterile water for injecting meds.",
		client = {
			image = "sterilewater.png",
		}
	},

	["drug_grinder"] = {
		label = "Grinder",
		weight = 150,
		stack = true,
		close = false,
		description = "A grinder for grinding herbs.. or other things..",
		client = {
			image = "drug_grinder.png",
		}
	},

	["methylamine"] = {
		label = "Methylamine",
		weight = 1500,
		stack = true,
		close = true,
		description = "Methylamine? What is this breaking bad?",
		client = {
			image = "methylamine.png",
		}
	},

	["cement"] = {
		label = "Cement",
		weight = 1000,
		stack = true,
		close = true,
		description = "Just a regular bag of builders cement.",
		client = {
			image = "cement.png",
		}
	},

	["liquidheroin"] = {
		label = "Liquid Heroin",
		weight = 10,
		stack = true,
		close = true,
		description = "Heroin. Destroying lives since 1898!",
		client = {
			image = "liquidheroin.png",
		}
	},

	["sodiumbicarbonate"] = {
		label = "Baking Soda",
		weight = 1000,
		stack = true,
		close = true,
		description = "Baking soda ey? What you cooking?",
		client = {
			image = "sodiumbicarbonate.png",
		}
	},

	["cocaleaf"] = {
		label = "Cocaine Leaf",
		weight = 200,
		stack = true,
		close = false,
		description = "Makes that premium nose candy!",
		client = {
			image = "cocaineleaf.png",
		}
	},

	["crack_1oz"] = {
		label = "Ounce of Crack",
		weight = 500,
		stack = true,
		close = true,
		description = "For all the thirsty out there",
		client = {
			image = "crack_1oz.png",
		}
	},

	["weed_white-widow_joint"] = {
		label = "White-Widow: Joint",
		weight = 1,
		stack = true,
		close = false,
		description = "A 1g joint of the finest white-widow!",
		client = {
			image = "weed_white-widow_joint.png",
		}
	},

	["water_jerrycan"] = {
		label = "Water Jerrycan",
		weight = 3500,
		stack = true,
		close = false,
		description = "Water from a tanker.. it could be a dirty but who cares..",
		client = {
			image = "water_jerrycan.png",
		}
	},

	["weed_og-kush_seed_m"] = {
		label = "OG-Kush: Seed (M)",
		weight = 1,
		stack = true,
		close = true,
		description = "A male og-kush seed!",
		client = {
			image = "weed_og-kush_seed_m.png",
		}
	},

	["weed_purple-haze_joint"] = {
		label = "Purple-Haze: Joint",
		weight = 1,
		stack = true,
		close = false,
		description = "A 1g joint of the finest purple-haze!",
		client = {
			image = "weed_purple-haze_joint.png",
		}
	},

	["weed_amnesia_crop"] = {
		label = "Amnesia: Crop",
		weight = 400,
		stack = true,
		close = false,
		description = "A freshly harvested crop of the finest amnesia flower!",
		client = {
			image = "weed_amnesia_crop.png",
		}
	},

	["ketamine_1oz"] = {
		label = "Ounce of Ketamine",
		weight = 2800,
		stack = true,
		close = true,
		description = "A ounce of ketamine!",
		client = {
			image = "ketamine_1oz.png",
		}
	},

	["trowel"] = {
		label = "Trowel",
		weight = 1000,
		stack = true,
		close = true,
		description = "Small handheld garden shovel",
		client = {
			image = "trowel.png",
		}
	},

	["weed_skunk_joint"] = {
		label = "Skunk: Joint",
		weight = 1,
		stack = true,
		close = false,
		description = "A 1g joint of the finest skunk!",
		client = {
			image = "weed_skunk_joint.png",
		}
	},

	["weed_gelato_crop"] = {
		label = "Gelato: Crop",
		weight = 400,
		stack = true,
		close = false,
		description = "A freshly harvested crop of the finest gelato flower!",
		client = {
			image = "weed_gelato_crop.png",
		}
	},

	["weed_purple-haze"] = {
		label = "Purple-Haze: 2g",
		weight = 2,
		stack = true,
		close = false,
		description = "A 2g bag of the finest purple-haze flower!",
		client = {
			image = "weed_purple-haze.png",
		}
	},

	["drug_cuttingkit"] = {
		label = "Cutting Kit",
		weight = 1000,
		stack = true,
		close = true,
		description = "A mirror, a razor blade.. obviously this is a make up kit..",
		client = {
			image = "drug_cuttingkit.png",
		}
	},

	["illegalgasoline"] = {
		label = "Illegal Gasoline",
		weight = 2500,
		stack = true,
		close = true,
		description = "Stolen gasoline? What are you doing with this?",
		client = {
			image = "illegalgasoline.png",
		}
	},

	["weed_ak47_joint"] = {
		label = "AK47: Joint",
		weight = 1,
		stack = true,
		close = false,
		description = "A 1g joint of the finest ak47!",
		client = {
			image = "weed_ak47_joint.png",
		}
	},

	["weed_zkittlez_seed_f"] = {
		label = "Zkittlez: Seed (F)",
		weight = 1,
		stack = true,
		close = true,
		description = "A feminized zkittlez seed.",
		client = {
			image = "weed_zkittlez_seed_f.png",
		}
	},

	["burnerphone"] = {
		label = "Burner Phone",
		weight = 250,
		stack = true,
		close = true,
		description = "A burner phone, what do you need one of these for?",
		client = {
			image = "burnerphone.png",
		}
	},

	["weed_gelato"] = {
		label = "Gelato: 2g",
		weight = 2,
		stack = true,
		close = false,
		description = "A 2g bag of the finest gelato flower!",
		client = {
			image = "weed_gelato.png",
		}
	},

	["heroinbaggy"] = {
		label = "Bag of Heroin",
		weight = 1,
		stack = true,
		close = true,
		description = "Heroin. Destroying lives since 1898!",
		client = {
			image = "heroinbaggy.png",
		}
	},

	["weed_ak47_crop"] = {
		label = "AK47: Crop",
		weight = 400,
		stack = true,
		close = false,
		description = "A freshly harvested crop of the finest ak47 flower!",
		client = {
			image = "weed_ak47_crop.png",
		}
	},

	["lithium"] = {
		label = "Lithium",
		weight = 500,
		stack = true,
		close = true,
		description = "Lithium, for batteries or maybe or things?",
		client = {
			image = "lithium.png",
		}
	},

	["weed_purple-haze_seed_m"] = {
		label = "Purple-Haze: Seed (M)",
		weight = 1,
		stack = true,
		close = true,
		description = "A male purple-haze seed!",
		client = {
			image = "weed_purple-haze_seed_m.png",
		}
	},

	["weed_amnesia_seed_m"] = {
		label = "Amnesia: Seed (M)",
		weight = 1,
		stack = true,
		close = true,
		description = "A male amnesia seed!",
		client = {
			image = "weed_amnesia_seed_m.png",
		}
	},

	["weed_gelato_joint"] = {
		label = "Gelato: Joint",
		weight = 1,
		stack = true,
		close = false,
		description = "A 1g joint of the finest gelato!",
		client = {
			image = "weed_gelato_joint.png",
		}
	},

	["acetone"] = {
		label = "Acetone",
		weight = 1500,
		stack = true,
		close = false,
		description = "A highly volitile and flamable liquid..",
		client = {
			image = "acetone.png",
		}
	},

	["weed_zkittlez_joint"] = {
		label = "Zkittlez: Joint",
		weight = 1,
		stack = true,
		close = false,
		description = "A 1g joint of the finest zkittlez!",
		client = {
			image = "weed_zkittlez_joint.png",
		}
	},

	["weed_og-kush_crop"] = {
		label = "OG-Kush: Crop",
		weight = 400,
		stack = true,
		close = false,
		description = "A freshly harvested crop of the finest og-kush flower!",
		client = {
			image = "weed_og-kush_crop.png",
		}
	},

	["weed_zkittlez_crop"] = {
		label = "Zkittlez: Crop",
		weight = 400,
		stack = true,
		close = false,
		description = "A freshly harvested crop of the finest zkittlez flower!",
		client = {
			image = "weed_zkittlez_crop.png",
		}
	},

	["weed_gelato_seed_f"] = {
		label = "Gelato: Seed (F)",
		weight = 1,
		stack = true,
		close = true,
		description = "A feminized gelato seed.",
		client = {
			image = "weed_gelato_seed_f.png",
		}
	},

	["sodiumcarbonate"] = {
		label = "Sodium Carbonate",
		weight = 200,
		stack = true,
		close = true,
		description = "Sodium Carbonate is the disodium salt of carbonic acid with alkalinizing property.",
		client = {
			image = "sodiumcarbonate.png",
		}
	},

	["weed_og-kush_joint"] = {
		label = "OG-Kush: Joint",
		weight = 1,
		stack = true,
		close = false,
		description = "A 1g joint of the finest og-kush!",
		client = {
			image = "weed_og-kush_joint.png",
		}
	},

	["weed_skunk_seed_f"] = {
		label = "Skunk: Seed (F)",
		weight = 1,
		stack = true,
		close = true,
		description = "A feminized skunk seed.",
		client = {
			image = "weed_skunk_seed_f.png",
		}
	},

	["aceticacid"] = {
		label = "Acetic Acid",
		weight = 1000,
		stack = true,
		close = true,
		description = "Acetic Acid is a clear colourless liquid which has a pungent, vinegar-like odour.",
		client = {
			image = "aceticacid.png",
		}
	},

	["razorblade"] = {
		label = "Razor Blade",
		weight = 10,
		stack = true,
		close = true,
		description = "A sharp razorblade, be careful not to cut yourself!",
		client = {
			image = "razorblade.png",
		}
	},

	["weed_og-kush"] = {
		label = "OG-Kush: 2g",
		weight = 2,
		stack = true,
		close = false,
		description = "A 2g bag of the finest og-kush flower!",
		client = {
			image = "weed_og-kush.png",
		}
	},

	["weed_white-widow_seed_m"] = {
		label = "White-Widow: Seed (M)",
		weight = 1,
		stack = true,
		close = true,
		description = "A male white-widow seed!",
		client = {
			image = "weed_white-widow_seed_m.png",
		}
	},

	["ether"] = {
		label = "Petroleum Ether",
		weight = 1000,
		stack = true,
		close = true,
		description = "Petroleum ether is the petroleum fraction consisting of aliphatic hydrocarbons, commonly used as a laboratory solvent.",
		client = {
			image = "ether.png",
		}
	},

	["rollingpapers"] = {
		label = "Rolling Papers",
		weight = 50,
		stack = true,
		close = false,
		description = "Paper made specifically for encasing and smoking tobacco or cannabis.",
		client = {
			image = "rollingpapers.png",
		}
	},

	["weed_fertilizer"] = {
		label = "Big Bud Fertilizer",
		weight = 1000,
		stack = true,
		close = false,
		description = "Get that big bug energy!",
		client = {
			image = "weed_fertilizer.png",
		}
	},

	["morphinebaggy"] = {
		label = "Bag of Morphine",
		weight = 1,
		stack = true,
		close = true,
		description = "Morphine. Good for pain but also a good time!",
		client = {
			image = "morphinebaggy.png",
		}
	},

	["weed_zkittlez"] = {
		label = "Zkittlez: 2g",
		weight = 2,
		stack = true,
		close = false,
		description = "A 2g bag of the finest zkittlez flower!",
		client = {
			image = "weed_zkittlez.png",
		}
	},

	["hydrochloricacid"] = {
		label = "Hydrochloric Acid",
		weight = 1500,
		stack = true,
		close = false,
		description = "Disolves food pretty well..",
		client = {
			image = "hydrochloricacid.png",
		}
	},

	["weed_skunk_seed_m"] = {
		label = "Skunk: Seed (M)",
		weight = 1,
		stack = true,
		close = true,
		description = "A male skunk seed!",
		client = {
			image = "weed_skunk_seed_m.png",
		}
	},

	["weed_white-widow_crop"] = {
		label = "White-Widow: Crop",
		weight = 400,
		stack = true,
		close = false,
		description = "A freshly harvested crop of the finest white-widow flower!",
		client = {
			image = "weed_white-widow_crop.png",
		}
	},

	["liquidketamine"] = {
		label = "Liquid Ketamine",
		weight = 500,
		stack = true,
		close = true,
		description = "A vial of liquid ketamine!",
		client = {
			image = "liquidketamine.png",
		}
	},

	["slakedlime"] = {
		label = "Slaked Lime",
		weight = 1000,
		stack = true,
		close = true,
		description = "Supposed to be used in preparation of dry mixer for painting and white washing.. However..",
		client = {
			image = "slakedlime.png",
		}
	},

	["weed_white-widow_seed_f"] = {
		label = "White-Widow: Seed (F)",
		weight = 1,
		stack = true,
		close = true,
		description = "A feminized white-widow seed.",
		client = {
			image = "weed_white-widow_seed_f.png",
		}
	},

	["weed_og-kush_seed_f"] = {
		label = "OG-Kush: Seed (F)",
		weight = 1,
		stack = true,
		close = true,
		description = "A feminized og-kush seed.",
		client = {
			image = "weed_og-kush_seed_f.png",
		}
	},

	["weed_amnesia_seed_f"] = {
		label = "Amnesia: Seed (F)",
		weight = 1,
		stack = true,
		close = true,
		description = "A feminized amnesia seed.",
		client = {
			image = "weed_amnesia_seed_f.png",
		}
	},

	["ketamine"] = {
		label = "Bag of Ketamine",
		weight = 100,
		stack = true,
		close = true,
		description = "A bag of ketamine!",
		client = {
			image = "ketamine.png",
		}
	},

	["weed_ak47_seed_f"] = {
		label = "AK47: Seed (F)",
		weight = 1,
		stack = true,
		close = true,
		description = "A feminized ak47 seed.",
		client = {
			image = "weed_ak47_seed_f.png",
		}
	},

	["emptyvial"] = {
		label = "Empty Vial",
		weight = 50,
		stack = true,
		close = true,
		description = "A empty sterile vial for storing liquid meds.",
		client = {
			image = "emptyvial.png",
		}
	},

	["distilled_water"] = {
		label = "Distilled Water",
		weight = 1000,
		stack = true,
		close = false,
		description = "Distilled water for your plants or other uses..",
		client = {
			image = "distilled_water.png",
		}
	},

	["ammonia"] = {
		label = "Ammonia",
		weight = 1000,
		stack = true,
		close = true,
		description = "Ammonia is a colorless, highly irritating gas with a pungent, suffocating odor.",
		client = {
			image = "ammonia.png",
		}
	},

	["weed_amnesia_joint"] = {
		label = "Amnesia: Joint",
		weight = 1,
		stack = true,
		close = false,
		description = "A 1g joint of the finest amnesia!",
		client = {
			image = "weed_amnesia_joint.png",
		}
	},

	["heroin_1oz"] = {
		label = "Ounce of Heroin",
		weight = 280,
		stack = true,
		close = true,
		description = "A large amount of heroin.",
		client = {
			image = "heroin_1oz.png",
		}
	},

	["weed_white-widow"] = {
		label = "White-Widow: 2g",
		weight = 2,
		stack = true,
		close = false,
		description = "A 2g bag of the finest white-widow flower!",
		client = {
			image = "weed_white-widow.png",
		}
	},

	["plasticjerrycan"] = {
		label = "Plastic Jerrycan",
		weight = 500,
		stack = true,
		close = true,
		description = "A empty jerry can for storing liquids.",
		client = {
			image = "plasticjerrycan.png",
		}
	},

	["heroinbase"] = {
		label = "Heroin Base",
		weight = 1000,
		stack = true,
		close = true,
		description = "Heroin base. Refine this into heroin powder.",
		client = {
			image = "heroinbase.png",
		}
	},

	["payticket"] = {
		label = "Receipt",
		weight = 150,
		stack = true,
		close = false,
		description = "Cash these in at the bank!",
		client = {
			image = "ticket.png",
		}
	},

	["houselaptop"] = {
		label = "House Hacking Laptop",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "houselaptop.png",
		}
	},

	["mansionlaptop"] = {
		label = "Mansion Hacking Laptop",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "mansionlaptop.png",
		}
	},
    -- HouseRobbery
	['phone'] = {
		label = 'Phone',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['casio'] = {
		label = 'Casio',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['necklace'] = {
		label = 'Necklace',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['high_end_tv'] = {
		label = 'Expensive TV',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['low_end_tv'] = {
		label = 'Cheap TV',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['high_end_art'] = {
		label = 'Expensive Art',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['low_end_art'] = {
		label = 'Cheap Art',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['stolen_laptop'] = {
		label = 'Laptop',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['ipod'] = {
		label = 'iPod',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['coffee_machine'] = {
		label = 'Coffee Machine',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['toaster'] = {
		label = 'Toaster',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	['decrypter'] = {
		label = 'Decrypter',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	
	['black_usb'] = {
		label = 'Black USB',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},

	["sapphire"] = {
		label = "Sapphire",
		weight = 100,
		stack = true,
		close = false,
		description = "A Sapphire that shimmers",
		client = {
			image = "sapphire.png",
		}
	},

	["sapphire_ring_silver"] = {
		label = "Sapphire Ring Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_ring_silver.png",
		}
	},

	["ruby_necklace"] = {
		label = "Ruby Necklace",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_necklace.png",
		}
	},

	["pickaxe"] = {
		label = "Pickaxe",
		weight = 1000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "pickaxe.png",
		}
	},

	["silver_ring"] = {
		label = "Silver Ring",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "silver_ring.png",
		}
	},

	["goldearring"] = {
		label = "Golden Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "gold_earring.png",
		}
	},

	["ruby"] = {
		label = "Ruby",
		weight = 100,
		stack = true,
		close = false,
		description = "A Ruby that shimmers",
		client = {
			image = "ruby.png",
		}
	},

	["oilbarrel"] = {
		label = "Oil Barrel",
		weight = 20000,
		stack = false,
		close = true,
		description = "Full of oil, probably has some value",
		client = {
			image = "oilbarrel.png",
		}
	},

	["uncut_sapphire"] = {
		label = "Uncut Sapphire",
		weight = 100,
		stack = true,
		close = false,
		description = "A rough Sapphire",
		client = {
			image = "uncut_sapphire.png",
		}
	},

	["sapphire_necklace"] = {
		label = "Sapphire Necklace",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_necklace.png",
		}
	},

	["bands"] = {
		label = "Band Of Notes",
		weight = 100,
		stack = true,
		close = false,
		description = "A band of small notes..",
		client = {
			image = "bands.png",
		}
	},

	["emerald_earring_silver"] = {
		label = "Emerald Earrings Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_earring_silver.png",
		}
	},

	["ruby_necklace_silver"] = {
		label = "Ruby Necklace Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_necklace_silver.png",
		}
	},

	["miningdrill"] = {
		label = "Mining Drill",
		weight = 1000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "miningdrill.png",
		}
	},

	["laptop_pink"] = {
		label = "Pink Laptop",
		weight = 5000,
		stack = false,
		close = true,
		description = "A security Laptop",
		client = {
			image = "laptop_pink.png",
		}
	},

	["rolls"] = {
		label = "Roll Of Small Notes",
		weight = 100,
		stack = true,
		close = false,
		description = "A roll of small notes..",
		client = {
			image = "rolls.png",
		}
	},

	["sapphire_necklace_silver"] = {
		label = "Sapphire Necklace Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_necklace_silver.png",
		}
	},

	["sapphire_earring"] = {
		label = "Sapphire Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_earring.png",
		}
	},

	["silverchain"] = {
		label = "Silver Chain",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "silverchain.png",
		}
	},

	["uncut_emerald"] = {
		label = "Uncut Emerald",
		weight = 100,
		stack = true,
		close = false,
		description = "A rough Emerald",
		client = {
			image = "uncut_emerald.png",
		}
	},

	["goldpan"] = {
		label = "Gold Panning Tray",
		weight = 10,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "goldpan.png",
		}
	},

	["uncut_ruby"] = {
		label = "Uncut Ruby",
		weight = 100,
		stack = true,
		close = false,
		description = "A rough Ruby",
		client = {
			image = "uncut_ruby.png",
		}
	},

	["ruby_earring_silver"] = {
		label = "Ruby Earrings Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_earring_silver.png",
		}
	},

	["ruby_ring"] = {
		label = "Ruby Ring",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_ring.png",
		}
	},

	["package"] = {
		label = "Suspicious Package",
		weight = 10000,
		stack = false,
		close = false,
		description = "A mysterious package.. Scary!",
		client = {
			image = "package.png",
		}
	},

	["sapphire_earring_silver"] = {
		label = "Sapphire Earrings Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_earring_silver.png",
		}
	},

	["emerald"] = {
		label = "Emerald",
		weight = 100,
		stack = true,
		close = false,
		description = "A Emerald that shimmers",
		client = {
			image = "emerald.png",
		}
	},

	["emerald_earring"] = {
		label = "Emerald Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_earring.png",
		}
	},

	["silverearring"] = {
		label = "Silver Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "silver_earring.png",
		}
	},

	["carbon"] = {
		label = "Carbon",
		weight = 1000,
		stack = true,
		close = false,
		description = "Carbon, a base ore.",
		client = {
			image = "carbon.png",
		}
	},

	["goldore"] = {
		label = "Gold Ore",
		weight = 1000,
		stack = true,
		close = false,
		description = "Gold Ore",
		client = {
			image = "goldore.png",
		}
	},

	["sapphire_ring"] = {
		label = "Sapphire Ring",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_ring.png",
		}
	},

	["stone"] = {
		label = "Stone",
		weight = 2000,
		stack = true,
		close = false,
		description = "Stone woo",
		client = {
			image = "stone.png",
		}
	},

	["ruby_earring"] = {
		label = "Ruby Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_earring.png",
		}
	},

	["security_card_oil"] = {
		label = "Pink USB Dongle",
		weight = 500,
		stack = false,
		close = true,
		description = "This has got to be some important information...",
		client = {
			image = "security_card_oil.png",
		}
	},

	["ruby_ring_silver"] = {
		label = "Ruby Ring Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_ring_silver.png",
		}
	},

	["diamond_ring_silver"] = {
		label = "Diamond Ring Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "diamond_ring_silver.png",
		}
	},

	["diamond_necklace_silver"] = {
		label = "Diamond Necklace Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "diamond_necklace_silver.png",
		}
	},

	["emerald_necklace_silver"] = {
		label = "Emerald Necklace Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_necklace_silver.png",
		}
	},

	["emerald_ring"] = {
		label = "Emerald Ring",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_ring.png",
		}
	},

	["silverore"] = {
		label = "Silver Ore",
		weight = 1000,
		stack = true,
		close = false,
		description = "Silver Ore",
		client = {
			image = "silverore.png",
		}
	},

	["diamond_earring_silver"] = {
		label = "Diamond Earrings Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "diamond_earring_silver.png",
		}
	},

	["token"] = {
		label = "Mysterious Token",
		weight = 500,
		stack = false,
		close = true,
		description = "A Mysterious Token",
		client = {
			image = "token.png",
		}
	},

	["silveringot"] = {
		label = "Silver Ingot",
		weight = 1000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "silveringot.png",
		}
	},

	["copperore"] = {
		label = "Copper Ore",
		weight = 1000,
		stack = true,
		close = false,
		description = "Copper, a base ore.",
		client = {
			image = "copperore.png",
		}
	},

	["emerald_ring_silver"] = {
		label = "Emerald Ring Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_ring_silver.png",
		}
	},

	["ironore"] = {
		label = "Iron Ore",
		weight = 1000,
		stack = true,
		close = false,
		description = "Iron, a base ore.",
		client = {
			image = "ironore.png",
		}
	},

	["drillbit"] = {
		label = "Drill Bit",
		weight = 10,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "drillbit.png",
		}
	},

	["mininglaser"] = {
		label = "Mining Laser",
		weight = 900,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "mininglaser.png",
		}
	},

	["emerald_necklace"] = {
		label = "Emerald Necklace",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_necklace.png",
		}
	},

	["goldingot"] = {
		label = "Gold Ingot",
		weight = 1000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "goldingot.png",
		}
	},

	["diamond_necklace"] = {
		label = "Diamond Necklace",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "diamond_necklace.png",
		}
	},

	["gold_ring"] = {
		label = "Gold Ring",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "gold_ring.png",
		}
	},

	["revivekit"] = {
		label = "Revival Kit",
		weight = 3000,
		stack = false,
		close = false,
		description = "When your pal needs that pick me up",
		client = {
			image = "revivekit.png",
		}
	},

	["shotfries"] = {
		label = "Shot Fries",
		weight = 200,
		stack = true,
		close = true,
		description = "Shot Fries",
		client = {
			image = "burger-fries.png",
		}
	},

	["blueocean"] = {
		label = "Blue Ocean",
		weight = 500,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "blueoceanh.png",
		}
	},

	["cake"] = {
		label = "Strawberry Cake",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cake.png",
		}
	},

	["bleeder"] = {
		label = "The Bleeder",
		weight = 200,
		stack = true,
		close = true,
		description = "The Bleeder",
		client = {
			image = "burger-bleeder.png",
		}
	},

	["heartstopper"] = {
		label = "HeartStopper",
		weight = 500,
		stack = true,
		close = true,
		description = "Heartstopper",
		client = {
			image = "burger-heartstopper.png",
		}
	},

	["cheesewrap"] = {
		label = "BS Cheese Wrap",
		weight = 200,
		stack = true,
		close = true,
		description = "BurgerShot Cheese Wrap",
		client = {
			image = "burger-chickenwrap.png",
		}
	},

	["miso"] = {
		label = "Miso Soup",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "miso.png",
		}
	},

	["uncut_diamond"] = {
		label = "Uncut Diamond",
		weight = 100,
		stack = true,
		close = false,
		description = "A rough Diamond",
		client = {
			image = "uncut_diamond.png",
		}
	},

	["friedrice"] = {
		label = "Fried Rice",
		weight = 500,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "friedriceh.png",
		}
	},

	["newspaper"] = {
		label = "Newspaper",
		weight = 10,
		stack = true,
		close = true,
		description = "Los Santos Newspaper",
		client = {
			image = "newspaper.png",
		}
	},

	["sake"] = {
		label = "Cat Coffee",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "sake.png",
		}
	},

	["vegshawarma"] = {
		label = "Veg Shawarma",
		weight = 500,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "vegshawarmah.png",
		}
	},

	["riceball"] = {
		label = "Neko Onigiri",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "catrice.png",
		}
	},

	["gbobatea"] = {
		label = "Green Boba Tea",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "bubbleteagreen.png",
		}
	},

	["bbobatea"] = {
		label = "Blue Boba Tea",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "bubbleteablue.png",
		}
	},

	["saltedveg"] = {
		label = "Salted Veg",
		weight = 500,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "saltedvegh.png",
		}
	},

	["murderbag"] = {
		label = "Murder Bag",
		weight = 200,
		stack = false,
		close = true,
		description = "Grab a Murder Bag of Burgers",
		client = {
			image = "burgerbag.png",
		}
	},

	["milkshake"] = {
		label = "Milkshake",
		weight = 500,
		stack = true,
		close = true,
		description = "BurgerShot Milkshake",
		client = {
			image = "burger-milkshake.png",
		}
	},

	["creampie"] = {
		label = "Creampie",
		weight = 200,
		stack = true,
		close = true,
		description = "BurgerShot Apple Pie",
		client = {
			image = "burger-creampie.png",
		}
	},

	["soyasauce"] = {
		label = "Soya Sauce",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "soyasauce.png",
		}
	},

	["omochi"] = {
		label = "Orange Mochi",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "mochiorange.png",
		}
	},

	["bento"] = {
		label = "Bento Box",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "bento.png",
		}
	},

	["diamond_earring"] = {
		label = "Diamond Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "diamond_earring.png",
		}
	},

	["shotnuggets"] = {
		label = "Shot Nuggets",
		weight = 200,
		stack = true,
		close = true,
		description = "Burgershot Nuggets",
		client = {
			image = "burger-shotnuggets.png",
		}
	},

	["mohito"] = {
		label = "Mohito",
		weight = 500,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "mohitoh.png",
		}
	},

	["arabianshawarma"] = {
		label = "Arabian Shawarma",
		weight = 500,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "arabianshawarmah.png",
		}
	},

	["alpilaf"] = {
		label = "Al Pilaf",
		weight = 500,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "alpilafh.png",
		}
	},

	["alkebsa"] = {
		label = "Al Kebsa",
		weight = 500,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "alkebsah.png",
		}
	},

	["potato"] = {
		label = "Potatoes",
		weight = 500,
		stack = true,
		close = false,
		description = "Bag of Potatos",
		client = {
			image = "potatoes.png",
		}
	},

	["bobatea"] = {
		label = "Boba Tea",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "bubbletea.png",
		}
	},

	["onion"] = {
		label = "Onion",
		weight = 500,
		stack = true,
		close = false,
		description = "An onion",
		client = {
			image = "burger-onion.png",
		}
	},

	["shawarmaehabibi"] = {
		label = "Shawarma-e Habibi",
		weight = 500,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "shawarmaehabibih.png",
		}
	},

	["orangehawaii"] = {
		label = "Orange Hawaii",
		weight = 500,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "orangehawaiih.png",
		}
	},

	["nekodonut"] = {
		label = "Neko Donut",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "catdonut.png",
		}
	},

	["pbobatea"] = {
		label = "Pink Boba Tea",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "bubbleteapink.png",
		}
	},

	["obobatea"] = {
		label = "Orange Boba Tea",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "bubbleteaorange.png",
		}
	},

	["bbqchicken"] = {
		label = "BBQ Chicken",
		weight = 500,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "bbqchickenh.png",
		}
	},

	["torpedo"] = {
		label = "Torpedo",
		weight = 200,
		stack = true,
		close = true,
		description = "BurgerShot Torpedo",
		client = {
			image = "burger-torpedo.png",
		}
	},

	["moneyshot"] = {
		label = "Money Shot",
		weight = 200,
		stack = true,
		close = true,
		description = "Money Shot",
		client = {
			image = "burger-moneyshot.png",
		}
	},

	["gmochi"] = {
		label = "Green Mochi",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "mochigreen.png",
		}
	},

	["bscoke"] = {
		label = "BurgerShot Coke",
		weight = 200,
		stack = true,
		close = true,
		description = "BurgerShot Cola",
		client = {
			image = "burger-softdrink.png",
		}
	},

	["bmochi"] = {
		label = "Blue Mochi",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "mochiblue.png",
		}
	},

	["catcoffee"] = {
		label = "Cat Coffee",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "catcoffee.png",
		}
	},

	["bscoffee"] = {
		label = "BurgerShot Coffee",
		weight = 200,
		stack = true,
		close = true,
		description = "BurgerShot Coffee",
		client = {
			image = "burger-coffee.png",
		}
	},

	["chickenwrap"] = {
		label = "BS Goat Cheese Wrap",
		weight = 200,
		stack = true,
		close = true,
		description = "BurgerShot Goat Cheese Wrap",
		client = {
			image = "burger-goatwrap.png",
		}
	},

	["pmochi"] = {
		label = "Pink Mochi",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "mochipink.png",
		}
	},

	["friedbeef"] = {
		label = "Fried Beef",
		weight = 500,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "friedbeefh.png",
		}
	},

	["rimjob"] = {
		label = "Rim Job",
		weight = 200,
		stack = true,
		close = true,
		description = "BurgerShot Donut",
		client = {
			image = "burger-rimjob.png",
		}
	},

	["meatfree"] = {
		label = "Meat Free",
		weight = 200,
		stack = true,
		close = true,
		description = "Meat Free",
		client = {
			image = "burger-meatfree.png",
		}
	},

	["shotrings"] = {
		label = "Ring Shots",
		weight = 200,
		stack = true,
		close = true,
		description = "Burgershot Onion Rings",
		client = {
			image = "burger-shotrings.png",
		}
	},

	["nekolatte"] = {
		label = "Neko Latte",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "latte.png",
		}
	},

	["nekocookie"] = {
		label = "Neko Cookie",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "catcookie.png",
		}
	},
	["bolt_cutter"] = {
		label = "Bolt Cutter",
		weight = 50,
		stack = true,
		close = true,
		description = "Wanna cut some metal items ?",
		client = {
			image = "bolt_cutter.png",
		}
	},

	-- Custom Attachhment

	-- Pistol

	["PISTOL_EXTCLIP"] = {
		label = "Pistol Ext Clip",
		weight = 1000,
		stack = false,
		close = true,
		description = "For Extra Ammo For Pistol",
		client = {
			image = "pistol_extclip.png",
		}
	},
	["PISTOL_SUPPRESSOR"] = {
		label = "Pistol Suppressor",
		weight = 1000,
		stack = false,
		close = true,
		description = "Silent Your Pistol",
		client = {
			image = "pistol_suppressor.png",
		}
	},

	-- SMG

	["SMG_EXTCLIP"] = {
		label = "SMG Ext Clip",
		weight = 1000,
		stack = false,
		close = true,
		description = "For Extra Ammo For SMG",
		client = {
			image = "smg_extclip.png",
		}
	},
	["SMG_SUPPRESSOR"] = {
		label = "SMG Suppressor",
		weight = 1000,
		stack = false,
		close = true,
		description = "Silent Your SMG",
		client = {
			image = "smg_suppressor.png",
		}
	},
	["SMG_SCOPE"] = {
		label = "SMG Scope",
		weight = 1000,
		stack = false,
		close = true,
		description = "Want to zoom more?",
		client = {
			image = "smg_scope.png",
		}
	},

	-- AR

	["RIFLE_EXTCLIP"] = {
		label = "Rifle Ext Clip",
		weight = 1000,
		stack = false,
		close = true,
		description = "More Ammo for Rifle",
		client = {
			image = "rifle_extclip.png",
		}
	},
	["RIFLE_SUPPRESSOR"] = {
		label = "Rifle Suppressor",
		weight = 1000,
		stack = false,
		close = true,
		description = "Silent Your Rifle",
		client = {
			image = "rifle_suppressor.png",
		}
	},
	["RIFLE_SCOPE"] = {
		label = "Rifle Scope",
		weight = 1000,
		stack = false,
		close = true,
		description = "Want to zoom more?",
		client = {
			image = "rifle_scope.png",
		}
	},
	["RIFLE_GRIP"] = {
		label = "Rifle Grip",
		weight = 1000,
		stack = false,
		close = true,
		description = "More Stability",
		client = {
			image = "rifle_grip.png",
		}
	},
	["RIFLE_FLASH"] = {
		label = "Rifle Flash",
		weight = 1000,
		stack = false,
		close = true,
		description = "You can`t see anything? Use this",
		client = {
			image = "rifle_flash.png",
		}
	},

	["meatdeer"] = {
		label = "Deer Horns",
		weight = 100,
		stack = true,
		close = false,
		description = "Deer Horns",
		client = {
			image = "deerhorns.png",
		}
	},

	["meatrabbit"] = {
		label = "Rabbit Fur",
		weight = 100,
		stack = true,
		close = false,
		description = "Rabbit Fur",
		client = {
			image = "rabbitfur.png",
		}
	},

	["huntingbait"] = {
		label = "Hunting Bait",
		weight = 150,
		stack = true,
		close = true,
		description = "Hunting Bait",
		client = {
			image = "huntingbait.png",
		}
	},

	["meatbird"] = {
		label = "Bird Feather",
		weight = 100,
		stack = true,
		close = false,
		description = "Bird Feather",
		client = {
			image = "birdfeather.png",
		}
	},

	["meatcoyote"] = {
		label = "Coyote Pelt",
		weight = 100,
		stack = true,
		close = false,
		description = "Coyote Pelt",
		client = {
			image = "coyotepelt.png",
		}
	},

	["meatlion"] = {
		label = "Cougar Claws",
		weight = 100,
		stack = true,
		close = false,
		description = "Cougar Claw",
		client = {
			image = "cougarclaw.png",
		}
	},

	["huntknife"] = {
		label = "Hunting Knife",
		weight = 500,
		stack = false,
		close = false,
		description = "Used to skin animals!",
		client = {
			image = "huntingknife.png",
		}
	},

	["meatboar"] = {
		label = "Boar Tusks",
		weight = 100,
		stack = true,
		close = false,
		description = "Boar Tusks",
		client = {
			image = "boartusks.png",
		}
	},

	["meatcow"] = {
		label = "Cow Pelt",
		weight = 100,
		stack = true,
		close = false,
		description = "Cow Pelt",
		client = {
			image = "cowpelt.png",
		}
	},

	["meatpig"] = {
		label = "Pig Meat",
		weight = 100,
		stack = true,
		close = false,
		description = "Pig Meat",
		client = {
			image = "pigpelt.png",
		}
	},

	["meat_cormorant"] = {
		label = "Cormorant Meat",
		weight = 400,
		stack = true,
		close = true,
		description = "Cormorant meat!",
		client = {
			image = "meat_cormorant.png",
		}
	},

	["meat_rabbit"] = {
		label = "Rabbit Meat",
		weight = 700,
		stack = true,
		close = true,
		description = "Rabbit meat!",
		client = {
			image = "meat_rabbit.png",
		}
	},

	["skin_whale"] = {
		label = "Whale Skin",
		weight = 7500,
		stack = true,
		close = true,
		description = "Whale skin. Highly illegal",
		client = {
			image = "skin_whale.png",
		}
	},

	["skin_cow"] = {
		label = "Cow Hide",
		weight = 1250,
		stack = true,
		close = true,
		description = "Cow hide.",
		client = {
			image = "skin_cow.png",
		}
	},

	["meat_stingray"] = {
		label = "Stingray Meat",
		weight = 700,
		stack = true,
		close = true,
		description = "Stingray meat!",
		client = {
			image = "meat_stingray.png",
		}
	},

	["skin_rat"] = {
		label = "Rat Hide",
		weight = 150,
		stack = true,
		close = true,
		description = "Rat hide.",
		client = {
			image = "skin_rat.png",
		}
	},

	["meat_rat"] = {
		label = "Rat Meat",
		weight = 200,
		stack = true,
		close = true,
		description = "Rat meat!",
		client = {
			image = "meat_rat.png",
		}
	},

	["meat_dolphin"] = {
		label = "Dolphin Meat",
		weight = 850,
		stack = true,
		close = true,
		description = "Dolphin meat!",
		client = {
			image = "meat_dolphin.png",
		}
	},

	["huntinglicense"] = {
		label = "Hunting License",
		weight = 1,
		stack = false,
		close = false,
		description = "Permit to show officals that you can legally hunt.",
		client = {
			image = "huntinglicense.png",
		}
	},

	["skin_mtlion"] = {
		label = "Mt Lion Hide",
		weight = 1050,
		stack = true,
		close = true,
		description = "Mt. Lion hide. Highly illegal!",
		client = {
			image = "skin_mtlion.png",
		}
	},

	["meat_deer"] = {
		label = "Venison",
		weight = 850,
		stack = true,
		close = true,
		description = "Deer meat!",
		client = {
			image = "meat_deer.png",
		}
	},

	["meat_whale"] = {
		label = "Whale Meat",
		weight = 6000,
		stack = true,
		close = true,
		description = "Whale meat!",
		client = {
			image = "meat_whale.png",
		}
	},

	["meat_cow"] = {
		label = "Beef Meat",
		weight = 1000,
		stack = true,
		close = true,
		description = "Cow meat!",
		client = {
			image = "meat_cow.png",
		}
	},

	["meat_coyote"] = {
		label = "Coyote Meat",
		weight = 700,
		stack = true,
		close = true,
		description = "Coyote meat!",
		client = {
			image = "meat_coyote.png",
		}
	},

	["skin_deer"] = {
		label = "Deer Hide",
		weight = 950,
		stack = true,
		close = true,
		description = "Deer hide.",
		client = {
			image = "skin_deer.png",
		}
	},

	["meat_mtlion"] = {
		label = "Mt Lion Meat",
		weight = 1000,
		stack = true,
		close = true,
		description = "Mt Lion meat!",
		client = {
			image = "meat_mtlion.png",
		}
	},

	["skin_boar"] = {
		label = "Boar Hide",
		weight = 1250,
		stack = true,
		close = true,
		description = "Boar hide.",
		client = {
			image = "skin_boar.png",
		}
	},

	["skin_coyote"] = {
		label = "Coyote Hide",
		weight = 750,
		stack = true,
		close = true,
		description = "Coyote hide.",
		client = {
			image = "skin_coyote.png",
		}
	},

	["skin_shark"] = {
		label = "Shark Skin",
		weight = 1750,
		stack = true,
		close = true,
		description = "Shark skin. Highly illegal!",
		client = {
			image = "skin_shark.png",
		}
	},

	["skin_pig"] = {
		label = "Pig Skin",
		weight = 850,
		stack = true,
		close = true,
		description = "Pig skin.",
		client = {
			image = "skin_pig.png",
		}
	},

	["skin_dolphin"] = {
		label = "Dolphin Skin",
		weight = 850,
		stack = true,
		close = true,
		description = "Dolphin skin. Highly illegal!",
		client = {
			image = "skin_dolphin.png",
		}
	},

	["skin_stingray"] = {
		label = "Stingray Skin",
		weight = 850,
		stack = true,
		close = true,
		description = "Stingray skin. Highly illegal!",
		client = {
			image = "skin_stingray.png",
		}
	},

	["meat_chicken"] = {
		label = "Chicken Meat",
		weight = 700,
		stack = true,
		close = true,
		description = "Chicken meat!",
		client = {
			image = "meat_chicken.png",
		}
	},

	["meat_boar"] = {
		label = "Boar Meat",
		weight = 700,
		stack = true,
		close = true,
		description = "Boar meat!",
		client = {
			image = "meat_boar.png",
		}
	},

	["meat_shark"] = {
		label = "Shark Meat",
		weight = 1200,
		stack = true,
		close = true,
		description = "Shark meat!",
		client = {
			image = "meat_shark.png",
		}
	},

	["meat_chickenhawk"] = {
		label = "Chickenhawk Meat",
		weight = 400,
		stack = true,
		close = true,
		description = "Chickenhawk meat!",
		client = {
			image = "meat_chickenhawk.png",
		}
	},

	["meat_pig"] = {
		label = "Pork Meat",
		weight = 750,
		stack = true,
		close = true,
		description = "Pig meat!",
		client = {
			image = "meat_pig.png",
		}
	},

	["skin_rabbit"] = {
		label = "Rabbit Hide",
		weight = 550,
		stack = true,
		close = true,
		description = "Rabbit hide.",
		client = {
			image = "skin_rabbit.png",
		}
	},

	["hugecutbait"] = {
		label = "Huge Cut Bait",
		weight = 10,
		stack = true,
		close = true,
		description = "Bait: Huge Cut Bait",
		client = {
			image = "hugecutbait.png",
		}
	},

	["cheapmono"] = {
		label = "Cheap Mono Line",
		weight = 10,
		stack = true,
		close = true,
		description = "Mine as well use your shoe string...",
		client = {
			image = "cheapmono.png",
		}
	},

	["waxworms"] = {
		label = "Waxworms",
		weight = 10,
		stack = true,
		close = true,
		description = "Bait: Waxworms",
		client = {
			image = "waxworms.png",
		}
	},

	["pollock"] = {
		label = "Pollock",
		weight = 10,
		stack = true,
		close = true,
		description = "Fresh Caught: Pollock",
		client = {
			image = "pollock.png",
		}
	},

	["fishrusreel"] = {
		label = "Fish R Us Reel",
		weight = 500,
		stack = true,
		close = true,
		description = "The legendary fishing pole from 'Fish R Us' used for fishing fishes.",
		client = {
			image = "fishrusreel.png",
		}
	},

	["garfish"] = {
		label = "Garfish",
		weight = 10,
		stack = true,
		close = true,
		description = "Fresh Caught: Garfish",
		client = {
			image = "garfish.png",
		}
	},

	["brutasrod"] = {
		label = "Brutas Rod",
		weight = 300,
		stack = true,
		close = true,
		description = "A brute fishing pole.",
		client = {
			image = "brutasrod.png",
		}
	},

	["leech"] = {
		label = "Leech",
		weight = 10,
		stack = true,
		close = true,
		description = "Bait: Leech",
		client = {
			image = "leech.png",
		}
	},

	["haddock"] = {
		label = "Haddock",
		weight = 10,
		stack = true,
		close = true,
		description = "Fresh Caught: Haddock",
		client = {
			image = "haddock.png",
		}
	},

	["redworms"] = {
		label = "Red Worms",
		weight = 10,
		stack = true,
		close = true,
		description = "Bait: RedWorms",
		client = {
			image = "redworms.png",
		}
	},

	["towhook"] = {
		label = "Tow Hook",
		weight = 10,
		stack = true,
		close = true,
		description = "You trying to catch a great white shark with that thing?!",
		client = {
			image = "towhook.png",
		}
	},

	["kingbraid"] = {
		label = "KingBraid Line",
		weight = 10,
		stack = true,
		close = true,
		description = "The kings braid for catching the most powerful fish in the sea!",
		client = {
			image = "kingbraid.png",
		}
	},

	["maggots"] = {
		label = "Maggots",
		weight = 10,
		stack = true,
		close = true,
		description = "Bait: Maggots",
		client = {
			image = "maggots.png",
		}
	},

	["no2"] = {
		label = "#2/0 Fish Hook",
		weight = 10,
		stack = true,
		close = true,
		description = "At least you can catch seaweed with this thing",
		client = {
			image = "no2.png",
		}
	},

	["lightningbraid"] = {
		label = "Lightning Braid",
		weight = 10,
		stack = true,
		close = true,
		description = "The line of lightning ready to catch fish in any waters!.",
		client = {
			image = "lightningbraid.png",
		}
	},

	["turtlemeat"] = {
		label = "Turtle Meat",
		weight = 10,
		stack = true,
		close = true,
		description = "Bait: Turtle Meat",
		client = {
			image = "turtlemeat.png",
		}
	},

	["no10"] = {
		label = "#10/0 Fish Hook",
		weight = 10,
		stack = true,
		close = true,
		description = "A professional grade fishing hook!",
		client = {
			image = "no10.png",
		}
	},

	["rainbowtrout"] = {
		label = "Rainbow Trout",
		weight = 10,
		stack = true,
		close = true,
		description = "Fresh Caught: Rainbow Trout",
		client = {
			image = "rainbowtrout.png",
		}
	},

	["zillareel"] = {
		label = "Zilla Reel",
		weight = 500,
		stack = true,
		close = true,
		description = "The 'zilla' of all reels!",
		client = {
			image = "zillareel.png",
		}
	},

	["no3"] = {
		label = "#3/0 Fish Hook",
		weight = 10,
		stack = true,
		close = true,
		description = "Finally a real fishing hook!",
		client = {
			image = "no3.png",
		}
	},

	["nightworms"] = {
		label = "Night Worms",
		weight = 10,
		stack = true,
		close = true,
		description = "Bait: NightWorms",
		client = {
			image = "nightworms.png",
		}
	},

	["zeusrod"] = {
		label = "Zeus Rod",
		weight = 250,
		stack = true,
		close = true,
		description = "The Zeus of fishing poles!",
		client = {
			image = "zeusrod.png",
		}
	},

	["mobeymono"] = {
		label = "Mobey Mono Line",
		weight = 10,
		stack = true,
		close = true,
		description = "Finally some real fishing line, time to reel em' in!",
		client = {
			image = "mobeymono.png",
		}
	},

	["thunderreel"] = {
		label = "Thunder Reel",
		weight = 500,
		stack = true,
		close = true,
		description = "The thunder of reels used for fishing mega fishes.",
		client = {
			image = "thunderreel.png",
		}
	},

	["noodlebraid"] = {
		label = "NoodleBraid Line",
		weight = 10,
		stack = true,
		close = true,
		description = "A professional grade fishing line.",
		client = {
			image = "noodlebraid.png",
		}
	},

	["no6"] = {
		label = "#6/0 Fish Hook",
		weight = 10,
		stack = true,
		close = true,
		description = "A deep sea fishing hook.",
		client = {
			image = "no6.png",
		}
	},

	["linesnifferreel"] = {
		label = "LineSniffer Reel",
		weight = 500,
		stack = true,
		close = true,
		description = "Line Sniffer Reel used for fishing fishes & sniffing lines.",
		client = {
			image = "linesnifferreel.png",
		}
	},

	["technoplankton"] = {
		label = "Technoplankton",
		weight = 10,
		stack = true,
		close = true,
		description = "Bait: Technoplankton",
		client = {
			image = "technoplankton.png",
		}
	},

	["bitesizemono"] = {
		label = "Bite-size Mono Line",
		weight = 10,
		stack = true,
		close = true,
		description = "You can fit the line between your teeth!",
		client = {
			image = "bitesizedmono.png",
		}
	},

	["crab"] = {
		label = "Crab",
		weight = 10,
		stack = true,
		close = true,
		description = "Bait: Crab",
		client = {
			image = "crab.png",
		}
	},

	["shark"] = {
		label = "Shark",
		weight = 10,
		stack = true,
		close = true,
		description = "Fresh Caught: Shark",
		client = {
			image = "shark.png",
		}
	},

	["magnumxlrod"] = {
		label = "Magnum XL Rod",
		weight = 250,
		stack = true,
		close = true,
		description = "The best fishing pole on the market the 'magnum'!",
		client = {
			image = "magnumxlrod.png",
		}
	},

	["turtle"] = {
		label = "Turtle",
		weight = 10,
		stack = true,
		close = true,
		description = "Fresh Caught: Turtle",
		client = {
			image = "turtle.png",
		}
	},

	["valuecastrod"] = {
		label = "Value Cast Rod",
		weight = 400,
		stack = true,
		close = true,
		description = "Dollar store fishing rod.",
		client = {
			image = "valuecastrod.png",
		}
	},

	["minnow"] = {
		label = "Minnow",
		weight = 10,
		stack = true,
		close = true,
		description = "Fresh Caught: Minnow",
		client = {
			image = "minnow.png",
		}
	},

	["rockbottomreel"] = {
		label = "Rock Bottom Reel",
		weight = 500,
		stack = true,
		close = true,
		description = "Fishing for rock bottom used for fishing fishes.",
		client = {
			image = "rockbottomreel.png",
		}
	},

	["elementalrod"] = {
		label = "Elemental Rod",
		weight = 350,
		stack = true,
		close = true,
		description = "A rod that can adapt to all elements.",
		client = {
			image = "elementalrod.png",
		}
	},

	["mealworms"] = {
		label = "Mealworms",
		weight = 10,
		stack = true,
		close = true,
		description = "Bait: Mealworms",
		client = {
			image = "mealworms.png",
		}
	},

	["no1"] = {
		label = "#1/0 Fish Hook",
		weight = 10,
		stack = true,
		close = true,
		description = "Better off using your hands. Good luck!",
		client = {
			image = "no1.png",
		}
	},

	["nerorod"] = {
		label = "Nero Rod",
		weight = 325,
		stack = true,
		close = true,
		description = "Extremely durable fishing rod.",
		client = {
			image = "nerorod.png",
		}
	},

	["stripedbass"] = {
		label = "Striped Bass",
		weight = 10,
		stack = true,
		close = true,
		description = "Fresh Caught: Striped Bass",
		client = {
			image = "stripedbass.png",
		}
	},

	["crappie"] = {
		label = "Crappie",
		weight = 10,
		stack = true,
		close = true,
		description = "Fresh Caught: Crappie",
		client = {
			image = "crappie.png",
		}
	},

	["trout"] = {
		label = "Trout",
		weight = 10,
		stack = true,
		close = true,
		description = "Fresh Caught: Trout",
		client = {
			image = "trout.png",
		}
	},

	["bacon"] = {
		label = "Bacon",
		weight = 10,
		stack = true,
		close = true,
		description = "Bait: Bacon",
		client = {
			image = "bacon.png",
		}
	},

	["northernpike"] = {
		label = "Northern Pike",
		weight = 10,
		stack = true,
		close = true,
		description = "Fresh Caught: Northern Pike",
		client = {
			image = "northernpike.png",
		}
	},

	["copperwire"] = {
		label = "Copper Wire",
		weight = 10,
		stack = true,
		close = true,
		description = "Wires that can help you build stuffs",
		client = {
			image = "copper_wires.png",
		}
	},
	["metal"] = {
		label = "Metal",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "metal.png",
		}
	},
	["gunpowder"] = {
		label = "Gun Powder",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "gun_powder.png",
		}
	},
	["spring"] = {
		label = "Spring",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "spring.png",
		}
	},
	["pcb"] = {
		label = "PCB Board",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pcb.png",
		}
	},
	["blacktape"] = {
		label = "Black Tape",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "blacktape.png",
		}
	},
	["rope"] = {
		label = "rope",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "blacktape.png",
		}
	},
	["remote"] = {
		label = "Remote",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "remote.png",
		}
	},
	["weapontrigger"] = {
		label = "Weapon Trigger",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "trigger.png",
		}
	},
	["barrelextension"] = {
		label = "Barrel Extension",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "barrel_extension.png",
		}
	},
	["triggerguard"] = {
		label = "Trigger Guard",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "gaurd.png",
		}
	},
	["cockingclip"] = {
		label = "Cocking Clip",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cocking_clip.png",
		}
	},
	["handgurd"] = {
		label = "Handgurd",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "handguard.png",
		}
	},
	["pistolblueprint"] = {
		label = "Auto Pistol Blue Print",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pistolblueprint.png",
		}
	},
	["smgblueprint"] = {
		label = "SMG Blue Print",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "smgblueprint.png",
		}
	},
	["rifleblueprint"] = {
		label = "Rifle Blueprint",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "rifleblueprint.png",
		}
	},

	["concentratedammonia"] = {
		label = "Concentrated Ammonia",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "concentratedammonia.png",
		}
	},

	["bobcatkeycard"] = {
		label = "Bobcat Security Card",
		weight = 1000,
		stack = true,
		close = true,
		description = "A keycard used at the Bobcat Security Deposit..",
		client = {
			image = "bobcatkeycard.png",
		}
	},

	["ocb_paper"] = {
		label = "Ocb Paper",
		weight = 200,
		stack = true,
		close = true,
		description = "Ocb paper for rolling joints",
		client = {
			image = "ocb_paper.png",
		}
	},

	["purple_haze_bag"] = {
		label = "Purple Haze Bag",
		weight = 200,
		stack = true,
		close = true,
		description = "Weed for packing",
		client = {
			image = "purple_haze_bag.png",
		}
	},

	["purple_haze_joint"] = {
		label = "Purple Haze Joint",
		weight = 200,
		stack = true,
		close = true,
		description = "Good joint",
		client = {
			image = "purple_haze_joint.png",
		}
	},

	["cubancigar"] = {
		label = "Cuban Cigar",
		weight = 200,
		stack = true,
		close = true,
		description = "Real cigar",
		client = {
			image = "cubancigar.png",
		}
	},

	["blue_dream_bag"] = {
		label = "Blue Dream Bag",
		weight = 200,
		stack = true,
		close = true,
		description = "Weed for packing",
		client = {
			image = "blue_dream_bag.png",
		}
	},

	["davidoffcigar"] = {
		label = "Davidoff Cigar",
		weight = 200,
		stack = true,
		close = true,
		description = "Real cigar",
		client = {
			image = "davidoffcigar.png",
		}
	},

	["c4_bomb"] = {
		label = "C4 Brick",
		weight = 1000,
		stack = false,
		close = true,
		description = "Very Dangerous! High Yield Explosive.",
		client = {
			image = "c4_bomb.png",
		}
	},

	["fish-finder"] = {
		label = "Fish Finder",
		weight = 500,
		stack = true,
		close = true,
		description = "A Fish finder for locating fish in bodies of water",
		client = {
			image = "fish-finder.png",
		}
	},

	["redw"] = {
		label = "Redwood Pack",
		weight = 200,
		stack = true,
		close = true,
		description = "Take out your cigarettes",
		client = {
			image = "redw.png",
		}
	},

	["vape"] = {
		label = "Vape",
		weight = 200,
		stack = true,
		close = true,
		description = "Electronic cigarette",
		client = {
			image = "vape.png",
		}
	},

	["marlboro"] = {
		label = "Marlboro Pack",
		weight = 200,
		stack = true,
		close = true,
		description = "Take out your cigarettes",
		client = {
			image = "marlboro.png",
		}
	},

	["banana_kush_weed"] = {
		label = "Banana Kush Weed 1G",
		weight = 200,
		stack = true,
		close = true,
		description = "Weed for packing",
		client = {
			image = "banana_kush_weed.png",
		}
	},

	["liquid"] = {
		label = "Liquid",
		weight = 200,
		stack = true,
		close = true,
		description = "Vape liquid",
		client = {
			image = "liquid.png",
		}
	},

	["banana_kush_bag"] = {
		label = "Banana Kush Bag",
		weight = 200,
		stack = true,
		close = true,
		description = "Weed for packing",
		client = {
			image = "banana_kush_bag.png",
		}
	},

	["purple_haze_weed"] = {
		label = "Purple Haze Weed 1G",
		weight = 200,
		stack = true,
		close = true,
		description = "Weed for packing",
		client = {
			image = "purple_haze_weed.png",
		}
	},

	["blue_dream_weed"] = {
		label = "Blue Dream Weed 1G",
		weight = 200,
		stack = true,
		close = true,
		description = "Weed for packing",
		client = {
			image = "blue_dream_weed.png",
		}
	},

	["thermite_h"] = {
		label = "Thermite",
		weight = 1000,
		stack = false,
		close = true,
		description = "A low-yield thermite charge..",
		client = {
			image = "thermite_h.png",
		}
	},

	["og_kush_joint"] = {
		label = "Og Kush Joint",
		weight = 200,
		stack = true,
		close = true,
		description = "Good joint",
		client = {
			image = "og_kush_joint.png",
		}
	},

	["banana_kush_joint"] = {
		label = "Banana Lush Joint",
		weight = 200,
		stack = true,
		close = true,
		description = "Good joint",
		client = {
			image = "banana_kush_joint.png",
		}
	},

	["blue_dream_joint"] = {
		label = "Blue Dream Joint",
		weight = 200,
		stack = true,
		close = true,
		description = "Good joint",
		client = {
			image = "blue_dream_joint.png",
		}
	},

	["og_kush_weed"] = {
		label = "Og Kush Weed 1G",
		weight = 200,
		stack = true,
		close = true,
		description = "Weed for packing",
		client = {
			image = "og_kush_weed.png",
		}
	},

	["marlborocig"] = {
		label = "Marlboro Cigarette",
		weight = 200,
		stack = true,
		close = true,
		description = "Smoking cigarette",
		client = {
			image = "marlborocig.png",
		}
	},

	["redwcig"] = {
		label = "Redwood Cigarette",
		weight = 200,
		stack = true,
		close = true,
		description = "Smoking cigarette",
		client = {
			image = "redwcig.png",
		}
	},

	["og_kush_bag"] = {
		label = "Og Kush Bag",
		weight = 200,
		stack = true,
		close = true,
		description = "Weed for packing",
		client = {
			image = "og_kush_bag.png",
		}
	},
	["gps_panel"] = {
		label = "GPS panel",
		weight = 200,
		stack = true,
		close = true,
		description = "Weed for packing",
		client = {
			image = "gps_panel.png",
		}
	},
	["vehicle_gps"] = {
		label = "Og Kush Bag",
		weight = 200,
		stack = true,
		close = true,
		description = "Weed for packing",
		client = {
			image = "vehicle_gps.png",
		}
	},
	["gpsremove"] = {
		label = "Og Kush Bag",
		weight = 200,
		stack = true,
		close = true,
		description = "Weed for packing",
		client = {
			image = "gpsremove.png",
		}
	},
	["gps_detector"] = {
		label = "Og Kush Bag",
		weight = 200,
		stack = true,
		close = true,
		description = "Weed for packing",
		client = {
			image = "gps_detector.png",
		}
	},
	["player_gps"] = {
		label = "Og Kush Bag",
		weight = 200,
		stack = true,
		close = true,
		description = "Weed for packing",
		client = {
			image = "player_gps.png",
		}
	},
	["jewellery"] = {
		label = "Jewellery",
		weight = 200,
		stack = true,
		close = true,
		description = "Weed for packing",
		client = {
			image = "jewellery.png",
		}
	},

	["mechanic_tools"] = {
		label = "Mechanic tools", weight = 0, stack = false, close = true, description = "Needed for vehicle repairs",
		client = { image = "mechanic_tools.png", event = "jim-mechanic:client:Repair:Check" }
	},
	["toolbox"] = {
		label = "Toolbox", weight = 0, stack = false, close = true, description = "Needed for Performance part removal",
		client = { image = "toolbox.png", event = "jim-mechanic:client:Menu" }
	},
	["ducttape"] = {
		label = "Duct Tape", weight = 0, stack = false, close = true, description = "Good for quick fixes",
		client = { image = "bodyrepair.png", event = "jim-mechanic:quickrepair" }
	},
	['mechboard'] = { label = 'Mechanic Sheet', weight = 0, stack = false, close = false,
		buttons = {
			{ 	label = 'Copy Parts List',
				action = function(slot)
					local item = exports.ox_inventory:Search('slots', 'mechboard')
					for _, v in pairs(item) do
						if (v.slot == slot) then lib.setClipboard(v.metadata.info.vehlist) break end
					end
				end },
			{ 	label = 'Copy Plate Number',
				action = function(slot)
					local item = exports.ox_inventory:Search('slots', 'mechboard')
					for _, v in pairs(item) do
						if (v.slot == slot) then lib.setClipboard(v.metadata.info.vehplate) break end
					end
				end },
			{	label = 'Copy Vehicle Model',
				action = function(slot)
					local item = exports.ox_inventory:Search('slots', 'mechboard')
					for _, v in pairs(item) do
						if (v.slot == slot) then lib.setClipboard(v.metadata.info.veh) break  end
					end
				end },
		},
	},
	--Performance
	["turbo"] = {
		label = "Supercharger Turbo", weight = 0, stack = false, close = true, description = "Who doesn't need a 65mm Turbo??",
		client = { image = "turbo.png", event = "jim-mechanic:client:applyTurbo", remove = false },
	},
	["car_armor"] = {
		label = "Vehicle Armor", weight = 0, stack = false, close = true, description = "",
		client = { image = "armour.png", event = "jim-mechanic:client:applyArmour", remove = false },
	},
	["nos"] = {
		label = "NOS Bottle", weight = 0, stack = false, close = true, description = "A full bottle of NOS",
		client = { image = "nos.png", event = "jim-mechanic:client:applyNOS", },
	},
	["noscan"] = {
		label = "Empty NOS Bottle", weight = 0, stack = true, close = true, description = "An Empty bottle of NOS",
		client = { image = "noscan.png", }
	},
	["noscolour"] = {
		label = "NOS Colour Injector", weight = 0, stack = true, close = true, description = "Make that purge spray",
		client = { image = "noscolour.png", }
	},
	
	["engine1"] = {
		label = "Tier 1 Engine", weight = 0, stack = false, close = true, description = "",
		client = { image = "engine1.png",  event = "jim-mechanic:client:applyEngine", level = 0, remove = false },
	},
	["engine2"] = {
		label = "Tier 2 Engine", weight = 0, stack = false, close = true, description = "",
		client = { image = "engine2.png",  event = "jim-mechanic:client:applyEngine", level = 1, remove = false },
	},
	["engine3"] = {
		label = "Tier 3 Engine", weight = 0, stack = false, close = true, description = "",
		client = { image = "engine3.png",  event = "jim-mechanic:client:applyEngine", level = 2, remove = false },
	},
	["engine4"] = {
		label = "Tier 4 Engine", weight = 0, stack = false, close = true, description = "",
		client = { image = "engine4.png",  event = "jim-mechanic:client:applyEngine", level = 3, remove = false },
	},
	["engine5"] = {
		label = "Tier 5 Engine", weight = 0, stack = false, close = true, description = "",
		client = { image = "engine5.png",  event = "jim-mechanic:client:applyEngine", level = 4, remove = false },
	},
	
	["transmission1"] = {
		label = "Tier 1 Transmission", weight = 0, stack = false, close = true, description = "",
		client = { image = "transmission1.png",  event = "jim-mechanic:client:applyTransmission", level = 0, remove = false },
	},
	["transmission2"] = {
		label = "Tier 2 Transmission", weight = 0, stack = false, close = true, description = "",
		client = { image = "transmission2.png",  event = "jim-mechanic:client:applyTransmission", level = 1, remove = false },
	},
	["transmission3"] = {
		label = "Tier 3 Transmission", weight = 0, stack = false, close = true, description = "",
		client = { image = "transmission3.png",  event = "jim-mechanic:client:applyTransmission", level = 2, remove = false },
	},
	["transmission4"] = {
		label = "Tier 4 Transmission", weight = 0, stack = false, close = true, description = "",
		client = { image = "transmission4.png",  event = "jim-mechanic:client:applyTransmission", level = 3, remove = false },
	},
	
	["brakes1"] = {
		label = "Tier 1 Brakes", weight = 0, stack = false, close = true, description = "",
		client = { image = "brakes1.png",  event = "jim-mechanic:client:applyBrakes", level = 0, remove = false },
	},
	["brakes2"] = {
		label = "Tier 2 Brakes", weight = 0, stack = false, close = true, description = "",
		client = { image = "brakes2.png",  event = "jim-mechanic:client:applyBrakes", level = 1, remove = false },
	},
	["brakes3"] = {
		label = "Tier 3 Brakes", weight = 0, stack = false, close = true, description = "",
		client = { image = "brakes3.png",  event = "jim-mechanic:client:applyBrakes", level = 2, remove = false },
	},
	
	["suspension1"] = {
		label = "Tier 1 Suspension", weight = 0, stack = false, close = true, description = "",
		client = { image = "suspension1.png", event = "jim-mechanic:client:applySuspension",  level = 0, remove = false },
	},
	["suspension2"] = {
		label = "Tier 2 Suspension", weight = 0, stack = false, close = true, description = "",
		client = { image = "suspension2.png", event = "jim-mechanic:client:applySuspension", level = 1, remove = false },
	},
	["suspension3"] = {
		label = "Tier 3 Suspension", weight = 0, stack = false, close = true, description = "",
		client = { image = "suspension3.png", event = "jim-mechanic:client:applySuspension", level = 2, remove = false },
	},
	["suspension4"] = {
		label = "Tier 4 Suspension", weight = 0, stack = false, close = true, description = "",
		client = { image = "suspension4.png", event = "jim-mechanic:client:applySuspension", level = 3, remove = false },
	},
	["suspension5"] = {
		label = "Tier 5 Suspension", weight = 0, stack = false, close = true, description = "",
		client = { image = "suspension5.png", event = "jim-mechanic:client:applySuspension", level = 4, remove = false },
	},
	
	["bprooftires"] = {
		label = "Bulletproof Tires", weight = 0, stack = false, close = true, description = "",
		client = { image = "bprooftires.png", event = "jim-mechanic:client:applyBulletProof", remove = false },
	},
	["drifttires"] = {
		label = "Drift Tires", weight = 0, stack = false, close = true, description = "",
		client = { image = "drifttires.png", event = "jim-mechanic:client:applyDrift", remove = false },
	},
	
	["oilp1"] = {
		label = "Tier 1 Oil Pump", weight = 0, stack = false, close = true, description = "",
		client = { image = "oilp1.png", event = "jim-mechanic:client:applyExtraPart", level = 1, mod = "oilp", remove = false },
	},
	["oilp2"] = {
		label = "Tier 2 Oil Pump", weight = 0, stack = false, close = true, description = "",
		client = { image = "oilp2.png", event = "jim-mechanic:client:applyExtraPart", level = 2, mod = "oilp", remove = false },
	},
	["oilp3"] = {
		label = "Tier 3 Oil Pump", weight = 0, stack = false, close = true, description = "",
		client = { image = "oilp3.png", event = "jim-mechanic:client:applyExtraPart", level = 3, mod = "oilp", remove = false },
	},
	
	["drives1"] = {
		label = "Tier 1 Drive Shaft", weight = 0, stack = false, close = true, description = "",
		client = { image = "drives1.png", event = "jim-mechanic:client:applyExtraPart", level = 1, mod = "drives", remove = false },
	},
	["drives2"] = {
		label = "Tier 2 Drive Shaft", weight = 0, stack = false, close = true, description = "",
		client = { image = "drives2.png", event = "jim-mechanic:client:applyExtraPart", level = 2, mod = "drives", remove = false },
	},
	["drives3"] = {
		label = "Tier 3 Drive Shaft", weight = 0, stack = false, close = true, description = "",
		client = { image = "drives3.png", event = "jim-mechanic:client:applyExtraPart", level = 3, mod = "drives", remove = false },
	},
	
	["cylind1"] = {
		label = "Tier 1 Cylinder Head", weight = 0, stack = false, close = true, description = "",
		client = { image = "cylind1.png", event = "jim-mechanic:client:applyExtraPart", level = 1, mod = "cylind", remove = false },
	},
	["cylind2"] = {
		label = "Tier 2 Cylinder Head", weight = 0, stack = false, close = true, description = "",
		client = { image = "cylind2.png", event = "jim-mechanic:client:applyExtraPart", level = 2, mod = "cylind", remove = false },
	},
	["cylind3"] = {
		label = "Tier 3 Cylinder Head", weight = 0, stack = false, close = true, description = "",
		client = { image = "cylind3.png", event = "jim-mechanic:client:applyExtraPart", level = 3, mod = "cylind", remove = false },
	},
	
	["cables1"] = {
		label = "Tier 1 Battery Cables", weight = 0, stack = false, close = true, description = "",
		client = { image = "cables1.png", event = "jim-mechanic:client:applyExtraPart", level = 1, mod = "cables", remove = false },
	},
	["cables2"] = {
		label = "Tier 2 Battery Cables", weight = 0, stack = false, close = true, description = "",
		client = { image = "cables2.png", event = "jim-mechanic:client:applyExtraPart", level = 2, mod = "cables", remove = false },
	},
	["cables3"] = {
		label = "Tier 3 Battery Cables", weight = 0, stack = false, close = true, description = "",
		client = { image = "cables3.png", event = "jim-mechanic:client:applyExtraPart", level = 3, mod = "cables", remove = false },
	},
	
	["fueltank1"] = {
		label = "Tier 1 Fuel Tank", weight = 0, stack = false, close = true, description = "",
		client = { image = "fueltank1.png", event = "jim-mechanic:client:applyExtraPart", level = 1, mod = "fueltank", remove = false },
	},
	["fueltank2"] = {
		label = "Tier 2 Fuel Tank", weight = 0, stack = false, close = true, description = "",
		client = { image = "fueltank2.png", event = "jim-mechanic:client:applyExtraPart", level = 2, mod = "fueltank", remove = false },
	},
	["fueltank3"] = {
		label = "Tier 3 Fuel Tank", weight = 0, stack = false, close = true, description = "",
		client = { image = "fueltank3.png", event = "jim-mechanic:client:applyExtraPart", level = 3, mod = "fueltank", remove = false },
	},
	
	["antilag"] = {
		label = "AntiLag", weight = 0, stack = false, close = true, description = "",
		client = { image = "antiLag.png", event = "jim-mechanic:client:applyAntiLag", remove = false },
	},
	
	["underglow_controller"] = {
		label = "Neon Controller", weight = 0, stack = false, close = true, description = "",
		client = { image = "underglow_controller.png", event = "jim-mechanic:client:neonMenu", },
	},
	["headlights"] = {
		label = "Xenon Headlights", weight = 0, stack = false, close = true, description = "",
		client = { image = "headlights.png", event = "jim-mechanic:client:applyXenons", },
	},
	
	["tint_supplies"] = {
		label = "Window Tint Kit", weight = 0, stack = false, close = true, description = "",
		client = { image = "tint_supplies.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	
	["customplate"] = {
		label = "Customized Plates", weight = 0, stack = false, close = true, description = "",
		client = { image = "plate.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	["hood"] = {
		label = "Vehicle Hood", weight = 0, stack = false, close = true, description = "",
		client = { image = "hood.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	["roof"] = {
		label = "Vehicle Roof", weight = 0, stack = false, close = true, description = "",
		client = { image = "roof.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	["spoiler"] = {
		label = "Vehicle Spoiler", weight = 0, stack = false, close = true, description = "",
		client = { image = "spoiler.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	["bumper"] = {
		label = "Vehicle Bumper", weight = 0, stack = false, close = true, description = "",
		client = { image = "bumper.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	["skirts"] = {
		label = "Vehicle Skirts", weight = 0, stack = false, close = true, description = "",
		client = { image = "skirts.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	["exhaust"] = {
		label = "Vehicle Exhaust", weight = 0, stack = false, close = true, description = "",
		client = { image = "exhaust.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	["seat"] = {
		label = "Seat Cosmetics", weight = 0, stack = false, close = true, description = "",
		client = { image = "seat.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	["rollcage"] = {
		label = "Roll Cage", weight = 0, stack = false, close = true, description = "",
		client = { image = "rollcage.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	
	["rims"] = {
		label = "Custom Wheel Rims", weight = 0, stack = false, close = true, description = "",
		client = { image = "rims.png", event = "jim-mechanic:client:Rims:Check", },
	},
	
	["livery"] = {
		label = "Livery Roll", weight = 0, stack = false, close = true, description = "",
		client = { image = "livery.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	["paintcan"] = {
		label = "Vehicle Spray Can", weight = 0, stack = false, close = true, description = "",
		client = { image = "spraycan.png", event = "jim-mechanic:client:Paints:Check", },
	},
	["tires"] = {
		label = "Drift Smoke Tires", weight = 0, stack = false, close = true, description = "",
		client = { image = "tires.png", event = "jim-mechanic:client:Tires:Check", },
	},
	
	["horn"] = {
		label = "Custom Vehicle Horn", weight = 0, stack = false, close = true, description = "",
		client = { image = "horn.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	
	["internals"] = {
		label = "Internal Cosmetics", weight = 0, stack = false, close = true, description = "",
		client = { image = "internals.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},

	["externals"] = {
		label = "Exterior Cosmetics", weight = 0, stack = false, close = true, description = "",
		client = { image = "mirror.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	
	["newoil"] = {
		label = "Car Oil", weight = 0, stack = false, close = true, description = "",
		client = { image = "caroil.png", },
	},

	["sparkplugs"] = {
		label = "Spark Plugs", weight = 0, stack = false, close = true, description = "",
		client = { image = "sparkplugs.png", },
	},

	["carbattery"] = {
		label = "Car Battery", weight = 0, stack = false, close = true, description = "",
		client = { image = "carbattery.png", },
	},

	["axleparts"] = {
		label = "Axle Parts", weight = 0, stack = false, close = true, description = "",
		client = { image = "axleparts.png", },
	},

	["sparetire"] = {
		label = "Spare Tire", weight = 0, stack = false, close = true, description = "",
		client = { image = "sparetire.png", },
	},
	
	["harness"] = {
		label = "Race Harness", weight = 0, stack = true, close = true, description = "Racing Harness so no matter what you stay in the car",
		client = { image = "harness.png", event = "jim-mechanic:client:applyHarness", remove = false },
	},

	["cleaningkit"] = {
		label = "Cleaning Kit", weight = 0, stack = true, close = true, description = "A microfiber cloth with some soap will let your car sparkle again!",
		client = { image = "cleaningkit.png", event = "jim-mechanic:client:cleanVehicle"},
	},

	["repairkit"] = {
		label = "Repairkit", weight = 0, stack = true, close = true, description = "A nice toolbox with stuff to repair your vehicle",
		client = { image = "repairkit.png", event = "jim-mechanic:vehFailure:RepairVehicle", item = "repairkit", full = false },
	},
	
	["advancedrepairkit"] = {
		label = "Advanced Repairkit", weight = 0, stack = true, close = true, description = "A nice toolbox with stuff to repair your vehicle",
		client = { image = "advancedkit.png", event = "jim-mechanic:vehFailure:RepairVehicle", item = "advancedrepairkit", full = true },
	},

	["tenkgoldchain"] = {
		label = "10k Gold Chain",
		weight = 2000,
		stack = true,
		close = true,
		description = "10 carat golden chain",
		client = {
			image = "10kgoldchain.png",
		}
	},

	["bratte"] = {
		label = "The Bratte",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 30,
			},
			image = "bratte.png",
		}
	},

	["pisswasser2"] = {
		label = "Pißwasser Stout",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 42,
			},
			image = "pisswaser2.png",
		}
	},

	["electronicscrap"] = {
		label = "Electronic Scrap",
		weight = 100,
		stack = true,
		close = false,
		description = "A couple of wires and a circuit board, might be able to do something with this?",
		client = {
			image = "electronics.png",
		}
	},

	["coke"] = {
		label = "Raw Cocaine",
		weight = 1000,
		stack = true,
		close = false,
		description = "Processed cocaine",
		client = {
			image = "coke.png",
		}
	},

	["blue_cats3"] = {
		label = "Tricatse Stack blue cats",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "kitty_blue.png",
		}
	},

	["rollingpaper"] = {
		label = "Rolling Paper For Joints",
		weight = 450,
		stack = true,
		close = false,
		description = "Rolling Paper For Joints",
		client = {
			image = "rollingpaper.png",
		}
	},

	["quadpress"] = {
		label = "Quad Pill Press",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pillpress.png",
		}
	},

	["oldtire"] = {
		label = "Old worn tire",
		weight = 320,
		stack = true,
		close = true,
		description = "This tire looks like it has seen better days, might be able to salvage some of it...",
		client = {
			image = "oldtire.png",
		}
	},

	["pizzmushrooms"] = {
		label = "Mushrooms",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "mushrooms.png",
		}
	},

	["tunasandwich"] = {
		label = "Tuna Sandwich",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 29,
			},
			image = "tunasandwich.png",
		}
	},

	["ace"] = {
		label = "Ace of Spades",
		weight = 100,
		stack = true,
		close = false,
		description = "An old trading card - kinda crusty...",
		client = {
			image = "ace.png",
		}
	},

	["orange_trolls2"] = {
		label = "Dual Stack orange trolls",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "troll_orange.png",
		}
	},

	["trunk"] = {
		label = "Car Trunk",
		weight = 10000,
		stack = false,
		close = true,
		client = {
			image = "car_trunk.png",
		}
	},

	["red_pl4"] = {
		label = "Quad Stack red pl",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "PL_red.png",
		}
	},

	["strawdaquiri"] = {
		label = "Strawberry Daquiri",
		weight = 200,
		stack = true,
		close = true,
		description = "Strawberry Daquiri",
		client = {
			status = {
				thirst = 42,
			},
			image = "strawdaquiri.png",
		}
	},

	["tobacco"] = {
		label = "Tobacco",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "tobacco.png",
		}
	},

	["blue_trolls"] = {
		label = "Single Stack blue trolls",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "troll_blue.png",
		}
	},

	["bltsandwich"] = {
		label = "BLT Sandwich",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 22,
			},
			image = "bltsandwich.png",
		}
	},

	["jelly"] = {
		label = "Jelly",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 20,
			},
			image = "jelly.png",
		}
	},

	["raw_ham"] = {
		label = "Raw Ham",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "raw_ham.png",
		}
	},

	["apple"] = {
		label = "Apple",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "apple.png",
		}
	},

	["raw_beef"] = {
		label = "Raw Beef",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "raw_beef.png",
		}
	},

	["hamsandwich"] = {
		label = "Ham Sandwich",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 25,
			},
			image = "hamsandwich.png",
		}
	},

	["emptycowbucket"] = {
		label = "Empty Bucket",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "emptybucket.png",
		}
	},

	["triplsec"] = {
		label = "Triple Sec",
		weight = 200,
		stack = true,
		close = true,
		description = "Triple Sec",
		client = {
			status = {
				thirst = 50,
			},
			image = "triplesec.png",
		}
	},

	["surgical_gloves"] = {
		label = "Surgical gloves",
		weight = 500,
		stack = true,
		close = true,
		description = "edit here",
		client = {
			image = "surgical_gloves.png",
		}
	},

	["surgical_tray"] = {
		label = "Surgical tray",
		weight = 500,
		stack = true,
		close = true,
		description = "edit here",
		client = {
			image = "surgical_tray.png",
		}
	},

	["ecocoffee"] = {
		label = "The Eco-ffee",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 20,
			},
			image = "ecoffee.png",
		}
	},

	["blue_pl2"] = {
		label = "Dual Stack blue pl",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "PL_blue.png",
		}
	},

	["white_aliens"] = {
		label = "Single Stack White aliens",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "alien_white.png",
		}
	},

	["white_trolls4"] = {
		label = "Quad Stack White trolls",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "troll_white.png",
		}
	},

	["specialbrownie"] = {
		label = "Special Brownie",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "chocolate.png",
		}
	},

	["vicodin"] = {
		label = "Vicie",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "vicodin.png",
		}
	},

	["white_cats2"] = {
		label = "Dual Stack White cats",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "kitty_white.png",
		}
	},

	["orange_playboys2"] = {
		label = "Dual Stack orange Playboys",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "playboy_orange.png",
		}
	},

	["bolognese"] = {
		label = "Bolognese",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 28,
			},
			image = "bolognese.png",
		}
	},

	["adderal_prescription"] = {
		label = "Mdderal Prescription",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "adderalprescription.png",
		}
	},

	["crayons"] = {
		label = "Crayons",
		weight = 100,
		stack = true,
		close = true,
		description = "A small set of pastel coloured crayons, used to decorate illustrations. Stay within the lines!",
		client = {
			image = "crayons.png",
		}
	},

	["white_trolls"] = {
		label = "Single Stack White trolls",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "troll_white.png",
		}
	},

	["gym_pass"] = {
		label = "Gym Membership",
		weight = 0,
		stack = false,
		close = false,
		description = "Lifetime Gym Membership",
		client = {
			image = "gym_pass.png",
		}
	},

	["red_cats3"] = {
		label = "Tricatse Stack red cats",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "kitty_red.png",
		}
	},

	["orange_pl2"] = {
		label = "Dual Stack orange pl",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "PL_orange.png",
		}
	},

	["white_aliens3"] = {
		label = "Triple Stack White aliens",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "alien_white.png",
		}
	},

	["bottlecaps"] = {
		label = "Bottle caps",
		weight = 300,
		stack = true,
		close = true,
		description = "Some plastic caps for what looks like a variety of soda bottles.",
		client = {
			image = "bottlecaps.png",
		}
	},

	["longisland"] = {
		label = "Long Island Ice tea",
		weight = 200,
		stack = true,
		close = true,
		description = "Long Island Ice Tea",
		client = {
			status = {
				thirst = 45,
			},
			image = "longisland.png",
		}
	},

	["blue_cats2"] = {
		label = "Dual Stack blue cats",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "kitty_blue.png",
		}
	},

	["rum"] = {
		label = "Rum",
		weight = 200,
		stack = true,
		close = true,
		description = "A bottle of Rum",
		client = {
			status = {
				thirst = 20,
			},
			image = "rum.png",
		}
	},

	["shroombag"] = {
		label = "Bag of Shrooms",
		weight = 160,
		stack = true,
		close = false,
		description = "A small bag containing hallucinogenic mushrooms.",
		client = {
			image = "bagofshrooms.png",
		}
	},

	["heroinvialstagetwo"] = {
		label = "Better Vial of Heroin",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "heroinstagetwo.png",
		}
	},

	["speedball"] = {
		label = "The SpeedBall",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 29,
			},
			image = "speedball.png",
		}
	},

	["heroincutstagetwo"] = {
		label = "Better Cut Heroin",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "heroinpowderstagethree.png",
		}
	},

	["blue_playboys3"] = {
		label = "Triple Stack blue Playboys",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "playboy_blue.png",
		}
	},

	["receipt"] = {
		label = "Receipt",
		weight = 0,
		stack = false,
		close = true,
		description = "Receipt that needs to be paid",
		client = {
			image = "receipt.png",
		}
	},

	["leo-gps"] = {
		label = "LEO GPS",
		weight = 2000,
		stack = false,
		close = true,
		description = "Show your gps location to others",
		client = {
			image = "leo-gps.png",
		}
	},

	["heroin_readystagethree"] = {
		label = "Syringe Of Best Heroin",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "heroin_readystagethree.png",
		}
	},

	["marinara"] = {
		label = "Marinara",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 22,
			},
			image = "marinara.png",
		}
	},

	["weed_purple-haze_seed"] = {
		label = "Purple Haze Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "A weed seed of Purple Haze",
		client = {
			image = "weed_seed.png",
		}
	},

	["grindedweed"] = {
		label = "Keef",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "keef.png",
		}
	},

	["heroinstagetwo"] = {
		label = "Better Heroin",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "heroinpowderstagetwo.png",
		}
	},

	["tots"] = {
		label = "Tits or Tots",
		weight = 200,
		stack = true,
		close = true,
		description = "Sexy Tots",
		client = {
			status = {
				hunger = 49,
			},
			image = "tots.png",
		}
	},

	["sunglasses"] = {
		label = "Sunnies",
		weight = 100,
		stack = true,
		close = true,
		description = "A pair of what look like expenssive UV spec, designer shades - except they say Gouccy?",
		client = {
			image = "sunglasses.png",
		}
	},

	["orange_playboys4"] = {
		label = "Quad Stack orange Playboys",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "playboy_orange.png",
		}
	},

	["blue_aliens"] = {
		label = "Single Stack blue aliens",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "alien_blue.png",
		}
	},

	["gratefuldead_tabs"] = {
		label = "Grateful Dead Tabs",
		weight = 100,
		stack = true,
		close = true,
		description = "DONT USE IF YOU GET SEIZURES",
		client = {
			image = "gratefuldead_tabs.png",
		}
	},

	["red_xtc3"] = {
		label = "Triple Stack Red XTC",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "unstampedred.png",
		}
	},

	["dualpress"] = {
		label = "Dual Pill Press",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pillpress.png",
		}
	},

	["weed_og-kush_seed"] = {
		label = "OGKush Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "A weed seed of OG Kush",
		client = {
			image = "weed_seed.png",
		}
	},

	["smileyfacesheet"] = {
		label = "Smiley Face Sheet",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "smileysheet.png",
		}
	},

	["capricciosa"] = {
		label = "Capriccosa",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 26,
			},
			image = "capricciosa.png",
		}
	},

	["pumpkinpiebox"] = {
		label = "Box of Pie",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pumpkinpiebox.png",
		}
	},

	["shatter"] = {
		label = "Shatter",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "shatter.png",
		}
	},

	["washcoin"] = {
		label = "Washcoin",
		weight = 0,
		stack = true,
		close = false,
		description = "Coin for washingmachine",
		client = {
			image = "washcoin.png",
		}
	},

	["red_trolls3"] = {
		label = "Tritrollse Stack red trolls",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "troll_red.png",
		}
	},

	["carengine"] = {
		label = "Engine Block",
		weight = 2250,
		stack = true,
		close = true,
		description = "Combustion engine from a motor vehicle.",
		client = {
			image = "carengine.png",
		}
	},

	["weedplant_branch"] = {
		label = "Weed Branch",
		weight = 10000,
		stack = false,
		close = false,
		description = "Weed plant",
		client = {
			image = "weedplant_branch.png",
		}
	},

	["car_door"] = {
		label = "Car Door",
		weight = 10000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "car_door.png",
		}
	},

	["specialmuffin"] = {
		label = "Special Muffin",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "specialmuffin.png",
		}
	},

	["red_pl2"] = {
		label = "Dual Stack red pl",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "PL_red.png",
		}
	},

	["prosciuttio"] = {
		label = "Prosciuttio E Funghi",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 29,
			},
			image = "proscuttio.png",
		}
	},

	["adderalbottle"] = {
		label = "Madderal Bottle",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pillbottle.png",
		}
	},

	["carwipers"] = {
		label = "Windsheild Wipers",
		weight = 250,
		stack = true,
		close = true,
		description = "Looks like these wipers can still be used, not bad.",
		client = {
			image = "windshieldwipers.png",
		}
	},

	["curaco"] = {
		label = "Curaco",
		weight = 200,
		stack = true,
		close = true,
		description = "A bottle of Curaco",
		client = {
			status = {
				thirst = 25,
			},
			image = "curaco.png",
		}
	},

	["red_playboys4"] = {
		label = "Quad Stack red Playboys",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "playboy_red.png",
		}
	},

	["lsd_vial_six"] = {
		label = "Purest LSD",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "lsd_vial_six.png",
		}
	},

	["dirtyheroinlabkit"] = {
		label = "Dirty heroin Lab Kit",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "labkit_dirty.png",
		}
	},

	["dextroblunts"] = {
		label = "Dextro Blunts",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "dextroblunts.png",
		}
	},

	["vicodin_prescription"] = {
		label = "Vicie Prescription",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "vicodinprescription.png",
		}
	},

	["surgical_staple"] = {
		label = "Surgical staple",
		weight = 500,
		stack = true,
		close = true,
		description = "edit here",
		client = {
			image = "surgical_staple.png",
		}
	},

	["blue_pl"] = {
		label = "Single Stack blue pl",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "PL_blue.png",
		}
	},

	["phonehacker"] = {
		label = "Hacker Phone",
		weight = 10000,
		stack = false,
		close = true,
		client = {
			image = "encryptedtablet.png",
		}
	},

	["mdtablet"] = {
		label = "Tablet",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "mdtablet.png",
		}
	},

	["ccookie"] = {
		label = "Cranberry Cookie",
		weight = 200,
		stack = true,
		close = true,
		description = "Cranberry Cookie Cocktail",
		client = {
			status = {
				thirst = 23,
			},
			image = "ccookie.png",
		}
	},

	["bluntwrap"] = {
		label = "Blunt Wrap",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "bluntwrap.png",
		}
	},

	["blue_playboys4"] = {
		label = "Quad Stack blue Playboys",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "playboy_blue.png",
		}
	},

	["ciggie"] = {
		label = "Ciggie",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "ciggie.png",
		}
	},

	["brussian"] = {
		label = "Black Russian",
		weight = 200,
		stack = true,
		close = true,
		description = "Black Russian Cocktail",
		client = {
			status = {
				thirst = 29,
			},
			image = "brussian.png",
		}
	},

	["white_xtc2"] = {
		label = "Dual Stack White XTC",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "unstampedwhite.png",
		}
	},

	["gin"] = {
		label = "Gin",
		weight = 200,
		stack = true,
		close = true,
		description = "A bottle of Gin",
		client = {
			status = {
				thirst = 22,
			},
			image = "gin.png",
		}
	},

	["margarita"] = {
		label = "Margarita",
		weight = 200,
		stack = true,
		close = true,
		description = "Margarita",
		client = {
			status = {
				thirst = 47,
			},
			image = "margarita.png",
		}
	},

	["og-kush"] = {
		label = "Raw Og-Kush",
		weight = 450,
		stack = true,
		close = false,
		description = "Raw Og-Kush",
		client = {
			image = "weedogkush.png",
		}
	},

	["white_aliens2"] = {
		label = "Dual Stack White aliens",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "alien_white.png",
		}
	},

	["fabric"] = {
		label = "Fabric scrap",
		weight = 150,
		stack = true,
		close = true,
		description = "Looks like someone has thrown an old strip of fabric, must have bought too much?",
		client = {
			image = "fabric.png",
		}
	},

	["blankusb"] = {
		label = "Blank USB",
		weight = 0,
		stack = true,
		close = true,
		description = "Non-descript USB, wonder if there is anything on it?",
		client = {
			image = "blankusb.png",
		}
	},

	["bulletcasing"] = {
		label = "Bullet casing",
		weight = 400,
		stack = true,
		close = false,
		description = "A used bullet shell... Still in tact though... Interesting.",
		client = {
			image = "bullet_casing.png",
		}
	},

	["pistol4"] = {
		label = "Pistol Chassis",
		weight = 100,
		stack = true,
		close = false,
		description = "The chassis of a Walther P-99 Pistol.",
		client = {
			image = "pistol4.png",
		}
	},

	["carjack"] = {
		label = "Car Jack",
		weight = 1000,
		stack = true,
		close = true,
		description = "A battery used to power motor vehicles. Not sure if this has any charge left.",
		client = {
			image = "carjack.png",
		}
	},

	["blue_xtc3"] = {
		label = "Triple Stack Blue XTC",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "unstampedblue.png",
		}
	},

	["cranberry"] = {
		label = "Cranberry Juice",
		weight = 200,
		stack = true,
		close = true,
		description = "Cranberry Juice",
		client = {
			status = {
				thirst = 22,
			},
			image = "cranberry.png",
		}
	},

	["milkbucket"] = {
		label = "Milk Bucket",
		weight = 75,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "milkbucket.png",
		}
	},

	["blue_aliens4"] = {
		label = "Quad Stack blue aliens",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "alien_blue.png",
		}
	},

	["tequila"] = {
		label = "Tequila",
		weight = 200,
		stack = true,
		close = true,
		description = "Tequila",
		client = {
			status = {
				thirst = 49,
			},
			image = "tequila.png",
		}
	},

	["specialcookie"] = {
		label = "Special Cookie",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "specialcookie.png",
		}
	},

	["gardengloves"] = {
		label = "Gardening Gloves",
		weight = 500,
		stack = true,
		close = false,
		description = "A sturdy set of gardening gloves, used to avoid harm when gardening.",
		client = {
			image = "gardengloves.png",
		}
	},

	["teddy"] = {
		label = "Teddy bear",
		weight = 150,
		stack = true,
		close = true,
		description = "A teddy bear that appears to be unwanted, still has the tag on it and everything.",
		client = {
			image = "teddy.png",
		}
	},

	["amarone"] = {
		label = "Amarone",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 24,
			},
			image = "amarone.png",
		}
	},

	["lsd_vial_two"] = {
		label = "Slightly Better LSD Vial",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "lsd_vial_two.png",
		}
	},

	["blue_trolls4"] = {
		label = "Quad Stack blue trolls",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "troll_blue.png",
		}
	},

	["diavolabox"] = {
		label = "Boxed Diavola",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pizzabox.png",
		}
	},

	["art3"] = {
		label = "Fancy Kitty Art",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "art3.png",
		}
	},

	["beandonut"] = {
		label = "Donut",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 28,
			},
			image = "popdonut.png",
		}
	},

	["baggedcrackedstagetwo"] = {
		label = "Better Bag Of Crack",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "crackbag2.png",
		}
	},

	["eggsandwich"] = {
		label = "Eggs Sandwich",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 28,
			},
			image = "eggsandwich.png",
		}
	},

	["yogamat_blue"] = {
		label = "Blue Yoga Mat",
		weight = 1000,
		stack = true,
		close = true,
		description = "Did somebody say Yoga?",
		client = {
			image = "yogamat_blue.png",
		}
	},

	["greenpepper"] = {
		label = "Green Pepper",
		weight = 15,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "greenpepper.png",
		}
	},

	["weedscissors"] = {
		label = "Weed Scissors",
		weight = 1000,
		stack = true,
		close = true,
		description = "Weed Scissors",
		client = {
			image = "weedscissors.png",
		}
	},

	["hamburger"] = {
		label = "Hamburger",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 25,
			},
			image = "hamburger.png",
		}
	},

	["white_pl2"] = {
		label = "Dual Stack White pl",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "PL_white.png",
		}
	},

	["bakingsoda"] = {
		label = "Baking Soda",
		weight = 300,
		stack = true,
		close = false,
		description = "Household Baking Soda!",
		client = {
			image = "bakingsoda.png",
		}
	},

	["prescription_pad"] = {
		label = "Prescription Pad",
		weight = 10,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "prescriptionpad.png",
		}
	},

	["blue_xtc2"] = {
		label = "Dual Stack Blue XTC",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "unstampedblue.png",
		}
	},

	["salami"] = {
		label = "Salami",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "salami.png",
		}
	},

	["mozz"] = {
		label = "Mozzeralla",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "mozz.png",
		}
	},

	["barbera"] = {
		label = "Barbera D'Asti",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 25,
			},
			image = "barbera.png",
		}
	},

	["yogamat_red"] = {
		label = "Red Yoga Mat",
		weight = 1000,
		stack = true,
		close = true,
		description = "Did somebody say Yoga?",
		client = {
			image = "yogamat_red.png",
		}
	},

	["popdonut"] = {
		label = "Donut",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 27,
			},
			image = "popdonut.png",
		}
	},

	["art1"] = {
		label = "Kitty Sleeping Art",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "art1.png",
		}
	},

	["cargrill"] = {
		label = "Car Grill",
		weight = 850,
		stack = true,
		close = true,
		description = "Front grill chrome alloy from a motor vehicle.",
		client = {
			image = "cargrill.png",
		}
	},

	["housewhite"] = {
		label = "House White Wine",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 24,
			},
			image = "housewhite.png",
		}
	},

	["cooked_ham"] = {
		label = "Cooked Ham",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cooked_ham.png",
		}
	},

	["beancoffee"] = {
		label = "Coffe Beans",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 30,
			},
			image = "beancoffee.png",
		}
	},

	["payment_terminal"] = {
		label = "Payment Terminal",
		weight = 0,
		stack = false,
		close = true,
		description = "Payment Terminal to charge customers",
		client = {
			image = "payment_terminal.png",
		}
	},

	["art4"] = {
		label = "Presidential Kitty Art",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "art4.png",
		}
	},

	["heroinvialstagethree"] = {
		label = "Best Vial Of Heroin",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "heroinstagethree.png",
		}
	},

	["bartsheet"] = {
		label = "Bart Simpson Sheet",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "bartsheet.png",
		}
	},

	["blue_playboys"] = {
		label = "Single Stack blue Playboys",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "playboy_blue.png",
		}
	},

	["sausageeggs"] = {
		label = "Sausage and Eggs",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 26,
			},
			image = "sausageeggs.png",
		}
	},

	["red_cats4"] = {
		label = "Quad Stack red cats",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "kitty_red.png",
		}
	},

	["kamikaze"] = {
		label = "Kamikaze",
		weight = 200,
		stack = true,
		close = true,
		description = "Kamikase Cocktail",
		client = {
			status = {
				thirst = 29,
			},
			image = "kamikaze.png",
		}
	},

	["caffeagra"] = {
		label = "Caffeagra",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 20,
			},
			image = "caffeagra.png",
		}
	},

	["heroin_readystagetwo"] = {
		label = "Syringe Of Better Heroin",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "heroin_readystagetwo.png",
		}
	},

	["bellini"] = {
		label = "Bellini",
		weight = 200,
		stack = true,
		close = true,
		description = "Bellini",
		client = {
			status = {
				thirst = 42,
			},
			image = "bellini.png",
		}
	},

	["triplepress"] = {
		label = "Triple Pill Press",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pillpress.png",
		}
	},

	["fish"] = {
		label = "CatFish",
		weight = 200,
		stack = true,
		close = false,
		description = "A Catfish",
		client = {
			status = {
				hunger = 44,
			},
			image = "fish.png",
		}
	},

	["carradio"] = {
		label = "Car Radio",
		weight = 550,
		stack = true,
		close = true,
		description = "A radio equipped to play through changes in radio signals.",
		client = {
			image = "carradio.png",
		}
	},

	["raw_sausage"] = {
		label = "Raw Sausage",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "raw_sausage.png",
		}
	},

	["yinyangsheet"] = {
		label = "Yin and Yang Sheet",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "yinyangsheet.png",
		}
	},

	["wetcannabis"] = {
		label = "Wet Cannabis",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "wetcannabis.png",
		}
	},

	["xanaxbottle"] = {
		label = "Zany Bottle",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pillbottle.png",
		}
	},

	["heroincutstagethree"] = {
		label = "Best Cut Heroin",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "heroinpowderstagetwo.png",
		}
	},

	["vusliders"] = {
		label = "Sliders",
		weight = 200,
		stack = true,
		close = true,
		description = "Sliders",
		client = {
			status = {
				hunger = 40,
			},
			image = "sliders.png",
		}
	},

	["pinejuice"] = {
		label = "Pineapple Juice",
		weight = 200,
		stack = true,
		close = true,
		description = "Pineapple Juice",
		client = {
			status = {
				thirst = 50,
			},
			image = "pinejuice.png",
		}
	},

	["blunt"] = {
		label = "Blunts",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "blunt.png",
		}
	},

	["red_aliens2"] = {
		label = "Dual Stack red aliens",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "alien_red.png",
		}
	},

	["vicodinbottle"] = {
		label = "Vicie Bottle",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pillbottle.png",
		}
	},

	["gratefuldeadsheet"] = {
		label = "Grateful Dead Sheet",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "gratefuldeadsheet.png",
		}
	},

	["corncob"] = {
		label = "Corn Cob",
		weight = 15,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "corncob.png",
		}
	},

	["red_xtc2"] = {
		label = "Dual Stack Red XTC",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "unstampedred.png",
		}
	},

	["shrooms"] = {
		label = "Shrooms",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "shrooms.png",
		}
	},

	["white_trolls2"] = {
		label = "Dual Stack White trolls",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "troll_white.png",
		}
	},

	["drycannabis"] = {
		label = "Dry Cannabis",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "driedcannabis.png",
		}
	},

	["cooked_pork"] = {
		label = "Cooked Pork",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cooked_pork.png",
		}
	},

	["calamari"] = {
		label = "Calamari Marinara",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 28,
			},
			image = "calamari.png",
		}
	},

	["art7"] = {
		label = "Family Portait",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "art7.png",
		}
	},

	["chewyblunt"] = {
		label = "Chewy",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "blunt.png",
		}
	},

	["dextrobluntwrap"] = {
		label = "Dextro Blunt Wrap",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "dextrobluntwrap.png",
		}
	},

	["nachos"] = {
		label = "Nachos",
		weight = 200,
		stack = true,
		close = true,
		description = "A bag of Nachos",
		client = {
			status = {
				hunger = 49,
			},
			image = "nachos.png",
		}
	},

	["meat"] = {
		label = "Meat",
		weight = 200,
		stack = true,
		close = true,
		description = "A slab of Meat",
		client = {
			status = {
				hunger = 48,
			},
			image = "meat.png",
		}
	},

	["heroinlabkit"] = {
		label = "Heroin Lab Kit",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "labkit.png",
		}
	},

	["housered"] = {
		label = "House Red Wine",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 30,
			},
			image = "housered.png",
		}
	},

	["orange_playboys3"] = {
		label = "Triple Stack orange Playboys",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "playboy_orange.png",
		}
	},

	["pasta"] = {
		label = "Bag of Pasta",
		weight = 200,
		stack = true,
		close = false,
		description = "A bag of Pasta",
		client = {
			image = "pasta.png",
		}
	},

	["crackburner"] = {
		label = "Juke Burner",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "crackburner.png",
		}
	},

	["schnapps"] = {
		label = "Peach Schnapps",
		weight = 200,
		stack = true,
		close = true,
		description = "A bottle of Peach Schnapps",
		client = {
			status = {
				thirst = 27,
			},
			image = "schnapps.png",
		}
	},

	["cupofdextro"] = {
		label = "Dextro Cup",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cupofdextro.png",
		}
	},

	["amarettosour"] = {
		label = "Amaretto Sour",
		weight = 200,
		stack = true,
		close = true,
		description = "Amaretto Sour",
		client = {
			status = {
				thirst = 46,
			},
			image = "amarettosour.png",
		}
	},

	["empty_watering_can"] = {
		label = "Empty Watering Can",
		weight = 500,
		stack = false,
		close = true,
		description = "Empty watering can",
		client = {
			image = "watering_can.png",
		}
	},

	["morphine_prescription"] = {
		label = "Morphin Prescription",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "morphineprescription.png",
		}
	},

	["baconeggs"] = {
		label = "Bacon and Eggs",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 29,
			},
			image = "baconeggs.png",
		}
	},

	["margheritabox"] = {
		label = "Boxed Margherita",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pizzabox.png",
		}
	},

	["mdp2p"] = {
		label = "mdp2p",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "mdp2p.png",
		}
	},

	["white_cats3"] = {
		label = "Tricatse Stack White cats",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "kitty_white.png",
		}
	},

	["ham"] = {
		label = "Ham",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "ham.png",
		}
	},

	["hamcheesesandwich"] = {
		label = "Ham and Cheese Sandwich",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 22,
			},
			image = "hamcheesesandwich.png",
		}
	},

	["airfilter"] = {
		label = "Airfilter",
		weight = 550,
		stack = true,
		close = true,
		description = "A filter to avoid contimaination of airflow into the motor vehicle.",
		client = {
			image = "airfilter.png",
		}
	},

	["adderal"] = {
		label = "Madderal",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "adderal.png",
		}
	},

	["cokebaggystagethree"] = {
		label = "Bag of Great Coke",
		weight = 100,
		stack = true,
		close = true,
		description = "To get happy real quick",
		client = {
			image = "cocaine_baggystagethree.png",
		}
	},

	["loosecoke"] = {
		label = "loose coke",
		weight = 100,
		stack = true,
		close = true,
		description = "Paper made specifically for encasing and smoking tobacco or cannabis.",
		client = {
			image = "loosecoke.png",
		}
	},

	["plant_tub"] = {
		label = "Plant Tub",
		weight = 1000,
		stack = true,
		close = false,
		description = "Pot for planting plants",
		client = {
			image = "plant_tub.png",
		}
	},

	["cokestagetwo"] = {
		label = "Better Raw Cocaine",
		weight = 100,
		stack = true,
		close = false,
		description = "Processed cocaine",
		client = {
			image = "cokestagetwo.png",
		}
	},

	["marinarabox"] = {
		label = "Boxed Marinara",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pizzabox.png",
		}
	},

	["weed_white-widow_seed"] = {
		label = "White Widow Seed",
		weight = 0,
		stack = true,
		close = false,
		description = "A weed seed of White Widow",
		client = {
			image = "weed_seed.png",
		}
	},

	["white_xtc"] = {
		label = "Single Stack White XTC",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "unstampedwhite.png",
		}
	},

	["bart_tabs"] = {
		label = "Bart Simpson Tabs",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "bart_tabs.png",
		}
	},

	["red_xtc"] = {
		label = "Single Stack Red XTC",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "unstampedred.png",
		}
	},

	["baggedcracked"] = {
		label = "Bag Of Crack",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "crackbag1.png",
		}
	},

	["spores"] = {
		label = "spores",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "shrooms.png",
		}
	},

	["dusche"] = {
		label = "Dusche Gold",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 41,
			},
			image = "dusche.png",
		}
	},

	["sbullet"] = {
		label = "Silver Bullet",
		weight = 200,
		stack = true,
		close = true,
		description = "Silver Bullet Cocktail",
		client = {
			status = {
				thirst = 27,
			},
			image = "sbullet.png",
		}
	},

	["watermelon"] = {
		label = "WaterMelon Slice",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 27,
				thirst = 22,
			},
			image = "watermelon.png",
		}
	},

	["weedplant_seedf"] = {
		label = "Female Weed Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "Female Weed Seed",
		client = {
			image = "weedplant_seed.png",
		}
	},

	["yogamat_black"] = {
		label = "Black Yoga Mat",
		weight = 1000,
		stack = true,
		close = true,
		description = "Did somebody say Yoga?",
		client = {
			image = "yogamat_black.png",
		}
	},

	["carrim"] = {
		label = "Sports Rim",
		weight = 850,
		stack = true,
		close = true,
		description = "A chrome rim alloy.",
		client = {
			image = "carrim.png",
		}
	},

	["chillypepper"] = {
		label = "Chilly Pepper",
		weight = 15,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "chillypepper.png",
		}
	},

	["tomato"] = {
		label = "tomato",
		weight = 15,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "tomato.png",
		}
	},

	["orange_xtc4"] = {
		label = "Quad Stack Orange XTC",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "unstampedorange.png",
		}
	},

	["iflag"] = {
		label = "Irish Flag",
		weight = 200,
		stack = true,
		close = true,
		description = "Irish Flag Cocktail",
		client = {
			status = {
				thirst = 22,
			},
			image = "iflag.png",
		}
	},

	["canofcorn"] = {
		label = "Can Of Corn",
		weight = 15,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "canofcorn.png",
		}
	},

	["mdlean"] = {
		label = "Sizzurup",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "Sizzurup.png",
		}
	},

	["mdreddextro"] = {
		label = "Red Dextro",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "reddextro.png",
		}
	},

	["orange_xtc3"] = {
		label = "Triple Stack Orange XTC",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "unstampedorange.png",
		}
	},

	["woowoo"] = {
		label = "Woo Woo",
		weight = 200,
		stack = true,
		close = true,
		description = "Woowoo Cocktail",
		client = {
			status = {
				thirst = 27,
			},
			image = "woowoo.png",
		}
	},

	["cokebaggystagetwo"] = {
		label = "Bag of Good Coke",
		weight = 100,
		stack = true,
		close = true,
		description = "To get happy real quick",
		client = {
			image = "cocaine_baggystagetwo.png",
		}
	},

	["lsd_vial_three"] = {
		label = "Good LSD",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "lsd_vial_three.png",
		}
	},

	["diavola"] = {
		label = "Diavola",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 26,
			},
			image = "diavola.png",
		}
	},

	["donut"] = {
		label = "Neko Donut",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 42,
			},
			image = "catdonut.png",
		}
	},

	["red_trolls4"] = {
		label = "Quad Stack red trolls",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "troll_red.png",
		}
	},

	["shroom"] = {
		label = "Mushroom",
		weight = 40,
		stack = true,
		close = false,
		description = "A strange looking mushroom, smells kind of funky?",
		client = {
			image = "mushroom.png",
		}
	},

	["tiramisu"] = {
		label = "Tiramisu",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 29,
			},
			image = "tiramisu.png",
		}
	},

	["crackrockstagetwo"] = {
		label = "Better Crack Rock",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "crackrock2.png",
		}
	},

	["veggiewrap"] = {
		label = "Veggie Wrap",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 28,
			},
			image = "veggiewrap.png",
		}
	},

	["carhood"] = {
		label = "Car Hood",
		weight = 1450,
		stack = true,
		close = true,
		description = "The hood component of a motor vehicle.",
		client = {
			image = "carhood.png",
		}
	},

	["pineapplesheet"] = {
		label = "Pineapple Sheet",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pineapplesheet.png",
		}
	},

	["orange_trolls4"] = {
		label = "Quad Stack orange trolls",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "troll_orange.png",
		}
	},

	["bigfruit"] = {
		label = "The Big Fruit",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 30,
			},
			image = "bigfruit.png",
		}
	},

	["crackrockstagethree"] = {
		label = "Best Crack Rock",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "crackrock3.png",
		}
	},

	["orange_aliens"] = {
		label = "Single Stack orange aliens",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "alien_orange.png",
		}
	},

	["lsdlabkit"] = {
		label = "LSD Mixing Table",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "labkit.png",
		}
	},

	["pistol3"] = {
		label = "Slide",
		weight = 100,
		stack = true,
		close = false,
		description = "The grip of a Walther P-99 Pistol.",
		client = {
			image = "pistol3.png",
		}
	},

	["tab_paper"] = {
		label = "Tab Paper",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "tab_paper.png",
		}
	},

	["vegetariana"] = {
		label = "Vegetariana",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 27,
			},
			image = "vegetariana.png",
		}
	},

	["toastbacon"] = {
		label = "Bacon and Toast",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 27,
			},
			image = "toastbacon.png",
		}
	},

	["leanbluntwrap"] = {
		label = "Lean Blunt Wrap",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "leanbluntwrap.png",
		}
	},

	["pizzadough"] = {
		label = "Pizza Dough",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "pizzadough.png",
		}
	},

	["rhinohorn"] = {
		label = "Rhino Horn",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "rhinohorn.png",
		}
	},

	["weedplant_package"] = {
		label = "Suspicious Package",
		weight = 10000,
		stack = false,
		close = false,
		description = "Suspicious Package",
		client = {
			image = "weedplant_package.png",
		}
	},

	["heroinstagethree"] = {
		label = "Best Heroin",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "heroinpowderstagethree.png",
		}
	},

	["heroin"] = {
		label = "Weak Heroin Powder",
		weight = 500,
		stack = true,
		close = false,
		description = "Really addictive depressant...",
		client = {
			image = "loosecoke.png",
		}
	},

	["orange_playboys"] = {
		label = "Single Stack orange Playboys",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "playboy_orange.png",
		}
	},

	["blue_aliens2"] = {
		label = "Dual Stack blue aliens",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "alien_blue.png",
		}
	},

	["tomatopaste"] = {
		label = "tomato Paste",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "tomatopaste.png",
		}
	},

	["vutacos"] = {
		label = "Tacos",
		weight = 200,
		stack = true,
		close = true,
		description = "Tacos",
		client = {
			status = {
				hunger = 46,
			},
			image = "tacos.png",
		}
	},

	["pisswasser3"] = {
		label = "Pißwasser Pale Ale",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 42,
			},
			image = "pisswaser3.png",
		}
	},

	["3060gpu"] = {
		label = "RTX 3060",
		weight = 0,
		stack = false,
		close = true,
		description = "IDK Man! It's so expensive.",
		client = {
			image = "3060.png",
		}
	},

	["ecola"] = {
		label = "eCola",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 26,
			},
			image = "ecola.png",
		}
	},

	["white_playboys"] = {
		label = "Single Stack White Playboys",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "playboy_white.png",
		}
	},

	["ak-47"] = {
		label = "Raw AK-47",
		weight = 450,
		stack = true,
		close = false,
		description = "Raw AK-47",
		client = {
			image = "weedak47.png",
		}
	},

	["pineapple_tabs"] = {
		label = "Pineapple Tabs",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pineapple_tabs.png",
		}
	},

	["diethylamide"] = {
		label = "Diethylamide",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "diethylamide.png",
		}
	},

	["loosecokestagethree"] = {
		label = "Purest Loose Coke",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "loosecokestagethree.png",
		}
	},

	["logger"] = {
		label = "Logger Beer",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 46,
			},
			image = "logger.png",
		}
	},

	["pig_leather"] = {
		label = "Pig Skin",
		weight = 50,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pig_leather.png",
		}
	},

	["white_pl3"] = {
		label = "Triple Stack White pl",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "PL_white.png",
		}
	},

	["driedmescaline"] = {
		label = "Mescaline",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "driedmescaline.png",
		}
	},

	["emsbag"] = {
		label = "Medical Bag",
		weight = 150,
		stack = true,
		close = true,
		description = "Useful bag made for the medics",
		client = {
			image = "emsbag.png",
		}
	},

	["visa"] = {
		label = "Visa Card",
		weight = 0,
		stack = false,
		close = false,
		description = "Visa can be used via ATM",
		client = {
			image = "visacard.png",
		}
	},

	["scotch"] = {
		label = "Scotch",
		weight = 200,
		stack = true,
		close = true,
		description = "A bottle of Scotch",
		client = {
			status = {
				thirst = 28,
			},
			image = "scotch.png",
		}
	},

	["skunk"] = {
		label = "Raw Skunk",
		weight = 450,
		stack = true,
		close = false,
		description = "Raw Skunk",
		client = {
			image = "weedskunk.png",
		}
	},

	["red_trolls2"] = {
		label = "Dual Stack red trolls",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "troll_red.png",
		}
	},

	["art5"] = {
		label = "Obi Jesus Painting",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "art5.png",
		}
	},

	["cheesesandwich"] = {
		label = "Cheese Sandwich",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 21,
			},
			image = "cheesesandwich.png",
		}
	},

	["screwdriver"] = {
		label = "Screwdriver",
		weight = 100,
		stack = true,
		close = false,
		description = "A flathead screwdriver. I mean sure the handle is a bit worn but this thing probably works.",
		client = {
			image = "screwdriver.png",
		}
	},

	["art6"] = {
		label = "Merp Kitty Art",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "art6.png",
		}
	},

	["orange_xtc2"] = {
		label = "Dual Stack Orange XTC",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "unstampedorange.png",
		}
	},

	["white_playboys2"] = {
		label = "Dual Stack White Playboys",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "playboy_white.png",
		}
	},

	["white_trolls3"] = {
		label = "Tritrollse Stack White trolls",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "troll_white.png",
		}
	},

	["red_playboys"] = {
		label = "Single Stack red Playboys",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "playboy_red.png",
		}
	},

	["mdwoods"] = {
		label = "MDWOODS",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "mdwoods.png",
		}
	},

	["white_cats4"] = {
		label = "Quad Stack White cats",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "kitty_white.png",
		}
	},

	["steakburger"] = {
		label = "Steak Burger",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 27,
			},
			image = "steakburger.png",
		}
	},

	["popicecream"] = {
		label = "Ice Cream",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 21,
			},
			image = "popicecream.png",
		}
	},

	["lsdburner"] = {
		label = "SideKick Burner",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "lsdburner.png",
		}
	},

	["ambeer"] = {
		label = "AM Beer",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 41,
			},
			image = "ambeer.png",
		}
	},

	["4090gpu"] = {
		label = "RTX 4090",
		weight = 0,
		stack = false,
		close = true,
		description = "Is it just me or this looks kinda thicc?",
		client = {
			image = "4090.png",
		}
	},

	["cosmopolitan"] = {
		label = "Cosmopolitan",
		weight = 200,
		stack = true,
		close = true,
		description = "Cosmopolitan",
		client = {
			status = {
				thirst = 47,
			},
			image = "cosmopolitan.png",
		}
	},

	["shitgpu"] = {
		label = "A trash gpu",
		weight = 0,
		stack = false,
		close = true,
		description = "Just look at it, what do you expect!",
		client = {
			image = "shitgpu.png",
		}
	},

	["rustynails"] = {
		label = "Rusted Nails",
		weight = 150,
		stack = true,
		close = true,
		description = "A collection of nails that have seen better days... Perhaps they can be cleaned?",
		client = {
			image = "rustynails.png",
		}
	},

	["margherita"] = {
		label = "Margherita",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 25,
			},
			image = "margherita.png",
		}
	},

	["wallet"] = {
		label = "Old Wallet",
		weight = 350,
		stack = true,
		close = false,
		description = "Feels like leather... Clearly been used and abused though...",
		client = {
			image = "wallet.png",
		}
	},

	["blue_xtc4"] = {
		label = "Quad Stack Blue XTC",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "unstampedblue.png",
		}
	},

	["vegetarianabox"] = {
		label = "Boxed Vegetariana",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pizzabox.png",
		}
	},

	["heroinburner"] = {
		label = "Razr Burner",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "heroinburner.png",
		}
	},

	["yinyang_tabs"] = {
		label = "Yin and Yang Tabs",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "yinyang_tabs.png",
		}
	},

	["tissuebox"] = {
		label = "Tissue Box",
		weight = 100,
		stack = true,
		close = true,
		description = "An old box of tissues... Wonderful...",
		client = {
			image = "tissuebox.png",
		}
	},

	["white_pl4"] = {
		label = "Quad Stack White pl",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "PL_white.png",
		}
	},

	["basil"] = {
		label = "Basil",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "basil.png",
		}
	},

	["cannabis"] = {
		label = "Raw Cannabis",
		weight = 450,
		stack = true,
		close = false,
		description = "Raw Cannabis",
		client = {
			image = "cannabis.png",
		}
	},

	["pisswasser"] = {
		label = "Pißwasser",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 50,
			},
			image = "pisswaser1.png",
		}
	},

	["crackrock"] = {
		label = "Crack Rock",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "crackrock1.png",
		}
	},

	["hotsauce"] = {
		label = "Hot Sauce",
		weight = 15,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "hotsauce.png",
		}
	},

	["crisps"] = {
		label = "Crisps",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 29,
			},
			image = "chips.png",
		}
	},

	["chickenbreast"] = {
		label = "Chicken Breast",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 29,
			},
			image = "chickenbreast.png",
		}
	},

	["blue_playboys2"] = {
		label = "Dual Stack blue Playboys",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "playboy_blue.png",
		}
	},

	["grapes"] = {
		label = "Grapes",
		weight = 15,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "grapes.png",
		}
	},

	["butane"] = {
		label = "Butane",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "butane.png",
		}
	},

	["blue_pl4"] = {
		label = "Quad Stack blue pl",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "PL_blue.png",
		}
	},

	["sodacan"] = {
		label = "Soda Can",
		weight = 500,
		stack = true,
		close = true,
		description = "What was once a refreshing beverage is now just a tin can...",
		client = {
			image = "crushedcan.png",
		}
	},

	["keya"] = {
		label = "Labkey A",
		weight = 0,
		stack = false,
		close = false,
		description = "Labkey A..",
		client = {
			image = "keya.png",
		}
	},

	["prosciuttiobox"] = {
		label = "Boxed Prosciuttio E Funghi",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pizzabox.png",
		}
	},

	["jimeggs"] = {
		label = "Eggs",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 27,
			},
			image = "jimeggs.png",
		}
	},

	["smiley_tabs"] = {
		label = "Smiley tabs",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "smiley_tabs.png",
		}
	},

	["lsd_vial_five"] = {
		label = "Amazing LSD",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "lsd_vial_five.png",
		}
	},

	["slicedpie"] = {
		label = "Slice of Pie",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "slicedpie.png",
		}
	},

	["full_watering_can"] = {
		label = "Full Watering Can",
		weight = 1000,
		stack = false,
		close = false,
		description = "Watering can filled with water for watering plants",
		client = {
			image = "watering_can.png",
		}
	},

	["heroincut"] = {
		label = "Cut Heroin",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "heroinpowder.png",
		}
	},

	["needle"] = {
		label = "Syringe",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "syringe.png",
		}
	},

	["orange_xtc"] = {
		label = "Single Stack Orange XTC",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "unstampedorange.png",
		}
	},

	["weedgrinder"] = {
		label = "Weed Grinder",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "weedgrinder.png",
		}
	},

	["cupoflean"] = {
		label = "Lean Cup",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cupoflean.png",
		}
	},

	["olives"] = {
		label = "Olives",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "olives.png",
		}
	},

	["singlepress"] = {
		label = "Single Pill Press",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pillpress.png",
		}
	},

	["loosecokestagetwo"] = {
		label = "More Pure Loose Coke",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "loosecokestagetwo.png",
		}
	},

	["white_pl"] = {
		label = "Single Stack White pl",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "PL_white.png",
		}
	},

	["checkbook"] = {
		label = "Check Book",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "checkbook.png",
		}
	},

	["xanax"] = {
		label = "Zany",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "xanax.png",
		}
	},

	["cokeburner"] = {
		label = "Nokia Burner",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cokeburner.png",
		}
	},

	["leanblunts"] = {
		label = "Lean Blunts",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "leanblunts.png",
		}
	},

	["specialchocolate"] = {
		label = "Special Chocolate",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "specialchocolate.png",
		}
	},

	["oystershell"] = {
		label = "Oyster Shell",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "oyster.png",
		}
	},

	["lsd_one_vial"] = {
		label = "Weakest LSD Vial",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "lsd_one_vial.png",
		}
	},

	["red_aliens3"] = {
		label = "Triple Stack red aliens",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "alien_red.png",
		}
	},

	["rawpumpkin"] = {
		label = "Raw Pumpkin",
		weight = 50,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "raw_pumpkin.png",
		}
	},

	["orange_pl4"] = {
		label = "Quad Stack orange pl",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "PL_orange.png",
		}
	},

	["1060gpu"] = {
		label = "gtx 1060",
		weight = 0,
		stack = false,
		close = true,
		description = "A good upgrade if you are broke.",
		client = {
			image = "1060.png",
		}
	},

	["blue_trolls3"] = {
		label = "Tritrollse Stack blue trolls",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "troll_blue.png",
		}
	},

	["orange_cats2"] = {
		label = "Dual Stack orange cats",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "kitty_orange.png",
		}
	},

	["mddesktop"] = {
		label = "Desktop",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "mddesktop.png",
		}
	},

	["wildcherry_tabs"] = {
		label = "Wild Cherry Tabs",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "wildcherry_tabs.png",
		}
	},

	["wd40"] = {
		label = "WD-40",
		weight = 250,
		stack = false,
		close = false,
		description = "A chemical compound with multiple purposes, including the removal of corrosion.",
		client = {
			image = "wd40.png",
		}
	},

	["pinacolada"] = {
		label = "Pina Colada",
		weight = 200,
		stack = true,
		close = true,
		description = "Pine Colada",
		client = {
			status = {
				thirst = 41,
			},
			image = "pinacolada.png",
		}
	},

	["xanax_prescription"] = {
		label = "Zany Prescription",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "xanaxprescription.png",
		}
	},

	["baggedcrackedstagethree"] = {
		label = "Best Bag Of Crack",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "crackbag3.png",
		}
	},

	["shovel"] = {
		label = "Shovel",
		weight = 1,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "shovel.png",
		}
	},

	["meatball"] = {
		label = "Homemade Meatballs",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 27,
			},
			image = "meatball.png",
		}
	},

	["bkamikaze"] = {
		label = "Blue Kamikaze",
		weight = 200,
		stack = true,
		close = true,
		description = "Blue Kamikaze Cocktail",
		client = {
			status = {
				thirst = 27,
			},
			image = "bkamikaze.png",
		}
	},

	["methbags"] = {
		label = "Meth",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "methbags.png",
		}
	},

	["midori"] = {
		label = "Midori",
		weight = 200,
		stack = true,
		close = true,
		description = "Midori",
		client = {
			status = {
				thirst = 46,
			},
			image = "midori.png",
		}
	},

	["thermalpast"] = {
		label = "Thermal past",
		weight = 0,
		stack = false,
		close = true,
		description = "A thermalpast To keep your cpu chiling.",
		client = {
			image = "thermalpast.png",
		}
	},

	["pescatore"] = {
		label = "Pescatore",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 24,
			},
			image = "pescatore.png",
		}
	},

	["leancup"] = {
		label = "Empty Cup",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "leancup.png",
		}
	},

	["isosafrole"] = {
		label = "isosafrole",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "isosafrole.png",
		}
	},

	["emptybottle"] = {
		label = "Empty bottle",
		weight = 300,
		stack = true,
		close = false,
		description = "Makes a satisfying crunch when you press on it, not a single drop left...",
		client = {
			image = "emptybottle.png",
		}
	},

	["red_pl3"] = {
		label = "Triple Stack red pl",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "PL_red.png",
		}
	},

	["grilledwrap"] = {
		label = "Grilled Wrap",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 22,
			},
			image = "grilledwrap.png",
		}
	},

	["soybeans"] = {
		label = "Soy Beans",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "soybeans.png",
		}
	},

	["cooked_sausage"] = {
		label = "Cooked Sausage",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cooked_sausage.png",
		}
	},

	["blue_cats"] = {
		label = "Single Stack blue cats",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "kitty_blue.png",
		}
	},

	["ranchwrap"] = {
		label = "Ranch Wrap",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 22,
			},
			image = "ranchwrap.png",
		}
	},

	["morphinebottle"] = {
		label = "Morphin Bottle",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pillbottle.png",
		}
	},

	["strawmargarita"] = {
		label = "Strawberry Margarita",
		weight = 200,
		stack = true,
		close = true,
		description = "Starberry Margarita",
		client = {
			status = {
				thirst = 40,
			},
			image = "strawmargarita.png",
		}
	},

	["jimsausages"] = {
		label = "Sausages",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 23,
			},
			image = "jimsausages.png",
		}
	},

	["prosecco"] = {
		label = "Prosecco",
		weight = 200,
		stack = true,
		close = true,
		description = "Prosecco",
		client = {
			status = {
				thirst = 49,
			},
			image = "prosecco.png",
		}
	},

	["raw_xtc"] = {
		label = "Raw XTC",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "raw_xtc.png",
		}
	},

	["cardoor"] = {
		label = "Car Door",
		weight = 1650,
		stack = true,
		close = true,
		description = "A door which has been stripped off a motor vehicle.",
		client = {
			image = "cardoor.png",
		}
	},

	["art2"] = {
		label = "Wide Eye Kitty Art",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "art2.png",
		}
	},

	["raw_bacon"] = {
		label = "Raw Bacon",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "raw_bacon.png",
		}
	},

	["red_trolls"] = {
		label = "Single Stack red trolls",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "troll_red.png",
		}
	},

	["chewinggum"] = {
		label = "Old pack of gum",
		weight = 120,
		stack = true,
		close = true,
		description = "An old looking pack of chewing gum... Wouldn't trust it...",
		client = {
			image = "chewinggum.png",
		}
	},

	["white_playboys4"] = {
		label = "Quad Stack White Playboys",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "playboy_white.png",
		}
	},

	["red_xtc4"] = {
		label = "Quad Stack Red XTC",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "unstampedred.png",
		}
	},

	["alla"] = {
		label = "Alla Vodka",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 24,
			},
			image = "alla.png",
		}
	},

	["red_pl"] = {
		label = "Single Stack red pl",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "PL_red.png",
		}
	},

	["pistol2"] = {
		label = "Slide Assembly",
		weight = 100,
		stack = true,
		close = false,
		description = "The frame of a Walther P-99 Pistol.",
		client = {
			image = "pistol2.png",
		}
	},

	["cubasil"] = {
		label = "Cucumber Basil",
		weight = 200,
		stack = true,
		close = false,
		description = "Hand full of Cucumber and Basil",
		client = {
			status = {
				hunger = 43,
			},
			image = "cubasil.png",
		}
	},

	["highnoon"] = {
		label = "Highnoon",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 21,
			},
			image = "highnoon.png",
		}
	},

	["dolceto"] = {
		label = "Dolcetto D'Alba",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 28,
			},
			image = "dolceto.png",
		}
	},

	["nplate"] = {
		label = "Nachos Plate",
		weight = 200,
		stack = true,
		close = true,
		description = "A plate of nachos and cheese",
		client = {
			status = {
				hunger = 50,
			},
			image = "nplate.png",
		}
	},

	["casino_goldchip"] = {
		label = "Casino Chip",
		weight = 0,
		stack = true,
		close = false,
		description = "Diamond Casino Chip",
		client = {
			image = "casino_goldchip.png",
		}
	},

	["cactusbulb"] = {
		label = "Cactus Bulb",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cactusbulb.png",
		}
	},

	["sangria"] = {
		label = "Sangria",
		weight = 200,
		stack = true,
		close = true,
		description = "Sangria",
		client = {
			status = {
				thirst = 43,
			},
			image = "sangria.png",
		}
	},

	["brokencup"] = {
		label = "Broken Cup",
		weight = 500,
		stack = true,
		close = true,
		description = "A nice piece of glasswear... or it would have been if the handle wasn't cracked.",
		client = {
			image = "brokencup.png",
		}
	},

	["casino_vip"] = {
		label = "V.I.P Membership",
		weight = 500,
		stack = false,
		close = false,
		description = "Diamond Casino V.I.P Card",
		client = {
			image = "casino_vip.png",
		}
	},

	["white_playboys3"] = {
		label = "Triple Stack White Playboys",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "playboy_white.png",
		}
	},

	["peach"] = {
		label = "Peach",
		weight = 200,
		stack = true,
		close = true,
		description = "A peach",
		client = {
			status = {
				hunger = 45,
			},
			image = "peach.png",
		}
	},

	["radiator"] = {
		label = "Car Radiator",
		weight = 10000,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "car_radiator.png",
		}
	},

	["blue_trolls2"] = {
		label = "Dual Stack blue trolls",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "troll_blue.png",
		}
	},

	["gelato"] = {
		label = "Choc and Vanilla Gelato",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 23,
			},
			image = "gelato.png",
		}
	},

	["blue_pl3"] = {
		label = "Triple Stack blue pl",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "PL_blue.png",
		}
	},

	["carrotcake"] = {
		label = "Carrot Cake",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 21,
			},
			image = "carrotcake.png",
		}
	},

	["cheesecake"] = {
		label = "Cheese Cake",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 28,
			},
			image = "cheesecake.png",
		}
	},

	["1080gpu"] = {
		label = "gtx 1080",
		weight = 0,
		stack = false,
		close = true,
		description = "It must be good since it got 3 fans right?",
		client = {
			image = "1080.png",
		}
	},

	["orange_pl3"] = {
		label = "Triple Stack orange pl",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "PL_orange.png",
		}
	},

	["raw_pork"] = {
		label = "Raw Pork",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "raw_pork.png",
		}
	},

	["rosso"] = {
		label = "Rosso Del Montalcino",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 22,
			},
			image = "rosso.png",
		}
	},

	["dirtylsdlabkit"] = {
		label = "Dirty LSD Mixing Table",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "labkit_dirty.png",
		}
	},

	["cooked_bacon"] = {
		label = "Cooked Bacon",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cooked_bacon.png",
		}
	},

	["red_aliens4"] = {
		label = "Quad Stack red aliens",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "alien_red.png",
		}
	},

	["poppyresin"] = {
		label = "Poppy resin",
		weight = 2000,
		stack = true,
		close = false,
		description = "It sticks to your fingers when you handle it.",
		client = {
			image = "poppyresin.png",
		}
	},

	["white_cats"] = {
		label = "Single Stack White cats",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "kitty_white.png",
		}
	},

	["orange_cats3"] = {
		label = "Tricatse Stack orange cats",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "kitty_orange.png",
		}
	},

	["icream"] = {
		label = "Irish Cream",
		weight = 200,
		stack = true,
		close = true,
		description = "A bottle of Irish Cream Liquer",
		client = {
			status = {
				thirst = 23,
			},
			image = "icream.png",
		}
	},

	["red_cats2"] = {
		label = "Dual Stack red cats",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "kitty_red.png",
		}
	},

	["medfruits"] = {
		label = "Fresh Fruit Medly",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 22,
			},
			image = "medfruits.png",
		}
	},

	["ephedrine"] = {
		label = "Ephedrine",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "ephedrine.png",
		}
	},

	["b52"] = {
		label = "B-52",
		weight = 200,
		stack = true,
		close = true,
		description = "B-52 Cocktail",
		client = {
			status = {
				thirst = 22,
			},
			image = "b52.png",
		}
	},

	["car_wheel"] = {
		label = "Car Wheel",
		weight = 10000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "car_wheel.png",
		}
	},

	["actiontoy"] = {
		label = "Action figure",
		weight = 350,
		stack = true,
		close = false,
		description = "An old toy, looks kinda neat - might be valuable?",
		client = {
			image = "actionfigure.png",
		}
	},

	["flusher"] = {
		label = "The Flusher",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 24,
			},
			image = "flusher.png",
		}
	},

	["orange_pl"] = {
		label = "Single Stack orange pl",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "PL_orange.png",
		}
	},

	["lsd_vial_four"] = {
		label = "Really Good LSD",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "lsd_vial_four.png",
		}
	},

	["blue_cats4"] = {
		label = "Quad Stack blue cats",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "kitty_blue.png",
		}
	},

	["blue_xtc"] = {
		label = "Single Stack Blue XTC",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "unstampedblue.png",
		}
	},

	["orange_aliens3"] = {
		label = "Triple Stack orange aliens",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "alien_orange.png",
		}
	},

	["voodoo"] = {
		label = "Voodoo",
		weight = 200,
		stack = true,
		close = true,
		description = "Voodoo Cocktail",
		client = {
			status = {
				thirst = 22,
			},
			image = "voodoo.png",
		}
	},

	["white_xtc3"] = {
		label = "Triple Stack White XTC",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "unstampedwhite.png",
		}
	},

	["mdbutter"] = {
		label = "Butter",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "butter.png",
		}
	},

	["wildcherrysheet"] = {
		label = "Wild Cherry Sheet",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "wildcherrysheet.png",
		}
	},

	["coca_leaf"] = {
		label = "Cocaine leaves",
		weight = 1500,
		stack = true,
		close = false,
		description = "Cocaine leaves that must be processed !",
		client = {
			image = "coca_leaf.png",
		}
	},

	["cokestagethree"] = {
		label = "Best Raw Cocaine",
		weight = 100,
		stack = true,
		close = false,
		description = "Processed cocaine",
		client = {
			image = "cokestagethree.png",
		}
	},

	["capricciosabox"] = {
		label = "Boxed Capriccosa",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pizzabox.png",
		}
	},

	["chocolate"] = {
		label = "Chocolate",
		weight = 200,
		stack = true,
		close = false,
		description = "Chocolate Bar",
		client = {
			status = {
				hunger = 25,
			},
			image = "chocolate.png",
		}
	},

	["casino_member"] = {
		label = "Casino Membership",
		weight = 500,
		stack = false,
		close = false,
		description = "Diamond Casino Member Card",
		client = {
			image = "casino_member.png",
		}
	},

	["1050gpu"] = {
		label = "gtx 1050",
		weight = 0,
		stack = false,
		close = true,
		description = "It does the job for its price.",
		client = {
			image = "1050.png",
		}
	},

	["orange_cats"] = {
		label = "Single Stack orange cats",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "kitty_orange.png",
		}
	},

	["blue_aliens3"] = {
		label = "Triple Stack blue aliens",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "alien_blue.png",
		}
	},

	["red_aliens"] = {
		label = "Single Stack red aliens",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "alien_red.png",
		}
	},

	["wood"] = {
		label = "Wood",
		weight = 1,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "wood.png",
		}
	},

	["blowtorch"] = {
		label = "Blowtorch",
		weight = 3500,
		stack = false,
		close = false,
		description = "A high propane instrument used for welding and other things...",
		client = {
			image = "blowtorch.png",
		}
	},

	["red_playboys3"] = {
		label = "Triple Stack red Playboys",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "playboy_red.png",
		}
	},

	["xtcburner"] = {
		label = "ENV Burner",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "xtcburner.png",
		}
	},

	["dextroblunt"] = {
		label = "Dextro Blunt Wrap",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "dextroblunt.png",
		}
	},

	["orange_cats4"] = {
		label = "Quad Stack orange cats",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "kitty_orange.png",
		}
	},

	["dabrig"] = {
		label = "Dab Rig",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "dabrig2.png",
		}
	},

	["mdspeakers"] = {
		label = "Speakers",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "speaker.png",
		}
	},

	["mdmonitor"] = {
		label = "Monitor",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "mansionlaptop.png",
		}
	},

	["pistol1"] = {
		label = "Pistol Grip",
		weight = 100,
		stack = true,
		close = false,
		description = "The barrel of a Walther P-99 Pistol.",
		client = {
			image = "pistol1.png",
		}
	},

	["white_aliens4"] = {
		label = "Quad Stack White aliens",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "alien_white.png",
		}
	},

	["yogamat_pro"] = {
		label = "ProLaps Yoga Mat",
		weight = 1000,
		stack = true,
		close = true,
		description = "Did somebody say Yoga?",
		client = {
			image = "yogamat_pro.png",
		}
	},

	["fuelcap"] = {
		label = "Fuel Cap",
		weight = 160,
		stack = true,
		close = true,
		description = "Used to keep the fuel in the tank, could use a spare couple of these...",
		client = {
			image = "fuelcap.png",
		}
	},

	["cheeseburger"] = {
		label = "Cheese Burger",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 25,
			},
			image = "cheeseburger.png",
		}
	},

	["ecolalight"] = {
		label = "eCola Light",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 25,
			},
			image = "ecolalight.png",
		}
	},

	["sprunklight"] = {
		label = "Sprunk Light",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 29,
			},
			image = "sprunklight.png",
		}
	},

	["red_cats"] = {
		label = "Single Stack red cats",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "kitty_red.png",
		}
	},

	["red_playboys2"] = {
		label = "Dual Stack red Playboys",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "playboy_red.png",
		}
	},

	["2080gpu"] = {
		label = "RTX 2080",
		weight = 0,
		stack = false,
		close = true,
		description = "WOOW!! A new look! Then This is the one.",
		client = {
			image = "2080.png",
		}
	},

	["gunkaccino"] = {
		label = "The Gunkaccino",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 30,
			},
			image = "gunkaccino.png",
		}
	},

	["mintleaf"] = {
		label = "Mint",
		weight = 200,
		stack = true,
		close = false,
		description = "Mint Leaves",
		client = {
			status = {
				hunger = 45,
			},
			image = "mint.png",
		}
	},

	["orange_aliens4"] = {
		label = "Quad Stack orange aliens",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "alien_orange.png",
		}
	},

	["cappucc"] = {
		label = "Cappuccinotini",
		weight = 200,
		stack = true,
		close = true,
		description = "Cappuccinotini Cocktail",
		client = {
			status = {
				thirst = 20,
			},
			image = "cappucc.png",
		}
	},

	["orange_trolls3"] = {
		label = "Tritrollse Stack orange trolls",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "troll_orange.png",
		}
	},

	["apple_juice"] = {
		label = "Apple Juice",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "apple_juice.png",
		}
	},

	["weedplant_weed"] = {
		label = "Dried Weed",
		weight = 100,
		stack = true,
		close = false,
		description = "Weed ready for packaging",
		client = {
			image = "weedplant_weed.png",
		}
	},

	["heist_papers"] = {
		label = "Vehicle Papers",
		weight = 0,
		stack = false,
		close = true,
		description = "Delivery documents.",
		client = {
			image = "heist_papers.png",
		}
	},

	["pizzabase"] = {
		label = "Pizza Base",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "base2.png",
		}
	},

	["chocpudding"] = {
		label = "Chocolate Pudding",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 27,
			},
			image = "chocpudding.png",
		}
	},

	["amaretto"] = {
		label = "Amaretto",
		weight = 200,
		stack = true,
		close = true,
		description = "A bottle of Amaretto",
		client = {
			status = {
				thirst = 25,
			},
			image = "amaretto.png",
		}
	},

	["butanetorch"] = {
		label = "Butane Torch",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "butanetorch.png",
		}
	},

	["shroombaggy"] = {
		label = "Empty Bag",
		weight = 100,
		stack = true,
		close = false,
		description = "A small plastic bag, cheap and easy to store perishables temporarily.",
		client = {
			image = "shroombaggy.png",
		}
	},

	["weedplant_seedm"] = {
		label = "Male Weed Seed",
		weight = 0,
		stack = true,
		close = false,
		description = "Male Weed Seed",
		client = {
			image = "weedplant_seed.png",
		}
	},

	["gearshift"] = {
		label = "Gearshift",
		weight = 450,
		stack = true,
		close = true,
		description = "A manual car stick shifter.",
		client = {
			image = "gearshift.png",
		}
	},

	["cow_leather"] = {
		label = "Cow Skin",
		weight = 50,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cow_leather.png",
		}
	},

	["weedplant_packedweed"] = {
		label = "Packed Weed",
		weight = 100,
		stack = false,
		close = false,
		description = "Weed ready for sale",
		client = {
			image = "weedplant_weed.png",
		}
	},

	["cannabutter"] = {
		label = "Canna-Butter",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cannabutter.png",
		}
	},

	["lime"] = {
		label = "Lime",
		weight = 200,
		stack = true,
		close = false,
		description = "A Lime.",
		client = {
			image = "lime.png",
		}
	},

	["orange_aliens2"] = {
		label = "Dual Stack orange aliens",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "alien_orange.png",
		}
	},

	["white_xtc4"] = {
		label = "Quad Stack White XTC",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "unstampedwhite.png",
		}
	},

	["lysergic_acid"] = {
		label = "Lysergic Acid",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "lysergic_acid.png",
		}
	},

	["heroin_ready"] = {
		label = "Syringe Of Heroin",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "heroin_ready.png",
		}
	},

	["orange_trolls"] = {
		label = "Single Stack orange trolls",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "troll_orange.png",
		}
	},

	["mdlaptop"] = {
		label = "Slow Laptop",
		weight = 2500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "laptop.png",
		}
	},

	["heroinvial"] = {
		label = "Vial Of Heroin",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "heroin.png",
		}
	},
}