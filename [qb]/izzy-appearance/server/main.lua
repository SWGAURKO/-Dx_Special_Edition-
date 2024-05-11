if Config.Framework == "qb" then
    QBCore = exports['qb-core']:GetCoreObject()
else
    ESX = exports["es_extended"]:getSharedObject()
end

RegisterServerEvent("sh-creation:saveSkin", function(model, skin)
    local src = source

    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(src)
        if model ~= nil and skin ~= nil then
            MySQL.query('DELETE FROM playerskins WHERE citizenid = ?', { Player.PlayerData.citizenid }, function()
                MySQL.insert('INSERT INTO playerskins (citizenid, model, skin, active) VALUES (?, ?, ?, ?)', {
                    Player.PlayerData.citizenid,
                    model,
                    skin,
                    1
                })
            end)
        end
    else
        local xPlayer = ESX.GetPlayerFromId(src)
        if model ~= nil and skin ~= nil then
            MySQL.Async.execute('DELETE FROM playerskins WHERE citizenid = @identifier', {
                ['@identifier'] = xPlayer.getIdentifier()
            }, function(rowsChanged)
                MySQL.Async.execute(
                'INSERT INTO playerskins (citizenid, model, skin, active) VALUES (@identifier, @model, @skin, @active)',
                    {
                        ['@identifier'] = xPlayer.getIdentifier(),
                        ['@model'] = model,
                        ['@skin'] = skin,
                        ['@active'] = 1
                    })
            end)
        end
    end
end)

if Config.Framework == "qb" then
    QBCore.Functions.CreateCallback('sh-creation:saveSkinData', function(source, cb, data)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)

        if data.type == "clothing" then
            local citizenid = Player.PlayerData.citizenid

            MySQL.Async.execute(
            'INSERT INTO saved_skins (license, model, mugshot, type, skin, skin2) VALUES (@citizenid, @model, @mugshot, @type, @skin, @skin2)',
                {
                    ['@citizenid'] = citizenid,
                    ['@model'] = data.model,
                    ['@mugshot'] = data.mugshot,
                    ['@type'] = data.type,
                    ['@skin'] = json.encode(data.skin),
                    ['@skin2'] = json.encode(data.skin2)
                }, function(rowsChanged)
                MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @citizenid AND type = @type', {
                    ['@citizenid'] = citizenid,
                    ['@type'] = data.type
                }, function(skins)
                    cb(skins)
                end)
            end)
        elseif data.type == "barber" then
            local citizenid = Player.PlayerData.citizenid

            MySQL.Async.execute(
            'INSERT INTO saved_skins (license, model, mugshot, type, skin, skin2) VALUES (@citizenid, @model, @mugshot, @type, @skin, @skin2)',
                {
                    ['@citizenid'] = citizenid,
                    ['@model'] = data.model,
                    ['@mugshot'] = data.mugshot,
                    ['@type'] = data.type,
                    ['@skin'] = json.encode(data.skin),
                    ['@skin2'] = json.encode(data.skin2)
                }, function(rowsChanged)
                MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @citizenid AND type = @type', {
                    ['@citizenid'] = citizenid,
                    ['@type'] = data.type
                }, function(skins)
                    cb(skins)
                end)
            end)
        elseif data.type == "surgery" then
            local citizenid = Player.PlayerData.citizenid

            MySQL.Async.execute(
            'INSERT INTO saved_skins (license, model, mugshot, type, skin, skin2) VALUES (@citizenid, @model, @mugshot, @type, @skin, @skin2)',
                {
                    ['@citizenid'] = citizenid,
                    ['@model'] = data.model,
                    ['@mugshot'] = data.mugshot,
                    ['@type'] = data.type,
                    ['@skin'] = json.encode(data.skin),
                    ['@skin2'] = json.encode(data.skin2)
                }, function(rowsChanged)
                MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @citizenid AND type = @type', {
                    ['@citizenid'] = citizenid,
                    ['@type'] = data.type
                }, function(skins)
                    cb(skins)
                end)
            end)
        else
            local license = Player.PlayerData.license

            MySQL.Async.execute(
            'INSERT INTO saved_skins (license, model, mugshot, type, skin, skin2) VALUES (@license, @model, @mugshot, @type, @skin, @skin2)',
                {
                    ['@license'] = license,
                    ['@model'] = data.model,
                    ['@mugshot'] = data.mugshot,
                    ['@type'] = data.type,
                    ['@skin'] = json.encode(data.skin),
                    ['@skin2'] = json.encode(data.skin2)
                }, function(rowsChanged)
                MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @license', {
                    ['@license'] = license
                }, function(skins)
                    cb(skins)
                end)
            end)
        end
    end)
