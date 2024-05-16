local QBCore = nil

Citizen.CreateThread(function()
	while QBCore == nil do 
		Citizen.Wait(1000)
		QBCore = exports['qb-core']:GetCoreObject()
	end
end)

local canAdvertise = true

if Config.AllowPlayersToClearTheirChat then
	RegisterCommand(Config.ClearChatCommand, function(source, args, rawCommand)
		TriggerClientEvent('chat:client:ClearChat', source)
	end)
end

if Config.AllowStaffsToClearEveryonesChat then
	RegisterCommand(Config.ClearEveryonesChatCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local time = os.date(Config.DateFormat)

		if isAdmin(source) then
			TriggerClientEvent('chat:client:ClearChat', -1)
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div style="position: relative;" class="chat-message system"><b><span style="position: absolute; top: 1vh; left: -.1vh; font-size: 16px; color: #d30000; padding-bottom: 2px; border-bottom: 2px solid #d30000; transform: rotate(-90deg); ">SYSTEM</span>&nbsp;</b><span style="font-size: 12px; position: relative; left: 3vh; color: #ffffff88;">{0}</span><div style="position: relative; left: 3.3vh; font-size: 18px; font-weight: 300;">The chat has been cleared!</div></div>',
				args = { time }
			})
		end
	end)
end

if Config.EnableStaffCommand then
	RegisterCommand(Config.StaffCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local length = string.len(Config.StaffCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		playerName = xPlayer.PlayerData.name

		if isAdmin(source) then
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div style="position: relative;" class="chat-message staff"><b><span style="position: absolute; top: 1vh; left: .6vh; font-size: 16px; color: #ec5b25; padding-bottom: 2px; border-bottom: 2px solid #ec5b25; transform: rotate(-90deg);">STAFF</span>&nbsp;</b><span style="position: relative; left: 3vh; font-size: 12px; color: #fff; border-radius: 40px;">Sender : {0}</span>&nbsp;<span style="font-size: 12px; position: relative; left: 3vh; color: #ffffff88;">{2}</span><div style="position: relative; left: 3.3vh; font-size: 18px; font-weight: 300;">{1}</div></div>',
				args = { playerName, message, time }
			})
		end
	end)
end

