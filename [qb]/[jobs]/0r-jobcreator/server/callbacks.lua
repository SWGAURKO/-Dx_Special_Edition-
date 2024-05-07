QBCore.Functions.CreateCallback("0r-jobcreator:Server:GetJobs", function(source, cb)
    local src = source
    local xPlayer = GetPlayerBySource(src)
    if xPlayer then
        cb(JobsClass:getJobs())
    end
end)

QBCore.Functions.CreateCallback("0r-jobcreator:Server:CreateJob", function(source, cb, job)
    local src = source
    local xPlayer = GetPlayerBySource(src)
    if xPlayer then
        local hasPerm = CheckPlayerPermission(src, "admin")
        if hasPerm then
            local jobIdentity = CreateJobIdentity()
            local jobUniqueName = CheckJobUniqueNameAvailable(job.name, jobIdentity)
            if not jobUniqueName then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.already_created_with_name"),
                    "error"
                )
                cb(false)
                return
            end
            job.identity = jobIdentity
            job.unique_name = jobUniqueName
            job.author = xPlayer.PlayerData.citizenid
            job.status = "deactive"
            job.start_type = nil
            job.blip = {}
            job.start_ped = {}
            job.steps = {}
            job.teleports = {}
            job.objects = {}
            job.carSpawners = {}
            JobsClass:addJob(job)
            TriggerClientEvent("0r-jobcreator:Client:OnJobCreated", -1, job)
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.created_new_job"),
                "success"
            )
            SaveJobToDatabase(job, xPlayer)
            cb({ newJob = job })
            return
        end
    end
    cb(false)
end)

QBCore.Functions.CreateCallback("0r-jobcreator:Server:UpdateJobMainSettings", function(source, cb, job)
    local src = source
    local xPlayer = GetPlayerBySource(src)
    if xPlayer then
        local hasPerm = CheckPlayerPermission(src, "admin")
        if hasPerm then
            if job.status == "active" then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.cannot_make_changes_is_active"),
                    "error"
                )
                cb(false)
                return
            end
            if job.start_type == "ped" then
                local isCoordAreaBusy, jobIdentity, err = JobCoordAreaCheck(
                    { job.start_ped.coords },
                    1.5,
                    job.identity
                )
                if err then
                    SendNotifyServerside(nil,
                        src,
                        _t("JobCreator.invalid_vector_type", "err"),
                        "error"
                    )
                    cb(false)
                    return
                end
                if isCoordAreaBusy then
                    SendNotifyServerside(nil,
                        src,
                        _t("JobCreator.another_job_that_area", jobIdentity),
                        "error"
                    )
                    cb(false)
                    return
                end
            end
            local jobUniqueName = CheckJobUniqueNameAvailable(job.name, job.identity)
            if not jobUniqueName then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.already_created_with_name"),
                    "error"
                )
                cb(false)
                return
            end
            local newValues = {
                name = job.name,
                unique_name = jobUniqueName,
                perm = job.perm,
                notify_type = job.notify_type,
                progressbar_type = job.progressbar_type,
                skillbar_type = job.skillbar_type,
                menu_type = job.menu_type,
                target_type = job.target_type,
                textui_type = job.textui_type,
                start_type = job.start_type,
                start_ped = job.start_ped,
                blip = job.blip,
                author = xPlayer.PlayerData.citizenid,
            }
            local updatedJob = JobsClass:updateJobMainSettings(job.identity, newValues)
            TriggerClientEvent("0r-jobcreator:Client:OnUpdatedJob", -1, updatedJob)
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.updated_job_main_settings"),
                "success"
            )
            SaveJobToDatabase(updatedJob, xPlayer)
            cb({ updatedJob = updatedJob })
            return
        end
    end
    cb(false)
end)