else
    ESX.RegisterServerCallback('sh-creation:saveSkinData', function(source, cb, data)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

        if data.type == "clothing" then
            local citizenid = xPlayer.getIdentifier()

            MySQL.Async.execute(
            'INSERT INTO saved_skins (license, model, mugshot, type, skin, skin2) VALUES (@citizenid, @model, @mugshot, @type, @skin, @skin2)',
                {
                    ['@citizenid'] = citizenid,
                    ['@model'] = data.model,
                    ['@mugshot'] = data.mugshot,
                    ['@type'] = data.type,
                    ['@skin'] = json.encode(data.skin),
                    ['@skin2'] = json.encode(data.skin2)
                }, function(rowsChanged)
                MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @citizenid AND type = @type', {
                    ['@citizenid'] = citizenid,
                    ['@type'] = data.type
                }, function(skins)
                    cb(skins)
                end)
            end)
        elseif data.type == "barber" then
            local citizenid = xPlayer.getIdentifier()

            MySQL.Async.execute(
            'INSERT INTO saved_skins (license, model, mugshot, type, skin, skin2) VALUES (@citizenid, @model, @mugshot, @type, @skin, @skin2)',
                {
                    ['@citizenid'] = citizenid,
                    ['@model'] = data.model,
                    ['@mugshot'] = data.mugshot,
                    ['@type'] = data.type,
                    ['@skin'] = json.encode(data.skin),
                    ['@skin2'] = json.encode(data.skin2)
                }, function(rowsChanged)
                MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @citizenid AND type = @type', {
                    ['@citizenid'] = citizenid,
                    ['@type'] = data.type
                }, function(skins)
                    cb(skins)
                end)
            end)
        elseif data.type == "surgery" then
            local citizenid = xPlayer.getIdentifier()

            MySQL.Async.execute(
            'INSERT INTO saved_skins (license, model, mugshot, type, skin, skin2) VALUES (@citizenid, @model, @mugshot, @type, @skin, @skin2)',
                {
                    ['@citizenid'] = citizenid,
                    ['@model'] = data.model,
                    ['@mugshot'] = data.mugshot,
                    ['@type'] = data.type,
                    ['@skin'] = json.encode(data.skin),
                    ['@skin2'] = json.encode(data.skin2)
                }, function(rowsChanged)
                MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @citizenid AND type = @type', {
                    ['@citizenid'] = citizenid,
                    ['@type'] = data.type
                }, function(skins)
                    cb(skins)
                end)
            end)
        else
            local license = xPlayer.getIdentifier()

            MySQL.Async.execute(
            'INSERT INTO saved_skins (license, model, mugshot, type, skin, skin2) VALUES (@license, @model, @mugshot, @type, @skin, @skin2)',
                {
                    ['@license'] = license,
                    ['@model'] = data.model,
                    ['@mugshot'] = data.mugshot,
                    ['@type'] = data.type,
                    ['@skin'] = json.encode(data.skin),
                    ['@skin2'] = json.encode(data.skin2)
                }, function(rowsChanged)
                MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @license', {
                    ['@license'] = license
                }, function(skins)
                    cb(skins)
                end)
            end)
        end
    end)
