function Load(name)
	local resourceName = GetCurrentResourceName()
	local chunk = LoadResourceFile(resourceName, ('data/%s.lua'):format(name))
	if chunk then
		local err
		chunk, err = load(chunk, ('@@%s/data/%s.lua'):format(resourceName, name), 't')
		if err then
			error(('\n^1 %s'):format(err), 0)
		end
		return chunk()
	end
end

local Allowrefuel = false
local AllowElectricRefuel = false
-------------------------------------------------------------------------------
-- Settings
-------------------------------------------------------------------------------

Config = {}

-- It's possible to interact with entities through walls so this should be low
Config.MaxDistance = 7.0

-- Enable debug options
Config.Debug = false

-- Supported values: true, false
Config.Standalone = false

-- Enable outlines around the entity you're looking at
Config.EnableOutline = false

-- Whether to have the target as a toggle or not
Config.Toggle = false

-- Draw a Sprite on the center of a PolyZone to hint where it's located
Config.DrawSprite = false

-- The default distance to draw the Sprite
Config.DrawDistance = 10.0

-- The color of the sprite in rgb, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.DrawColor = {255, 255, 255, 255}

-- The color of the sprite in rgb when the PolyZone is targeted, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.SuccessDrawColor = {30, 144, 255, 255}

-- The color of the outline in rgb, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.OutlineColor = {255, 255, 255, 255}

-- Enable default options (Toggling vehicle doors)
Config.EnableDefaultOptions = true

-- Disable the target eye whilst being in a vehicle
Config.DisableInVehicle = false

-- Key to open the target eye, here you can find all the names: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
Config.OpenKey = 'LMENU' -- Left Alt

-- Control for key press detection on the context menu, it's the Right Mouse Button by default, controls are found here https://docs.fivem.net/docs/game-references/controls/
Config.MenuControlKey = 238

-------------------------------------------------------------------------------
-- Target Configs
-------------------------------------------------------------------------------

-- These are all empty for you to fill in, refer to the .md files for help in filling these in

Config.CircleZones = {

}

Config.BoxZones = {

}

Config.PolyZones = {

}

Config.TargetBones = {

}

Config.TargetModels = {
    ["drinks"] = {
        models = {
            "prop_vend_coffe_01",
            "prop_vend_soda_01",
            "prop_vend_soda_02",
        },
        options = {
            {
                type = "client",
                event = "codem-market:OpenMarketUI",
                icon = "fa-wine-glass",
                label = "Open Drinks",
            },
        },
        distance = 1.5,
    },
	["trashsearch"] = {
        models = {
			-1096777189,--normal small
			666561306,--big
			1437508529,--small circle
			-1426008804,--small open circle
			-228596739,--open small circle
			161465839,--werid blue small circle
			651101403,--open medium circle
			218085040,
			682791951,
			1511880420,

        },
        options = {
            {
                type = "client",
                event = "qb-trashsearch:client:searchtrash",
                icon = "fas fa-pencil-ruler",
                label = "Search Trash",
            },
        },
        distance = 2.1
    },
	["pedgarage"] = {
        models = {
            "ig_djtalignazio",
        },
        options = {
            {
                type = "client",
                event = "police:client:opengaragemenu",
                icon = "fas fa-car",
                label = "Open Garage",
                job = "police",
            },
        },
        distance = 4.0,
    },
	["pdgarage2"] = {
        models = {
            "ig_djsolmike",
        },
        options = {
            {
                type = "client",
                event = "police:client:opengaragemenu2",
                icon = "fas fa-car",
                label = "Open Garage",
                job = "police",
            },
        },
        distance = 4.0,
    },
	["pdcloth"] = {
        models = {
            "s_f_y_cop_01",
        },
        options = {
            {
                type = "client",
                event = "qb-clothing:client:openMenu",
                icon = "fas fa-tshirt",
                label = "Open Clothing",
                job = "police",
            },
        },
        distance = 4.0,
    },
    ["emscloth"] = {
        models = {
            "a_f_y_business_04",
        },
        options = {

            {
                type = "client",
                event = "qb-clothing:client:openMenu",
                icon = "fas fa-tshirt",
                label = "Open Clothing",
                job = "ambulance",
            },
        },
        distance = 4.0,
    },
	["mechaniccloth"] = {
        models = {
            "csb_agatha",
        },
        options = {

            {
                type = "client",
                event = "qb-clothing:client:openMenu",
                icon = "fas fa-tshirt",
                label = "Open Clothing",
                job = "mechanic",
            },
        },
        distance = 4.0,
    },
}

Config.GlobalPedOptions = {

}

Config.GlobalVehicleOptions = {

}

Config.GlobalObjectOptions = {

}

Config.GlobalPlayerOptions = {
    options = {
        { 
            type = "client",
            event = "police:client:CuffPlayerSoft",
            icon = 'fas fa-circle',
            label = 'Soft Cuff',
            job = 'police',
        },
        { 
            type = "client",
            event = "police:client:CuffPlayer",
            icon = 'fas fa-circle',
            label = 'Hard Cuff',
            job = 'police',
            item = 'handcuffs',
        },
        
        { 
            type = "client", 
            event = "police:client:EscortPlayer", 
            icon = 'fas fa-circle', 
            label = 'Escort',
        },
        { 
            type = "client", 
            event = "police:client:RobPlayer", 
            icon = 'fas fa-circle', 
            label = 'Rob Player',
        },
        { 
            type = "client", 
            event = "police:client:KidnapPlayer", 
            icon = 'fas fa-circle', 
            label = 'Kidnap Player',
        },
    },
      distance = 2.5,

}