QBCore.Functions.CreateCallback("0r-jobcreator:Server:UpdateJobStatusByIdentity", function(source, cb, identity, status)
    local src = source
    local xPlayer = GetPlayerBySource(src)
    if xPlayer then
        local hasPerm = CheckPlayerPermission(src, "admin")
        if not hasPerm then
            cb(false)
            return
        end
        local job = JobsClass:getJobByIdentity(identity)
        if not job then
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.job_not_exist"),
                "error"
            )
            cb(false)
            return
        end
        local stringStatus = status and "active" or "deactive"
        if job.status == stringStatus then
            cb(false)
            return
        end
        if status then
            if not next(job.steps) then
                job.steps = {}
            end
            if not job.start_type then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.incomplete_setting", "Start Type"),
                    "error"
                )
                cb(false)
                return
            end
            if job.start_type and job.start_type == "ped" and (not job.start_ped.interaction_type or not job.start_ped.model or not job.start_ped.coords) then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.incomplete_setting",
                        "Start Ped"),
                    "error"
                )
                cb(false)
                return
            end
            if not job.notify_type or
                not job.progressbar_type or
                not job.skillbar_type or
                not job.menu_type or
                not job.target_type or
                not job.textui_type then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.incomplete_setting", "Main Settings"),
                    "error"
                )
                cb(false)
                return
            end
        end
        local newStatus = JobsClass:updateJobStatusByJobIdentity(job.identity, status)
        TriggerClientEvent("0r-jobcreator:Client:OnJobStatusUpdated", -1, job.identity, newStatus)
        SendNotifyServerside(nil,
            src,
            _t("JobCreator.job_status_changed", newStatus),
            "success"
        )
        UpdateJobStatusToDatabase(job.identity, newStatus, xPlayer)
        cb({ newStatus = newStatus })
        return
    end
    cb(false)
end)

QBCore.Functions.CreateCallback("0r-jobcreator:Server:DeleteJobByIdentity", function(source, cb, jobIdentity)
    local src = source
    local xPlayer = GetPlayerBySource(src)
    if xPlayer then
        local hasPerm = CheckPlayerPermission(src, "admin")
        if hasPerm then
            local job = JobsClass:getJobByIdentity(jobIdentity)
            if not job then
                cb(false)
                return
            end
            if job.status == "active" then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.cannot_make_changes_is_active"),
                    "error"
                )
                cb(false)
                return
            end
            JobsClass:deleteJob(job.identity)
            TriggerClientEvent("0r-jobcreator:Client:OnJobDeleted", -1, job.identity)
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.deleted_job", job.identity),
                "success"
            )
            DeleteJobToDatabase(job.identity, xPlayer)
            cb(true)
        end
    end
    cb(false)
end)


QBCore.Functions.CreateCallback("0r-jobcreator:Server:CheckAndPerformStep", function(source, cb, jobIdentity, stepId)
    local src = source
    local xPlayer = GetPlayerBySource(src)
    local job = JobsClass:getJobByIdentity(jobIdentity)
    if not job then
        SendNotifyServerside(nil,
            src,
            _t("JobCreator.job_not_exist"),
            "error"
        )
        cb(false)
        return
    end
    local step = JobsClass:getJobStepById(jobIdentity, stepId)
    if not step then
        SendNotifyServerside(nil,
            src,
            _t("JobCreator.job_step_not_exist"),
            "error"
        )
        cb(false)
        return
    end
    local jobPerm = job.perm
    if jobPerm and jobPerm.type ~= "all" then
        if (jobPerm.type == "job" and xPlayer.PlayerData.job.name ~= jobPerm.name) or
            (jobPerm.type == "gang" and xPlayer.PlayerData.gang.name ~= jobPerm.name)
        then
            SendNotifyServerside(job.notify_type,
                src,
                _t("JobCreator.cant_make_this_step"),
                "error"
            )
            cb(false)
            return
        end
    end
    local cooling, left = JobsClass:isStepOnCooldownById(src, jobIdentity, stepId)
    if cooling then
        SendNotifyServerside(job.notify_type,
            src,
            _t("JobCreator.in_step_cooling_down", left),
            "error"
        )
        cb(false)
        return
    end
    local stepRequiredItem = step.required_item
    if stepRequiredItem.is_required == "yes" then
        local hasItem, amount = PlayerHasItem(xPlayer, stepRequiredItem.name)
        if not hasItem or amount < tonumber(stepRequiredItem.count) then
            SendNotifyServerside(job.notify_type, src,
                _t("JobCreator.dont_have_necessary_items",
                    (stepRequiredItem.name .. " " .. (tonumber(stepRequiredItem.count or 0) - amount))),
                "error"
            )
            cb(false)
            return
        end
    end
    local stepAnimation = step.animation
    if stepAnimation.is_required == "yes" then
        cb({
            playAnimation = true
        })
    else
        local response = LastProcessTheStep(src, job, step)
        cb(response)
    end
end)

