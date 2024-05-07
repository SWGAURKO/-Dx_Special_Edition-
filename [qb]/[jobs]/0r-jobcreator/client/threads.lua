CreateThread(function()
    while true do
        local sleep = 1500
        if gPlayer.inZone then
            local data = gPlayer.zoneInfo.data
            local type = gPlayer.zoneInfo.type
            local job = JobsClass:getJobByIdentity(data.jobIdentity)
            if job then
                if job.perm and job.perm.type ~= "all" then
                    if (job.perm.type == "job" and PlayerData.job.name ~= job.perm.name) or
                        (job.perm.type == "gang" and PlayerData.gang.name ~= job.perm.name)
                    then
                        goto continue
                    end
                end
                if type == "start_ped" then
                    if IsControlJustReleased(0, 38) then
                        local underscoreIndex = string.find(data.menu.menuId, "_")
                        local menuType = string.sub(data.menu.menuId, 1, underscoreIndex - 1)
                        OpenMenuByResource(menuType, data.menu.menuId, data.menu.options)
                    end
                    sleep = 5
                elseif type == "step" then
                    if job.status == "active" then
                        local step = JobsClass:getJobStepById(job.identity, data.zone.stepId)
                        if step then
                            if IsControlJustReleased(0, 38) then
                                TriggerEvent("0r-jobcreator:Client:PerformJobStep", job.identity, step.id)
                            end
                            sleep = 5
                        end
                    end
                elseif type == "teleport" then
                    if job.status == "active" then
                        local teleport = JobsClass:getJobTeleportById(job.identity, data.teleportId)
                        if teleport then
                            if IsControlJustReleased(0, 38) then
                                if data.entry then
                                    TriggerEvent("0r-jobcreator:Client:TeleportToCoords", teleport.exit_coords)
                                elseif teleport.type == "two-way" then
                                    TriggerEvent("0r-jobcreator:Client:TeleportToCoords", teleport.entry_coords)
                                end
                            end
                            sleep = 5
                        end
                    end
                elseif type == "car_spawner" then
                    if job.status == "active" then
                        local carSpawner = JobsClass:getJobCarSpawnerById(job.identity, data.spawnerId)
                        if carSpawner then
                            if IsControlJustReleased(0, 38) then
                                local underscoreIndex = string.find(data.menu.menuId, "_")
                                local menuType = string.sub(data.menu.menuId, 1, underscoreIndex - 1)
                                OpenMenuByResource(menuType, data.menu.menuId, data.menu.options)
                            end
                            sleep = 5
                        end
                    end
                elseif type == "stash" then
                    if job.status == "active" then
                        local stash = JobsClass:getJobStashById(job.identity, data.stashId)
                        if stash then
                            if IsControlJustReleased(0, 38) then
                                OpenJobStash(stash)
                            end
                            sleep = 5
                        end
                    end
                elseif type == "market" then
                    if job.status == "active" then
                        local market = JobsClass:getJobMarketById(data.zone.jobIdentity, data.zone.marketId)
                        if market then
                            if IsControlJustReleased(0, 38) then
                                local underscoreIndex = string.find(data.menu.menuId, "_")
                                local menuType = string.sub(data.menu.menuId, 1, underscoreIndex - 1)
                                OpenMenuByResource(menuType, data.menu.menuId, data.menu.options)
                            end
                            sleep = 5
                        end
                    end
                end
            end
        end
        ::continue::
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        sleep = 1500
        if next(gCreatedDrawTexts) then
            local playerCoord = GetEntityCoords(PlayerPedId())
            for key, value in pairs(gCreatedDrawTexts) do
                local job = JobsClass:getJobByIdentity(value.jobIdentity)
                if job then
                    local distance = #(playerCoord - vector3(value.coords.x, value.coords.y, value.coords.z))
                    if distance < 1.5 then
                        if job.perm and job.perm.type ~= "all" then
                            if (job.perm.type == "job" and PlayerData.job.name ~= job.perm.name) or
                                (job.perm.type == "gang" and PlayerData.gang.name ~= job.perm.name)
                            then
                                goto continue
                            end
                        end
                        DrawText3D(value.coords, _t("JobCreator.e_interact"))
                        sleep = 5
                    end
                else
                    gCreatedDrawTexts[key] = nil
                end
                ::continue::
            end
        end
        Wait(sleep)
    end
end)
