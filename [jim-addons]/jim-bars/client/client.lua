local QBCore = exports['qb-core']:GetCoreObject()

PlayerJob = {}
local Targets = {}
local Props = {}
local onDuty = false
local alcoholCount = 0

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function() QBCore.Functions.GetPlayerData(function(PlayerData) PlayerJob = PlayerData.job PlayerGang = PlayerData.gang end) end)
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo) PlayerJob = JobInfo onDuty = PlayerJob.onduty end)
RegisterNetEvent('QBCore:Client:SetDuty', function(duty) onDuty = duty end)
RegisterNetEvent('QBCore:Client:OnGangUpdate', function(GangInfo) PlayerGang = GangInfo end)

AddEventHandler('onResourceStart', function(r) if GetCurrentResourceName() ~= r then return end
	QBCore.Functions.GetPlayerData(function(PlayerData) PlayerJob = PlayerData.job PlayerGang = PlayerData.gang onDuty = PlayerJob.onduty end)
end)

CreateThread(function()
	for p, v in pairs(Config.Locations) do
		-- Base Variables
		local job = nil
		local gang = nil
		local bossroles = {}
		local gangroles = {}
		local loc = v

		if (QBCore.Shared.Jobs[loc.job] or QBCore.Shared.Gangs[loc.gang]) and loc.zoneEnable then
			if loc.job then --Grab Boss role from the qb-core jobs.lua to make bossmenu accessible
				job = loc.job
				for grade in pairs(QBCore.Shared.Jobs[job].grades) do
					if QBCore.Shared.Jobs[job].grades[grade].isboss then
						if bossroles[job] then
							if bossroles[job] > tonumber(grade) then bossroles[job] = tonumber(grade) end
						else bossroles[job] = tonumber(grade) end
					end
				end
			elseif loc.gang then --Grab Boss role from the qb-core gangs.lua to make gangmenu accessible
				gang = loc.gang
				for grade in pairs(QBCore.Shared.Gangs[gang].grades) do
					if QBCore.Shared.Gangs[gang].grades[grade].isboss then
						if gangroles[gang] then
							if gangroles[gang] > tonumber(grade) then gangroles[gang] = tonumber(grade) end
						else gangroles[gang] = tonumber(grade)	end
					end
				end
			end

			--Make PolyZone from location
			if loc.autoClockOut then
				JobLocation = PolyZone:Create(loc.zones, { name = loc.label, debugPoly = Config.Debug })
				JobLocation:onPlayerInOut(function(isPointInside) if not isPointInside and onDuty and PlayerJob.name == loc.job then TriggerServerEvent("QBCore:ToggleDuty") end end)
			end
			--Make Blip from location
			if loc.Blip.showBlip then makeBlip({ coords = loc.Blip.coords, sprite = loc.Blip.sprite, col = loc.Blip.color, name = loc.label}) end

			--Built-in DJ Booth location creation
			local Booth = loc.Booth
			if loc.Booth.enableBooth then
				Targets["BarBooth"..p] =
					exports['qb-target']:AddCircleZone("BarBooth"..p, Booth.coords, 0.75, {name="BarBooth"..p, debugPoly=Config.Debug, useZ=true, },
						{ options = { { event = "jim-bars:client:playMusic", icon = "fab fa-youtube", label = Loc[Config.Lan].target["dj_booth"], job = job, gang = gang, zone = p, logo = loc.logo }, }, distance = 2.0 })
			end

			--Target Setup
			local Tar = loc.Targets
			if loc.Targets.Clockin then
				for k, v in pairs(loc.Targets.Clockin) do
					local options = {}
					if gang then
						options[#options+1] = { event = "qb-gangmenu:client:OpenMenu", icon = "fas fa-list", label = Loc[Config.Lan].target["gang_menu"], gang = gangroles }
					else
						options[#options+1] = { type = "server", event = "QBCore:ToggleDuty", icon = "fas fa-user-check", label = Loc[Config.Lan].target["duty"], job = job, }
						options[#options+1] = { event = "qb-bossmenu:client:OpenMenu", icon = "fas fa-list", label = Loc[Config.Lan].target["boss_menu"], job = bossroles, }
					end
					Targets[loc.label.."Clockin"..k] =
					exports['qb-target']:AddBoxZone(loc.label.."Clockin"..k, v.coords, v.l, v.w, { name=loc.label.."Clockin"..k, heading = v.h, debugPoly=Config.Debug, minZ=v.bottom, maxZ=v.top },
						{ options = options, distance = 2.0 })
					if v.prop then
						if not Props[loc.label.."Clockin"..k] then
							Props[loc.label.."Clockin"..k] = makeProp({prop = `prop_laptop_jimmy`, coords = vector4(v.coords.x, v.coords.y, v.coords.z, v.h)}, 1, 0)
						end
					end
				end
			end
			--Hand Washing Sinks
			if loc.Targets.HandWash then
				for k, v in pairs(loc.Targets.HandWash) do
					Targets[loc.label.."HandWash"..k] =
					exports['qb-target']:AddBoxZone(loc.label.."HandWash"..k, v.coords, v.l, v.w, { name=loc.label.."HandWash"..k, heading = v.h, debugPoly=Config.Debug, minZ=v.bottom, maxZ=v.top },
							{ options = { { event = "jim-bars:washHands", icon = "fas fa-hand-holding-water", label = Loc[Config.Lan].target["wash_hands"], coords = v.coords }, }, distance = 1.5 })
				end
			end
			--Shop Locations (Usually a Kitchen Fridge or Under counter Bar fridge)
			if loc.Targets.Shop then
				for k, v in pairs(loc.Targets.Shop) do
					Targets[loc.label.."Shop"..k] =
					exports['qb-target']:AddBoxZone(loc.label.."Shop"..k, v.coords, v.l, v.w, { name=loc.label.."Shop"..k, heading = v.h, debugPoly=Config.Debug, minZ=v.bottom, maxZ=v.top },
						{ options = { {  event = "jim-bars:Shop", icon = "fas fa-archive", label = Loc[Config.Lan].target["open_fridge"], job = job, gang = gang, shop = Config.DrinkItems, coords = v.coords }, }, distance = 1.5 })
				end
			end
			-- Cocktail preparation locations
			if loc.Targets.Cocktails then
				for k, v in pairs(loc.Targets.Cocktails) do
					Targets[loc.label.."Cocktails"..k] =
					exports['qb-target']:AddBoxZone(loc.label.."Cocktails"..k, v.coords, v.l, v.w, { name=loc.label.."Cocktails"..k, heading = v.h, debugPoly=Config.Debug, minZ=v.bottom, maxZ=v.top },
						{ options = { { event = "jim-bars:Crafting", icon = "fas fa-cocktail", label = Loc[Config.Lan].target["prep_cocktail"], job = job, gang = gang, craftable = Crafting.Cocktails, header = Loc[Config.Lan].menu["cocktail_menu"], coords = v.coords }, }, distance = 2.0 })
					if v.prop then
						if not Props[loc.label.."Cocktails"..k] then
							Props[loc.label.."Cocktails"..k] = makeProp({prop = `v_res_mchopboard`, coords = vector4(v.coords.x, v.coords.y, v.coords.z, v.h)}, 1, 0)
						end
					end
				end
			end
			-- Beer tap locations
			if loc.Targets.Tap then
				for k, v in pairs(loc.Targets.Tap) do
					Targets[loc.label.."Tap"..k] =
					exports['qb-target']:AddBoxZone(loc.label.."Tap"..k, v.coords, v.l, v.w, { name=loc.label.."Tap"..k, heading = v.h, debugPoly=Config.Debug, minZ=v.bottom, maxZ=v.top },
						{ options = { { event = "jim-bars:Crafting", icon = "fas fa-cocktail", label = Loc[Config.Lan].target["beer_tap"], job = job, gang = gang, craftable = Crafting.Beer, header = Loc[Config.Lan].menu["beer_menu"], coords = v.coords }, }, distance = 2.0 })
					if v.prop then
						if not Props[loc.label.."Tap"..k] then
							Props[loc.label.."Tap"..k] = makeProp({prop = `prop_bar_pump_06`, coords = vector4(v.coords.x, v.coords.y, v.coords.z, v.h)}, 1, 0)
						end
					end
				end
			end
			-- Simple coffee location
			if loc.Targets.Coffee then
				for k, v in pairs(loc.Targets.Coffee) do
					Targets[loc.label.."Coffee"..k] =
					exports['qb-target']:AddBoxZone(loc.label.."Coffee"..k, v.coords, v.l, v.w, { name=loc.label.."Coffee"..k, heading = v.h, debugPoly=Config.Debug, minZ=v.bottom, maxZ=v.top },
						{ options = { { event = "jim-bars:Crafting", icon = "fas fa-mug-hot", label = Loc[Config.Lan].target["pour_coffee"], job = job, gang = gang, craftable = Crafting.Coffee, header = Loc[Config.Lan].menu["coffee_menu"], coords = v.coords }, }, distance = 2.0 })
					if v.prop then
						if not Props[loc.label.."Coffee"..k] then
							Props[loc.label.."Coffee"..k] = makeProp({prop = `prop_coffee_mac_02`, coords = vector4(v.coords.x, v.coords.y, v.coords.z, v.h)}, 1, 0)
						end
					end
				end
			end
			-- Simple Tray location
			if loc.Targets.Tray then
				for k, v in pairs(loc.Targets.Tray) do
					Targets[loc.label.."Tray"..k] =
					exports['qb-target']:AddBoxZone(loc.label.."Tray"..k, v.coords, v.l, v.w, { name=loc.label.."Tray"..k, heading = v.h, debugPoly=Config.Debug, minZ=v.bottom, maxZ=v.top },
						{ options = { { event = "jim-bars:Stash", icon = "fas fa-hamburger", label = Loc[Config.Lan].target["open_counter"], stash = loc.label.."Tray"..tonumber(k+1), coords = v.coords }, }, distance = 2.5 })
					if v.prop then
						if not Props[loc.label.."tray"..k] then
							Props[loc.label.."tray"..k] = makeProp({prop = `prop_food_tray_01`, coords = vector4(v.coords.x, v.coords.y, v.coords.z, v.h)}, 1, 0)
						end
					end
				end
			end
			-- Simple Cash Register location
			if loc.Targets.Payment then
				for k, v in pairs(loc.Targets.Payment) do
					Targets[loc.label.."Payment"..k] =
					exports['qb-target']:AddBoxZone(loc.label.."Payment"..k, v.coords, v.l, v.w, { name=loc.label.."Payment"..k, heading = v.h, debugPoly=Config.Debug, minZ=v.bottom, maxZ=v.top },
						{ options = { { event = "jim-payments:client:Charge", icon = "fas fa-credit-card", label = Loc[Config.Lan].target["charge"], job = job, gang = gang,
										img = "<center><p><img src="..loc.logo.." width=225px></p>"
									} }, distance = 2.0 })
					if v.prop then
						if not Props[loc.label.."Payment"..k] then
							Props[loc.label.."Payment"..k] = makeProp({prop = `prop_till_03`, coords = vector4(v.coords.x, v.coords.y, v.coords.z, v.h+90)}, 1, 0)
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent('jim-bars:washHands', function(data)
	lookEnt(data.coords)
    QBCore.Functions.Progressbar('washing_hands', Loc[Config.Lan].progressbar["progress_washing"], 5000, false, false, {
        disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
		{ animDict = "mp_arresting", anim = "a_uncuff", flags = 8, }, {}, {}, function()
		triggerNotify(nil, Loc[Config.Lan].success["washed_hands"], 'success')
    end, function()
        TriggerEvent('inventory:client:busy:status', false)
		triggerNotify(nil, Loc[Config.Lan].error["cancel"], 'error')
    end, data.icon)
end)

RegisterNetEvent('jim-bars:Stash', function(data) lookEnt(data.coords) TriggerServerEvent("inventory:server:OpenInventory", "stash", data.stash) TriggerEvent("inventory:client:SetCurrentStash", data.stash) end)

RegisterNetEvent('jim-bars:Shop', function(data)
	if (data.job and PlayerJob.name ~= data.job) and (data.gang and PlayerGang.name ~= data.gang) then return end
	lookEnt(data.coords)
	local event = "inventory:server:OpenInventory"
	if Config.JimShop then event = "jim-shops:ShopOpen" end
	TriggerServerEvent(event, "shop", data.job or data.gang, data.shop)

end)

RegisterNetEvent('jim-bars:Crafting:MakeItem', function(data)
	local bartext = ""
	for i = 1, #Crafting.Cocktails do
		for k, v in pairs(Crafting.Cocktails[i]) do
			if data.item == k then
				bartext = Loc[Config.Lan].progressbar["progress_mix"]
				bartime = 7000
				animDictNow = "anim@heists@prison_heiststation@cop_reactions"
				animNow = "cop_b_idle"
			end
		end
	end
	for i = 1, #Crafting.Beer do
		for k, v in pairs(Crafting.Beer[i]) do
			if data.item == k then
				bartext = Loc[Config.Lan].progressbar["progress_pour"]
				bartime = 3000
				animDictNow = "mp_ped_interaction"
				animNow = "handshake_guy_a"
			end
		end
	end
	if data.item == "coffee" then
		bartext = Loc[Config.Lan].progressbar["progress_pour"]
		bartime = 3000
		animDictNow = "mp_ped_interaction"
		animNow = "handshake_guy_a"
	end
	QBCore.Functions.Progressbar('making_food', bartext..QBCore.Shared.Items[data.item].label, bartime, false, true, { disableMovement = true, disableCarMovement = false, disableMouse = false, disableCombat = false, },
	{ animDict = animDictNow, anim = animNow, flags = 8, },
	{}, {}, function()
		TriggerServerEvent('jim-bars:Crafting:GetItem', data.item, data.craft)
		Wait(500)
		TriggerEvent("jim-bars:Crafting", data)
	end, function() -- Cancel
		TriggerEvent('inventory:client:busy:status', false)
		TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end, data.item)
end)

RegisterNetEvent('jim-bars:client:Menu:Close', function() exports['qb-menu']:closeMenu() end)

RegisterNetEvent('jim-bars:Crafting', function(data)
	lookEnt(data.coords)
	local Menu = {}
	Menu[#Menu + 1] = { header = data.header, txt = "", isMenuHeader = true }
	Menu[#Menu + 1] = { icon = "fas fa-circle-xmark", header = "", txt = Loc[Config.Lan].menu["close"], params = { event = "jim-bars:client:Menu:Close" } }
	for i = 1, #data.craftable do
		for k, v in pairs(data.craftable[i]) do
			if k ~= "amount" and k ~= "job" and k ~= "gang" then
				if data.craftable[i]["job"] then hasjob = false
					for l, b in pairs(data.craftable[i]["job"]) do
						if l == PlayerJob.name and PlayerJob.grade.level >= b then hasjob = true end
					end
				end
				if data.craftable[i]["gang"] then hasjob = false
					for l, b in pairs(data.craftable[i]["gang"]) do
						if l == PlayerGang.name and PlayerGang.grade.level >= b then hasjob = true end
					end
				end
				if not QBCore.Shared.Items[k] then print("Item not found in server: '"..k.."'") else
					if (data.craftable[i]["job"] or data.craftable[i]["gang"]) and hasjob == false then else
						local text = ""
						setheader = QBCore.Shared.Items[tostring(k)].label
						if data.craftable[i]["amount"] ~= nil then setheader = setheader.." x"..data.craftable[i]["amount"] end
						local disable = false
						local checktable = {}
						for l, b in pairs(data.craftable[i][tostring(k)]) do
							if b == 1 then number = "" else number = " x"..b end
							text = text.."- "..QBCore.Shared.Items[l].label..number.."<br>"
							settext = text
							checktable[l] = HasItem(l, b)
						end
						for _, v in pairs(checktable) do if v == false then disable = true break end end
						if not disable then setheader = setheader.." ✔️" end
						Menu[#Menu + 1] = { disabled = disable, icon = k, header = setheader, txt = settext, params = { event = "jim-bars:Crafting:MakeItem", args = { item = k, craft = data.craftable[i], craftable = data.craftable, header = data.header } } }
						settext, setheader = nil
					end
				end
			end
		end Wait(0)
	end
	exports['qb-menu']:openMenu(Menu)
end)

function FoodProgress(ItemMake, craftable)
	QBCore.Functions.Progressbar('making_food', Loc[Config.Lan].progressbar["progress_pour"]..QBCore.Shared.Items[ItemMake].label, 3000, false, false, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
	{ animDict = "mp_ped_interaction", anim = "handshake_guy_a", flags = 8, },
	{}, {}, function()
		TriggerServerEvent('jim-bars:Crafting:GetItem', ItemMake, craftable)
	end, function() -- Cancel
		TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end, ItemMake)
end

RegisterNetEvent('jim-bars:client:DrinkAlcohol', function(itemName)
	if itemName == "ambeer" then TriggerEvent('animations:client:EmoteCommandStart', {"beer3"})
	elseif itemName == "dusche" then TriggerEvent('animations:client:EmoteCommandStart', {"beer1"})
	elseif itemName == "logger" then TriggerEvent('animations:client:EmoteCommandStart', {"beer2"})
	elseif itemName == "pisswasser" then TriggerEvent('animations:client:EmoteCommandStart', {"beer4"})
	elseif itemName == "pisswasser2" then TriggerEvent('animations:client:EmoteCommandStart', {"beer5"})
	elseif itemName == "pisswasser3" then TriggerEvent('animations:client:EmoteCommandStart', {"beer6"})
	elseif itemName == "b52" or itemName == "brussian" or itemName == "bkamikaze" or itemName == "cappucc" or itemName == "ccookie" or itemName == "iflag" or itemName == "kamikaze" or itemName == "sbullet" or itemName == "voodoo" or itemName == "woowoo" then TriggerEvent('animations:client:EmoteCommandStart', {"whiskey"})
	elseif itemName == "icream" then TriggerEvent('animations:client:EmoteCommandStart', {"icream"})
	elseif itemName == "rum" then TriggerEvent('animations:client:EmoteCommandStart', {"rumb"})
	elseif itemName == "gin" then TriggerEvent('animations:client:EmoteCommandStart', {"ginb"})
	elseif itemName == "scotch" then TriggerEvent('animations:client:EmoteCommandStart', {"whiskeyb"})
	elseif itemName == "vodka" or itemName == "amaretto" or itemName == "curaco" then TriggerEvent('animations:client:EmoteCommandStart', {"vodkab"})
	else TriggerEvent('animations:client:EmoteCommandStart', {"flute"}) end
    QBCore.Functions.Progressbar("snort_coke", Loc[Config.Lan].progressbar["progress_drink"]..QBCore.Shared.Items[itemName].label.."..", math.random(3000, 6000), false, true, { disableMovement = false, disableCarMovement = false, disableMouse = false, disableCombat = true, },
	{}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		toggleItem(false, itemName, 1)
		if QBCore.Shared.Items[itemName].hunger then TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + QBCore.Shared.Items[itemName].hunger) end
        if QBCore.Shared.Items[itemName].thirst then TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + QBCore.Shared.Items[itemName].thirst) end
        alcoholCount = alcoholCount + 1
        if alcoholCount > 1 and alcoholCount < 4 then TriggerEvent("evidence:client:SetStatus", "alcohol", 200)
        elseif alcoholCount >= 4 then TriggerEvent("evidence:client:SetStatus", "heavyalcohol", 200)
			AlienEffect()
        end
	end, function() -- Cancel
		TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end, itemName)
end)

--Alcohol Effects
function AlienEffect()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Wait(math.random(5000, 8000))
    local ped = PlayerPedId()
    RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK")
    while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do Citizen.Wait(0) end
    SetPedCanRagdoll( ped, true )
    ShakeGameplayCam('DRUNK_SHAKE', 2.80)
    SetTimecycleModifier("Drunk")
    SetPedMovementClipset(ped, "MOVE_M@DRUNK@VERYDRUNK", true)
    SetPedMotionBlur(ped, true)
    SetPedIsDrunk(ped, true)
    Wait(1500)
    SetPedToRagdoll(ped, 5000, 1000, 1, false, false, false )
    Wait(13500)
    SetPedToRagdoll(ped, 5000, 1000, 1, false, false, false )
    Wait(120500)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(ped, 0)
    SetPedIsDrunk(ped, false)
    SetPedMotionBlur(ped, false)
    AnimpostfxStopAll()
    ShakeGameplayCam('DRUNK_SHAKE', 0.0)
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Wait(math.random(45000, 60000))
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
end
--Weed Effects
function WeedEffect()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Wait(math.random(3000, 20000))
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Wait(math.random(15000, 20000))
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
end
--Other Effects
function TrevorEffect()
    StartScreenEffect("DrugsTrevorClownsFightIn", 3.0, 0)
    Wait(3000)
    StartScreenEffect("DrugsTrevorClownsFight", 3.0, 0)
    Wait(30000)
	StartScreenEffect("DrugsTrevorClownsFightOut", 3.0, 0)
	StopScreenEffect("DrugsTrevorClownsFight")
	StopScreenEffect("DrugsTrevorClownsFightIn")
	StopScreenEffect("DrugsTrevorClownsFightOut")
end

RegisterNetEvent('jim-bars:client:Drink', function(itemName)
	if itemName == "sprunk" or itemName == "sprunklight" then TriggerEvent('animations:client:EmoteCommandStart', {"sprunk"})
	elseif itemName == "ecola" or itemName == "ecolalight" then TriggerEvent('animations:client:EmoteCommandStart', {"ecola"})
    elseif itemName == "cranberry" then TriggerEvent('animations:client:EmoteCommandStart', {"wine"})
	elseif itemName == "coffee" then TriggerEvent('animations:client:EmoteCommandStart', {"coffee"}) end
	QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan].progressbar["progress_drink"]..QBCore.Shared.Items[itemName].label.."..", 5000, false, true, { disableMovement = false, disableCarMovement = false, disableMouse = false, disableCombat = true, },
	{}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		toggleItem(false, itemName, 1)
		if QBCore.Shared.Items[itemName].hunger then TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + QBCore.Shared.Items[itemName].hunger) end
        if QBCore.Shared.Items[itemName].thirst then TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + QBCore.Shared.Items[itemName].thirst) end
	end, function() -- Cancel
		TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end, itemName)
end)

RegisterNetEvent('jim-bars:client:Eat', function(itemName)
	if itemName == "crisps" then TriggerEvent('animations:client:EmoteCommandStart', {"crisps"})
	else TriggerEvent('animations:client:EmoteCommandStart', {"burger"}) end
    QBCore.Functions.Progressbar("eat_something", Loc[Config.Lan].progressbar["progress_eat"]..QBCore.Shared.Items[itemName].label.."..", 5000, false, true, { disableMovement = false, disableCarMovement = false, disableMouse = false, disableCombat = true, },
	{}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		toggleItem(false, itemName, 1)
		if QBCore.Shared.Items[itemName].hunger then TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + QBCore.Shared.Items[itemName].hunger) end
        if QBCore.Shared.Items[itemName].thirst then TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + QBCore.Shared.Items[itemName].thirst) end
        TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
	end, function() -- Cancel
		TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end, itemName)
end)