QBCore.Functions.CreateCallback("0r-jobcreator:Server:LastProcessTheStep", function(source, cb, jobIdentity, stepId)
    local src = source
    local job = JobsClass:getJobByIdentity(jobIdentity)
    if not job or job.status == "deactive" then
        cb(false)
        return
    end
    local step = JobsClass:getJobStepById(jobIdentity, stepId)
    if not step then
        cb(false)
        return
    end
    local response = LastProcessTheStep(src, job, step)
    cb(response)
end)

QBCore.Functions.CreateCallback("0r-jobcreator:Server:AddJobStep", function(source, cb, jobIdentity, newStep)
    local src = source
    local xPlayer = GetPlayerBySource(src)
    if xPlayer then
        local hasPerm = CheckPlayerPermission(src, "admin")
        if not hasPerm then
            cb(false)
            return
        end
        local job = JobsClass:getJobByIdentity(jobIdentity)
        if not job then
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.job_not_exist"),
                "error"
            )
            cb(false)
            return
        end
        if job.status == "active" then
            SendNotifyServerside(nil,
                source,
                _t("JobCreator.cannot_make_changes_is_active"),
                "error"
            )
            cb(false)
            return
        end
        if not newStep.coords or #newStep.coords == 0 then
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.one_coordinate_must_be_added", stepName),
                "error"
            )
            cb(false)
            return
        end
        local isCoordAreaBusy, info, err = JobCoordAreaCheck(
            newStep.coords,
            newStep.radius,
            job.identity
        )
        if err then
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.invalid_vector_type"),
                "error"
            )
        end
        if isCoordAreaBusy then
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.another_job_that_area", info),
                "error"
            )
            cb(false)
            return
        end
        local createdStepId = SaveJobStepToDatabase(job.identity, newStep, xPlayer)
        if not createdStepId then
            cb(false)
            return
        end
        newStep.id = createdStepId
        newStep.author = xPlayer.PlayerData.citizenid
        newStep.job_identity = job.identity
        JobsClass:addStep(job.identity, newStep)
        TriggerClientEvent("0r-jobcreator:Client:OnJobStepCreated", -1, job.identity, newStep)
        SendNotifyServerside(nil,
            src,
            _t("JobCreator.created_new_job_step"),
            "success"
        )
        cb({ newStep = newStep })
        return
    end
    cb(false)
end)

