if Config.framework == "esx" then
    ESX = exports["es_extended"]:getSharedObject()
else
    QBCore = exports['qb-core']:GetCoreObject()
end

local locations = {}

if Config.framework == "esx" then
    ESX.RegisterServerCallback('izzy-spawnselector:getAccess', function(source, cb)
        local xPlayer = ESX.GetPlayerFromId(source)
        
        for k,v in pairs(Config.permissions) do
            if xPlayer.identifier == v then
                cb(true)
            end
        end

        cb(false)
    end)

    ESX.RegisterServerCallback('izzy-spawnselector:getInfo', function(source, cb)
        local xPlayer = ESX.GetPlayerFromId(source)
        cb({locations = locations, image = getDiscordImage(source), name = getName(source), cash = xPlayer.getMoney()})
    end)
else
    QBCore.Functions.CreateCallback('izzy-spawnselector:getAccess', function(source, cb)
        local xPlayer = QBCore.Functions.GetPlayer(source)
        
        for k,v in pairs(Config.permissions) do
            print(xPlayer.PlayerData.citizenid, v)
            if xPlayer.PlayerData.citizenid == v then
                cb(true)
            end
        end

        cb(false)
    end)

    QBCore.Functions.CreateCallback('izzy-spawnselector:getInfo', function(source, cb)
        local xPlayer = QBCore.Functions.GetPlayer(source)
        print(locations)
        print(getDiscordImage(source))
        print(getName(source))
        print(xPlayer.PlayerData.money["cash"])
        cb({locations = locations, image = getDiscordImage(source), name = getName(source), cash = xPlayer.PlayerData.money["cash"]})
    end)
end



RegisterNetEvent('izzy-spawnselector:addSpawn')
AddEventHandler('izzy-spawnselector:addSpawn', function (data, coord, name)
    local data = {
        top = data.top,
        left = data.left,
        coord = coord
    }
    MySQL.Async.fetchAll("INSERT INTO izzy_spawnselector (name, data) VALUES (@name, @data)", { 
        ["@name"] = name, 
        ["@data"] = json.encode(data)
    }, function(a)
        refreshList()
    end)
end)

function refreshList()
    local Info = MySQL.Sync.fetchAll("SELECT * FROM izzy_spawnselector")

    
    for k,v in pairs(Info) do
        local info = json.decode(v.data)
        locations[k] = {name = v.name, left = info.left, top = info.top, coord = info.coord}
    end
end

Citizen.CreateThread(function()
    refreshList()
end)

local discordToken = "Bot " .. Settings["botToken"]

function DiscordRequest(method, endpoint, jsondata, reason)
    local data = nil
    PerformHttpRequest("https://discordapp.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
		data = {data=resultData, code=errorCode, headers=resultHeaders}
    end, method, #jsondata > 0 and jsondata or "", {["Content-Type"] = "application/json", ["Authorization"] = discordToken, ['X-Audit-Log-Reason'] = reason})

    while data == nil do
        Citizen.Wait(0)
    end
	
    return data
end

function getDiscord(id)
	for i = 0, GetNumPlayerIdentifiers(id) - 1 do
		local id = GetPlayerIdentifier(id, i)
		if string.find(id, "discord") then
			return string.gsub(id, "discord:", "")
		end
	end
end

function getDiscordImage(id)
	local discordId = getDiscord(id)
	if discordId then
		local endpoint = ("users/%s"):format(discordId)
		local member = DiscordRequest("GET", endpoint, {})
		local data = json.decode(member.data)

        return "https://cdn.discordapp.com/avatars/"..discordId.."/"..data.avatar..""
	else
		return "images/stg.png"
	end
end

function getName(id)
    if Config.framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(id)
        local Info = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {["@identifier"] = xPlayer.identifier})
        return Info[1].firstname.." "..Info[1].lastname
    else
        local xPlayer = QBCore.Functions.GetPlayer(id)
        return xPlayer.PlayerData.charinfo["firstname"].." "..xPlayer.PlayerData.charinfo["lastname"]
    end
end