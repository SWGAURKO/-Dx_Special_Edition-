function parseString(input)
    local index = string.find(input, ":")

    if index then
        local key = string.sub(input, 1, index - 1)
        local value = string.sub(input, index + 1)
        return { key, value }
    else
        return nil
    end
end

function formatDate(input)
    local month, day, year = string.match(input, "(%d+)/(%d+)/(%d+)")

    if month and day and year then
        return string.format("%04d-%02d-%02d", tonumber(year), tonumber(month), tonumber(day))
    else
        return nil
    end
end

Config = {}

Config.Framework = "qb" -- old_esx/esx/qb

Config.StarterItems = {
    ['phone'] = { amount = 1, item = 'phone' },
    -- ['id_card'] = { amount = 1, item = 'id_card' }, -- ENABLE IF ITS QBCORE
    -- ['driver_license'] = { amount = 1, item = 'driver_license' }, -- ENABLE IF ITS QBCORE
}

Config.GiveStarterItems = true

Config.ServerName = "IZZY RP" -- Server Name
Config.ServerLogo = "https://cdn.discordapp.com/attachments/1173039522653671474/1185473431546896444/image.png" -- Must be a png and background transparent
Config.ServerDescription = "Tworst RP is the best roleplay server ever. Nulla sit a augue molestie et purus massa Magnis sit nunc convallis pretium."

Config.TebexStore = "https://izzy.tebex.io/" -- Tebex Store Link

Config.DefaultExtraCharacterSlots = 1       -- Default Extra Character Slots (0 means you can create only 1 character)

Config.SkinSystem = "izzy-appearance"        -- izzy-appearance or illenium-appearance or qb-clothing or esx

Config.SpawnSelector = "izzy_spawn"          -- izzy_spawn or apartments

Config.DoYouUseOxInventory = true            -- false or true

Config.MaxCharacterSlots = 2

Config.FrameworkSharedObject = nil

Config.OLD_ESX = nil

Config.FrameworkSharedObjects = {
    ['qb'] = function()
        if Config.FrameworkSharedObject == nil then
            Config.FrameworkSharedObject = exports['qb-core']:GetCoreObject()
        end
        return Config.FrameworkSharedObject
    end,
    ['esx'] = function()
        if Config.FrameworkSharedObject == nil then
            Config.FrameworkSharedObject = exports['es_extended']:getSharedObject()
        end

        return Config.FrameworkSharedObject
    end,
    ['old_esx'] = function()
        if Config.OLD_ESX then
            return Config.OLD_ESX
        end

        ESX = nil

        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(30)
        end

        Config.OLD_ESX = ESX

        return ESX
    end
}