QBCore.Functions.CreateCallback("0r-jobcreator:Server:UpdateJobStepByStepId",
    function(source, cb, jobIdentity, stepId, updatedStep)
        local src = source
        local xPlayer = GetPlayerBySource(src)
        if xPlayer then
            local hasPerm = CheckPlayerPermission(src, "admin")
            if not hasPerm then
                cb(false)
                return
            end
            local job = JobsClass:getJobByIdentity(jobIdentity)
            if not job then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.job_not_exist"),
                    "error"
                )
                cb(false)
                return
            end
            if job.status == "active" then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.cannot_make_changes_is_active"),
                    "error"
                )
                cb(false)
                return
            end
            if not JobsClass:getJobStepById(jobIdentity, stepId) then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.job_step_not_exist"),
                    "error"
                )
                cb(false)
                return
            end
            if not updatedStep.coords or #updatedStep.coords == 0 then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.one_coordinate_must_be_added", stepName),
                    "error"
                )
                cb(false)
                return
            end
            local isCoordAreaBusy, info, err = JobCoordAreaCheck(
                updatedStep.coords,
                updatedStep.radius,
                job.identity,
                updatedStep.id
            )
            if err then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.invalid_vector_type", "err"),
                    "error"
                )
            end
            if isCoordAreaBusy then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.another_job_that_area", info),
                    "error"
                )
                cb(false)
                return
            end
            updatedStep.author = xPlayer.PlayerData.citizenid
            local _updatedStep = JobsClass:updateJobStepByIdentity(job.identity, updatedStep)
            if not _updatedStep then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.error_occurred"),
                    "error"
                )
                cb(false)
                return
            end
            TriggerClientEvent("0r-jobcreator:Client:OnJobStepUpdated", -1, job.identity, updatedStep)
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.updated_job_step"),
                "success"
            )
            SaveJobStepToDatabase(job.identity, updatedStep, xPlayer)
            cb({ updatedStep = updatedStep })
        end
    end
)

QBCore.Functions.CreateCallback("0r-jobcreator:Server:DeleteJobStepByIdentity", function(source, cb, jobIdentity, stepId)
    local src = source
    local xPlayer = GetPlayerBySource(src)
    if xPlayer then
        local hasPerm = CheckPlayerPermission(src, "admin")
        if hasPerm then
            local job = JobsClass:getJobByIdentity(jobIdentity)
            if not job then
                cb(false)
                return
            end
            if job.status == "active" then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.cannot_make_changes_is_active"),
                    "error"
                )
                cb(false)
                return
            end
            JobsClass:deleteJobStepByIdentity(job.identity, stepId)
            TriggerClientEvent("0r-jobcreator:Client:OnJobStepDeleted", -1, job.identity, stepId)
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.deleted_job_step"),
                "success"
            )
            DeleteJobStepToDatabase(job.identity, stepId, xPlayer)
            cb(true)
        end
    end
    cb(false)
end)

QBCore.Functions.CreateCallback("0r-jobcreator:Server:AddJobTeleport", function(source, cb, jobIdentity, newTeleport)
    local src = source
    local xPlayer = GetPlayerBySource(src)
    if xPlayer then
        local hasPerm = CheckPlayerPermission(src, "admin")
        if not hasPerm then
            cb(false)
            return
        end
        local job = JobsClass:getJobByIdentity(jobIdentity)
        if not job then
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.job_not_exist"),
                "error"
            )
            cb(false)
            return
        end
        if job.status == "active" then
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.cannot_make_changes_is_active"),
                "error"
            )
            cb(false)
            return
        end
        local isCoordAreaBusy, info, err = TeleportCoordAreaCheck(
            newTeleport.entry_coords,
            newTeleport.exit_coords,
            3.0,
            job.identity
        )
        if err then
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.invalid_vector_type"),
                "error"
            )
        end
        if isCoordAreaBusy then
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.another_teleport_that_area", info),
                "error"
            )
            cb(false)
            return
        end
        local createdTeleportId = SaveJobTeleportToDatabase(job.identity, newTeleport, xPlayer)
        if not createdTeleportId then
            cb(false)
            return
        end
        newTeleport.id = createdTeleportId
        newTeleport.author = xPlayer.PlayerData.citizenid
        newTeleport.job_identity = job.identity
        JobsClass:addTeleport(job.identity, newTeleport)
        TriggerClientEvent("0r-jobcreator:Client:OnJobTeleportCreated", -1, job.identity, newTeleport)
        SendNotifyServerside(nil,
            src,
            _t("JobCreator.created_new_job_teleport"),
            "success"
        )
        cb({ newTeleport = newTeleport })
        return
    end
    cb(false)
end)

