local playerLoaded = false

local playerModels = {
    [0] = 'mp_m_freemode_01',
    [1] = 'mp_f_freemode_01'
}

local defaultSpawnCoords = Config.Spawn
local defaultExtraCharacterSlots = Config.DefaultExtraCharacterSlots

Citizen.CreateThreadNow(function()
    DoScreenFadeOut(0)
    Wait(1500)
    while true do
        Wait(100)
        if NetworkIsSessionActive() or NetworkIsPlayerActive(PlayerId()) then
            exports['spawnmanager']:setAutoSpawn(false)
            Wait(1000)

            if Config.Framework == "esx" then
                TriggerServerEvent('izzy-multichar:server:resetCurrentChar')
            end
            
            CharacterSelect()
            SetEntityVisible(PlayerPedId(), false)
            TriggerEvent('esx:loadingScreenOff')
            break
        end
    end
end)

RegisterNetEvent('esx:firstloaded')
AddEventHandler('esx:firstloaded', function(playerData, isNew, skin)
	local spawn = playerData.coords or vector3(-1036.6721, -2733.8704, 13.7566)
	if isNew or not skin or #skin == 1 then
		local finished = false
		skin = Config.Default[playerData.sex]
		skin.sex = playerData.sex == "m" and 0 or 1
		local model = skin.sex == 0 and mp_m_freemode_01 or mp_f_freemode_01
		RequestModel(model)
		while not HasModelLoaded(model) do
			RequestModel(model)
			Wait(0)
		end
		SetPlayerModel(PlayerId(), model)
		SetModelAsNoLongerNeeded(model)
	end

    if Config.SkinSystem == "esx" then
        TriggerEvent('skinchanger:loadSkin', skin, function()
            local playerPed = PlayerPedId()
            SetPedAoBlobRendering(playerPed, true)
            ResetEntityAlpha(playerPed)
            TriggerEvent('esx_skin:openSaveableMenu', function()
                finished = true
            end, function()
                finished = true
            end)
        end)
    end
    
    DoScreenFadeOut(750)
	Wait(750)
	SetCamActive(cam, false)
	RenderScriptCams(false, false, 0, true, true)
	cam = nil
	local playerPed = PlayerPedId()
	FreezeEntityPosition(playerPed, true)
	SetEntityCoordsNoOffset(playerPed, spawn.x, spawn.y, spawn.z, false, false, false, true)
	SetEntityHeading(playerPed, spawn.heading)
	if not isNew then TriggerEvent('skinchanger:loadSkin', skin) end
    Wait(500)
	DoScreenFadeIn(750)
	Wait(750)
	repeat Wait(200) until not IsScreenFadedOut()
	TriggerServerEvent('esx:onPlayerSpawn')
	TriggerEvent('esx:onPlayerSpawn')
	TriggerEvent('playerSpawned')
	TriggerEvent('esx:restoreLoadout')
end)

CharacterSelect = function()
    TriggerEvent('esx:loadingScreenOff')
    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()
    DoScreenFadeOut(300)

    ShutdownLoadingScreenNui(true)
    RequestCollisionAtCoord(0.0, 0.0, 777.0)
    FreezeEntityPosition(PlayerPedId(), true)
    SetNuiFocus(true, true)
    enableCam()
    IntroCam()
    SetFocusEntity(PlayerPedId())
    TriggerServerEvent('izzy-multichar:server:toggleBucket', true)
    Config.FrameworkFunctions._TSC('izzy-multichar:server:getCharDatas', function(result)
        Wait(4000)
        DoScreenFadeIn(500)
        SendNUIMessage({
            action = "open",
            chars = result.chars,
            maxValues = result.maxValue,
            DefaultExtraCharacterSlots = Config.DefaultExtraCharacterSlots,
            MaxCharacterSlots = Config.MaxCharacterSlots,
            serverName = Config.ServerName,
            serverLogo = Config.ServerLogo,
            serverDescription = Config.ServerDescription,
            tebexStore = Config.TebexStore,
            framework = Config.Framework
        })
    end)
end

local cam = nil

enableCam = function()
    local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 2.0, 0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)

    if (not DoesCamExist(cam)) then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, true)
        SetCamCoord(cam, coords.x, coords.y, coords.z + 0.2)
        SetCamRot(cam, 0.0, 0.0, GetEntityHeading(PlayerPedId()) + 180)
    end

    if customCamLocation ~= nil then
        SetCamCoord(cam, customCamLocation.x, customCamLocation.y, customCamLocation.z)
        SetCamRot(cam, 0.0, 0.0, customCamLocation.w)
    end

    headingToCam = GetEntityHeading(PlayerPedId()) + 90
    camOffset = 2.0
end

IntroCam = function()
    ped = PlayerPedId()
    SetEntityCoords(ped, -1596.07, -1127.56, 1.26)
    SetEntityHeading(ped, 267.44)
    FreezeEntityPosition(ped, true)
    Wait(500)
    PointCamAtPedBone(cam, ped, 31086, 0.0, 0.0, 0.0, true)
    local coords = GetOffsetFromEntityInWorldCoords(ped, 0, 1.1, 0)
    SetCamCoord(cam, coords.x, coords.y, coords.z + 0.6)
    SetCamRot(cam, 0.0, 0.0, GetEntityHeading(ped) + 180)

    SetCamUseShallowDofMode(cam, true)
    SetCamNearDof(cam, 0.7)
    SetCamFarDof(cam, 5.3)
    SetCamDofStrength(cam, 1.0)
    SetUseHiDof()
