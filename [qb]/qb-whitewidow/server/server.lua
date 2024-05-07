local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("bong", function(source, item)
    if Config.UsableItemBong then
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        TriggerClientEvent("qb-whitewidow:Client:Bong", src)
    end                                                                 				
end)

--// Check Item For Process Cannabis \\--
QBCore.Functions.CreateCallback('qb-whitewidow:HasItemProcessCannabis', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cannabis = Player.Functions.GetItemByName(Config.WeedItemPickUp)
    local scissors = Player.Functions.GetItemByName(Config.ScissorsItem)
    if cannabis ~= nil and scissors ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

--// Check Item For Process Joints \\--
QBCore.Functions.CreateCallback('qb-whitewidow:CheckForItemsJoint', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cannabis = Player.Functions.GetItemByName(Config.WeedItemRecive)
    local ogkush = Player.Functions.GetItemByName(Config.OgKushItemRecive)
    local ak47 = Player.Functions.GetItemByName(Config.Ak47ItemRecive)
    local skunk = Player.Functions.GetItemByName(Config.SkunkItemRecive)
    local rollingpaper = Player.Functions.GetItemByName(Config.RollingPaperItem)
    if cannabis ~= nil and rollingpaper ~= nil or ogkush ~= nil and rollingpaper ~= nil or skunk ~= nil and rollingpaper ~= nil or ak47 ~= nil and rollingpaper ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

--// Check Item For Bong \\--
QBCore.Functions.CreateCallback('qb-whitewidow:HasItemSmokeBong', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bong = Player.Functions.GetItemByName(Config.BongItem)
    if bong ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

--// Check Item For Process Joints \\--
RegisterServerEvent('qb-whitewidow:ProcessJoints')
AddEventHandler('qb-whitewidow:ProcessJoints', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cannabis = Player.Functions.GetItemByName(Config.WeedItemRecive)
    local ogkush = Player.Functions.GetItemByName(Config.OgKushItemRecive)
    local ak47 = Player.Functions.GetItemByName(Config.Ak47ItemRecive)
    local skunk = Player.Functions.GetItemByName(Config.SkunkItemRecive)
    local rollingpaper = Player.Functions.GetItemByName(Config.RollingPaperItem)
    if cannabis ~= nil and rollingpaper ~= nil then
            Player.Functions.RemoveItem(Config.WeedItemRecive, 1)
            Player.Functions.RemoveItem(Config.RollingPaperItem, 1)
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.RollingPaperItem], "remove")
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.WeedItemRecive], "remove")
    elseif ogkush ~= nil and rollingpaper ~= nil then
        if ogkush ~= nil then
            Player.Functions.RemoveItem(Config.OgKushItemRecive, 1)
            Player.Functions.RemoveItem(Config.RollingPaperItem, 1)
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.RollingPaperItem], "remove")
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.OgKushItemRecive], "remove")
        end
    elseif ak47 ~= nil and rollingpaper ~= nil then
        Player.Functions.RemoveItem(Config.Ak47ItemRecive, 1)
        Player.Functions.RemoveItem(Config.RollingPaperItem, 1)
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.RollingPaperItem], "remove")
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.Ak47ItemRecive], "remove")
    else
        if skunk ~= nil and rollingpaper ~= nil then
            Player.Functions.RemoveItem(Config.SkunkItemRecive, 1)
            Player.Functions.RemoveItem(Config.RollingPaperItem, 1)
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.SkunkItemRecive], "remove")
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.RollingPaperItem], "remove")
        end
    end
end)

--// Add Item Joints \\--
RegisterServerEvent('qb-whitewidow:ProcessJointsAdd')
AddEventHandler('qb-whitewidow:ProcessJointsAdd', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.AddItem('joint', math.random(1,1))
    Player.Functions.AddItem('joint2', math.random(1,1))
    Player.Functions.AddItem('joint3', math.random(1,1))
    Player.Functions.AddItem('joint4', math.random(1,1))
    Player.Functions.AddItem('joint5', math.random(1,1))
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['joint'], "add")
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['joint2'], "add")
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['joint3'], "add")
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['joint4'], "add")
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['joint5'], "add")
	TriggerClientEvent('QBCore:Notify', src, 'Joints Successfully Processed', "success")                                                                         				
end)

