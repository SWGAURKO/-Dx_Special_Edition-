function GetPlayerData()
    return QBCore.Functions.GetPlayerData()
end

function GetCoordsByFramework(entity)
    return QBCore.Functions.GetCoords(entity)
end

function DeleteVehicleByFrameWork(vehicle)
    OnDeleteVehicle(vehicle, GetVehicleNumberPlateText(vehicle), GetEntityModel(vehicle))
    if DoesEntityExist(vehicle) then
        SetEntityAsMissionEntity(vehicle, true, true)
        DeleteVehicle(vehicle)
    end
end

function SpawnVehicleByFrameWork(model, coords, isnetworked)
    isnetworked = isnetworked or true
    local spawnedCar = nil
    QBCore.Functions.SpawnVehicle(model, function(veh)
        if DoesEntityExist(veh) then
            local plate = "JOB" .. math.random(1, 9) .. QBCore.Shared.RandomStr(4)
            SetVehicleNumberPlateText(veh, plate)
            SetEntityHeading(veh, coords.h)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            SetVehicleEngineOn(veh, true, true)
            OnSpawnedVehicle(veh, plate, model)
            spawnedCar = veh
        else
            spawnedCar = false
        end
    end, coords, isnetworked)
    while type(spawnedCar) == "nil" do
        Wait(0)
    end
    return spawnedCar
end

---@param show boolean boolean
function ToggleJobCreatorPanel(show)
    SetNuiFocus(show, show)
    SendReactMessage("setVisible", show)
end

function SendPlayerDataToReact()
    SendReactMessage("setPlayerData", {
        fullName = GetPlayerName(PlayerId()),
    })
end

function LoadJobsToClient()
    TriggerCallback("0r-jobcreator:Server:GetJobs", function(result)
        if not result then return end
        local jobs = JobsClass:loadJobsToClient(result)
        for identity, job in pairs(jobs) do
            if job.status == "active" then
                StartJobByJob(job)
            end
        end
    end)
end

function StopJobByJob(job, clearPed)
    -- remove start ped
    if clearPed then
        if gSpawnedPeds[job.identity] then
            for key, value in pairs(gSpawnedPeds[job.identity]) do
                DeletePed(value.ped)
                gSpawnedPeds[job.identity][key] = nil
            end
            gSpawnedPeds[job.identity] = nil
        end
    elseif gSpawnedPeds[job.identity] then
        for key, value in pairs(gSpawnedPeds[job.identity]) do
            if value.type ~= "start_ped" then
                DeletePed(value.ped)
                gSpawnedPeds[job.identity][key] = nil
            end
        end
    end
    -- remove blips
    if gCreatedBlips[job.identity] then
        local jobBlips = gCreatedBlips[job.identity]
        if jobBlips.blip then
            RemoveBlip(jobBlips.blip)
        end
        if next(jobBlips.stepBlips) then
            for _, stepBlip in pairs(jobBlips.stepBlips) do
                RemoveBlip(stepBlip)
            end
        end
        gCreatedBlips[job.identity] = nil
    end
    -- remove targets
    if gCreatedTargetZones[job.identity] then
        for key, zone in pairs(gCreatedTargetZones[job.identity]) do
            if zone.targetType == "qb_target" then
                exports["qb-target"]:RemoveZone(zone.id)
            elseif zone.targetType == "ox_target" then
                ox_target:removeZone(zone.id)
            end
            gCreatedTargetZones[job.identity][key] = nil
        end
        gCreatedTargetZones[job.identity] = nil
    end
    --remove target entities
    if gCreatedTargetEntities[job.identity] then
        for key, value in pairs(gCreatedTargetEntities[job.identity]) do
            if value.targetType == "qb_target" then
                exports["qb-target"]:RemoveTargetEntity(value.peds, value.label)
            elseif value.targetType == "ox_target" then
                ox_target:removeLocalEntity(value.peds, value.label)
            end
        end
        gCreatedTargetEntities[job.identity] = nil
    end
    -- destroy zones
    if gCreatedZones[job.identity] then
        for key, value in pairs(gCreatedZones[job.identity]) do
            if value.type == "start_ped" then
                if clearPed then
                    value.zone:destroy()
                    gCreatedZones[job.identity][key] = nil
                end
            else
                value.zone:destroy()
                gCreatedZones[job.identity][key] = nil
            end
        end
        if not next(gCreatedZones[job.identity]) then
            gCreatedZones[job.identity] = nil
        end
    end
    -- destroy objects
    if gCreatedObjects[job.identity] then
        for key, value in pairs(gCreatedObjects[job.identity]) do
            local objectModel = GetEntityModel(value.object)
            if objectModel == GetHashKey(value.modelHash) then
                DeleteObject(value.object)
                gCreatedObjects[job.identity][key] = nil
            end
        end
        gCreatedObjects[job.identity] = nil
    end
    HideMenu()
    if gPlayer.inZone then
        if gPlayer.zoneInfo.data.jobIdentity == job.identity then
            HideTextUIByResource(job.textui_type)
            table_remove(gCreatedDrawTexts, gPlayer.zoneInfo.type, job.identity)
            gPlayer.inZone = false
            gPlayer.zoneInfo = nil
        end
    end
    if gPlayer.onDuty then
        if gPlayer.job.identity == job.identity then
            gPlayer.onDuty = false
            gPlayer.job = nil
        end
    end
end

function StartJobByJob(job)
    if job.start_type == "ped" then
        local spawnedPed = CreatePedWithOptions(job.start_ped.model, job.start_ped.coords)
        if not spawnedPed then return end
        gSpawnedPeds[job.identity] = gSpawnedPeds[job.identity] or {}
        gSpawnedPeds[job.identity][#gSpawnedPeds[job.identity] + 1] = {
            type = "start_ped",
            ped = spawnedPed
        }
        local createdMenu = CreateMenuToJobStartPed(job)
        if job.blip.is_required == "yes" then
            CreateBlipForCoords(job.start_ped.coords, job.blip, job.identity)
        end
        if job.start_ped.interaction_type == "textui" then
            CreateZoneForJobStartPed(job, createdMenu)
        elseif job.start_ped.interaction_type == "target" then
            CreateTargetEntitiesForJobStartPed(job, spawnedPed, createdMenu)
        end
    elseif job.start_type == "always_active" then
        StartJobStepsByJob(job)
        CreateJobTeleports(job)
        CreateJobObjects(job)
        CreateJobCarSpawners(job)
        CreateJobStashes(job)
        CreateJobMarkets(job)
    end
end

function StartJobStepsByJob(job)
    if not job then return end
    local jobSteps = job.steps
    for _, step in pairs(jobSteps) do
        if step.blip.is_required == "yes" then
            CreateBlipForCoords(step.coords[1], step.blip, job.identity, step.id)
        end
        if step.interaction_type == "target" then
            CreateTargetZoneForJobStep(job, step)
        elseif step.interaction_type == "textui" then
            CreateZoneForJobStep(job, step)
        end
    end