Config.Peds = {
	[1] = {
        model = 'ig_gustavo',
        coords = vector4(2403.68, 3127.83, 48.15, 248.33),
        currentpednumber = 0,
        freeze = true,
        blockevents = true,
        invincible = true,
		minusOne = true,
    },
	[2] = {
        model = 'ig_djtalignazio', -- Police Garage
        coords = vector4(647.2527, 8.0115, 82.7861, 159.5431),
        currentpednumber = 0,
        freeze = true,
        blockevents = true,
        invincible = true,
		minusOne = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
    },
	[3] = {
        model = 'ig_djsolmike', -- Police Garage
        coords = vector4(-452.4786, 6001.7007, 31.3405, 84.7745),
        currentpednumber = 0,
        freeze = true,
        blockevents = true,
        invincible = true,
		minusOne = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
    },
	[4] = {
        model = 's_f_y_cop_01', -- Police clothing
        coords = vector4(611.7117, 17.2855, 82.7419, 119.5784),
        currentpednumber = 0,
        freeze = true,
        blockevents = true,
        invincible = true,
		minusOne = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
    },
	[5] = {
        model = 'a_f_y_business_04', -- Ems clothing
        coords = vector4(-444.7273, -310.4434, 34.9106, 229.5558),
        currentpednumber = 0,
        freeze = true,
        blockevents = true,
        invincible = true,
		minusOne = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
    },
	[6] = {
        model = 'csb_agatha', -- Mechanic clothing
        coords = vector4(-599.6970, -914.2761, 23.8866, 137.1270),
        currentpednumber = 0,
        freeze = true,
        blockevents = true,
        invincible = true,
		minusOne = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
    },
    [7] = {
        model = 's_m_m_doctor_01', -- Ems Checking
        coords = vector4(-435.3456, -324.1190, 34.9108, 161.9421),
        currentpednumber = 0,
        freeze = true,
        blockevents = true,
        invincible = true,
		minusOne = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
    },

}

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------
local function JobCheck() return true end
local function GangCheck() return true end
local function JobTypeCheck() return true end
local function ItemCheck() return true end
local function CitizenCheck() return true end

CreateThread(function()
	local state = GetResourceState('qb-core')
	if state ~= 'missing' then
		local timeout = 0
		while state ~= 'started' and timeout <= 100 do
			timeout += 1
			state = GetResourceState('qb-core')
			Wait(0)
		end
		Config.Standalone = false
	end
	if Config.Standalone then
		local firstSpawn = false
		local event = AddEventHandler('playerSpawned', function()
			SpawnPeds()
			firstSpawn = true
		end)
		-- Remove event after it has been triggered
		while true do
			if firstSpawn then
				RemoveEventHandler(event)
				break
			end
			Wait(1000)
		end
	else
		local QBCore = exports['qb-core']:GetCoreObject()
		local PlayerData = QBCore.Functions.GetPlayerData()

		ItemCheck = QBCore.Functions.HasItem

		JobCheck = function(job)
			if type(job) == 'table' then
				job = job[PlayerData.job.name]
				if job and PlayerData.job.grade.level >= job then
					return true
				end
			elseif job == 'all' or job == PlayerData.job.name then
				return true
			end
			return false
		end

		JobTypeCheck = function(jobType)
			if type(jobType) == 'table' then
				jobType = jobType[PlayerData.job.type]
				if jobType then
					return true
				end
			elseif jobType == 'all' or jobType == PlayerData.job.type then
				return true
			end
			return false
		end

		GangCheck = function(gang)
			if type(gang) == 'table' then
				gang = gang[PlayerData.gang.name]
				if gang and PlayerData.gang.grade.level >= gang then
					return true
				end
			elseif gang == 'all' or gang == PlayerData.gang.name then
				return true
			end
			return false
		end

		CitizenCheck = function(citizenid)
			return citizenid == PlayerData.citizenid or citizenid[PlayerData.citizenid]
		end

		RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
			PlayerData = QBCore.Functions.GetPlayerData()
			SpawnPeds()
		end)

		RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
			PlayerData = {}
			DeletePeds()
		end)

		RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
			PlayerData.job = JobInfo
		end)

		RegisterNetEvent('QBCore:Client:OnGangUpdate', function(GangInfo)
			PlayerData.gang = GangInfo
		end)

		RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
			PlayerData = val
		end)
	end
end)

function CheckOptions(data, entity, distance)
	if distance and data.distance and distance > data.distance then return false end
	if data.job and not JobCheck(data.job) then return false end
	if data.excludejob and JobCheck(data.excludejob) then return false end
	if data.jobType and not JobTypeCheck(data.jobType) then return false end
	if data.excludejobType and JobTypeCheck(data.excludejobType) then return false end
	if data.gang and not GangCheck(data.gang) then return false end
	if data.excludegang and GangCheck(data.excludegang) then return false end
	if data.item and not ItemCheck(data.item) then return false end
	if data.citizenid and not CitizenCheck(data.citizenid) then return false end
	if data.canInteract and not data.canInteract(entity, distance, data) then return false end
	return true
end