QBCore.Functions.CreateCallback("0r-jobcreator:Server:UpdateJobTeleport",
    function(source, cb, jobIdentity, teleportId, updatedTeleport)
        local src = source
        local xPlayer = GetPlayerBySource(src)
        if xPlayer then
            local hasPerm = CheckPlayerPermission(src, "admin")
            if not hasPerm then
                cb(false)
                return
            end
            local job = JobsClass:getJobByIdentity(jobIdentity)
            if not job then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.job_not_exist"),
                    "error"
                )
                cb(false)
                return
            end
            if job.status == "active" then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.cannot_make_changes_is_active"),
                    "error"
                )
                cb(false)
                return
            end
            if not JobsClass:getJobTeleportById(jobIdentity, teleportId) then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.job_teleport_not_exist"),
                    "error"
                )
                cb(false)
                return
            end
            local isCoordAreaBusy, info, err = TeleportCoordAreaCheck(
                updatedTeleport.entry_coords,
                updatedTeleport.exit_coords,
                3.0,
                job.identity,
                teleportId
            )
            if err then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.invalid_vector_type", "err"),
                    "error"
                )
            end
            if isCoordAreaBusy then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.another_teleport_that_area", info),
                    "error"
                )
                cb(false)
                return
            end
            updatedTeleport.author = xPlayer.PlayerData.citizenid
            local _updatedTeleport = JobsClass:updateJobTeleportByIdentity(job.identity, updatedTeleport)
            if not _updatedTeleport then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.error_occurred"),
                    "error"
                )
                cb(false)
                return
            end
            TriggerClientEvent("0r-jobcreator:Client:OnJobTeleportUpdated", -1, job.identity, _updatedTeleport)
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.updated_job_teleport"),
                "success"
            )
            SaveJobTeleportToDatabase(job.identity, _updatedTeleport, xPlayer)
            cb({ updatedTeleport = _updatedTeleport })
        end
    end
)

QBCore.Functions.CreateCallback("0r-jobcreator:Server:AddJobObject", function(source, cb, jobIdentity, newObject)
    local src = source
    local xPlayer = GetPlayerBySource(src)
    if xPlayer then
        local hasPerm = CheckPlayerPermission(src, "admin")
        if not hasPerm then
            cb(false)
            return
        end
        local job = JobsClass:getJobByIdentity(jobIdentity)
        if not job then
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.job_not_exist"),
                "error"
            )
            cb(false)
            return
        end
        local createdObjectId = SaveJobObjectToDatabase(job.identity, newObject, xPlayer)
        if not createdObjectId then
            cb(false)
            return
        end
        newObject.id = createdObjectId
        newObject.author = xPlayer.PlayerData.citizenid
        newObject.job_identity = job.identity
        JobsClass:addObject(job.identity, newObject)
        TriggerClientEvent("0r-jobcreator:Client:OnJobObjectCreated", -1, job.identity, newObject)
        SendNotifyServerside(nil,
            src,
            _t("JobCreator.created_new_job_object"),
            "success"
        )
        cb({ newObject = newObject })
        return
    end
    cb(false)
end)

QBCore.Functions.CreateCallback("0r-jobcreator:Server:UpdateJobObject",
    function(source, cb, jobIdentity, objectId, updatedObject)
        local src = source
        local xPlayer = GetPlayerBySource(src)
        if xPlayer then
            local hasPerm = CheckPlayerPermission(src, "admin")
            if not hasPerm then
                cb(false)
                return
            end
            local job = JobsClass:getJobByIdentity(jobIdentity)
            if not job then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.job_not_exist"),
                    "error"
                )
                cb(false)
                return
            end
            if not JobsClass:getJobObjectById(jobIdentity, objectId) then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.job_object_not_exist"),
                    "error"
                )
                cb(false)
                return
            end
            updatedObject.author = xPlayer.PlayerData.citizenid
            local _updatedObject = JobsClass:updateJobObjectByIdentity(job.identity, updatedObject)
            if not _updatedObject then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.error_occurred"),
                    "error"
                )
                cb(false)
                return
            end
            TriggerClientEvent("0r-jobcreator:Client:OnJobObjectUpdated", -1, job.identity, _updatedObject)
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.updated_job_object"),
                "success"
            )
            SaveJobObjectToDatabase(job.identity, _updatedObject, xPlayer)
            cb({ updatedObject = _updatedObject })
        end
    end
)

