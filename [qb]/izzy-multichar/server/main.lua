RegisterServerEvent("izzy-multichar:server:resetCurrentChar", function()
    local src = source

    TriggerEvent('esx:playerLogout', src)
    Config.FrameworkSharedObjects[Config.Framework]().Players[src] = nil
end)

local function GiveStarterItems(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    for _, v in pairs(QBCore.Shared.StarterItems) do
        local info = {}
        if v.item == "id_card" then
            info.citizenid = Player.PlayerData.citizenid
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.gender = Player.PlayerData.charinfo.gender
            info.nationality = Player.PlayerData.charinfo.nationality
        elseif v.item == "driver_license" then
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.type = "Class C Driver License"
        end
        Player.Functions.AddItem(v.item, v.amount, false, info)
    end
end

Config.FrameworkFunctions._RSC('izzy-multichar:server:redeemKeycode', function(source, cb, data)
    local src = source
    local license = Config.FrameworkFunctions._GPI(src)

    local keys = json.decode(LoadResourceFile(GetCurrentResourceName(), 'keys.json'))

    if keys[data] ~= nil then
        if keys[data].used == false then
            keys[data].used = true
            SaveResourceFile(GetCurrentResourceName(), 'keys.json', json.encode(keys), -1)

            local maxValues = json.decode(LoadResourceFile(GetCurrentResourceName(), 'maxValues.json'))

            if maxValues[license] ~= nil then
                maxValues[license] = maxValues[license] + 1
            else
                maxValues[license] = 1
            end

            SaveResourceFile(GetCurrentResourceName(), 'maxValues.json', json.encode(maxValues), -1)
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

Config.FrameworkFunctions._RSC('izzy-multichar:server:getCharDatas', function(source, cb)
    local src = source
    local license = Config.FrameworkFunctions._GPI(src)
    Config.FrameworkFunctions._GETCHARS(src, function(chars)
        local maxValue = 0

        local maxValues = json.decode(LoadResourceFile(GetCurrentResourceName(), 'maxValues.json'))

        if maxValues[license] ~= nil then
            maxValue = maxValues[license]
        else
            maxValue = 0
        end

        cb({chars = chars, maxValue = maxValue})
    end)
end)

Config.FrameworkFunctions._RSC('izzy-multichar:server:getCharData', function(source, cb, data)
    local src = source

    Config.FrameworkFunctions._GETCHAR(src, function(char)
        cb(char)
    end, data.identifier)
end)

RegisterServerEvent("izzy-multichar:server:loadCharPed", function(identifier, gender)
    local src = source
    local ped = GetPlayerPed(src)

    Config.FrameworkFunctions._GETPLAYERSKIN(src, function(data)
        TriggerClientEvent('izzy-multichar:client:loadCharPed', src, data, gender)
    end, identifier, gender)
end)

RegisterServerEvent("izzy-multichar:server:toggleBucket", function(toggle)
    local src = source

    local bucket = toggle and math.random(0, 65535) or 0

    SetPlayerRoutingBucket(src, bucket)
end)

Config.FrameworkFunctions._RSC('izzy-multichar:server:createChar', function(source, cb, payload)
    local src = source
    Config.FrameworkFunctions._CREATECHAR(src, function(result)
        cb(result)
    end, payload)
end)

Config.FrameworkFunctions._RSC('izzy-multichar:server:playChar', function(source, cb, identifier)
    local src = source
    Config.FrameworkFunctions._PLAYCHAR(src, function(result)
        cb(result)
    end, identifier)
end)