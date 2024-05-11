if Config.framework == "esx" then
    ESX = exports["es_extended"]:getSharedObject()
else
    QBCore = exports['qb-core']:GetCoreObject()
end

local spawnName = nil
local manuel = false
local locations = {}

RegisterCommand(Config.command, function ()
    if Config.framework == "esx" then 
        ESX.TriggerServerCallback('izzy-spawnselector:getAccess', function(data)
            if data then
                createSpawn()
            end
        end)
    else
        QBCore.Functions.TriggerCallback('izzy-spawnselector:getAccess', function(data)
            if data then
                createSpawn()
            end
        end)
    end
end)

function createSpawn()
    if Config.framework == "esx" then 
        ESX.UI.Menu.Open(
            'dialog', "asdsdsd", 'get_item_count',
            {
            title = "Name of new spawn point",
            },
            function(data2, menu)

            local label = data2.value

                menu.close()
                if label then
                    spawnName = label

                    SetNuiFocus(true, true)
                    SendNUIMessage({
                        type = "addSpawn"
                    })
                else
                    print("not found.")
                end
            end,
            function(data2,menu)
            menu.close()
        end)
    else
        local dialog = exports['qb-input']:ShowInput({
            header = "Spawn Selector",
            submitText = "Create",
            inputs = {
                {
                    text = "Name of new spawn point...",
                    name = "value",
                    type = "text",
                    isRequired = true,
                },
            },
        })
      
        if dialog ~= nil and dialog["value"] then
            spawnName = dialog["value"]

            SetNuiFocus(true, true)
            SendNUIMessage({
                type = "addSpawn"
            })
        end   
    end
end

RegisterNUICallback('addSpawn', function(data)
    SetNuiFocus(false, false)
    TriggerServerEvent('izzy-spawnselector:addSpawn', data, GetEntityCoords(PlayerPedId()), spawnName)
end)

RegisterNUICallback('spawn', function(data)
    SetNuiFocus(false, false)
    DoScreenFadeOut(300)


    local coord = locations[data.id].coord
    SetEntityCoords(PlayerPedId(), coord.x, coord.y, coord.z)
    Citizen.Wait(1500)
    DoScreenFadeIn(100)
end)

RegisterCommand('test', function()
    TriggerEvent('izzy-spawnselector:open')
end)

RegisterNetEvent('izzy-spawnselector:open')
AddEventHandler('izzy-spawnselector:open', function(val)
    manuel = val
    if Config.framework == "esx" then 
        DoScreenFadeOut(300)
        ESX.TriggerServerCallback('izzy-spawnselector:getInfo', function(data)
            SendNUIMessage({
                type = "update",
                image = data.image,
                name = data.name,
                cash = data.cash
            })
            for k,v in pairs(data.locations) do
                locations[k] = v
                SendNUIMessage({
                    type = "addLocation",
                    id = k,
                    data = v
                })
            end

            SendNUIMessage({
                type = "open"
            })
            SetNuiFocus(true, true)
            DoScreenFadeIn(300)
        end)
    else
        if not Config.autoOpen and not manuel then
            TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
            TriggerEvent('QBCore:Client:OnPlayerLoaded')
        end

        DoScreenFadeOut(300)
        QBCore.Functions.TriggerCallback('izzy-spawnselector:getInfo', function(data)
            SendNUIMessage({
                type = "update",
                image = data.image,
                name = data.name,
                cash = data.cash
            })
            for k,v in pairs(data.locations) do
                locations[k] = v
                SendNUIMessage({
                    type = "addLocation",
                    id = k,
                    data = v
                })
            end

            SendNUIMessage({
                type = "open"
            })
            SetNuiFocus(true, true)
            Citizen.Wait(1500)
            DoScreenFadeIn(300)
        end)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    if Config.autoOpen then
        TriggerEvent('izzy-spawnselector:open', false)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    if Config.autoOpen and not manuel then
        TriggerEvent('izzy-spawnselector:open', false)
    end
end)