end

function CreateJobMarkets(job)
    if not job then return end
    local markets = job.markets or {}
    if next(markets) == nil then return end
    for _, market in pairs(markets) do
        local menu = CreateMenuToJobMarket(job, market)
        if market.interaction_type == "target" then
            CreateTargetEntitiesForJobMarket(job, market, menu)
        elseif market.interaction_type == "textui" then
            CreateZoneForJobMarket(job, market, menu)
        end
    end
end

function CreateMenuToJobMarket(job, market)
    local menuType = job.menu_type
    local menuId = nil
    local menuOptions = nil
    if not menuType or menuType == "no_menu" then
        menuType = Config.Default.MenuType
    end
    if menuType == "qb_menu" then
        menuId = "qb_" .. job.identity .. "_market_" .. market.id
        menuOptions = {
            {
                header = _t("JobCreator.market_menu_title", market.name),
                icon = "fa-solid fa-magnifying-glass",
                isMenuHeader = true
            },
        }
        for _, item in pairs(market.items) do
            table.insert(menuOptions,
                {
                    header = item.label,
                    txt = item.type:upper() .. " " .. item.amount .. "x " .. item.price .. "$",
                    icon = "fa-solid fa-hand-holding-dollar",
                    params = {
                        event = "0r-jobcreator:Client:JobMarketSelected",
                        args = {
                            market = market,
                            item = item
                        }
                    }
                }
            )
        end
    elseif menuType == "ox_menu" then
        menuId = "ox_" .. job.identity .. "_market_" .. market.id
        local menuItems = {}
        for _, item in pairs(market.items) do
            table.insert(menuItems,
                {
                    label = item.type:upper() .. " " .. item.label .. " " .. item.amount .. "x " .. item.price .. "$",
                    icon = "fa-solid fa-hand-holding-dollar",
                    iconColor = item.type == "sell" and "green" or "red",
                    args = {
                        market = market,
                        item = item
                    }
                }
            )
        end
        menuOptions = {
            id = menuId,
            title = _t("JobCreator.market_menu_title", market.name),
            position = "top-right",
            options = menuItems
        }
        lib.registerMenu(menuOptions, function(selected, scrollIndex, args)
            TriggerEvent("0r-jobcreator:Client:JobMarketSelected", args)
        end)
    end
    return {
        menuId = menuId,
        options = menuOptions
    }
end

function CreateTargetEntitiesForJobStartPed(job, spawnedPed, menu)
    if not job or not menu then return end
    local targetType = job.target_type
    if not targetType or targetType == "no_target" then
        targetType = Config.Default.TargetType
    end
    local startPed = job.start_ped
    local ped_coords = startPed.coords
    if targetType == "qb_target" then
        if not hasResource("qb-target") then
            debugPrint("error", "qb_target not found.")
            return
        end
        exports["qb-target"]:AddTargetEntity({ spawnedPed },
            {
                options = {
                    {
                        num = 1,
                        type = "client",
                        icon = "fa-regular fa-user",
                        label = "Open Menu: " .. job.name,
                        targeticon = "fa-solid fa-store",
                        action = function(entity)
                            local underscoreIndex = string.find(menu.menuId, "_")
                            local menuType = string.sub(menu.menuId, 1, underscoreIndex - 1)
                            OpenMenuByResource(menuType, menu.menuId, menu.options)
                        end,
                        job = job.perm.type == "job" and job.perm.name or nil,
                        gang = job.perm.type == "gang" and job.perm.name or nil,
                    }
                },
                distance = 1.5,
            }
        )
        gCreatedTargetEntities[job.identity] = gCreatedTargetEntities[job.identity] or {}
        gCreatedTargetEntities[job.identity][#gCreatedTargetEntities[job.identity] + 1] = {
            peds = createdEntities,
            label = "Open Market",
            targetType = targetType,
        }
    elseif targetType == "ox_target" then
        if not hasResource("ox_target") then
            debugPrint("error", "ox_target not found.")
            return
        end
        ox_target:addLocalEntity({ spawnedPed },
            {
                label = "Open Menu: " .. job.name,
                name = "target:entity:ox_target:start_ped:" .. job.identity,
                icon = "fa-regular fa-user",
                distance = 1.5,
                groups = (job.perm and job.perm.type ~= "all") and job.perm.name or nil,
                onSelect = function(data)
                    local underscoreIndex = string.find(menu.menuId, "_")
                    local menuType = string.sub(menu.menuId, 1, underscoreIndex - 1)
                    OpenMenuByResource(menuType, menu.menuId, menu.options)
                end,
            }
        )
        gCreatedTargetEntities[job.identity] = gCreatedTargetEntities[job.identity] or {}
        gCreatedTargetEntities[job.identity][#gCreatedTargetEntities[job.identity] + 1] = {
            peds = { spawnedPed },
            label = "target:entity:ox_target:start_ped:" .. job.identity,
            targetType = targetType,
        }
    end
end