end
if Config.Framework == "qb" then
    QBCore.Functions.CreateCallback('sh-creation:deleteSkinData', function(source, cb, data)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)


        if data.type == "clothing" then
            local citizenid = Player.PlayerData.citizenid

            MySQL.Async.execute('DELETE FROM saved_skins WHERE id = @id', {
                ['@id'] = data.id
            }, function(rowsChanged)
                MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @citizenid AND type = @type', {
                    ['@citizenid'] = citizenid,
                    ['@type'] = data.type
                }, function(skins)
                    cb(skins)
                end)
            end)
        elseif data.type == "barber" then
            local citizenid = Player.PlayerData.citizenid

            MySQL.Async.execute('DELETE FROM saved_skins WHERE id = @id', {
                ['@id'] = data.id
            }, function(rowsChanged)
                MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @citizenid AND type = @type', {
                    ['@citizenid'] = citizenid,
                    ['@type'] = data.type
                }, function(skins)
                    cb(skins)
                end)
            end)
        elseif data.type == "surgery" then
            local citizenid = Player.PlayerData.citizenid

            MySQL.Async.execute('DELETE FROM saved_skins WHERE id = @id', {
                ['@id'] = data.id
            }, function(rowsChanged)
                MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @citizenid AND type = @type', {
                    ['@citizenid'] = citizenid,
                    ['@type'] = data.type
                }, function(skins)
                    cb(skins)
                end)
            end)
        else
            local license = Player.PlayerData.license

            MySQL.Async.execute('DELETE FROM saved_skins WHERE id = @id', {
                ['@id'] = data.id
            }, function(rowsChanged)
                MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @license', {
                    ['@license'] = license
                }, function(skins)
                    cb(skins)
                end)
            end)
        end
    end)
else
    ESX.RegisterServerCallback('sh-creation:deleteSkinData', function(source, cb, data)
        local src = source

        local xPlayer = ESX.GetPlayerFromId(src)

        if data.type == "clothing" then
            local citizenid = xPlayer.getIdentifier()

            MySQL.Async.execute('DELETE FROM saved_skins WHERE id = @id', {
                ['@id'] = data.id
            }, function(rowsChanged)
                MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @citizenid AND type = @type', {
                    ['@citizenid'] = citizenid,
                    ['@type'] = data.type
                }, function(skins)
                    cb(skins)
                end)
            end)
        elseif data.type == "barber" then
            local citizenid = xPlayer.getIdentifier()

            MySQL.Async.execute('DELETE FROM saved_skins WHERE id = @id', {
                ['@id'] = data.id
            }, function(rowsChanged)
                MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @citizenid AND type = @type', {
                    ['@citizenid'] = citizenid,
                    ['@type'] = data.type
                }, function(skins)
                    cb(skins)
                end)
            end)
        elseif data.type == "surgery" then
            local citizenid = xPlayer.getIdentifier()

            MySQL.Async.execute('DELETE FROM saved_skins WHERE id = @id', {
                ['@id'] = data.id
            }, function(rowsChanged)
                MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @citizenid AND type = @type', {
                    ['@citizenid'] = citizenid,
                    ['@type'] = data.type
                }, function(skins)
                    cb(skins)
                end)
            end)
        else
            local citizenid = xPlayer.getIdentifier()

            MySQL.Async.execute('DELETE FROM saved_skins WHERE id = @id', {
                ['@id'] = data.id
            }, function(rowsChanged)
                MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @license AND type = @tpye', {
                    ['@license'] = license,
                    ['@type'] = "character"
                }, function(skins)
                    cb(skins)
                end)
            end)
        end
    end)
end

if Config.Framework == "qb" then
    QBCore.Functions.CreateCallback('sh-creation:getSkinData', function(source, cb, data)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)

        if data.type == "clothing" or data.type == "clothing_room" then
            local citizenid = Player.PlayerData.citizenid

            MySQL.Async.fetchAll('SELECT * FROM saved_skins WHERE id = @id AND license = @citizenid', {
                ['@id'] = data.id,
                ['@citizenid'] = citizenid
            }, function(skin)
                cb(skin)
            end)
        elseif data.type == "barber" then
            local citizenid = Player.PlayerData.citizenid

            MySQL.Async.fetchAll('SELECT * FROM saved_skins WHERE id = @id AND license = @citizenid', {
                ['@id'] = data.id,
                ['@citizenid'] = citizenid
            }, function(skin)
                cb(skin)
            end)
        elseif data.type == "surgery" then
            local citizenid = Player.PlayerData.citizenid

            MySQL.Async.fetchAll('SELECT * FROM saved_skins WHERE id = @id AND license = @citizenid', {
                ['@id'] = data.id,
                ['@citizenid'] = citizenid
            }, function(skin)
                cb(skin)
            end)
        else
            local license = Player.PlayerData.license

            MySQL.Async.fetchAll('SELECT * FROM saved_skins WHERE id = @id AND license = @license', {
                ['@id'] = data.id,
                ['@license'] = license
            }, function(skin)
                cb(skin)
            end)
        end
    end)