if Config.EnableStaffOnlyCommand then
	RegisterCommand(Config.StaffOnlyCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local length = string.len(Config.StaffOnlyCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		playerName = xPlayer.PlayerData.name

		if isAdmin(source) then
			showOnlyForAdmins(function(admins)
				TriggerClientEvent('chat:addMessage', admins, {
					template = '<div style="position: relative;" class="chat-message staffonly"><b><span style="position: absolute; top: 1vh; left: -.2vh; font-size: 16px; color: #0e0e0e88; padding-bottom: 2px; border-bottom: 2px solid #0e0e0e88; transform: rotate(-90deg);">STAFF/O</span>&nbsp;</b><span style="position: relative; left: 3vh; font-size: 12px; color: #fff; border-radius: 40px;">Sender : {0}</span>&nbsp;<span style="font-size: 12px; position: relative; left: 3vh; color: #ffffff88;">{2}</span><div style="position: relative; left: 3.3vh; font-size: 18px; font-weight: 300;">{1}</div></div>',
					args = { playerName, message, time }
				})
			end)
		end
	end)
end

if Config.EnableAdvertisementCommand then
	RegisterCommand(Config.AdvertisementCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local length = string.len(Config.AdvertisementCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		playerName = xPlayer.PlayerData.name
		local bankMoney = xPlayer.PlayerData.money.bank

		if canAdvertise then
			if bankMoney >= Config.AdvertisementPrice then
				xPlayer.Functions.RemoveMoney('bank', Config.AdvertisementPrice)
				TriggerClientEvent('chat:addMessage', -1, {
					template = '<div style="position: relative;" class="chat-message advertisement"><b><span style="position: absolute; top: 1vh; left: 0vh; font-size: 16px; color: #f9bf1d; padding-bottom: 2px; border-bottom: 2px solid #f9bf1d; transform: rotate(-90deg);">ADVERT</span>&nbsp;</b><span style="position: relative; left: 3vh; font-size: 12px; color: #fff; border-radius: 40px;">Sender : {0}</span>&nbsp;<span style="font-size: 12px; position: relative; left: 3vh; color: #ffffff88;">{2}</span><div style="position: relative; left: 3.3vh; font-size: 18px; font-weight: 300;">{1}</div></div>',
					args = { playerName, message, time }
				})

				TriggerClientEvent('qb-Notify:Alert', source, "ADVERTISEMENT", "Advertisement successfully made for "..Config.AdvertisementPrice..'€', 10000, 'success')

				local time = Config.AdvertisementCooldown * 60
				local pastTime = 0
				canAdvertise = false

				while (time > pastTime) do
					Citizen.Wait(1000)
					pastTime = pastTime + 1
					timeLeft = time - pastTime
				end
				canAdvertise = true
			else
				TriggerClientEvent('qb-Notify:Alert', source, "ADVERTISEMENT", "You don't have enough money to make an advertisement", 10000, 'error')
			end
		else
			TriggerClientEvent('qb-Notify:Alert', source, "ADVERTISEMENT", "You can't advertise so quickly", 10000, 'error')
		end
	end)
end

if Config.EnableTwitchCommand then
	RegisterCommand(Config.TwitchCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local length = string.len(Config.TwitchCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		playerName = xPlayer.PlayerData.name
		local twitch = twitchPermission(source)

		if twitch then
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div style="position: relative;" class="chat-message twitch"><b><span style="position: absolute; top: 1vh; left: 1vh; font-size: 16px; padding-right: 4px; border-right: 2px solid #FC1E57;"><i class="fas fa-calendar-check" style="font-size:24px; color: #FC1E57;"></i></span>&nbsp;</b><span style="position: relative; left: 3vh; font-size: 12px; color: #fff; border-radius: 40px;">Sender : {0}</span>&nbsp;<span style="font-size: 12px; position: relative; left: 3vh; color: #ffffff88;">{2}</span><div style="position: relative; left: 3.3vh; font-size: 18px; font-weight: 300;">{1}</div></div>',
				args = { playerName, message, time }
			})
		end
	end)
end

function twitchPermission(id)
	for k,v in ipairs(Config.TwitchList) do
		for k,x in ipairs(GetPlayerIdentifiers(id)) do
			if string.lower(x) == string.lower(v) then
				return true 
			end
		end
	end
	return false
end

if Config.EnableYoutubeCommand then
	RegisterCommand(Config.YoutubeCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local length = string.len(Config.YoutubeCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		playerName = xPlayer.PlayerData.name
		local youtube = youtubePermission(source)

		if youtube then
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div style="position: relative;" class="chat-message youtube"><b><span style="position: absolute; top: 1vh; left: .8vh; font-size: 16px; padding-right: 4px; border-right: 2px solid #fff;"><i class="fab fa-youtube" style="font-size:12px; color: #fff;"></i></span>&nbsp;</b><span style="position: relative; left: 3vh; font-size: 12px; color: #fff; border-radius: 40px;">Sender : {0}</span>&nbsp;<span style="font-size: 12px; position: relative; left: 3vh; color: #ffffff88;">{2}</span><div style="position: relative; left: 3.3vh; font-size: 18px; font-weight: 300;">{1}</div></div>',
				args = { playerName, message, time }
			})
		end
	end)
end

function youtubePermission(id)
	for k,v in ipairs(Config.YoutubeList) do
		for k,x in ipairs(GetPlayerIdentifiers(id)) do
			if string.lower(x) == string.lower(v) then
				return true 
			end
		end
	end
	return false
end