Config.FrameworkFunction = {
    ['qb'] = {
        ['_RSC'] = function(name, cb, ...)
            Config.FrameworkSharedObjects[Config.Framework]().Functions.CreateCallback(name, cb, ...)
        end,
        ['_TSC'] = function(name, cb, ...)
            Config.FrameworkSharedObjects[Config.Framework]().Functions.TriggerCallback(name, cb, ...)
        end,
        ['_GPI'] = function(source)
            return Config.FrameworkSharedObjects[Config.Framework]().Functions.GetIdentifier(source, 'license')
        end,
        ['_GETCHARS'] = function(source, cb)
            local chars = {}
            local src = source
            local license = Config.FrameworkSharedObjects[Config.Framework]().Functions.GetIdentifier(src, 'license')

            MySQL.Async.fetchAll('SELECT * FROM players WHERE license = ?', { license }, function(result)
                for i = 1, (#result), 1 do
                    local insertData = {
                        identifierChar = result[i].citizenid,
                        name = json.decode(result[i].charinfo).firstname,
                        surname = json.decode(result[i].charinfo).lastname,
                        job = json.decode(result[i].job).label,
                        cash = json.decode(result[i].money).cash,
                        bank = json.decode(result[i].money).bank,
                        nationality = json.decode(result[i].charinfo).nationality,
                        dateofbirth = json.decode(result[i].charinfo).birthdate,
                        gender = json.decode(result[i].charinfo).gender,
                    }

                    table.insert(chars, insertData)
                end
                cb(chars)
            end)
        end,
        ['_GETCHAR'] = function(source, cb, identifier)
            local char = {}

            MySQL.Async.fetchAll('SELECT * FROM players WHERE citizenid = ?', { identifier }, function(result)
                for i = 1, (#result), 1 do
                    local insertData = {
                        identifierChar = result[i].citizenid,
                        firstname = json.decode(result[i].charinfo).firstname,
                        lastname = json.decode(result[i].charinfo).lastname,
                        job = json.decode(result[i].job).label,
                        cash = json.decode(result[i].money).cash,
                        bank = json.decode(result[i].money).bank,
                        nationality = json.decode(result[i].charinfo).nationality,
                        dateofbirth = json.decode(result[i].charinfo).birthdate,
                        gender = json.decode(result[i].charinfo).gender,
                    }
                    cb(insertData)
                end
            end)
        end,
        ['_GETPLAYERSKIN'] = function(source, cb, identifier, gender)
            local char = {}
            
            MySQL.Async.fetchAll('SELECT * FROM playerskins WHERE citizenid = ?', { identifier }, function(result)
                insertData = {
                    citizenid = identifier,
                    model = false,
                    skin = false,
                    gender = gender
                }

                for i = 1, (#result), 1 do
                    insertData = {
                        citizenid = identifier,
                        model = result[i].model,
                        skin = result[i].skin,
                        gender = gender
                    }
                end

                cb(insertData)
            end)
        end,
        ['_CREATECHAR'] = function(source, cb, payload)
            local src = source
            local license = Config.FrameworkSharedObjects[Config.Framework]().Functions.GetIdentifier(src, 'license')
            Config.FrameworkSharedObjects[Config.Framework]().Player.Login(src, false, {charinfo=payload})
            local charIdentifier = Config.FrameworkSharedObjects[Config.Framework]().Functions.GetPlayer(src).PlayerData.citizenid
            if Config.DoYouUseOxInventory then
                MySQL.Async.execute('UPDATE players SET inventory = @inventory WHERE citizenid = @citizenid', {
                    ['@inventory'] = "[]",
                    ['@citizenid'] = charIdentifier
                })
            end

            if Config.SpawnSelector == "izzy_spawn" then
                Config.FrameworkFunctions._GETPLAYERSKIN(src, function(data)
                    if data.skin == false then
                        isNew = true
                    end

                    if isNew then
                        TriggerClientEvent("izzy-multichar:client:isNew", src)
                    else
                        TriggerClientEvent("izzy-spawnselector:open", src)
                    end
                end, identifier, nil)
            end

            cb(charIdentifier)

            if Config.GiveStarterItems then
                Config.FrameworkFunctions._GIVESTARTERITEMS(src)
            end
        end,
        ['_GIVESTARTERITEMS'] = function(source)
            local src = source
            local Player = Config.FrameworkSharedObjects[Config.Framework]().Functions.GetPlayer(src)

            for _, v in pairs(Config.StarterItems) do
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
        end,
        ['_PLAYCHAR'] = function(source, cb, identifier)
            local src = source
            local isNew = false
            local _identifier = false

            if Config.FrameworkSharedObjects[Config.Framework]().Functions.GetPlayer(src) ~= nil then
                _identifier = Config.FrameworkSharedObjects[Config.Framework]().Functions.GetPlayer(src)
                    .PlayerData.citizenid
            else
                _identifier = nil
            end

            if identifier ~= _identifier then
                Config.FrameworkSharedObjects[Config.Framework]().Player.Login(src, identifier)
            end

            print('^2[qb-core]^7 ' .. GetPlayerName(src) .. ' (Citizen ID: ' .. identifier .. ') has succesfully loaded!')
            Config.FrameworkSharedObjects[Config.Framework]().Commands.Refresh(src)

            if Config.SpawnSelector == "izzy_spawn" then
                Config.FrameworkFunctions._GETPLAYERSKIN(src, function(data)
                    if data.skin == false then
                        isNew = true
                    end

                    if isNew then
                        TriggerClientEvent("izzy-multichar:client:isNew", src)
                    else
                        TriggerClientEvent("izzy-spawnselector:open", src)
                    end
                end, identifier, nil)
            else
                Config.FrameworkFunctions._GETPLAYERSKIN(src, function(data)
                    if data.skin == false then
                        isNew = true
                    end

                    if isNew then
                        if Config.SkinSystem == "izzy-appearance" then
                            TriggerClientEvent("izzy-multichar:client:isNew", src)
                        else
                            TriggerClientEvent("izzy-multichar:client:isNew", src)
                        end
                    else
                        TriggerEvent('QBCore:Server:OnPlayerLoaded')
                        TriggerClientEvent('QBCore:Client:OnPlayerLoaded', src)
                        TriggerEvent('qb-houses:server:SetInsideMeta', 0, false)
                        TriggerEvent('qb-apartments:server:SetInsideMeta', 0, 0, false)
                        TriggerClientEvent('qb-weathersync:client:EnableSync', src)
                        TriggerClientEvent("izzy-multichar:client:spawn", src)
                    end
                end, identifier, nil)
            end
            cb(true)
        end,
        ['C_LOADPLAYERSKIN'] = function(data)
            -- data = {citizenid(string), model(json encoded), skin(number)}
            SetEntityVisible(PlayerPedId(), true)

            if data.skin ~= false then
                if Config.SkinSystem == "izzy-appearance" then
                    data.model = data.model ~= nil and tonumber(data.model) or false
                    Citizen.CreateThread(function()
                        local model = data.model
                        RequestModel(model)
                        while not HasModelLoaded(model) do
                            RequestModel(model)
                            Citizen.Wait(0)
                        end
                        SetPlayerModel(PlayerId(), model)
                        SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 2)

                        TriggerEvent('sh-creation:client:loadData', json.decode(data.skin), PlayerPedId())
                    end)
                else
                     if Config.SkinSystem == "illenium-appearance" then

                    local model = GetHashKey(data.model)
                    Citizen.CreateThread(function()
                        RequestModel(model)
                        while not HasModelLoaded(model) do
                            RequestModel(model)
                            Citizen.Wait(0)
                        end
                        SetPlayerModel(PlayerId(), model)
                        SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 2)
                                
                        data.skin = json.decode(data.skin)
                        exports['illenium-appearance']:setPedAppearance(PlayerPedId(), data.skin)
                        print("illenium loaded")
                        print(data.skin)
                        print(data.model)
                    end)
                        
                        
                     
                        
                        else
                        data.model = data.model ~= nil and tonumber(data.model) or false
                    Citizen.CreateThread(function()
                        local model = data.model
                        RequestModel(model)
                        while not HasModelLoaded(model) do
                            RequestModel(model)
                            Citizen.Wait(0)
                        end
                        SetPlayerModel(PlayerId(), model)
                        SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 2)

                        TriggerEvent('skinchanger:loadSkin', data.skin)
                    end)
                end
                    
                end
            else
                if Config.SkinSystem == "izzy-appearance" then
                    local skin = "mp_f_freemode_01"

                    if data.gender == 0 then
                        skin = "mp_m_freemode_01"
                    end

                    local model = GetHashKey(skin)
                    Citizen.CreateThread(function()
                        RequestModel(model)
                        while not HasModelLoaded(model) do
                            RequestModel(model)
                            Citizen.Wait(0)
                        end
                        SetPlayerModel(PlayerId(), model)
                        SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 2)
                    end)
                end

                if Config.SkinSystem == "illenium-appearance" then
                    local skin = "mp_f_freemode_01"

                    if data.gender == 0 then
                        skin = "mp_m_freemode_01"
                    end

                    local model = GetHashKey(skin)
                    Citizen.CreateThread(function()
                        RequestModel(model)
                        while not HasModelLoaded(model) do
                            RequestModel(model)
                            Citizen.Wait(0)
                        end
                        SetPlayerModel(PlayerId(), model)
                        SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 2)
                    end)
                end
            end
        end
    },
    ['esx'] = {
        ['_RSC'] = function(name, cb, ...)
            Config.FrameworkSharedObjects[Config.Framework]().RegisterServerCallback(name, cb, ...)
        end,
        ['_TSC'] = function(name, cb, ...)
            Config.FrameworkSharedObjects[Config.Framework]().TriggerServerCallback(name, cb, ...)
        end,
        ['_GPI'] = function(source)
            local license
            for k, v in ipairs(GetPlayerIdentifiers(source)) do
                if string.match(v, "license:") then
                    license = v
                    break
                end
            end
            return license
        end,
        ['_GETCHARS'] = function(source, cb)
            local chars = {}
            local src = source
            local license = Config.FrameworkFunctions._GPI(src)

            local license = parseString(license)
            license = license[2]

            local id = 'char%:' .. license

            MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier LIKE ?', { '%' .. id .. '%' }, function(result)
                for i = 1, (#result), 1 do
                    local insertData = {
                        identifierChar = result[i].identifier,
                        name = result[i].firstname,
                        surname = result[i].lastname,
                        job = "Unemployed",
                        cash = json.decode(result[i].accounts).money,
                        bank = json.decode(result[i].accounts).bank,
                        nationality = nil,
                        dateofbirth = formatDate(result[i].dateofbirth),
                        gender = (result[i].sex == "m") and 0 or 1,
                    }
                    table.insert(chars, insertData)

                    MySQL.Async.fetchAll('SELECT * FROM job_grades WHERE job_name = @job_name AND grade = @grade', {
                        ['@job_name'] = result[i].job,
                        ['@grade'] = result[i].job_grade
                    }, function(jobResult)
                        if jobResult[1] ~= nil then
                            _job = jobResult[1].label
                        else
                            _job = "Unemployed"
                        end

                        for k,v in ipairs(chars) do
                            if v.identifierChar == result[i].identifier then
                                chars[k].job = _job
                            end
                        end
                    end)
                end
                cb(chars)
            end)
        end,
        ['_GETCHAR'] = function(source, cb, identifier)
            local char = {}

            MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = ? LIMIT 1', { identifier }, function(result)
                for i = 1, (#result), 1 do
                    MySQL.Async.fetchAll('SELECT * FROM job_grades WHERE job_name = @job_name AND grade = @grade', {
                        ['@job_name'] = result[i].job,
                        ['@grade'] = result[i].job_grade
                    }, function(jobResult)
                        if jobResult[1] ~= nil then
                            _job = jobResult[1].label
                        end
                    end)


                    local insertData = {
                        identifierChar = result[i].identifier,
                        firstname = result[i].firstname,
                        lastname = result[i].lastname,
                        job = _job,
                        cash = json.decode(result[i].accounts).money,
                        bank = json.decode(result[i].accounts).bank,
                        nationality = nil,
                        dateofbirth = formatDate(result[i].dateofbirth),
                        gender = (result[i].sex == "m") and 0 or 1,
                    }

                    cb(insertData)
                end
            end)
        end,
        ['_GETPLAYERSKIN'] = function(source, cb, identifier, _gender)
            local char = {}

            if Config.SkinSystem == "izzy-appearance" then
                MySQL.Async.fetchAll('SELECT * FROM playerskins WHERE citizenid = ?', { identifier }, function(result)
                    insertData = {
                        citizenid = identifier,
                        model = falsel,
                        skin = false,
                        gender = gender
                    }
    
                    for i = 1, (#result), 1 do
                        insertData = {
                            citizenid = identifier,
                            model = result[i].model,
                            skin = result[i].skin,
                            gender = gender
                        }
                    end

                    cb(insertData)
                end)
            else
                MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = ?', { identifier }, function(result)
                    insertData = {
                        citizenid = identifier,
                        model = false,
                        skin = false,
                        gender = _gender
                    }
    
                    for i = 1, (#result), 1 do
                        insertData = {
                            citizenid = identifier,
                            model = nil,
                            skin = result[i].skin,
                            gender = _gender
                        }
                    end
                    cb(insertData)
                end)
            end
        end,
        ['_CREATECHAR'] = function(source, cb, payload)
            local src = source
            local license = Config.FrameworkFunctions._GPI(src)
            local license = parseString(license)
            license = license[2]

            payload.sex = payload.gender
            Config.FrameworkFunction[Config.Framework]._GETCHARS(src, function(data)
                if data ~= nil then
                    local charSlots = 0
                    for k, v in pairs(data) do
                        charSlots = charSlots + 1
                    end

                    slot = charSlots + 1
                else
                    slot = 1
                end
                TriggerClientEvent("izzy-multichar:client:isNew", src)
                TriggerEvent('esx:onPlayerJoined', src, "char" .. slot, payload)
                cb(payload.sex)

                if Config.GiveStarterItems then
                    Config.FrameworkFunctions._GIVESTARTERITEMS(src)
                end
            end)
        end,
        ['_GIVESTARTERITEMS'] = function(source)
            local src = source

            local xPlayer = Config.FrameworkSharedObjects[Config.Framework]().GetPlayerFromId(src)

            for _, v in pairs(Config.StarterItems) do
                xPlayer.addInventoryItem(v.item, v.amount)
            end
        end,
        ['_PLAYCHAR'] = function(source, cb, identifier)
            local src = source
            local isNew = false


            local charId = parseString(identifier)
            charId = charId[1]

            TriggerEvent('esx:onPlayerJoined', src, charId)
            if Config.SpawnSelector == "izzy_spawn" then
                Config.FrameworkFunctions._GETPLAYERSKIN(src, function(data)
                    if data.skin == false then
                        isNew = true
                    end

                    if isNew then
                        TriggerClientEvent("izzy-multichar:client:isNew", src)
                    else
                        TriggerClientEvent("izzy-spawnselector:open", src)
                        TriggerClientEvent("izzy-multichar:client:spawn", src)
                        Citizen.Wait(500)
                        TriggerClientEvent('izzy-multichar:client:loadCharPed', src, data, data.gender)
                    end
                end, identifier, nil)
            else
                Config.FrameworkFunctions._GETPLAYERSKIN(src, function(data)
                    if data.skin == false then
                        isNew = true
                    end

                    if isNew then
                        if Config.SkinSystem == "izzy-appearance" then
                            TriggerClientEvent("izzy-multichar:client:isNew", src)
                        else
                            TriggerClientEvent("izzy-multichar:client:isNew", src)
                        end
                    else
                        TriggerClientEvent("izzy-multichar:client:spawn", src)
                    end
                end, identifier, nil)
            end


            cb(true)



            -- Config.FrameworkFunctions._GETLASTPOS(src, function(result)
            --     local skinData = json.decode(result.skin)
            --     TriggerClientEvent('izzy-multichar:client:spawnESX', src, result.pos, skinData.sex, skinData)
            --     cb(true)
            -- end, identifier)
        end,
        ['_GETLASTPOS'] = function(source, cb, identifier)
            local src = source

            MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = ?', { identifier }, function(result)
                Config.FrameworkFunctions._GETPLAYERSKIN(src, function(_result)
                    result[1].position = json.decode(result[1].position)

                    local insertData = {
                        x = result[1].position.x,
                        y = result[1].position.y,
                        z = result[1].position.z,
                    }

                    cb({ pos = insertData, skin = _result.skin, gender = _result.gender })
                end, identifier)
            end)
        end,
        ['C_LOADPLAYERSKIN'] = function(data)
            -- data = {citizenid(string), model(json encoded), skin(number)} one sec
            SetEntityVisible(PlayerPedId(), true)
            if data.skin ~= false then
                if Config.SkinSystem == "izzy-appearance" then
                    data.model = data.model ~= nil and tonumber(data.model) or false

                    if data.model == 1885233650 then
                        cmodel = "mp_m_freemode_01"
                    else
                        cmodel = "mp_f_freemode_01"
                    end

                    Citizen.CreateThread(function()
                        local model = GetHashKey(cmodel)
                        RequestModel(model)
                        while not HasModelLoaded(model) do
                            RequestModel(model)
                            Citizen.Wait(0)
                        end
                        SetPlayerModel(PlayerId(), model)
                        SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 2)
                        TriggerEvent('sh-creation:client:loadData', json.decode(data.skin), PlayerPedId())
                    end)
                else
                    local skinData = json.decode(data.skin)

                        if data.gender == 0 or data.gender == "m" then
                            cmodel = "mp_m_freemode_01"
                        else
                            cmodel = "mp_f_freemode_01"
                        end
                        local model = GetHashKey(cmodel)
                        RequestModel(model)
                        while not HasModelLoaded(model) do
                            RequestModel(model)
                            Citizen.Wait(0)
                        end
                        SetPlayerModel(PlayerId(), model)
                        SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 2)

                    if data.skin then
                        skinData.sex = data.gender
                        TriggerEvent('skinchanger:loadSkin', json.decode(data.skin), function()
                        end)
                    end 
                end
            else
                if Config.SkinSystem == "izzy-appearance" then
                    local skin = "mp_f_freemode_01"

                    if data.gender == 0 then
                        skin = "mp_m_freemode_01"
                    end

                    local model = GetHashKey(skin)
                    Citizen.CreateThread(function()
                        RequestModel(model)
                        while not HasModelLoaded(model) do
                            RequestModel(model)
                            Citizen.Wait(0)
                        end
                        SetPlayerModel(PlayerId(), model)
                        SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 2)
                    end)
                else
                    local skin = "mp_f_freemode_01"

                    if data.gender == 0 then
                        skin = "mp_m_freemode_01"
                    end

                    local model = GetHashKey(skin)
                    Citizen.CreateThread(function()
                        RequestModel(model)
                        while not HasModelLoaded(model) do
                            RequestModel(model)
                            Citizen.Wait(0)
                        end
                        SetPlayerModel(PlayerId(), model)
                        SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 2)
                    end)
                end
            end
        end
    },
}