else
    ESX.RegisterServerCallback('sh-creation:getSkinData', function(source, cb, data)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

        if data.type == "clothing" then
            local citizenid = xPlayer.getIdentifier()

            MySQL.Async.fetchAll('SELECT * FROM saved_skins WHERE id = @id AND license = @citizenid', {
                ['@id'] = data.id,
                ['@citizenid'] = citizenid
            }, function(skin)
                cb(skin)
            end)
        elseif data.type == "barber" then
            local citizenid = xPlayer.getIdentifier()

            MySQL.Async.fetchAll('SELECT * FROM saved_skins WHERE id = @id AND license = @citizenid', {
                ['@id'] = data.id,
                ['@citizenid'] = citizenid
            }, function(skin)
                cb(skin)
            end)
        elseif data.type == "surgery" then
            local citizenid = xPlayer.getIdentifier()

            MySQL.Async.fetchAll('SELECT * FROM saved_skins WHERE id = @id AND license = @citizenid', {
                ['@id'] = data.id,
                ['@citizenid'] = citizenid
            }, function(skin)
                cb(skin)
            end)
        else
            local citizenid = xPlayer.getIdentifier()

            MySQL.Async.fetchAll('SELECT * FROM saved_skins WHERE id = @id AND license = @license', {
                ['@id'] = data.id,
                ['@license'] = license
            }, function(skin)
                cb(skin)
            end)
        end
    end)
end

if Config.Framework == "qb" then
    QBCore.Functions.CreateCallback('sh-creation:getCurrentSkinData', function(source, cb, data)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)

        local citizenid = Player.PlayerData.citizenid

        MySQL.Async.fetchAll('SELECT * FROM playerskins WHERE citizenid = @citizenid', {
            ['@citizenid'] = citizenid
        }, function(skin)
            cb(json.decode(skin[1].skin))
        end)
    end)
else
    ESX.RegisterServerCallback('sh-creation:getCurrentSkinData', function(source, cb, data)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

        local citizenid = xPlayer.getIdentifier()

        MySQL.Async.fetchAll('SELECT * FROM playerskins WHERE citizenid = @citizenid', {
            ['@citizenid'] = citizenid
        }, function(skin)
            cb(json.decode(skin[1].skin))
        end)
    end)

    ESX.RegisterServerCallback('sh-creation:getCurrentSkinData2', function(source, cb, data)
        local citizenid = data

        MySQL.Async.fetchAll('SELECT * FROM playerskins WHERE citizenid = @citizenid', {
            ['@citizenid'] = citizenid
        }, function(skin)
            cb(json.decode(skin[1].skin))
        end)
    end)
end

if Config.Framework == "qb" then
    QBCore.Functions.CreateCallback('sh-creation:getSkinDatas', function(source, cb, data)
        local src = source

        local license = QBCore.Functions.GetPlayer(src).PlayerData.license

        MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @license AND license = @license', {
            ['@license'] = license
        }, function(skins)
            cb(skins)
        end)
    end)
else
    ESX.RegisterServerCallback('sh-creation:getSkinDatas', function(source, cb, data)
        local src = source

        local license = ESX.GetPlayerFromId(src).getIdentifier()

        MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @license AND type = @type', {
            ['@license'] = license,
            ['@type'] = "character"
        }, function(skins)
            cb(skins)
        end)
    end)
end