end

RegisterNUICallback('redeemKeycode', function(data, cb)
    Config.FrameworkFunctions._TSC('izzy-multichar:server:redeemKeycode', function(result)
        if result == true then
            Config.FrameworkFunctions._TSC('izzy-multichar:server:getCharDatas', function(result)
                SendNUIMessage({
                    action = "open",
                    chars = result.chars,
                    maxValues = result.maxValue,
                    DefaultExtraCharacterSlots = Config.DefaultExtraCharacterSlots,
                    MaxCharacterSlots = Config.MaxCharacterSlots,
                    framework = Config.Framework
                })
            end)
        end
        cb(result)
    end, data.keycode)
end)

RegisterNUICallback('selectChar', function(data, cb)
    Config.FrameworkFunctions._TSC('izzy-multichar:server:getCharData', function(result)
        TriggerServerEvent('izzy-multichar:server:loadCharPed', data.identifier, result.gender)
        cb(result)
    end, data)
end)

RegisterNUICallback('createChar', function(payload, cb)
    Config.FrameworkFunctions._TSC('izzy-multichar:server:createChar', function(__)
        Config.FrameworkFunctions._TSC('izzy-multichar:server:getCharDatas', function(result)
            RenderScriptCams(false, true, 250, 1, 0)
            DestroyCam(cam, false)
            FreezeEntityPosition(PlayerPedId(), false)

            SetNuiFocus(false, false)

            if __ == 0 then
                gender = "m"
            else
                gender = "f"
            end
            if Config.SkinSystem == "esx" then
                TriggerEvent('skinchanger:loadSkin', Config.Default[gender], function()
                    local playerPed = PlayerPedId()
                    SetPedAoBlobRendering(playerPed, true)
                    ResetEntityAlpha(playerPed)
                        TriggerEvent('esx_skin:openSaveableMenu', function()
                            finished = true
                        end, function()
                            finished = true
                        end)
                end)
            end

            local playerData = {
                sex = gender
            }

            TriggerEvent('esx:firstloaded', playerData, true, Config.Default[gender])
            cb(true)
        end)
    end, payload)
end)

RegisterNUICallback('playChar', function(data, cb)
    TriggerServerEvent('izzy-multichar:server:toggleBucket', false)
    Config.FrameworkFunctions._TSC('izzy-multichar:server:playChar', function()
        SetNuiFocus(false, false)
        cb(true)
    end, data.identifier)
end)

RegisterNUICallback('selectGender', function(data, cb)
    data.skin = false
    if data.gender == "male" then
        data.gender = 0
        Config.FrameworkFunctions.C_LOADPLAYERSKIN(data)
    else
        data.gender = 1
        Config.FrameworkFunctions.C_LOADPLAYERSKIN(data)
    end
end)

RegisterNetEvent('izzy-multichar:client:loadCharPed')
AddEventHandler('izzy-multichar:client:loadCharPed', function(data, gender)
    data.gender = gender
    Config.FrameworkFunctions.C_LOADPLAYERSKIN(data)
end)

RegisterNetEvent('izzy-multichar:client:isNew')
AddEventHandler('izzy-multichar:client:isNew', function(data, gender)
    SetEntityCoords(PlayerPedId(), -1036.6721, -2733.8704, 13.7566)
    RenderScriptCams(false, true, 250, 1, 0)
    DestroyCam(cam, false)

    FreezeEntityPosition(PlayerPedId(), false)
    if Config.SkinSystem == "izzy-appearance" then
        TriggerEvent('sh-creation:client:CreateCharacter')
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
    else
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
        TriggerServerEvent('qb-houses:server:SetInsideMeta', 0, false)
        TriggerServerEvent('qb-apartments:server:SetInsideMeta', 0, 0, false)
        TriggerEvent('qb-weathersync:client:EnableSync')
        TriggerEvent('qb-clothes:client:CreateFirstCharacter')
    end
end)

RegisterNetEvent('izzy-multichar:client:spawn')
AddEventHandler('izzy-multichar:client:spawn', function(data, gender)
    SetEntityCoords(PlayerPedId(), -1036.6721, -2733.8704, 13.7566)
    RenderScriptCams(false, true, 250, 1, 0)
    DestroyCam(cam, false)

    FreezeEntityPosition(PlayerPedId(), false)

    if Config.Framework == "qb" then
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
    end
end)

RegisterNetEvent('izzy-multichar:loadchar')
AddEventHandler('izzy-multichar:loadchar', function(data, gender)
    RenderScriptCams(false, true, 250, 1, 0)
    DestroyCam(cam, false)

    FreezeEntityPosition(PlayerPedId(), false)
    TriggerEvent('izzy-multichar:client:loadCharPed', data, gender)
end)

RegisterNetEvent('izzy-multichar:client:spawnESX')
AddEventHandler('izzy-multichar:client:spawnESX', function(coords,gender,skin)
    SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z)
    RenderScriptCams(false, true, 250, 1, 0)
    DestroyCam(cam, false)
    FreezeEntityPosition(PlayerPedId(), false)
    local model = skin.sex == 0 and mp_m_freemode_01 or mp_f_freemode_01
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(0)
    end
    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
    
    TriggerClientEvent('skinchanger:loadSkin', src, json.decode(result.skin))
end)