QBCore.Functions.CreateCallback("0r-jobcreator:Server:DeleteJobObjectByIdentity",
    function(source, cb, jobIdentity, objectId)
        local src = source
        local xPlayer = GetPlayerBySource(src)
        if xPlayer then
            local hasPerm = CheckPlayerPermission(src, "admin")
            if hasPerm then
                local job = JobsClass:getJobByIdentity(jobIdentity)
                if not job then
                    cb(false)
                    return
                end
                JobsClass:deleteJobObjectByIdentity(job.identity, objectId)
                TriggerClientEvent("0r-jobcreator:Client:OnJobObjectDeleted", -1, job.identity, objectId)
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.deleted_job_object"),
                    "success"
                )
                DeleteJobObjectToDatabase(job.identity, objectId, xPlayer)
                cb(true)
            end
        end
        cb(false)
    end
)

QBCore.Functions.CreateCallback("0r-jobcreator:Server:AddJobCarSpawner", function(source, cb, jobIdentity, newCarSpawner)
    local src = source
    local xPlayer = GetPlayerBySource(src)
    if xPlayer then
        local hasPerm = CheckPlayerPermission(src, "admin")
        if not hasPerm then
            cb(false)
            return
        end
        local job = JobsClass:getJobByIdentity(jobIdentity)
        if not job then
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.job_not_exist"),
                "error"
            )
            cb(false)
            return
        end
        if job.status == "active" then
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.cannot_make_changes_is_active"),
                "error"
            )
            cb(false)
            return
        end
        local createdCarSpawnerId = SaveJobCarSpawnerToDatabase(job.identity, newCarSpawner, xPlayer)
        if not createdCarSpawnerId then
            cb(false)
            return
        end
        newCarSpawner.id = createdCarSpawnerId
        newCarSpawner.author = xPlayer.PlayerData.citizenid
        newCarSpawner.job_identity = job.identity
        JobsClass:addCarSpawner(job.identity, newCarSpawner)
        TriggerClientEvent("0r-jobcreator:Client:OnJobCarSpawnerCreated", -1, job.identity, newCarSpawner)
        SendNotifyServerside(nil,
            src,
            _t("JobCreator.created_new_job_carSpawner"),
            "success"
        )
        cb({ newCarSpawner = newCarSpawner })
        return
    end
    cb(false)
end)

QBCore.Functions.CreateCallback("0r-jobcreator:Server:UpdateJobCarSpawner",
    function(source, cb, jobIdentity, carSpawnerId, updatedCarSpawner)
        local src = source
        local xPlayer = GetPlayerBySource(src)
        if xPlayer then
            local hasPerm = CheckPlayerPermission(src, "admin")
            if not hasPerm then
                cb(false)
                return
            end
            local job = JobsClass:getJobByIdentity(jobIdentity)
            if not job then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.job_not_exist"),
                    "error"
                )
                cb(false)
                return
            end
            if job.status == "active" then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.cannot_make_changes_is_active"),
                    "error"
                )
                cb(false)
                return
            end
            if not JobsClass:getJobCarSpawnerById(jobIdentity, carSpawnerId) then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.job_carSpawner_not_exist"),
                    "error"
                )
                cb(false)
                return
            end
            updatedCarSpawner.author = xPlayer.PlayerData.citizenid
            local _updatedCarSpawner = JobsClass:updateJobCarSpawnerByIdentity(job.identity, updatedCarSpawner)
            if not _updatedCarSpawner then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.error_occurred"),
                    "error"
                )
                cb(false)
                return
            end
            TriggerClientEvent("0r-jobcreator:Client:OnJobCarSpawnerUpdated", -1, job.identity, _updatedCarSpawner)
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.updated_job_carSpawner"),
                "success"
            )
            SaveJobCarSpawnerToDatabase(job.identity, _updatedCarSpawner, xPlayer)
            cb({ updatedCarSpawner = _updatedCarSpawner })
        end
    end
)