if Config.Framework == "qb" then
    QBCore.Functions.CreateCallback('sh-creation:getClothingDatas', function(source, cb, data)
        local src = source

        local cid = QBCore.Functions.GetPlayer(src).PlayerData.citizenid

        MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @citizenid AND type = @type', {
            ['@citizenid'] = cid,
            ['@type'] = "clothing"
        }, function(skins)
            cb(skins)
        end)
    end)
else
    ESX.RegisterServerCallback('sh-creation:getClothingDatas', function(source, cb, data)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

        local cid = xPlayer.getIdentifier()

        MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @citizenid AND type = @type', {
            ['@citizenid'] = cid,
            ['@type'] = "clothing"
        }, function(skins)
            cb(skins)
        end)
    end)
end

if Config.Framework == "qb" then
    QBCore.Functions.CreateCallback('sh-creation:getBarberDatas', function(source, cb, data)
        local src = source

        local cid = QBCore.Functions.GetPlayer(src).PlayerData.citizenid

        MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @citizenid AND type = @type', {
            ['@citizenid'] = cid,
            ['@type'] = "barber"
        }, function(skins)
            cb(skins)
        end)
    end)
else
    ESX.RegisterServerCallback('sh-creation:getBarberDatas', function(source, cb, data)
        local src = source

        local cid = ESX.GetPlayerFromId(src).getIdentifier()

        MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @citizenid AND type = @type', {
            ['@citizenid'] = cid,
            ['@type'] = "barber"
        }, function(skins)
            cb(skins)
        end)
    end)
end

if Config.Framework == "qb" then
    QBCore.Functions.CreateCallback('sh-creation:getSurgeryDatas', function(source, cb, data)
        local src = source

        local cid = QBCore.Functions.GetPlayer(src).PlayerData.citizenid

        MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @citizenid AND type = @type', {
            ['@citizenid'] = cid,
            ['@type'] = "surgery"
        }, function(skins)
            cb(skins)
        end)
    end)
else
    ESX.RegisterServerCallback('sh-creation:getSurgeryDatas', function(source, cb, data)
        local src = source

        local cid = ESX.GetPlayerFromId(src).getIdentifier()

        MySQL.Async.fetchAll('SELECT id, mugshot FROM saved_skins WHERE license = @citizenid AND type = @type', {
            ['@citizenid'] = cid,
            ['@type'] = "surgery"
        }, function(skins)
            cb(skins)
        end)
    end)
end

if Config.Framework == "qb" then
    QBCore.Functions.CreateCallback('sh-creation:server:buyClothing', function(source, cb, data)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)

        local price = Config.ClothingShopPrice

        if Player.PlayerData.money.cash >= price then
            Player.Functions.RemoveMoney('cash', price, "bought clothing")
            cb({
                status = true
            })
        elseif Player.PlayerData.money.bank >= price then
            Player.Functions.RemoveMoney('bank', price, "bought clothing")
            cb({
                status = true
            })
        else
            cb({
                status = false
            })
        end
    end)
else
    ESX.RegisterServerCallback('sh-creation:server:buyClothing', function(source, cb, data)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

        local price = Config.ClothingShopPrice

        local PlayerMoney = xPlayer.getMoney()

        if PlayerMoney >= price then
            xPlayer.removeMoney(price)
            cb({
                status = true
            })
        elseif xPlayer.getAccount('bank').money >= price then
            xPlayer.removeAccountMoney('bank', price)
            cb({
                status = true
            })
        else
            cb({
                status = false
            })
        end
    end)
end

RegisterServerEvent('sh-creation:server:setBucket')
AddEventHandler('sh-creation:server:setBucket', function(bucket)
    local src = source
    SetPlayerRoutingBucket(src, bucket)
end)

if Config.Framework == "qb" then
    QBCore.Commands.Add("skin", "Open skin menu", {}, false, function(source, args)
        local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
        if Player then
            if QBCore.Functions.HasPermission(source, 'god') or IsPlayerAceAllowed(source, 'command') then
                TriggerClientEvent('sh-creation:client:openMenu', args[1])
            end
        end
    end)
else
    ESX.RegisterCommand('skin', 'admin', function(source, args, user)
        TriggerClientEvent('sh-creation:client:openMenu', tonumber(args[1]))
    end, false, { help = 'Open skin menu' })
end