--// Add Item Cola \\--
RegisterServerEvent('qb-whitewidow:GrabCola')
AddEventHandler('qb-whitewidow:GrabCola', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.money.cash >= Config.ColaPrice then
	    Player.Functions.AddItem(Config.ColaItem, 1)
        Player.Functions.RemoveMoney("cash", Config.ColaPrice)
	    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.ColaItem], "add")
	    TriggerClientEvent('QBCore:Notify', src, 'Cola Successfully Bought', "success")          
    else
        TriggerClientEvent('QBCore:Notify', src, 'You Dont Have Enough Cash !', "error")              
    end                                          				
end)

--// Add Item Snack \\--
RegisterServerEvent('qb-whitewidow:GrabSnack')
AddEventHandler('qb-whitewidow:GrabSnack', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.money.cash >= Config.SnackPrice then
	    Player.Functions.AddItem(Config.SnackItem, 1)
        Player.Functions.RemoveMoney("cash", Config.SnackPrice)
	    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.SnackItem], "add")
	    TriggerClientEvent('QBCore:Notify', src, 'Snack Successfully Bought', "success")          
    else
        TriggerClientEvent('QBCore:Notify', src, 'You Dont Have Enough Cash !', "error")              
    end                                          				
end)

--// Add Item Water \\--
RegisterServerEvent('qb-whitewidow:GrabWater')
AddEventHandler('qb-whitewidow:GrabWater', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.money.cash >= Config.WaterPrice then
	    Player.Functions.AddItem(Config.WaterItem, 1)
        Player.Functions.RemoveMoney("cash", Config.WaterPrice)
	    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.WaterItem], "add")
	    TriggerClientEvent('QBCore:Notify', src, 'Water Successfully Bought', "success")          
    else
        TriggerClientEvent('QBCore:Notify', src, 'You Dont Have Enough Cash !', "error")              
    end                                          				
end)

RegisterServerEvent('qb-whitewidow:ProcessCannabis')
AddEventHandler('qb-whitewidow:ProcessCannabis', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.RemoveItem(Config.WeedItemPickUp, 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.WeedItemPickUp], "remove")  
end)

QBCore.Functions.CreateCallback('qb-whitewidow:HasItemProcessSkunk', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local skunk = Player.Functions.GetItemByName(Config.SkunkItemPickUp)
    local scissors = Player.Functions.GetItemByName(Config.ScissorsItem)
    if skunk ~= nil and scissors ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

RegisterServerEvent('qb-whitewidow:ProcessSkunk')
AddEventHandler('qb-whitewidow:ProcessSkunk', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.RemoveItem(Config.SkunkItemPickUp, 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.SkunkItemPickUp], "remove")                                                                  				
end)

QBCore.Functions.CreateCallback('qb-whitewidow:HasItemProcessAk47', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local ak47 = Player.Functions.GetItemByName(Config.Ak47ItemPickUp)
    local scissors = Player.Functions.GetItemByName(Config.ScissorsItem)
    if ak47 ~= nil and scissors ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

RegisterServerEvent('qb-whitewidow:ProcessAk-47')
AddEventHandler('qb-whitewidow:ProcessAk-47', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.RemoveItem(Config.Ak47ItemPickUp, 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.Ak47ItemPickUp], "remove")                                                                    				
end)

QBCore.Functions.CreateCallback('qb-whitewidow:HasItemProcessOgKush', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local ogkush = Player.Functions.GetItemByName(Config.OgKushItemPickUp)
    local scissors = Player.Functions.GetItemByName(Config.ScissorsItem)
    if ogkush ~= nil and scissors ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

RegisterServerEvent('qb-whitewidow:ProcessOgKush')
AddEventHandler('qb-whitewidow:ProcessOgKush', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.RemoveItem(Config.OgKushItemPickUp, 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.OgKushItemPickUp], "remove")                                                                    				
end)

RegisterServerEvent('qb-whitewidow:ProcessAk47')
AddEventHandler('qb-whitewidow:ProcessAk47', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.RemoveItem(Config.Ak47ItemPickUp, 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.Ak47ItemPickUp], "remove")                                                                    				
end)

RegisterServerEvent('qb-whitewidow:ProcessCannabisAdd')
AddEventHandler('qb-whitewidow:ProcessCannabisAdd', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.AddItem(Config.WeedItemRecive, math.random(1,3))
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.WeedItemRecive], "add")
	TriggerClientEvent('QBCore:Notify', src, 'Skunk Weed Processed Successfully', "success")                                                                         				
end)