QBCore.Functions.CreateCallback("0r-jobcreator:Server:AddJobStash", function(source, cb, jobIdentity, newStash)
    local src = source
    local xPlayer = GetPlayerBySource(src)
    if xPlayer then
        local hasPerm = CheckPlayerPermission(src, "admin")
        if not hasPerm then
            cb(false)
            return
        end
        local job = JobsClass:getJobByIdentity(jobIdentity)
        if not job then
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.job_not_exist"),
                "error"
            )
            cb(false)
            return
        end
        if job.status == "active" then
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.cannot_make_changes_is_active"),
                "error"
            )
            cb(false)
            return
        end
        local stashUniqueName = "jobcreator:" .. job.identity .. ":stash:" .. stringToUnique(newStash.name)
        newStash.unique_name = stashUniqueName
        local createdStashId = SaveJobStashToDatabase(job.identity, newStash, xPlayer)
        if not createdStashId then
            cb(false)
            return
        end
        newStash.id = createdStashId
        newStash.author = xPlayer.PlayerData.citizenid
        newStash.job_identity = job.identity
        JobsClass:addStash(job.identity, newStash)
        TriggerClientEvent("0r-jobcreator:Client:OnJobStashCreated", -1, job.identity, newStash)
        SendNotifyServerside(nil,
            src,
            _t("JobCreator.created_new_job_stash"),
            "success"
        )
        cb({ newStash = newStash })
        return
    end
    cb(false)
end)

QBCore.Functions.CreateCallback("0r-jobcreator:Server:UpdateJobStash",
    function(source, cb, jobIdentity, stashId, updatedStash)
        local src = source
        local xPlayer = GetPlayerBySource(src)
        if xPlayer then
            local hasPerm = CheckPlayerPermission(src, "admin")
            if not hasPerm then
                cb(false)
                return
            end
            local job = JobsClass:getJobByIdentity(jobIdentity)
            if not job then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.job_not_exist"),
                    "error"
                )
                cb(false)
                return
            end
            if job.status == "active" then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.cannot_make_changes_is_active"),
                    "error"
                )
                cb(false)
                return
            end
            if not JobsClass:getJobStashById(jobIdentity, stashId) then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.job_stash_not_exist"),
                    "error"
                )
                cb(false)
                return
            end
            local stashUniqueName = "jobcreator:" .. job.identity .. ":stash:" .. updatedStash.id
            updatedStash.unique_name = stashUniqueName
            updatedStash.author = xPlayer.PlayerData.citizenid
            local _updatedStash = JobsClass:updateJobStashByIdentity(job.identity, updatedStash)
            if not _updatedStash then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.error_occurred"),
                    "error"
                )
                cb(false)
                return
            end
            TriggerClientEvent("0r-jobcreator:Client:OnJobStashUpdated", -1, job.identity, _updatedStash)
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.updated_job_stash"),
                "success"
            )
            SaveJobStashToDatabase(job.identity, _updatedStash, xPlayer)
            cb({ updatedStash = _updatedStash })
        end
    end
)

QBCore.Functions.CreateCallback("0r-jobcreator:Server:DeleteJobStashByIdentity",
    function(source, cb, jobIdentity, stashId)
        local src = source
        local xPlayer = GetPlayerBySource(src)
        if xPlayer then
            local hasPerm = CheckPlayerPermission(src, "admin")
            if hasPerm then
                local job = JobsClass:getJobByIdentity(jobIdentity)
                if not job then
                    cb(false)
                    return
                end
                JobsClass:deleteJobStashByIdentity(job.identity, stashId)
                TriggerClientEvent("0r-jobcreator:Client:OnJobStashDeleted", -1, job.identity, stashId)
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.deleted_job_stash"),
                    "success"
                )
                DeleteJobStashToDatabase(job.identity, stashId, xPlayer)
                cb(true)
            end
        end
        cb(false)
    end
)

