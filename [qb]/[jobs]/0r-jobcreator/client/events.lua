AddEventHandler("onResourceStart", function(resource)
    if resource == GetCurrentResourceName() then
        PlayerData = GetPlayerData()
        Wait(1000)
        SendPlayerDataToReact()
        LoadJobsToClient()
    end
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        SetNuiFocus(false, false)
        DeleteSpawnedJobPeds()
        DestroyZones()
        DestroyTargetEntities()
        DestroyObjects()
        DestroyBlips()
        HideTextUI()
        ClearDrawTexts()
        HideMenu()
        DeleteSpawnedCar()
        gPlayer.inZone = false
        gPlayer.zoneInfo = nil
        gPlayer.job = false
        gPlayer.onDuty = false
        gPlayer.spawnedCar = false
    end
end)

--- Framework Events

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    PlayerData = GetPlayerData()
    SendPlayerDataToReact()
    LoadJobsToClient()
end)

RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
    PlayerData = {}
    SetNuiFocus(false, false)
    DeleteSpawnedJobPeds()
    DestroyZones()
    DestroyTargetEntities()
    DestroyObjects()
    DestroyBlips()
    HideTextUI()
    ClearDrawTexts()
    HideMenu()
    DeleteSpawnedCar()
    gPlayer.inZone = false
    gPlayer.zoneInfo = nil
    gPlayer.job = false
    gPlayer.onDuty = false
    gPlayer.spawnedCar = false
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate", function(jobInfo)
    PlayerData.job = jobInfo
end)

RegisterNetEvent("QBCore:Client:OnGangUpdate", function(gangInfo)
    PlayerData.gang = gangInfo
end)

RegisterNetEvent("QBCore:Player:SetPlayerData", function(val)
    PlayerData = val
end)

-- Job Creator Events --

RegisterNetEvent("0r-jobcreator:Client:OpenJobCreatorPanel", function()
    ToggleJobCreatorPanel(true)
end)

RegisterNetEvent("0r-jobcreator:Client:OnJobStatusUpdated", function(jobIdentity, status)
    JobsClass:updateJobStatusByJobIdentity(jobIdentity, status)
    local job = JobsClass:getJobByIdentity(jobIdentity)
    if status == "active" then
        StartJobByJob(job)
    else
        StopJobByJob(job, true)
    end
end)

RegisterNetEvent("0r-jobcreator:Client:OnJobDeleted", function(jobIdentity)
    JobsClass:deleteJob(jobIdentity)
end)

RegisterNetEvent("0r-jobcreator:Client:OnJobStepUpdated", function(jobIdentity, step)
    JobsClass:updateJobStepByIdentity(jobIdentity, step)
end)

RegisterNetEvent("0r-jobcreator:Client:OnUpdatedJob", function(job)
    JobsClass:updateJobMainSettings(job)
end)

RegisterNetEvent("0r-jobcreator:Client:OnJobCreated", function(job)
    JobsClass:addIfNotExist(job)
end)

RegisterNetEvent("0r-jobcreator:Client:OnJobStepCreated", function(jobIdentity, newStep)
    JobsClass:addStep(jobIdentity, newStep)
end)

RegisterNetEvent("0r-jobcreator:Client:OnJobStepDeleted", function(jobIdentity, stepId)
    JobsClass:deleteJobStepByIdentity(jobIdentity, stepId)
end)

RegisterNetEvent("0r-jobcreator:Client:PlayerStartWorkFromPed", function(data)
    if gPlayer.onDuty then
        SendNotify(Config.Default.NotifyType,
            _t("JobCreator.already_have_job", gPlayer.job.name),
            "error"
        )
        return
    end
    local jobIdentity = data.jobIdentity
    local job = JobsClass:getJobByIdentity(jobIdentity)
    if not job or not JobsClass:isJobAvailable(job.identity) then
        SendNotify(Config.Default.NotifyType,
            _t("JobCreator.job_not_exist"),
            "error"
        )
        return
    end
    gPlayer.onDuty = true
    gPlayer.job = job
    StartJobStepsByJob(job)
    CreateJobTeleports(job)
    CreateJobObjects(job)
    CreateJobCarSpawners(job)
    CreateJobStashes(job)
    CreateJobMarkets(job)
    SendNotify(job.notify_type,
        _t("JobCreator.started_work_at_job", job.name),
        "success"
    )
end)

RegisterNetEvent("0r-jobcreator:Client:PlayerStopWorkFromPed", function(data)
    if not gPlayer.onDuty then
        SendNotify(nil,
            _t("JobCreator.dont_have_a_job"),
            "error"
        )
        return
    end
    SendNotify(Config.Default.NotifyType,
        _t("JobCreator.stopped_work"),
        "success"
    )
    StopJobByJob(gPlayer.job, false)
end)