RegisterServerEvent('qb-whitewidow:ProcessSkunkAdd')
AddEventHandler('qb-whitewidow:ProcessSkunkAdd', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.AddItem(Config.SkunkItemRecive, math.random(1,3))
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.SkunkItemRecive], "add")
	TriggerClientEvent('QBCore:Notify', src, 'Weed Processed Successfully', "success")                                                                         				
end)

RegisterServerEvent('qb-whitewidow:ProcessOgKushAdd')
AddEventHandler('qb-whitewidow:ProcessOgKushAdd', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.AddItem(Config.OgKushItemRecive, math.random(1,3))
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.OgKushItemRecive], "add")
	TriggerClientEvent('QBCore:Notify', src, 'Og-Kush Processed Successfully', "success")                                                                         				
end)

RegisterServerEvent('qb-whitewidow:ProcessAddAk47')
AddEventHandler('qb-whitewidow:ProcessAddAk47', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.AddItem(Config.Ak47ItemRecive, math.random(1,3))
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.Ak47ItemRecive], "add")
	TriggerClientEvent('QBCore:Notify', src, 'AK-47 Processed Successfully', "success")                                                                         				
end)

RegisterServerEvent('qb-whitewidow:pickUpWeed')
AddEventHandler('qb-whitewidow:pickUpWeed', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if TriggerClientEvent("QBCore:Notify", src, "You Picked Up Some Weed", "success", 8000) then
		Player.Functions.AddItem(Config.WeedItemPickUp, 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.WeedItemPickUp], "add")
	end
end)

RegisterServerEvent('qb-whitewidow:pickUpSkunk')
AddEventHandler('qb-whitewidow:pickUpSkunk', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if TriggerClientEvent("QBCore:Notify", src, "You Picked Up Some Skunk", "success", 8000) then
		Player.Functions.AddItem(Config.SkunkItemPickUp, 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.SkunkItemPickUp], "add")
	end
end)

RegisterServerEvent('qb-whitewidow:pickUpAk47')
AddEventHandler('qb-whitewidow:pickUpAk47', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if TriggerClientEvent("QBCore:Notify", src, "You Picked Up Some AK-47", "success", 8000) then
		Player.Functions.AddItem(Config.Ak47ItemPickUp, 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.Ak47ItemPickUp], "add")
	end
end)

RegisterServerEvent('qb-whitewidow:pickUpOgKush')
AddEventHandler('qb-whitewidow:pickUpOgKush', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if TriggerClientEvent("QBCore:Notify", src, "You Picked Up Some Og-Kush", "success", 8000) then
		Player.Functions.AddItem(Config.OgKushItemPickUp, 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.OgKushItemPickUp], "add")
	end
end)

-- קופה

RegisterServerEvent("qb-whitewidow:bill:player")
AddEventHandler("qb-whitewidow:bill:player", function(playerId, amount)
        local biller = QBCore.Functions.GetPlayer(source)
        local billed = QBCore.Functions.GetPlayer(tonumber(playerId))
        local amount = tonumber(amount)
        if biller.PlayerData.job.name == 'whitewidow' then
            if billed ~= nil then
                if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
                    if amount and amount > 0 then
                       if Config.SQL == 'oxmysql' then
                        exports.oxmysql:insert('INSERT INTO phone_invoices (citizenid, amount, society, sender) VALUES (:citizenid, :amount, :society, :sender)', {
                            ['citizenid'] = billed.PlayerData.citizenid,
                            ['amount'] = amount,
                            ['society'] = biller.PlayerData.job.name,
                            ['sender'] = biller.PlayerData.charinfo.firstname
                        })
                        else
                          exports.ghmattimysql:execute('INSERT INTO phone_invoices (citizenid, amount, society, sender) VALUES (@citizenid, @amount, @society, @sender)', {
                            ['@citizenid'] = billed.PlayerData.citizenid,
                            ['@amount'] = amount,
                            ['@society'] = biller.PlayerData.job.name,
                            ['@sender'] = biller.PlayerData.charinfo.firstname
                           })
                       end
                        TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
                        TriggerClientEvent('QBCore:Notify', source, 'Invoice Successfully Sent', 'success')
                        TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, 'New Invoice Received')
                    else
                        TriggerClientEvent('QBCore:Notify', source, 'Must Be A Valid Amount Above 0', 'error')
                    end
                else
                    TriggerClientEvent('QBCore:Notify', source, 'You Cannot Bill Yourself', 'error')
                end
            else
                TriggerClientEvent('QBCore:Notify', source, 'Player Not Online', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, 'No Access', 'error')
        end
end)