QBCore.Functions.CreateCallback("0r-jobcreator:Server:AddJobMarket", function(source, cb, jobIdentity, newMarket)
    local src = source
    local xPlayer = GetPlayerBySource(src)
    if xPlayer then
        local hasPerm = CheckPlayerPermission(src, "admin")
        if not hasPerm then
            cb(false)
            return
        end
        local job = JobsClass:getJobByIdentity(jobIdentity)
        if not job then
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.job_not_exist"),
                "error"
            )
            cb(false)
            return
        end
        if job.status == "active" then
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.cannot_make_changes_is_active"),
                "error"
            )
            cb(false)
            return
        end
        local createdMarketId = SaveJobMarketToDatabase(job.identity, newMarket, xPlayer)
        if not createdMarketId then
            cb(false)
            return
        end
        local marketUniqueName = "jobcreator:" .. job.identity .. ":market:" .. createdMarketId
        newMarket.id = createdMarketId
        newMarket.author = xPlayer.PlayerData.citizenid
        newMarket.job_identity = job.identity
        JobsClass:addMarket(job.identity, newMarket)
        TriggerClientEvent("0r-jobcreator:Client:OnJobMarketCreated", -1, job.identity, newMarket)
        SendNotifyServerside(nil,
            src,
            _t("JobCreator.created_new_job_market"),
            "success"
        )
        cb({ newMarket = newMarket })
        return
    end
    cb(false)
end)

QBCore.Functions.CreateCallback("0r-jobcreator:Server:UpdateJobMarket",
    function(source, cb, jobIdentity, marketId, updatedMarket)
        local src = source
        local xPlayer = GetPlayerBySource(src)
        if xPlayer then
            local hasPerm = CheckPlayerPermission(src, "admin")
            if not hasPerm then
                cb(false)
                return
            end
            local job = JobsClass:getJobByIdentity(jobIdentity)
            if not job then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.job_not_exist"),
                    "error"
                )
                cb(false)
                return
            end
            if job.status == "active" then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.cannot_make_changes_is_active"),
                    "error"
                )
                cb(false)
                return
            end
            if not JobsClass:getJobMarketById(jobIdentity, marketId) then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.job_market_not_exist"),
                    "error"
                )
                cb(false)
                return
            end
            updatedMarket.author = xPlayer.PlayerData.citizenid
            local _updatedMarket = JobsClass:updateJobMarketByIdentity(job.identity, updatedMarket)
            if not _updatedMarket then
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.error_occurred"),
                    "error"
                )
                cb(false)
                return
            end
            TriggerClientEvent("0r-jobcreator:Client:OnJobMarketUpdated", -1, job.identity, _updatedMarket)
            SendNotifyServerside(nil,
                src,
                _t("JobCreator.updated_job_market"),
                "success"
            )
            SaveJobMarketToDatabase(job.identity, _updatedMarket, xPlayer)
            cb({ updatedMarket = _updatedMarket })
        end
    end
)

QBCore.Functions.CreateCallback("0r-jobcreator:Server:DeleteJobMarketByIdentity",
    function(source, cb, jobIdentity, marketId)
        local src = source
        local xPlayer = GetPlayerBySource(src)
        if xPlayer then
            local hasPerm = CheckPlayerPermission(src, "admin")
            if hasPerm then
                local job = JobsClass:getJobByIdentity(jobIdentity)
                if not job then
                    cb(false)
                    return
                end
                JobsClass:deleteJobMarketByIdentity(job.identity, marketId)
                TriggerClientEvent("0r-jobcreator:Client:OnJobMarketDeleted", -1, job.identity, marketId)
                SendNotifyServerside(nil,
                    src,
                    _t("JobCreator.deleted_job_market"),
                    "success"
                )
                DeleteJobMarketToDatabase(job.identity, marketId, xPlayer)
                cb(true)
            end
        end
        cb(false)
    end
)
