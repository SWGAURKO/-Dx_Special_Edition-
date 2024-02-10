CreateThread(function()
    while true do
        for _, sctyp in next, Config.BlacklistedScenarios['TYPES'] do
            SetScenarioTypeEnabled(sctyp, false)
        end
        for _, scgrp in next, Config.BlacklistedScenarios['GROUPS'] do
            SetScenarioGroupEnabled(scgrp, false)
        end
        Wait(10000)
    end
end)

AddEventHandler("populationPedCreating", function(x, y, z)
	Wait(500) -- Give the entity some time to be created
	local _, handle = GetClosestPed(x, y, z, 1.0) -- Get the entity handle
	SetPedDropsWeaponsWhenDead(handle, false)
end)

CreateThread(function() -- all these should only need to be called once
	if Config.DisableAmbience then
		StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
		SetAudioFlag("DisableFlightMusic", true)
	end
	SetAudioFlag("PoliceScannerDisabled", true)
	SetGarbageTrucks(false)
	SetCreateRandomCops(false)
	SetCreateRandomCopsNotOnScenarios(false)
	SetCreateRandomCopsOnScenarios(false)
	DistantCopCarSirens(false)
	RemoveVehiclesFromGeneratorsInArea(335.2616 - 300.0, -1432.455 - 300.0, 46.51 - 300.0, 335.2616 + 300.0, -1432.455 + 300.0, 46.51 + 300.0) -- central los santos medical center
	RemoveVehiclesFromGeneratorsInArea(441.8465 - 500.0, -987.99 - 500.0, 30.68 -500.0, 441.8465 + 500.0, -987.99 + 500.0, 30.68 + 500.0) -- police station mission row
	RemoveVehiclesFromGeneratorsInArea(316.79 - 300.0, -592.36 - 300.0, 43.28 - 300.0, 316.79 + 300.0, -592.36 + 300.0, 43.28 + 300.0) -- pillbox
	RemoveVehiclesFromGeneratorsInArea(-2150.44 - 500.0, 3075.99 - 500.0, 32.8 - 500.0, -2150.44 + 500.0, -3075.99 + 500.0, 32.8 + 500.0) -- military
	RemoveVehiclesFromGeneratorsInArea(-1108.35 - 300.0, 4920.64 - 300.0, 217.2 - 300.0, -1108.35 + 300.0, 4920.64 + 300.0, 217.2 + 300.0) -- nudist
	RemoveVehiclesFromGeneratorsInArea(-458.24 - 300.0, 6019.81 - 300.0, 31.34 - 300.0, -458.24 + 300.0, 6019.81 + 300.0, 31.34 + 300.0) -- police station paleto
	RemoveVehiclesFromGeneratorsInArea(1854.82 - 300.0, 3679.4 - 300.0, 33.82 - 300.0, 1854.82 + 300.0, 3679.4 + 300.0, 33.82 + 300.0) -- police station sandy
	RemoveVehiclesFromGeneratorsInArea(-724.46 - 300.0, -1444.03 - 300.0, 5.0 - 300.0, -724.46 + 300.0, -1444.03 + 300.0, 5.0 + 300.0) -- REMOVE CHOPPERS WOW
end)

if Config.Stun.active then
    CreateThread(function()
        local sleep
        while true do
            sleep = 1000
            local ped = PlayerPedId()
            if IsPedBeingStunned(ped, 0) then
                sleep = 0
                SetPedMinGroundTimeForStungun(ped, math.random(Config.Stun.min, Config.Stun.max))
            end
            Wait(sleep)
        end
    end)
end

CreateThread(function()
	for dispatchService, enabled in pairs(Config.DispatchServices) do
		EnableDispatchService(dispatchService, enabled)
	end

	local wantedLevel = 0
	if Config.EnableWantedLevel then
		wantedLevel = 5
	end

	SetMaxWantedLevel(wantedLevel)
end)

if Config.IdleCamera then --Disable Idle Cinamatic Cam
    DisableIdleCamera(true)
end