if Config.EnableTwitterCommand then
	RegisterCommand(Config.TwitterCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local length = string.len(Config.TwitterCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		playerName = xPlayer.PlayerData.name

		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="position: relative;" class="chat-message twitter"><b><span style="position: absolute; top: 1vh; left: 1vh; font-size: 16px; color: #2aa9e0; padding-right: 4px; border-right: 2px solid #2aa9e0;"><i class="fab fa-twitter" style="font-size:12px; color: #fff;"></i></span>&nbsp;</b><span style="position: relative; left: 3vh; font-size: 12px; color: #fff; border-radius: 40px;">Sender : {0}</span>&nbsp;<span style="font-size: 12px; position: relative; left: 3vh; color: #ffffff88;">{2}</span><div style="position: relative; left: 3.3vh; font-size: 18px; font-weight: 300;">{1}</div></div>',
			args = { playerName, message, time }
		})
	end)
end

if Config.EnablePoliceCommand then
	RegisterCommand(Config.PoliceCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local length = string.len(Config.PoliceCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		playerName = xPlayer.PlayerData.name
		local job = xPlayer.PlayerData.job.name

		if job == Config.PoliceJobName then
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div style="position: relative;" class="chat-message police"><b><span style="position: absolute; top: 1vh; left: .8vh; font-size: 16px; padding-right: 4px; border-right: 2px solid #0000ffbd;"><i class="fas fa-bullhorn" style="font-size:12px;"></i></span>&nbsp;</b><span style="position: relative; left: 3vh; font-size: 12px; color: #fff; border-radius: 40px;">Sender : {0}</span>&nbsp;<span style="font-size: 12px; position: relative; left: 3vh; color: #ffffff88;">{2}</span><div style="position: relative; left: 3.3vh; font-size: 18px; font-weight: 300;">{1}</div></div>',
				args = { playerName, message, time }
			})
		end
	end)
end

if Config.EnableAmbulanceCommand then
	RegisterCommand(Config.AmbulanceCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local length = string.len(Config.AmbulanceCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		playerName = xPlayer.PlayerData.name
		local job = xPlayer.PlayerData.job.name

		if job == Config.AmbulanceJobName then
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div style="position: relative;" class="chat-message ambulance"><b><span style="position: absolute; top: 1vh; left: .8vh; font-size: 16px; padding-right: 4px; border-right: 2px solid #f9bf1d;"><i class="fas fa-ambulance" style="font-size:12px;"></i></span>&nbsp;</b><span style="position: relative; left: 3vh; font-size: 12px; color: #fff; border-radius: 40px;">Sender : {0}</span>&nbsp;<span style="font-size: 12px; position: relative; left: 3vh; color: #ffffff88;">{2}</span><div style="position: relative; left: 3.3vh; font-size: 18px; font-weight: 300;">{1}</div></div>',
				args = { playerName, message, time }
			})
		end
	end)
end

if Config.EnableOOCCommand then
	RegisterCommand(Config.OOCCommand, function(source, args, rawCommand)
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local length = string.len(Config.OOCCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		playerName = xPlayer.PlayerData.name
		TriggerClientEvent('chat:ooc', -1, source, playerName, message, time)
	end)
end

RegisterCommand('darkweb', function(source, args, rawCommand)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local length = 8
	local message = rawCommand:sub(length + 1)
	local time = os.date(Config.DateFormat)
	playerName = xPlayer.PlayerData.name
	TriggerClientEvent('chat:ooc2', -1, source, 'Anonymous', message, time)
end)

function isAdmin(xPlayer)
	for k,v in ipairs(Config.StaffGroups) do
		if QBCore.Functions.GetPermission(xPlayer) == v then 
			return true 
		end
	end
	return false
end

function showOnlyForAdmins(admins)
	for k,v in ipairs(QBCore.Functions.GetPlayers()) do
		for k,x in ipairs(Config.StaffGroups) do
			if QBCore.Functions.GetPermission(v) == x then
				admins(v)
			end
		end
	end
end