RegisterNetEvent("0r-jobcreator:Client:PerformJobStep", function(jobIdentity, stepId)
    local job = JobsClass:getJobByIdentity(jobIdentity)
    if not job then return end
    local step = JobsClass:getJobStepById(jobIdentity, stepId)
    if not step then return end
    TriggerCallback("0r-jobcreator:Server:CheckAndPerformStep", function(result)
        if not result then return end
        if type(result) ~= "boolean" and result.playAnimation then
            local animation = step.animation
            if animation.type == "progressbar" then
                PlayAnimationProgressBar(job.progressbar_type, animation, function(response)
                    if response then
                        TriggerCallback("0r-jobcreator:Server:LastProcessTheStep", function(result)
                            if result then
                                SendNotify(job.notify_type,
                                    _t("JobCreator.completed_step"),
                                    "success"
                                )
                            else
                                SendNotify(job.notify_type,
                                    _t("JobCreator.error_occurred"),
                                    "error"
                                )
                            end
                        end, jobIdentity, stepId)
                    else
                        SendNotify(job.notify_type,
                            _t("JobCreator.step_not_be_completed"),
                            "error"
                        )
                    end
                end)
            elseif animation.type == "skillbar" then
                PlayAnimationSkillBar(job.skillbar_type, animation, function(response)
                    if response then
                        TriggerCallback("0r-jobcreator:Server:LastProcessTheStep", function(result)
                            if result then
                                SendNotify(job.notify_type,
                                    _t("JobCreator.completed_step"),
                                    "success"
                                )
                            else
                                SendNotify(job.notify_type,
                                    _t("JobCreator.error_occurred"),
                                    "error"
                                )
                            end
                        end, jobIdentity, stepId)
                    else
                        SendNotify(job.notify_type,
                            _t("JobCreator.step_not_be_completed"),
                            "error"
                        )
                    end
                end)
            end
        end
        if type(result) == "boolean" and result then
            SendNotify(job.notify_type,
                _t("JobCreator.completed_step"),
                "success"
            )
        end
    end, jobIdentity, stepId)
end)

RegisterNetEvent("0r-jobcreator:Client:OnJobTeleportCreated", function(jobIdentity, newTeleport)
    JobsClass:addTeleport(jobIdentity, newTeleport)
end)

RegisterNetEvent("0r-jobcreator:Client:OnJobTeleportUpdated", function(jobIdentity, updatedTeleport)
    JobsClass:updateJobTeleportByIdentity(jobIdentity, updatedTeleport)
end)

RegisterNetEvent("0r-jobcreator:Client:TeleportToCoords", function(coords)
    local ped = PlayerPedId()
    SetPedCoordsKeepVehicle(ped, coords.x, coords.y, coords.z)
    SetEntityHeading(ped, coords.h or GetEntityHeading(ped))
    Wait(1)
end)

RegisterNetEvent("0r-jobcreator:Client:OnJobObjectCreated", function(jobIdentity, newObject)
    JobsClass:addObject(jobIdentity, newObject)
end)

RegisterNetEvent("0r-jobcreator:Client:OnJobObjectUpdated", function(jobIdentity, updatedObject)
    JobsClass:updateJobObjectByIdentity(jobIdentity, updatedObject)
end)

RegisterNetEvent("0r-jobcreator:Client:OnJobObjectDeleted", function(jobIdentity, objectId)
    JobsClass:deleteJobObjectByIdentity(jobIdentity, objectId)
end)

RegisterNetEvent("0r-jobcreator:Client:OnJobCarSpawnerCreated", function(jobIdentity, newCarSpawner)
    JobsClass:addCarSpawner(jobIdentity, newCarSpawner)
end)

RegisterNetEvent("0r-jobcreator:Client:OnJobCarSpawnerUpdated", function(jobIdentity, updatedObject)
    JobsClass:updateJobCarSpawnerByIdentity(jobIdentity, updatedObject)
end)

RegisterNetEvent("0r-jobcreator:Client:JobCarSpawn", function(data)
    if gPlayer.spawnedCar then
        DeleteVehicleByFrameWork(gPlayer.spawnedCar)
    end
    local spawnedCar = SpawnVehicleByFrameWork(data.carModel, data.spawnerCoords, true)
    if spawnedCar then
        gPlayer.spawnedCar = spawnedCar
    end
end)

RegisterNetEvent("0r-jobcreator:Client:JobCarDelete", function()
    if gPlayer.spawnedCar then
        DeleteVehicleByFrameWork(gPlayer.spawnedCar)
        SendNotify(nil,
            _t("JobCreator.deleted_car"),
            "success"
        )
    end
end)

RegisterNetEvent("0r-jobcreator:Client:OnJobStashCreated", function(jobIdentity, newStash)
    JobsClass:addStash(jobIdentity, newStash)
end)

RegisterNetEvent("0r-jobcreator:Client:OnJobStashUpdated", function(jobIdentity, updatedStash)
    JobsClass:updateJobStashByIdentity(jobIdentity, updatedStash)
end)

RegisterNetEvent("0r-jobcreator:Client:OnJobStashDeleted", function(jobIdentity, stashId)
    JobsClass:deleteJobStashByIdentity(jobIdentity, stashId)
end)

RegisterNetEvent("0r-jobcreator:Client:OnJobMarketCreated", function(jobIdentity, newMarket)
    JobsClass:addMarket(jobIdentity, newMarket)
end)

RegisterNetEvent("0r-jobcreator:Client:OnJobMarketUpdated", function(jobIdentity, updatedMarket)
    JobsClass:updateJobMarketByIdentity(jobIdentity, updatedMarket)
end)

RegisterNetEvent("0r-jobcreator:Client:OnJobMarketDeleted", function(jobIdentity, marketId)
    JobsClass:deleteJobMarketByIdentity(jobIdentity, marketId)
end)

RegisterNetEvent("0r-jobcreator:Client:JobMarketSelected", function(data)
    local market = data.market
    local item = data.item
    JobMarketItemSelected(market, item)
end)