-- CUSTOM DJ BOOTH STUFF
RegisterNetEvent('jim-bars:client:playMusic', function(data)
	exports['qb-menu']:openMenu({
		{ isMenuHeader = true, header = '<center><img src='..data.logo..' width=225px>' },
		{ icon = "fas fa-circle-xmark", header = "", txt = Loc[Config.Lan].menu["close"], params = { event = "qb-menu:client:closemenu" } },
		{ icon = "fab fa-youtube", header = Loc[Config.Lan].menu["header_play"], txt = Loc[Config.Lan].menu["txt_enter"], params = { event = 'jim-bars:client:musicMenu', args = { zoneNum = data.zone } } },
		{ icon = "fas fa-pause", header = Loc[Config.Lan].menu["header_pause"], txt = Loc[Config.Lan].menu["txt_pause"], params = { isServer = true, event = 'jim-bars:server:pauseMusic', args = { zoneNum = data.zone } } },
		{ icon = "fas fa-play", header = Loc[Config.Lan].menu["header_resume"], txt = Loc[Config.Lan].menu["txt_resume"], params = { isServer = true, event = 'jim-bars:server:resumeMusic', args = { zoneNum = data.zone } } },
		{ icon = "fas fa-volume-off", header = Loc[Config.Lan].menu["header_volume"], txt = Loc[Config.Lan].menu["txt_change"], params = { event = 'jim-bars:client:changeVolume', args = { zoneNum = data.zone } } },
		{ icon = "fas fa-stop", header = Loc[Config.Lan].menu["header_off"], txt = Loc[Config.Lan].menu["txt_stop"], params = { isServer = true, event = 'jim-bars:server:stopMusic', args = { zoneNum = data.zone } } } })
end)
RegisterNetEvent('jim-bars:client:musicMenu', function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = Loc[Config.Lan].menu["header_select"],
        submitText = Loc[Config.Lan].menu["txt_sub"],
        inputs = { { type = 'text', isRequired = true, name = 'song', text = Loc[Config.Lan].menu["txt_url"] } } })
    if dialog then
        if not dialog.song then return end
        TriggerServerEvent('jim-bars:server:playMusic', dialog.song, data.zoneNum)
    end
end)
RegisterNetEvent('jim-bars:client:changeVolume', function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = Loc[Config.Lan].menu["header_volume"],
        submitText = Loc[Config.Lan].menu["txt_sub"],
        inputs = { { type = 'text', isRequired = true,  name = 'volume', text = Loc[Config.Lan].menu["txt_volume"] } } })
    if dialog then
        if not dialog.volume then return end
        TriggerServerEvent('jim-bars:server:changeVolume', dialog.volume, data.zoneNum)
    end
end)

AddEventHandler('onResourceStop', function(resource) if resource ~= GetCurrentResourceName() then return end
	for k, v in pairs(Targets) do exports['qb-target']:RemoveZone(k) end
	for k, v in pairs(Props) do DeleteEntity(Props[k]) end
end)