Config.FrameworkFunctions = Config.FrameworkFunction[Config.Framework == "old_esx" and "esx" or Config.Framework]

Config.Default = {
    ["m"] = {
        mom = 43,
        dad = 29,
        face_md_weight = 61,
        skin_md_weight = 27,
        nose_1 = -5,
        nose_2 = 6,
        nose_3 = 5,
        nose_4 = 8,
        nose_5 = 10,
        nose_6 = 0,
        cheeks_1 = 2,
        cheeks_2 = -10,
        cheeks_3 = 6,
        lip_thickness = -2,
        jaw_1 = 0,
        jaw_2 = 0,
        chin_1 = 0,
        chin_2 = 0,
        chin_13 = 0,
        chin_4 = 0,
        neck_thickness = 0,
        hair_1 = 76,
        hair_2 = 0,
        hair_color_1 = 61,
        hair_color_2 = 29,
        tshirt_1 = 4,
        tshirt_2 = 2,
        torso_1 = 23,
        torso_2 = 2,
        decals_1 = 0,
        decals_2 = 0,
        arms = 1,
        arms_2 = 0,
        pants_1 = 28,
        pants_2 = 3,
        shoes_1 = 70,
        shoes_2 = 2,
        mask_1 = 0,
        mask_2 = 0,
        bproof_1 = 0,
        bproof_2 = 0,
        chain_1 = 22,
        chain_2 = 2,
        helmet_1 = -1,
        helmet_2 = 0,
        glasses_1 = 0,
        glasses_2 = 0,
        watches_1 = -1,
        watches_2 = 0,
        bracelets_1 = -1,
        bracelets_2 = 0,
        bags_1 = 0,
        bags_2 = 0,
        eye_color = 0,
        eye_squint = 0,
        eyebrows_2 = 0,
        eyebrows_1 = 0,
        eyebrows_3 = 0,
        eyebrows_4 = 0,
        eyebrows_5 = 0,
        eyebrows_6 = 0,
        makeup_1 = 0,
        makeup_2 = 0,
        makeup_3 = 0,
        makeup_4 = 0,
        lipstick_1 = 0,
        lipstick_2 = 0,
        lipstick_3 = 0,
        lipstick_4 = 0,
        ears_1 = -1,
        ears_2 = 0,
        chest_1 = 0,
        chest_2 = 0,
        chest_3 = 0,
        bodyb_1 = -1,
        bodyb_2 = 0,
        bodyb_3 = -1,
        bodyb_4 = 0,
        age_1 = 0,
        age_2 = 0,
        blemishes_1 = 0,
        blemishes_2 = 0,
        blush_1 = 0,
        blush_2 = 0,
        blush_3 = 0,
        complexion_1 = 0,
        complexion_2 = 0,
        sun_1 = 0,
        sun_2 = 0,
        moles_1 = 0,
        moles_2 = 0,
        beard_1 = 11,
        beard_2 = 10,
        beard_3 = 0,
        beard_4 = 0
    },
    ["f"] = {
        mom = 28,
        dad = 6,
        face_md_weight = 63,
        skin_md_weight = 60,
        nose_1 = -10,
        nose_2 = 4,
        nose_3 = 5,
        nose_4 = 0,
        nose_5 = 0,
        nose_6 = 0,
        cheeks_1 = 0,
        cheeks_2 = 0,
        cheeks_3 = 0,
        lip_thickness = 0,
        jaw_1 = 0,
        jaw_2 = 0,
        chin_1 = -10,
        chin_2 = 10,
        chin_13 = -10,
        chin_4 = 0,
        neck_thickness = -5,
        hair_1 = 43,
        hair_2 = 0,
        hair_color_1 = 29,
        hair_color_2 = 35,
        tshirt_1 = 111,
        tshirt_2 = 5,
        torso_1 = 25,
        torso_2 = 2,
        decals_1 = 0,
        decals_2 = 0,
        arms = 3,
        arms_2 = 0,
        pants_1 = 12,
        pants_2 = 2,
        shoes_1 = 20,
        shoes_2 = 10,
        mask_1 = 0,
        mask_2 = 0,
        bproof_1 = 0,
        bproof_2 = 0,
        chain_1 = 85,
        chain_2 = 0,
        helmet_1 = -1,
        helmet_2 = 0,
        glasses_1 = 33,
        glasses_2 = 12,
        watches_1 = -1,
        watches_2 = 0,
        bracelets_1 = -1,
        bracelets_2 = 0,
        bags_1 = 0,
        bags_2 = 0,
        eye_color = 8,
        eye_squint = -6,
        eyebrows_2 = 7,
        eyebrows_1 = 32,
        eyebrows_3 = 52,
        eyebrows_4 = 9,
        eyebrows_5 = -5,
        eyebrows_6 = -8,
        makeup_1 = 0,
        makeup_2 = 0,
        makeup_3 = 0,
        makeup_4 = 0,
        lipstick_1 = 0,
        lipstick_2 = 0,
        lipstick_3 = 0,
        lipstick_4 = 0,
        ears_1 = -1,
        ears_2 = 0,
        chest_1 = 0,
        chest_2 = 0,
        chest_3 = 0,
        bodyb_1 = -1,
        bodyb_2 = 0,
        bodyb_3 = -1,
        bodyb_4 = 0,
        age_1 = 0,
        age_2 = 0,
        blemishes_1 = 0,
        blemishes_2 = 0,
        blush_1 = 0,
        blush_2 = 0,
        blush_3 = 0,
        complexion_1 = 0,
        complexion_2 = 0,
        sun_1 = 0,
        sun_2 = 0,
        moles_1 = 12,
        moles_2 = 8,
        beard_1 = 0,
        beard_2 = 0,
        beard_3 = 0,
        beard_4 = 0
    }
}
