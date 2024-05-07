local QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('onResourceStart', function(r) if GetCurrentResourceName() ~= r then return end
	for k, v in pairs(Crafting) do for i = 1, #v do for l, b in pairs(v[i]) do if l ~= "amount" and l ~= "job" and l ~= "gang" then
		if not QBCore.Shared.Items[l] then print("Crafting: Missing Item from QBCore.Shared.Items: '"..l.."'") end
		for j, c in pairs(b) do if not QBCore.Shared.Items[j] then print("Crafting: Missing Ingredient Item from QBCore.Shared.Items: '"..j.."'") end end end end end
	end
	for i = 1, #Config.DrinkItems.items do
		if not QBCore.Shared.Items[Config.DrinkItems.items[i].name] then print("Store: Missing Item from QBCore.Shared.Items: '"..Config.DrinkItems.items[i].name.."'") end
	end
	for _, v in pairs(Config.Locations) do
		--if Config.Debug then print("Loading Job into script: '"..v.label.."'") end
		if v.job then if not QBCore.Shared.Jobs[v.job] then print("Error: Job role not found - '"..v.job.."' for location: "..v.label) end end
		if v.gang then if not QBCore.Shared.Gangs[v.gang] then print("Error: Gang role not found - '"..v.gang.."' for location: "..v.label) end end
	end
end)

--Consumables
--[[CreateThread(function()
	local cocktails = { "b52", "brussian", "bkamikaze", "cappucc", "ccookie", "iflag", "kamikaze", "sbullet",
						"voodoo", "woowoo", "schnapps", "gin", "scotch", "rum", "icream", "amaretto", "curaco", "vodka" }
    for _, v in pairs(cocktails) do QBCore.Functions.CreateUseableItem(v, function(source, item) TriggerClientEvent('jim-bars:client:DrinkAlcohol', source, item.name) end) end

	local beers = { "ambeer", "dusche", "logger", "pisswasser", "pisswasser2", "pisswasser3" }
    for _, v in pairs(beers) do QBCore.Functions.CreateUseableItem(v, function(source, item) TriggerClientEvent('jim-bars:client:DrinkAlcohol', source, item.name) end) end

	local drinks = { "sprunk", "sprunklight", "ecola", "ecolalight", "cranberry" }
    for _, v in pairs(drinks) do QBCore.Functions.CreateUseableItem(v, function(source, item) TriggerClientEvent('jim-bars:client:Drink', source, item.name) end) end

	local food = { "chocolate", "crisps" }
    for _, v in pairs(food) do QBCore.Functions.CreateUseableItem(v, function(source, item) TriggerClientEvent('jim-bars:client:Eat', source, item.name) end) end
end)]]

---Crafting
RegisterServerEvent('jim-bars:Crafting:GetItem', function(ItemMake, craftable)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	--This grabs the table from client and removes the item requirements
	local amount = 1
	if craftable then
		if craftable["amount"] then amount = craftable["amount"] end
		for k, v in pairs(craftable[ItemMake]) do TriggerEvent("jim-bars:server:toggleItem", false, tostring(k), v, src) end
	end
	--This should give the item, while the rest removes the requirements
	TriggerEvent("jim-bars:server:toggleItem", true, ItemMake, amount, src)
end)

RegisterNetEvent('jim-bars:server:toggleItem', function(give, item, amount, newsrc)
	local src = newsrc or source
	if give == 0 or give == false then
		if HasItem(src, item, amount or 1) then -- check if you still have the item
			if QBCore.Functions.GetPlayer(src).Functions.RemoveItem(item, amount or 1) then
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", amount or 1)
				if Config.Debug then print("^5Debug^7: ^1Removing ^2from Player^7(^2"..src.."^7) '^6"..QBCore.Shared.Items[item].label.."^7(^2x^6"..(amount or "1").."^7)'") end
			end
		else TriggerEvent("jim-bars:server:DupeWarn", item, src) end -- if not boot the player
	else
		if QBCore.Functions.GetPlayer(src).Functions.AddItem(item, amount or 1) then
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", amount or 1)
			if Config.Debug then print("^5Debug^7: ^4Giving ^2Player^7(^2"..src.."^7) '^6"..QBCore.Shared.Items[item].label.."^7(^2x^6"..(amount or "1").."^7)'") end
		end
	end
end)