RegisterNetEvent('QBCore:Client:DrawWeapon', function()
    local sleep
    while true do
        sleep = 500
        local ped = PlayerPedId()
        local weapon = GetSelectedPedWeapon(ped)
        if weapon ~= `WEAPON_UNARMED` then
            if IsPedArmed(ped, 6) then
                sleep = 0
                DisableControlAction(1, 140, true)
                DisableControlAction(1, 141, true)
                DisableControlAction(1, 142, true)
            end

            if weapon == `WEAPON_FIREEXTINGUISHER` or weapon == `WEAPON_PETROLCAN` then
                if IsPedShooting(ped) then
                    SetPedInfiniteAmmo(ped, true, weapon)
                end
            end
        else
            break
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    local pedPool = GetGamePool('CPed')
    for _, v in pairs(pedPool) do
        SetPedDropsWeaponsWhenDead(v, false)
    end
end)

CreateThread(function()
    while true do
        Wait(2500)
        local ped = PlayerPedId()
        local weapon = GetSelectedPedWeapon(ped)
        if Config.BlacklistedWeapons[weapon] then
            RemoveWeaponFromPed(ped, weapon)
        end
    end
end)

-- turn off aim assiest 
CreateThread(function()-- probably just add this to an existing script
    while true do
        Wait(500)-- can set to 0 if needed 
        local gamepad = GetLastInputMethod(2)
        if not gamepad then
           SetPlayerTargetingMode(3)--set targeting to "free-aim" if a controller is being used
        else
            Wait(2000)--wait if the player is using a keyboard
        end
    end
end)

-- No helmet in an vehicle

CreateThread(function()
    while true do
        local sleep = 750
        if IsPedInAnyVehicle(playerped, false) and allowshuffle == false then
            sleep = 250
            SetPedConfigFlag(playerped, 184, true)
            if GetIsTaskActive(playerped, 165) then
                seat = 0
                if GetPedInVehicleSeat(currentvehicle, -1) == playerped then
                    seat =- 1
                end
                SetPedIntoVehicle(playerped, currentvehicle, seat)
            end
        elseif IsPedInAnyVehicle(playerped, false) and allowshuffle == true then
            SetPedConfigFlag(playerped, 184, false)
        end
        Citizen.Wait(sleep)
    end
end)

----wrong mussle punch error issue fixed 
-- Prevent props (hat, glasses, etc.) from falling off when punched

CreateThread(function()
    while true do
    if PlayerPedId() ~= lastped then
        lastped = PlayerPedId()
        SetPedCanLosePropsOnDamage(PlayerPedId(), false, 0)
    end
    Wait(100)
    end
end)

----train auto
CreateThread(function() -- TRAIN SPAWNS / SPAWN TRAINS
    SwitchTrainTrack(0, true)
    SwitchTrainTrack(3, true)
    N_0x21973bbf8d17edfa(0, 120000)
    SetRandomTrains(true)
end)

----regenarate helth over time 
CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local maxHealth = GetEntityMaxHealth(ped)
        local health = GetEntityHealth(ped)
        Wait(1000)

        local newHealth = GetEntityHealth(ped)
        if newHealth < health then
            Wait(60000)
        else
            if health < maxHealth and health >= 100 and not InLaststand and not isDead then
                SetEntityHealth(ped, health + 2)
            end
        end
    end
end)

-- anty bunny hop

CreateThread(function()
    while true do
        Wait(100)
        local ped = PlayerPedId()
        if IsPedOnFoot(ped) and not IsPedSwimming(ped) and (IsPedRunning(ped) or IsPedSprinting(ped)) and not IsPedClimbing(ped) and IsPedJumping(ped) and not IsPedRagdoll(ped) then
            local chance_result = math.random()
            --You can change the chance as you want! Just changed 0.2!
            if chance_result < 0.2 then 
                Wait(600)
                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.10)
                -- QBCore.Functions.Notify("You are too tired!", 'error', 2500)
                SetPedToRagdoll(ped, 5000, 1, 2)
            else
                Wait(2000)
            end
        end
    end
end)

----pistol wiping

CreateThread(function()
    while(true)do
            if globalIsPedArmed then
                DisableControlAction(1, 140, true)
                DisableControlAction(1, 141, true)
                DisableControlAction(1, 142, true)
            else
                Wait(100)
            end
        Wait(0)
    end
end)