function CreateTargetEntitiesForJobMarket(job, market, menu)
    if not job or not market or not menu then return end
    local targetType = job.target_type
    if not targetType or targetType == "no_target" then
        targetType = Config.Default.TargetType
    end
    local ped_coords = market.ped_coords
    local createdEntities = {}
    for key, coords in pairs(ped_coords) do
        local spawnedPed = CreatePedWithOptions(market.ped_model_hash, coords)
        if not spawnedPed then goto continue end
        createdEntities[#createdEntities + 1] = spawnedPed
        gSpawnedPeds[job.identity] = gSpawnedPeds[job.identity] or {}
        gSpawnedPeds[job.identity][#gSpawnedPeds[job.identity] + 1] = {
            type = "market",
            ped = spawnedPed
        }
        ::continue::
    end
    if targetType == "qb_target" then
        if not hasResource("qb-target") then
            debugPrint("error", "qb_target not found.")
            return
        end
        exports["qb-target"]:AddTargetEntity(createdEntities,
            {
                options = {
                    {
                        num = 1,
                        type = "client",
                        icon = "fa-solid fa-store",
                        label = "Open Market",
                        targeticon = "fa-solid fa-store",
                        action = function(entity)
                            local underscoreIndex = string.find(menu.menuId, "_")
                            local menuType = string.sub(menu.menuId, 1, underscoreIndex - 1)
                            OpenMenuByResource(menuType, menu.menuId, menu.options)
                        end,
                        job = job.perm.type == "job" and job.perm.name or nil,
                        gang = job.perm.type == "gang" and job.perm.name or nil,
                    }
                },
                distance = 1.5,
            }
        )
        gCreatedTargetEntities[job.identity] = gCreatedTargetEntities[job.identity] or {}
        gCreatedTargetEntities[job.identity][#gCreatedTargetEntities[job.identity] + 1] = {
            peds = createdEntities,
            label = "Open Market",
            targetType = targetType,
        }
    elseif targetType == "ox_target" then
        if not hasResource("ox_target") then
            debugPrint("error", "ox_target not found.")
            return
        end
        ox_target:addLocalEntity(createdEntities,
            {
                label = "Open Market",
                name = "target:entity:ox_target:market:" .. job.identity .. ":" .. market.id,
                icon = "fa-solid fa-toolbox",
                distance = 1.5,
                groups = (job.perm and job.perm.type ~= "all") and job.perm.name or nil,
                onSelect = function(data)
                    local underscoreIndex = string.find(menu.menuId, "_")
                    local menuType = string.sub(menu.menuId, 1, underscoreIndex - 1)
                    OpenMenuByResource(menuType, menu.menuId, menu.options)
                end,
            }
        )
        gCreatedTargetEntities[job.identity] = gCreatedTargetEntities[job.identity] or {}
        gCreatedTargetEntities[job.identity][#gCreatedTargetEntities[job.identity] + 1] = {
            peds = createdEntities,
            label = "target:entity:ox_target:market:" .. job.identity .. ":" .. market.id,
            targetType = targetType,
        }
    end
end

function CreateZoneForJobMarket(job, market, menu)
    if not job or not market or not menu then return end
    local _index = 1
    local createdMarketZones = {}
    for _, coords in pairs(market.ped_coords) do
        local spawnedPed = CreatePedWithOptions(market.ped_model_hash, coords)
        if not spawnedPed then goto continue end
        gSpawnedPeds[job.identity] = gSpawnedPeds[job.identity] or {}
        gSpawnedPeds[job.identity][#gSpawnedPeds[job.identity] + 1] = {
            type = "market",
            ped = spawnedPed
        }
        local uniqueZoneName = "zone:circle:market:" .. job.identity .. ":" .. market.id .. ":" .. _index
        local createdMarketZone = CircleZone:Create(vector3(coords.x, coords.y, coords.z), tonumber(1.5), {
            name = uniqueZoneName,
            debugPoly = false,
            useZ = true,
            data = {
                jobIdentity = job.identity,
                marketId = market.id
            }
        })
        createdMarketZones[#createdMarketZones + 1] = createdMarketZone
        _index = _index + 1
        ::continue::
    end
    local uniqueZoneId = "zone:combo:market:" .. job.identity .. ":" .. market.id
    gCreatedZones[job.identity] = gCreatedZones[job.identity] or {}
    gCreatedZones[job.identity][#gCreatedZones[job.identity] + 1] = {
        type = "market",
        zone = ComboZone:Create(createdMarketZones,
            {
                name = uniqueZoneId,
                debugPoly = false,
                useGrid = true
            }
        )
    }
    gCreatedZones[job.identity][#gCreatedZones[job.identity]].zone:onPlayerInOut(function(isPointInside, point, zone)
        if isPointInside then
            gPlayer.inZone = true
            gPlayer.zoneInfo = {
                type = "market",
                data = {
                    jobIdentity = job.identity,
                    zone = zone.data,
                    menu = menu
                },
            }
            if job.textui_type == "draw_text_marker" then
                gCreatedDrawTexts[#gCreatedDrawTexts + 1] = {
                    type = "market",
                    jobIdentity = job.identity,
                    marketId = market.id,
                    coords = zone.center
                }
            else
                ShowTextUIByResource(job.textui_type,
                    _t("JobCreator.e_interact")
                )
            end
        else
            gPlayer.inZone = false
            gPlayer.zoneInfo = nil
            table_remove(gCreatedDrawTexts, "market", job.identity, market.id)
            HideTextUIByResource(job.textui_type)
        end
    end)
end

function CreateJobStashes(job)
    if not job then return end
    local stashes = job.stashes or {}
    if next(stashes) == nil then return end
    for _, stash in pairs(stashes) do
        if stash.interaction_type == "target" then
            CreateTargetZoneForJobStash(job, stash)
        elseif stash.interaction_type == "textui" then
            CreateZoneForJobStash(job, stash)
        end
    end
end

function CreateTargetZoneForJobStash(job, stash)
    if not job or not stash then return end
    local targetType = job.target_type
    if not targetType or targetType == "no_target" then
        targetType = Config.Default.TargetType
    end
    local uniqueZoneId = nil
    local coords = stash.coords
    if targetType == "qb_target" then
        if not hasResource("qb-target") then
            debugPrint("error", "qb_target not found.")
            return
        end
        uniqueZoneId = "zone:sphere:qb_target:stash:" .. job.identity .. ":" .. stash.id
        exports["qb-target"]:AddCircleZone(uniqueZoneId, vector3(coords.x, coords.y, coords.z), 1.5,
            {
                name = uniqueZoneId,
                debugPoly = false,
            }, {
                options = {
                    {
                        num = 1,
                        type = "client",
                        icon = "fa-solid fa-toolbox",
                        label = "Open Stash",
                        targeticon = "fa-solid fa-toolbox",
                        action = function(entity)
                            OpenJobStash(stash)
                        end,
                        job = job.perm.type == "job" and job.perm.name or nil,
                        gang = job.perm.type == "gang" and job.perm.name or nil,
                    }
                },
                distance = 1.5,
            }
        )
    elseif targetType == "ox_target" then
        if not hasResource("ox_target") then
            debugPrint("error", "ox_target not found.")
            return
        end
        uniqueZoneId = ox_target:addSphereZone({
            coords = vector3(tonumber(coords.x), tonumber(coords.y), tonumber(coords.z)),
            radius = 1.5,
            debug = false,
            drawSprite = true,
            options = {
                {
                    label = "Open stash",
                    name = "zone:sphere:ox_target:stash:" .. job.identity .. ":" .. stash.id,
                    icon = "fa-solid fa-toolbox",
                    distance = 1.5,
                    groups = (job.perm and job.perm.type ~= "all") and job.perm.name or nil,
                    onSelect = function(data)
                        OpenJobStash(stash)
                    end,
                }
            }
        })
    end
    gCreatedTargetZones[job.identity] = gCreatedTargetZones[job.identity] or {}
    gCreatedTargetZones[job.identity][#gCreatedTargetZones[job.identity] + 1] = {
        targetType = targetType,
        id = uniqueZoneId
    }
end

function CreateZoneForJobStash(job, stash)
    if not job or not stash then return end
    local coords = stash.coords
    local uniqueZoneId = "zone:circle:stash:" .. job.identity .. ":" .. stash.id
    gCreatedZones[job.identity] = gCreatedZones[job.identity] or {}
    gCreatedZones[job.identity][#gCreatedZones[job.identity] + 1] = {
        type = "stash",
        zone = CircleZone:Create(vector3(coords.x, coords.y, coords.z), 1.5, {
            name = uniqueZoneId,
            debugPoly = false,
            useZ = true
        })
    }
    gCreatedZones[job.identity][#gCreatedZones[job.identity]].zone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            gPlayer.inZone = true
            gPlayer.zoneInfo = {
                type = "stash",
                data = {
                    jobIdentity = job.identity,
                    stashId = stash.id
                },
            }
            if job.textui_type == "draw_text_marker" then
                gCreatedDrawTexts[#gCreatedDrawTexts + 1] = {
                    type = "stash",
                    jobIdentity = job.identity,
                    stashId = stash.id,
                    coords = coords,
                }
            else
                ShowTextUIByResource(job.textui_type,
                    _t("JobCreator.e_interact")
                )
            end
        else
            gPlayer.inZone = false
            gPlayer.zoneInfo = nil
            table_remove(gCreatedDrawTexts, "stash", job.identity, stash.id)
            HideTextUIByResource(job.textui_type)
        end
    end)
end

function OpenJobStash(stash)
    local inventory_type = Config.Default.InventoryType
    if inventory_type == "qb_inventory" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", stash.unique_name,
            {
                maxWeight = stash.size,
                slots = stash.slots
            }
        )
        TriggerEvent("inventory:client:SetCurrentStash", stash.unique_name)
    elseif inventory_type == "ox_inventory" then
        if ox_inventory:openInventory("stash", stash.unique_name) == false then
            TriggerServerEvent("0r-jobcreator:Server:RegisterOxStash", stash)
            ox_inventory:openInventory("stash", stash.unique_name)
        end
    elseif inventory_type == "custom" then
        CustomInventory.OpenStash(PlayerData.source, stash)
    end
end

function CreateJobObjects(job)
    if not job then return end
    local objects = job.objects or {}
    if next(objects) == nil then return end
    for _, object in pairs(objects) do
        CreateJobObject(job.identity, object)
    end
end

function CreateJobCarSpawners(job)
    if not job then return end
    local spawners = job.carSpawners or {}
    if next(spawners) == nil then return end
    for _, spawner in pairs(spawners) do
        local menu = CreateMenuToJobCarSpawner(job, spawner)
        if spawner.interaction_type == "target" then
            CreateTargetZoneForJobCarSpawner(job, spawner, menu)
        elseif spawner.interaction_type == "textui" then
            CreateZoneForJobCarSpawner(job, spawner, menu)
        end
    end
end

function CreateJobObject(jobIdentity, object)
    local modelHash = object.model_hash
    loadModel(modelHash)
    local coords = nil
    local success, err = pcall(function()
        coords = vector3(tonumber(object.coords.x), tonumber(object.coords.y), tonumber(object.coords.z))
    end)
    if not success and err then
        SendNotify(nil,
            _t("JobCreator.invalid_vector_type", "err"),
            "error"
        )
        return
    end
    if object.type == "object" then
        local cObject = CreateObject(modelHash,
            vector3(coords.x, coords.y, coords.z),
            object.is_network == "yes",
            object.net_mission_entity == "yes",
            object.door_flag == "yes"
        )
        if cObject ~= 0 then
            PlaceObjectOnGroundProperly(cObject)
            FreezeEntityPosition(cObject, true)
            SetEntityInvincible(cObject, true)
            SetBlockingOfNonTemporaryEvents(cObject, true)
            gCreatedObjects[jobIdentity] = gCreatedObjects[jobIdentity] or {}
            gCreatedObjects[jobIdentity][#gCreatedObjects[jobIdentity] + 1] = {
                coords = coords,
                object = cObject,
                modelHash = modelHash,
            }
        end
    elseif object.type == "ped" then
        local spawnedPed = CreatePedWithOptions(modelHash, vector3(coords.x, coords.y, coords.z))
        if not spawnedPed then return end
        gSpawnedPeds[jobIdentity] = gSpawnedPeds[jobIdentity] or {}
        gSpawnedPeds[jobIdentity][#gSpawnedPeds[jobIdentity] + 1] = {
            type = "object_ped",
            ped = spawnedPed
        }
    end
end

function CreateJobTeleports(job)
    if not job then return end
    local teleports = job.teleports or {}
    if next(teleports) == nil then return end
    for _, teleport in pairs(teleports) do
        if teleport.interaction_type == "target" then
            CreateTargetZoneForJobTeleport(job, teleport)
        elseif teleport.interaction_type == "textui" then
            CreateZoneForJobTeleport(job, teleport)
        end
    end
end

function CreateTargetZoneForJobCarSpawner(job, spawner, menu)
    if not job or not spawner or not menu then return end
    local targetType = job.target_type
    if not targetType or targetType == "no_target" then
        targetType = Config.Default.TargetType
    end
    local uniqueZoneId = nil
    local coords = spawner.coords
    if targetType == "qb_target" then
        if not hasResource("qb-target") then
            debugPrint("error", "qb_target not found.")
            return
        end
        uniqueZoneId = "zone:sphere:qb_target:car_spawner:" .. job.identity .. ":" .. spawner.id
        exports["qb-target"]:AddCircleZone(uniqueZoneId,
            vector3(tonumber(coords.x), tonumber(coords.y), tonumber(coords.z)), 1.5,
            {
                name = uniqueZoneId,
                debugPoly = false,
            }, {
                options = {
                    {
                        num = 1,
                        type = "client",
                        icon = "fa-solid fa-bullseye",
                        label = "Spawn Car",
                        targeticon = "fa-solid fa-bullseye",
                        action = function(entity)
                            local underscoreIndex = string.find(menu.menuId, "_")
                            local menuType = string.sub(menu.menuId, 1, underscoreIndex - 1)
                            OpenMenuByResource(menuType, menu.menuId, menu.options)
                        end,
                        job = job.perm.type == "job" and job.perm.name or nil,
                        gang = job.perm.type == "gang" and job.perm.name or nil,
                    }
                },
                distance = 1.5,
            }
        )
    elseif targetType == "ox_target" then
        if not hasResource("ox_target") then
            debugPrint("error", "ox_target not found.")
            return
        end
        uniqueZoneId = ox_target:addSphereZone({
            coords = vector3(tonumber(coords.x), tonumber(coords.y), tonumber(coords.z)),
            radius = 1.5,
            debug = false,
            drawSprite = true,
            options = {
                {
                    label = "Spawn Car",
                    name = "zone:sphere:ox_target:car_spawner:" .. job.identity .. ":" .. spawner.id,
                    icon = "fa-solid fa-bullseye",
                    distance = 1.5,
                    groups = (job.perm and job.perm.type ~= "all") and job.perm.name or nil,
                    onSelect = function(data)
                        local underscoreIndex = string.find(menu.menuId, "_")
                        local menuType = string.sub(menu.menuId, 1, underscoreIndex - 1)
                        OpenMenuByResource(menuType, menu.menuId, menu.options)
                    end,
                }
            }
        })
    end
    gCreatedTargetZones[job.identity] = gCreatedTargetZones[job.identity] or {}
    gCreatedTargetZones[job.identity][#gCreatedTargetZones[job.identity] + 1] = {
        targetType = targetType,
        id = uniqueZoneId
    }
end

function CreateZoneForJobCarSpawner(job, spawner, menu)
    if not job or not spawner or not menu then return end
    local coords = spawner.coords
    local uniqueZoneId = "zone:circle:car_spawner:" .. job.identity .. ":" .. spawner.id
    gCreatedZones[job.identity] = gCreatedZones[job.identity] or {}
    gCreatedZones[job.identity][#gCreatedZones[job.identity] + 1] = {
        type = "car_spawner",
        zone = CircleZone:Create(vector3(coords.x, coords.y, coords.z), 1.5, {
            name = uniqueZoneId,
            debugPoly = false,
            useZ = true
        })
    }
    gCreatedZones[job.identity][#gCreatedZones[job.identity]].zone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            gPlayer.inZone = true
            gPlayer.zoneInfo = {
                type = "car_spawner",
                data = {
                    jobIdentity = job.identity,
                    spawnerId = spawner.id,
                    menu = menu
                },
            }
            if job.textui_type == "draw_text_marker" then
                gCreatedDrawTexts[#gCreatedDrawTexts + 1] = {
                    type = "car_spawner",
                    jobIdentity = job.identity,
                    spawnerId = spawner.id,
                    coords = coords,
                }
            else
                ShowTextUIByResource(job.textui_type,
                    _t("JobCreator.e_interact")
                )
            end
        else
            gPlayer.inZone = false
            gPlayer.zoneInfo = nil
            table_remove(gCreatedDrawTexts, "car_spawner", job.identity, spawner.id)
            HideTextUIByResource(job.textui_type)
        end
    end)
end

function CreateTargetZoneForJobTeleport(job, teleport)
    if not job or not teleport then return end
    local targetType = job.target_type
    if not targetType or targetType == "no_target" then
        targetType = Config.Default.TargetType
    end
    gCreatedTargetZones[job.identity] = gCreatedTargetZones[job.identity] or {}
    local _index = 1
    local teleport_coords = {
        teleport.entry_coords,
        teleport.type == "two-way" and teleport.exit_coords or nil
    }
    if targetType == "qb_target" then
        if not hasResource("qb-target") then
            debugPrint("error", "qb_target not found.")
            return
        end
        for key, coords in pairs(teleport_coords) do
            local uniqueZoneId = "zone:sphere:qb_target:teleport:" .. job.identity .. ":" .. teleport.id .. ":" .. _index
            exports["qb-target"]:AddCircleZone(uniqueZoneId, vector3(coords.x, coords.y, coords.z), 1.5,
                {
                    name = uniqueZoneId,
                    debugPoly = false,
                }, {
                    options = {
                        {
                            num = 1,
                            type = "client",
                            icon = "fa-solid fa-bullseye",
                            label = "Teleport",
                            targeticon = "fa-solid fa-bullseye",
                            action = function(entity)
                                TriggerEvent("0r-jobcreator:Client:TeleportToCoords",
                                    key == 1 and teleport.exit_coords or teleport.entry_coords
                                )
                            end,
                            job = job.perm.type == "job" and job.perm.name or nil,
                            gang = job.perm.type == "gang" and job.perm.name or nil,
                        }
                    },
                    distance = 1.5,
                }
            )
            _index = _index + 1
            gCreatedTargetZones[job.identity][#gCreatedTargetZones[job.identity] + 1] = {
                targetType = targetType,
                id = uniqueZoneId
            }
        end
    elseif targetType == "ox_target" then
        if not hasResource("ox_target") then
            debugPrint("error", "ox_target not found.")
            return
        end
        for key, coords in pairs(teleport_coords) do
            local uniqueZoneId = ox_target:addSphereZone({
                coords = vector3(tonumber(coords.x), tonumber(coords.y), tonumber(coords.z)),
                radius = 1.5,
                debug = false,
                drawSprite = true,
                options = {
                    {
                        label = "Teleport",
                        name = "zone:sphere:ox_target:teleport:" .. job.identity .. ":" .. teleport.id .. ":" .. _index,
                        icon = "fa-solid fa-bullseye",
                        distance = 1.5,
                        groups = (job.perm and job.perm.type ~= "all") and job.perm.name or nil,
                        onSelect = function(data)
                            TriggerEvent("0r-jobcreator:Client:TeleportToCoords",
                                key == 1 and teleport.exit_coords or teleport.entry_coords
                            )
                        end,
                    }
                }
            })
            _index = _index + 1
            gCreatedTargetZones[job.identity][#gCreatedTargetZones[job.identity] + 1] = {
                targetType = targetType,
                id = uniqueZoneId
            }
        end
    end
end

function CreateZoneForJobTeleport(job, teleport)
    if not job or not teleport then return end
    local _index = 1
    local teleport_coords = {
        teleport.entry_coords,
        teleport.type == "two-way" and teleport.exit_coords or nil
    }
    for key, coords in pairs(teleport_coords) do
        local uniqueZoneId = "zone:circle:teleport:" .. job.identity .. ":" .. teleport.id .. ":" .. _index
        gCreatedZones[job.identity] = gCreatedZones[job.identity] or {}
        gCreatedZones[job.identity][#gCreatedZones[job.identity] + 1] = {
            type = "teleport",
            zone = CircleZone:Create(vector3(coords.x, coords.y, coords.z), 1.5, {
                name = uniqueZoneId,
                debugPoly = false,
                useZ = true
            })
        }
        gCreatedZones[job.identity][#gCreatedZones[job.identity]].zone:onPlayerInOut(function(isPointInside)
            if isPointInside then
                gPlayer.inZone = true
                gPlayer.zoneInfo = {
                    type = "teleport",
                    data = {
                        jobIdentity = job.identity,
                        entry = key == 1 and true or false,
                        teleportId = teleport.id
                    },
                }
                if job.textui_type == "draw_text_marker" then
                    gCreatedDrawTexts[#gCreatedDrawTexts + 1] = {
                        type = "teleport",
                        jobIdentity = job.identity,
                        teleportId = teleport.id,
                        coords = coords
                    }
                else
                    ShowTextUIByResource(job.textui_type,
                        _t("JobCreator.e_interact")
                    )
                end
            else
                gPlayer.inZone = false
                gPlayer.zoneInfo = nil
                table_remove(gCreatedDrawTexts, "teleport", job.identity, teleport.id)
                HideTextUIByResource(job.textui_type)
            end
        end)
    end
end

function CreateMenuToJobCarSpawner(job, spawner)
    local menuType = job.menu_type
    local menuId = nil
    local menuOptions = nil
    if not menuType or menuType == "no_menu" then
        menuType = Config.Default.MenuType
    end
    if menuType == "qb_menu" then
        menuId = "qb_" .. job.identity .. "_carSpawner_" .. spawner.id
        menuOptions = {
            {
                header = _t("JobCreator.car_spawner_menu_title", spawner.name),
                icon = "fa-solid fa-magnifying-glass",
                isMenuHeader = true
            },
            {
                header = "Delete Vehicle",
                icon = "fa-solid fa-car",
                params = {
                    event = "0r-jobcreator:Client:JobCarDelete",
                }
            }
        }
        for _, car in pairs(spawner.cars) do
            table.insert(menuOptions,
                {
                    header = "Spawn Car",
                    txt = car.model:upper(),
                    icon = "fa-solid fa-car",
                    params = {
                        event = "0r-jobcreator:Client:JobCarSpawn",
                        args = {
                            jobIdentity = job.identity,
                            spawnerCoords = spawner.car_spawner_coords,
                            carModel = car.model
                        }
                    }
                }
            )
        end
    elseif menuType == "ox_menu" then
        menuId = "ox_" .. job.identity .. "_carSpawner_" .. spawner.id
        local menuItems = {
            {
                label = "Delete Vehicle",
                icon = "fa-solid fa-car",
                iconColor = "red",
                args = {
                    deleteEvent = true
                }
            }
        }
        for _, car in pairs(spawner.cars) do
            table.insert(menuItems,
                {
                    label = "Spawn: " .. car.model,
                    icon = "fa-solid fa-car",
                    iconColor = "green",
                    args = {
                        jobIdentity = job.identity,
                        spawnerCoords = spawner.car_spawner_coords,
                        carModel = car.model
                    }
                }
            )
        end
        menuOptions = {
            id = menuId,
            title = _t("JobCreator.car_spawner_menu_title", spawner.name),
            position = "top-right",
            options = menuItems
        }
        lib.registerMenu(menuOptions, function(selected, scrollIndex, args)
            if not args.deleteEvent then
                TriggerEvent("0r-jobcreator:Client:JobCarSpawn", args)
            else
                TriggerEvent("0r-jobcreator:Client:JobCarDelete")
            end
        end)
    end
    return {
        menuId = menuId,
        options = menuOptions
    }
end

function CreateMenuToJobStartPed(job)
    local menuType = job.menu_type
    local menuId = nil
    local menuOptions = nil
    if not menuType or menuType == "no_menu" then
        menuType = Config.Default.MenuType
    end
    if menuType == "qb_menu" then
        menuId = "qb_" .. job.identity
        menuOptions = {
            {
                header = _t("JobCreator.start_ped_menu_title", job.name),
                icon = "fa-solid fa-magnifying-glass",
                isMenuHeader = true
            },
            {
                header = "Start Work",
                txt = "Start doing the job",
                icon = "fa-solid fa-check",
                params = {
                    event = "0r-jobcreator:Client:PlayerStartWorkFromPed",
                    args = {
                        jobIdentity = job.identity
                    }
                }
            },
            {
                header = "Stop Work",
                txt = "Start doing the job",
                icon = "fa-solid fa-ban",
                params = {
                    event = "0r-jobcreator:Client:PlayerStopWorkFromPed",
                    args = {
                        jobIdentity = job.identity
                    }
                }
            },
        }
    elseif menuType == "ox_menu" then
        menuId = "ox_" .. job.identity
        menuOptions = {
            id = menuId,
            title = _t("JobCreator.start_ped_menu_title", job.name),
            position = "top-right",
            options = {
                {
                    label = "Start Work",
                    icon = "fa-solid fa-check",
                    iconColor = "green",
                    args = {
                        jobIdentity = job.identity
                    }
                },
                {
                    label = "Stop Work",
                    icon = "fa-solid fa-ban",
                    iconColor = "red",
                    args = {
                        jobIdentity = job.identity
                    }
                },
            }
        }
        lib.registerMenu(menuOptions, function(selected, scrollIndex, args)
            if selected == 1 then
                TriggerEvent("0r-jobcreator:Client:PlayerStartWorkFromPed", args)
            elseif selected == 2 then
                TriggerEvent("0r-jobcreator:Client:PlayerStopWorkFromPed", args)
            end
        end)
    end
    return {
        menuId = menuId,
        options = menuOptions
    }
end

function CreateZoneForJobStartPed(job, menu)
    local pedCoords = job.start_ped.coords
    local uniqueZoneId = "zone:circle:start_ped:" .. job.identity
    gCreatedZones[job.identity] = gCreatedZones[job.identity] or {}
    gCreatedZones[job.identity][#gCreatedZones[job.identity] + 1] = {
        type = "start_ped",
        zone = CircleZone:Create(vector3(pedCoords.x, pedCoords.y, pedCoords.z), 1.5, {
            name = uniqueZoneId,
            debugPoly = false
        })
    }
    gCreatedZones[job.identity][#gCreatedZones[job.identity]].zone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            gPlayer.inZone = true
            gPlayer.zoneInfo = {
                type = "start_ped",
                data = {
                    jobIdentity = job.identity,
                    menu = menu
                },
            }
            if job.textui_type == "draw_text_marker" then
                gCreatedDrawTexts[#gCreatedDrawTexts + 1] = {
                    type = "start_ped",
                    jobIdentity = job.identity,
                    coords = pedCoords
                }
            else
                ShowTextUIByResource(job.textui_type,
                    _t("JobCreator.e_interact")
                )
            end
        else
            gPlayer.inZone = false
            gPlayer.zoneInfo = nil
            table_remove(gCreatedDrawTexts, "start_ped", job.identity)
            HideTextUIByResource(job.textui_type)
        end
    end)
end

function CreateBlipForCoords(coords, options, jobIdentity, stepid)
    local newBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(newBlip, tonumber(options.sprite))
    SetBlipDisplay(newBlip, 4)
    SetBlipScale(newBlip, int2float(tonumber(options.scale)))
    SetBlipAsShortRange(newBlip, true)
    SetBlipColour(newBlip, tonumber(options.color))
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("[" .. options.name .. "]")
    EndTextCommandSetBlipName(newBlip)
    gCreatedBlips[jobIdentity] = gCreatedBlips[jobIdentity] or {
        blip      = nil,
        stepBlips = {}
    }
    if not stepid then
        gCreatedBlips[jobIdentity].blip = newBlip
    elseif gCreatedBlips[jobIdentity] then
        gCreatedBlips[jobIdentity].stepBlips[#gCreatedBlips[jobIdentity].stepBlips + 1] = newBlip
    end
end

function CreateTargetZoneForJobStep(job, step)
    if not job then return end
    local targetType = job.target_type
    if not targetType or targetType == "no_target" then
        targetType = Config.Default.TargetType
    end
    gCreatedTargetZones[job.identity] = gCreatedTargetZones[job.identity] or {}
    local _index = 1
    if targetType == "qb_target" then
        if not hasResource("qb-target") then
            debugPrint("error", "qb_target not found.")
            return
        end
        for _, coords in pairs(step.coords) do
            local uniqueZoneId = "zone:circle:qb_target:step:" .. job.identity .. ":" .. step.id .. ":" .. _index
            exports["qb-target"]:AddCircleZone(uniqueZoneId, vector3(coords.x, coords.y, coords.z), tonumber(step.radius),
                {
                    name = uniqueZoneId,
                    debugPoly = false,
                }, {
                    options = {
                        {
                            num = 1,
                            type = "client",
                            icon = "fa-solid fa-arrow-right",
                            label = "Do: " .. step.title,
                            targeticon = "fa-solid fa-hammer",
                            action = function(entity)
                                TriggerEvent("0r-jobcreator:Client:PerformJobStep", job.identity, step.id)
                            end,
                            item = step.required_item == "yes" and step.required_item.name or nil,
                            job = job.perm.type == "job" and job.perm.name or nil,
                            gang = job.perm.type == "gang" and job.perm.name or nil,
                        }
                    },
                    distance = tonumber(step.radius),
                }
            )
            _index = _index + 1
            gCreatedTargetZones[job.identity][#gCreatedTargetZones[job.identity] + 1] = {
                targetType = targetType,
                id = uniqueZoneId
            }
        end
    elseif targetType == "ox_target" then
        if not hasResource("ox_target") then
            debugPrint("error", "ox_target not found.")
            return
        end
        for _, coords in pairs(step.coords) do
            local uniqueZoneId = ox_target:addSphereZone({
                coords = vector3(tonumber(coords.x), tonumber(coords.y), tonumber(coords.z)),
                radius = tonumber(step.radius),
                debug = false,
                drawSprite = true,
                options = {
                    {
                        label = "Do: " .. step.title,
                        name = "zone:sphere:ox_target:step:" .. job.identity .. ":" .. step.id .. ":" .. _index,
                        icon = "fa-solid fa-arrow-right",
                        distance = tonumber(step.radius),
                        items = (step.required_item == "yes") and
                            { step.required_item.name, tonumber(step.required_item.count) } or nil,
                        groups = (job.perm and job.perm.type ~= "all") and job.perm.name or nil,
                        onSelect = function(data)
                            TriggerEvent("0r-jobcreator:Client:PerformJobStep", job.identity, step.id)
                        end,
                    }
                }
            })
            _index = _index + 1
            gCreatedTargetZones[job.identity][#gCreatedTargetZones[job.identity] + 1] = {
                targetType = targetType,
                id = uniqueZoneId
            }
        end
    end
end

function CreateZoneForJobStep(job, step)
    if not job or not step then return end
    local _index = 1
    local createdStepZones = {}
    for _, coords in pairs(step.coords) do
        local uniqueZoneName = "zone:circle:step:" .. job.identity .. ":" .. step.id .. ":" .. _index
        local createdStepZone = CircleZone:Create(vector3(coords.x, coords.y, coords.z), tonumber(step.radius), {
            name = uniqueZoneName,
            debugPoly = false,
            useZ = true,
            data = {
                stepId = step.id
            }
        })
        createdStepZones[#createdStepZones + 1] = createdStepZone
        _index = _index + 1
    end
    local uniqueZoneId = "zone:combo:step:" .. job.identity .. ":" .. step.id
    gCreatedZones[job.identity] = gCreatedZones[job.identity] or {}
    gCreatedZones[job.identity][#gCreatedZones[job.identity] + 1] = {
        type = "step",
        zone = ComboZone:Create(createdStepZones,
            {
                name = uniqueZoneId,
                debugPoly = false,
                useGrid = true
            }
        )
    }
    gCreatedZones[job.identity][#gCreatedZones[job.identity]].zone:onPlayerInOut(function(isPointInside, point, zone)
        if isPointInside then
            gPlayer.inZone = true
            gPlayer.zoneInfo = {
                type = "step",
                data = {
                    jobIdentity = job.identity,
                    zone = zone.data
                },
            }
            if job.textui_type == "draw_text_marker" then
                gCreatedDrawTexts[#gCreatedDrawTexts + 1] = {
                    type = "step",
                    jobIdentity = job.identity,
                    stepId = step.id,
                    coords = zone.center
                }
            else
                ShowTextUIByResource(job.textui_type,
                    _t("JobCreator.e_interact")
                )
            end
        else
            gPlayer.inZone = false
            gPlayer.zoneInfo = nil
            table_remove(gCreatedDrawTexts, "step", job.identity, step.id)
            HideTextUIByResource(job.textui_type)
        end
    end)
end

function DeleteSpawnedJobPeds()
    for _, peds in pairs(gSpawnedPeds) do
        for key, value in pairs(peds) do
            DeletePed(value.ped)
        end
    end
end

function HideTextUIByResource(resource)
    if resource == "qb_textui" then
        if (hasResource("qb-core")) then
            exports["qb-core"]:HideText()
        end
    elseif resource == "ox_textui" then
        if (hasResource("ox_lib")) then
            lib.hideTextUI()
        end
    end
end

function HideTextUI()
    if (hasResource("qb-core")) then
        exports["qb-core"]:HideText()
    end
    if (hasResource("ox_lib")) then
        lib.hideTextUI()
    end
end

function ClearDrawTexts()
    gCreatedDrawTexts = {}
end

function ShowTextUIByResource(resource, message, options)
    if resource == "qb_textui" then
        if (hasResource("qb-core")) then
            if not options then
                options = "left"
            end
            exports["qb-core"]:DrawText(message, options)
        end
    elseif resource == "ox_textui" then
        if (hasResource("ox_lib")) then
            if not options then
                options = {
                    position = "left-center"
                }
            end
            lib.showTextUI(message, options)
        end
    end
end

function OpenMenuByResource(resource, menuId, options)
    if resource == "qb" then
        if (hasResource("qb-core")) then
            exports["qb-menu"]:openMenu(options)
        end
    elseif resource == "ox" then
        if (hasResource("ox_lib")) then
            lib.showMenu(menuId)
        end
    end
end

function HideMenu()
    if (hasResource("qb-core")) then
        exports["qb-menu"]:closeMenu()
    end
    if (hasResource("ox_lib")) then
        lib.hideMenu()
    end
end

function DestroyZones()
    for identity, targetZones in pairs(gCreatedTargetZones) do
        for key, zone in pairs(targetZones) do
            if zone.targetType == "qb_target" then
                exports["qb-target"]:RemoveZone(zone.id)
            elseif zone.targetType == "ox_target" then
                ox_target:removeZone(zone.id)
            end
        end
        gCreatedTargetZones[identity] = nil
    end
    for identity, zones in pairs(gCreatedZones) do
        for key, value in pairs(zones) do
            value.zone:destroy()
        end
        gCreatedZones[identity] = nil
    end
end

function DestroyTargetEntities()
    for identity, entities in pairs(gCreatedTargetEntities) do
        for key, value in pairs(entities) do
            if value.targetType == "qb_target" then
                exports["qb-target"]:RemoveTargetEntity(value.peds, value.label)
            elseif value.targetType == "ox_target" then
                ox_target:removeLocalEntity(value.peds, value.label)
            end
        end
        gCreatedTargetEntities[identity] = nil
    end
end

function DestroyObjects()
    for identity, objects in pairs(gCreatedObjects) do
        for key, value in pairs(objects) do
            local objectModel = GetEntityModel(value.object)
            if objectModel == GetHashKey(value.modelHash) then
                DeleteObject(value.object)
                gCreatedObjects[identity][key] = nil
            end
        end
        gCreatedObjects[identity] = nil
    end
end

function DestroyBlips()
    for key, item in pairs(gCreatedBlips) do
        RemoveBlip(item.blip)
        if next(item.stepBlips) then
            for _, stepBlip in pairs(item.stepBlips) do
                RemoveBlip(stepBlip)
            end
        end
        gCreatedBlips[key] = nil
    end
end

function DeleteSpawnedCar()
    if gPlayer.spawnedCar then
        DeleteVehicleByFrameWork(gPlayer.spawnedCar)
    end
end

function PlayAnimationProgressBar(type, options, cb)
    if not type or type == "no_progressbar" then
        type = Config.Default.ProgressBarType
    end
    loadAnimDict(options.dict)
    local disableMovement = options.progressbar.disable_movement == "yes"
    if type == "qb_progressbar" then
        local busy = exports["progressbar"]:isDoingSomething()
        if busy then
            SendNotify(Config.Default.NotifyType,
                _t("JobCreator.cant_do_this_because_busy"),
                "error"
            )
            cb(false)
            return
        end
        local controlDisablesOptions = {
            disableMovement = disableMovement,
            disableCarMovement = disableMovement,
            disableMouse = false,
            disableCombat = true
        }
        local animOptions = {
            animDict = options.dict,
            anim = options.name,
            flags = tonumber(options.flags) or nil,
        }
        local propOptions = (options.prop.is_required == "yes") and {
            model = options.prop.model,
            bone = tonumber(options.prop.bone) or nil,
            coords = {
                x = tonumber(options.prop.coords.x),
                y = tonumber(options.prop.coords.y),
                z = tonumber(options.prop.coords.z)
            },
            rotation = {
                x = tonumber(options.prop.rotation.x),
                y = tonumber(options.prop.rotation.y),
                z = tonumber(options.prop.rotation.z)
            },
        } or nil
        QBCore.Functions.Progressbar("jobcreator_progress", options.progressbar.title, tonumber(options.duration), false,
            true,
            controlDisablesOptions, animOptions, propOptions, {}, function()
                StopAnimTask(
                    PlayerPedId(),
                    animOptions.animDict,
                    animOptions.anim,
                    1.0
                )
                cb(true)
            end, function()
                StopAnimTask(
                    PlayerPedId(),
                    animOptions.animDict,
                    animOptions.anim,
                    1.0
                )
                cb(false)
            end)
    elseif type == "ox_progressbar" then
        local busy = lib.progressActive()
        if busy then
            SendNotify(Config.Default.NotifyType,
                _t("JobCreator.cant_do_this_because_busy"),
                "error"
            )
            cb(false)
            return
        end
        local complete = lib.progressBar({
            duration = options.duration,
            label = options.progressbar.title,
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = disableMovement,
                car = disableMovement,
                mouse = false,
                combat = true
            },
            anim = {
                dict = options.dict,
                clip = options.name,
                flag = tonumber(options.flags) or nil
            },
            prop = options.prop.is_required == "yes" and {
                model = options.prop.model,
                bone = tonumber(options.prop.bone) or nil,
                pos = {
                    x = tonumber(options.prop.coords.x),
                    y = tonumber(options.prop.coords.y),
                    z = tonumber(options.prop.coords.z)
                },
                rot = {
                    x = tonumber(options.prop.rotation.x),
                    y = tonumber(options.prop.rotation.y),
                    z = tonumber(options.prop.rotation.z)
                }
            } or nil
        })
        StopAnimTask(
            PlayerPedId(),
            options.dict,
            options.name,
            1.0
        )
        cb(complete)
    elseif type == "custom_progressbar" then
        local complete = CustomProgressbar(options)
        StopAnimTask(
            PlayerPedId(),
            options.dict,
            options.name,
            1.0
        )
        cb(complete)
    end
end

function PlayAnimationSkillBar(type, options, cb)
    if not type or type == "no_skillbar" then
        type = Config.Default.ProgressBarType
    end
    if type == "qb_skillbar" then
        local neededAttempts = tonumber(options.skillbar.needed_attempts or 1)
        local succeededAttempts = 0
        local Skillbar = exports["qb-skillbar"]:GetSkillbarObject()
        Skillbar.Start({
            duration = math.random(2500, 5000),
            pos = math.random(20, 30),
            width = math.random(10, 20),
        }, function()
            if succeededAttempts + 1 >= neededAttempts then
                cb(true)
            else
                Skillbar.Repeat({
                    duration = math.random(2500, 5000),
                    pos = math.random(10, 30),
                    width = math.random(10, 20),
                })
                succeededAttempts = succeededAttempts + 1
            end
        end, function()
            cb(false)
        end)
    elseif type == "ox_skillbar" then
        local busy = lib.skillCheckActive()
        if busy then
            SendNotify(Config.Default.NotifyType,
                _t("JobCreator.cant_do_this_because_busy"),
                "error"
            )
            cb(false)
            return
        end
        local neededAttempts = tonumber(options.skillbar.needed_attempts or 1)
        local neededAttemptsTable = {}
        for i = 1, neededAttempts do
            neededAttemptsTable[#neededAttemptsTable + 1] = "medium"
        end
        local success = lib.skillCheck(neededAttemptsTable,
            { "w", "a", "s", "d" })
        cb(success)
    elseif type == "custom_skillbar" then
        local complete = CustomSkillbar(options)
        cb(complete)
    end
end

function JobMarketItemSelected(market, item)
    TriggerServerEvent("0r-jobcreator:Server:JobMarketItemSelected", PlayerData.source, market, item)
end
