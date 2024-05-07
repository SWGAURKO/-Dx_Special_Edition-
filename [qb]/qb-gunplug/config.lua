Config = {
    ["Inv-Link"] = "ox_inventory/web/images/", --Set this to your inventory Directory
    ["Weapons"] = {
        ["weapon_pistol"] = { --Item Name
            hash = "weapon_microsmg", --Item Name
            label = "Micro SMG", --Item Label shown inside the menu
            materials = {
                [1] = {
                    item = "iron", --Item Name
                    amount = 75, --Item Amount Needed
                },
                [2] = {
                    item = "steel", --Item Name
                    amount = 45, --Item Amount Needed
                },
                [3] = {
                    item = "copper", --Item Name
                    amount = 25, --Item Amount Needed
                },
                [4] = {
                    item = "plastic", --Item Name
                    amount = 35, --Item Amount Needed
                },
                [5] = {
                    item = "rubber", --Item Name
                    amount = 15, --Item Amount Needed
                },
            }
        },
        ["weapon_combatpistol"] = {
            hash = "weapon_combatpistol",
            label = "Combat Pistol",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 75,
                },
                [2] = {
                    item = "steel",
                    amount = 75,
                },
                [3] = {
                    item = "copper",
                    amount = 75,
                },
                [4] = {
                    item = "plastic",
                    amount = 40,
                },
                [5] = {
                    item = "rubber",
                    amount = 25,
                },
            }
        },
        ["weapon_pumpshotgun"] = {
            hash = "weapon_pumpshotgun",
            label = "Pump Shotgun",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 45,
                },
                [2] = {
                    item = "steel",
                    amount = 65,
                },
                [3] = {
                    item = "copper",
                    amount = 45,
                },
                [4] = {
                    item = "plastic",
                    amount = 55,
                },
                [5] = {
                    item = "rubber",
                    amount = 65,
                },
            }
        },
        ["weapon_revolver"] = {
            hash = "weapon_revolver",
            label = "Revolver",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 100,
                },
                [2] = {
                    item = "steel",
                    amount = 100,
                },
                [3] = {
                    item = "copper",
                    amount = 75,
                },
                [4] = {
                    item = "plastic",
                    amount = 60,
                },
                [5] = {
                    item = "rubber",
                    amount = 50,
                },
            }
        },
        ["weapon_pistol50"] = {
            hash = "weapon_pistol50",
            label = "50Cal Pistol",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 150,
                },
                [2] = {
                    item = "steel",
                    amount = 125,
                },
                [3] = {
                    item = "copper",
                    amount = 100,
                },
                [4] = {
                    item = "plastic",
                    amount = 75,
                },
                [5] = {
                    item = "rubber",
                    amount = 65,
                },
            }
        },
        ["weapon_assaultrifle"] = {
            hash = "weapon_assaultrifle",
            label = "Assault Rifle",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 125,
                },
                [2] = {
                    item = "steel",
                    amount = 95,
                },
                [3] = {
                    item = "copper",
                    amount = 85,
                },
                [4] = {
                    item = "plastic",
                    amount = 65,
                },
                [5] = {
                    item = "rubber",
                    amount = 75,
                },
            }
        },
    },
    ["Ammo"] = {
        ["pistol_ammo"] = {
            hash = "pistol_ammo",
            label = "Pistol Ammo",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 15,
                },
                [2] = {
                    item = "steel",
                    amount = 15,
                },
                [3] = {
                    item = "copper",
                    amount = 15,
                },
            }
        },
        ["rifle_ammo"] = {
            hash = "rifle_ammo",
            label = "Rifle Ammo",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 25,
                },
                [2] = {
                    item = "steel",
                    amount = 20,
                },
                [3] = {
                    item = "copper",
                    amount = 20,
                },
            }
        },
        ["shotgun_ammo"] = {
            hash = "shotgun_ammo",
            label = "Shotgun Ammo",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 35,
                },
                [2] = {
                    item = "steel",
                    amount = 15,
                },
                [3] = {
                    item = "copper",
                    amount = 5,
                },
            }
        },
        ["smg_ammo"] = {
            hash = "smg_ammo",
            label = "SMG Ammo",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 15,
                },
                [2] = {
                    item = "steel",
                    amount = 10,
                },
                [3] = {
                    item = "copper",
                    amount = 10,
                },
            }
        }
    },
    ["Attachment"] = {
        ["pistol_extendedclip"] = {
            hash = "pistol_extendedclip",
            label = "Pistol Extended Clip",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 25,
                },
                [2] = {
                    item = "steel",
                    amount = 25,
                },
                [3] = {
                    item = "copper",
                    amount = 15,
                },
                [4] = {
                    item = "plastic",
                    amount = 10,
                },
            }
        },
        ["pistol_flashlight"] = {
            hash = "pistol_flashlight",
            label = "Pistol Flaslight",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 25,
                },
                [2] = {
                    item = "steel",
                    amount = 25,
                },
                [3] = {
                    item = "copper",
                    amount = 15,
                },
                [4] = {
                    item = "plastic",
                    amount = 10,
                },
            }
        },
        ["pistol_suppressor"] = {
            hash = "pistol_suppressor",
            label = "Pistol Supressor",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 25,
                },
                [2] = {
                    item = "steel",
                    amount = 25,
                },
                [3] = {
                    item = "copper",
                    amount = 15,
                },
                [4] = {
                    item = "plastic",
                    amount = 10,
                },
            }
        },
        ["combatpistol_extendedclip"] = {
            hash = "combatpistol_extendedclip",
            label = "Combat Extended Clip",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 25,
                },
                [2] = {
                    item = "steel",
                    amount = 25,
                },
                [3] = {
                    item = "copper",
                    amount = 15,
                },
                [4] = {
                    item = "plastic",
                    amount = 10,
                },
            }
        },
        ["snspistol_extendedclip"] = {
            hash = "snspistol_extendedclip",
            label = "SNS Extended Clip",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 25,
                },
                [2] = {
                    item = "steel",
                    amount = 25,
                },
                [3] = {
                    item = "copper",
                    amount = 15,
                },
                [4] = {
                    item = "plastic",
                    amount = 10,
                },
            }
        },
        ["heavypistol_extendedclip"] = {
            hash = "heavypistol_extendedclip",
            label = "Heavy Extended Clip",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 25,
                },
                [2] = {
                    item = "steel",
                    amount = 25,
                },
                [3] = {
                    item = "copper",
                    amount = 15,
                },
                [4] = {
                    item = "plastic",
                    amount = 10,
                },
            }
        },
        ["pistol50_extendedclip"] = {
            hash = "pistol50_extendedclip",
            label = "50CAL Extended Clip",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 25,
                },
                [2] = {
                    item = "steel",
                    amount = 25,
                },
                [3] = {
                    item = "copper",
                    amount = 15,
                },
                [4] = {
                    item = "plastic",
                    amount = 10,
                },
            }
        },
        ["appistol_extendedclip"] = {
            hash = "appistol_extendedclip",
            label = "AP Extended Clip",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 25,
                },
                [2] = {
                    item = "steel",
                    amount = 25,
                },
                [3] = {
                    item = "copper",
                    amount = 15,
                },
                [4] = {
                    item = "plastic",
                    amount = 10,
                },
            }
        },
    },
    ["Tint"] = {
        ["weapontint_black"] = {
            hash = "weapontint_black",
            label = "Black Weapon Tint",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 25,
                },
                [2] = {
                    item = "steel",
                    amount = 10,
                },
                [3] = {
                    item = "copper",
                    amount = 5,
                },
            }
        },
        ["weapontint_green"] = {
            hash = "weapontint_green",
            label = "Black Weapon Tint",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 25,
                },
                [2] = {
                    item = "steel",
                    amount = 10,
                },
                [3] = {
                    item = "copper",
                    amount = 5,
                },
            }
        },
        ["weapontint_gold"] = {
            hash = "weapontint_gold",
            label = "Black Weapon Tint",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 25,
                },
                [2] = {
                    item = "steel",
                    amount = 10,
                },
                [3] = {
                    item = "copper",
                    amount = 5,
                },
            }
        },
        ["weapontint_pink"] = {
            hash = "weapontint_pink",
            label = "Black Weapon Tint",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 25,
                },
                [2] = {
                    item = "steel",
                    amount = 10,
                },
                [3] = {
                    item = "copper",
                    amount = 5,
                },
            }
        },
        ["weapontint_army"] = {
            hash = "weapontint_army",
            label = "Black Weapon Tint",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 25,
                },
                [2] = {
                    item = "steel",
                    amount = 10,
                },
                [3] = {
                    item = "copper",
                    amount = 5,
                },
            }
        },
        ["weapontint_orange"] = {
            hash = "weapontint_orange",
            label = "Black Weapon Tint",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 25,
                },
                [2] = {
                    item = "steel",
                    amount = 10,
                },
                [3] = {
                    item = "copper",
                    amount = 5,
                },
            }
        },
        ["weapontint_plat"] = {  
            hash = "weapontint_plat",
            label = "Black Weapon Tint",
            materials = {
                [1] = {
                    item = "iron",
                    amount = 25,
                },
                [2] = {
                    item = "steel",
                    amount = 10,
                },
                [3] = {
                    item = "copper",
                    amount = 5,
                },
            }
        }
    },
     ["GangLocation"] = {
    },
     ["JobLocation"] = {
    },
    ["PublicLocation"] = {
        ["craft"] = {
		    ["free"] = {   -- Location Name
                ["loc"] = vector3(586.95, -3276.75, 6.00),  --Polyzone for crafting
				["length"] = 0.5,
				["width"] = 0.5,
                ["name"] = "free", -- Location Name 
				["heading"] = 325,
				["minZ"] = 4,
				["maxZ"] = 8,
			},  -- Add More Locations below this
        },
    }
}