RegisterNetEvent("jim-bars:server:DupeWarn", function(item, newsrc)
	local src = newsrc or source
	local P = QBCore.Functions.GetPlayer(src)
	print("^5DupeWarn: ^1"..P.PlayerData.charinfo.firstname.." "..P.PlayerData.charinfo.lastname.."^7(^1"..tostring(src).."^7) ^2Tried to remove item ^7('^3"..item.."^7')^2 but it wasn't there^7")
	DropPlayer(src, "Kicked for attempting to duplicate items")
	print("^5DupeWarn: ^1"..P.PlayerData.charinfo.firstname.." "..P.PlayerData.charinfo.lastname.."^7(^1"..tostring(src).."^7) ^2Dropped from server for item duplicating^7")
end)

function HasItem(source, items, amount)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end
    local isTable = type(items) == 'table'
    local isArray = isTable and table.type(items) == 'array' or false
    local totalItems = #items
    local count = 0
    local kvIndex = 2
    if isTable and not isArray then
        totalItems = 0
        for _ in pairs(items) do totalItems += 1 end
        kvIndex = 1
    end
    if isTable then
	if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Checking if player^7(^6"..source.."^7)^2 has items^7") end
        for k, v in pairs(items) do
            local itemKV = {k, v}
            local item = Player.Functions.GetItemByName(itemKV[kvIndex])
            if item and ((amount and item.amount >= amount) or (not isArray and item.amount >= v) or (not amount and isArray)) then
                count += 1
            end
        end
        if count == totalItems then
			if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Items FOUND^7") end
            return true
        end
    else -- Single item as stringHasItem(v, 1)
		if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Checking if player^7(^6"..source.."^7)^2 has items^7") end
		local item = Player.Functions.GetItemByName(items)
        if item and (not amount or (item and amount and item.amount >= amount)) then
            return true
        end
    end
	if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Items Not FOUND^7") end
    return false
end


-- Server Side Built in DJ Booth stuff
local xSound = exports.xsound
RegisterNetEvent('jim-bars:server:playMusic', function(song, zoneNum)
    local src = source
	local Booth = Config.Locations[zoneNum].Booth
	local zoneLabel = Config.Locations[zoneNum].label..zoneNum
    xSound:PlayUrlPos(-1, zoneLabel, song, Booth.DefaultVolume, GetEntityCoords(GetPlayerPed(src)))
    xSound:Distance(-1, zoneLabel, Booth.radius)
    Config.Locations[zoneNum].Booth.playing = true
    --TriggerClientEvent('jim-bars:client:playMusic', src, { zone = zoneNum })
end)
RegisterNetEvent('jim-bars:server:stopMusic', function(data)
    local src = source
	print(json.encode(data))
	local zoneLabel = Config.Locations[data.zoneNum].label..data.zoneNum
    if Config.Locations[data.zoneNum].Booth.playing then
        Config.Locations[data.zoneNum].Booth.playing = false
        xSound:Destroy(-1, zoneLabel)
    end
    --TriggerClientEvent('jim-bars:client:playMusic', src, { zone = data.zoneNum })
end)
RegisterNetEvent('jim-bars:server:pauseMusic', function(data)
    local src = source
    if Config.Locations[data.zoneNum].Booth.playing then
        Config.Locations[data.zoneNum].Booth.playing = false
        xSound:Pause(-1, zoneLabel)
    end
    --TriggerClientEvent('jim-bars:client:playMusic', src, { zone = data.zoneNum })
end)
RegisterNetEvent('jim-bars:server:resumeMusic', function(data)
    local src = source
    if not Config.Locations[data.zoneNum].Booth.playing then
        Config.Locations[data.zoneNum].Booth.playing = true
        xSound:Resume(-1, zoneLabel)
    end
    --TriggerClientEvent('jim-bars:client:playMusic', src, { zone = data.zoneNum })
end)
RegisterNetEvent('jim-bars:server:changeVolume', function(volume, zoneNum)
    local src = source
	local Booth = Config.Locations[zoneNum].Booth
	local zoneLabel = Config.Locations[zoneNum].label..zoneNum
    if not tonumber(volume) then return end
    if Config.Locations[zoneNum].Booth.playing then xSound:setVolume(-1, zoneLabel, volume) end
    --TriggerClientEvent('jim-bars:client:playMusic', src, { zone = zoneNum })
end)

AddEventHandler('onResourceStop', function(resource) if resource ~= GetCurrentResourceName() then return end
	for i = 1, #Config.Locations do
		if Config.Locations[i].Booth.playing then
			local zoneLabel = Config.Locations[i].label..i
			xSound:Destroy(-1, zoneLabel)
		end
	end
end)