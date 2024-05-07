RegisterNUICallback("hideFrame", function(_, cb)
    ToggleJobCreatorPanel(false)
    cb(true)
end)

RegisterNUICallback("job-creator/new", function(data, cb)
    TriggerCallback("0r-jobcreator:Server:CreateJob", function(result)
        cb(result)
    end, data)
end)

RegisterNUICallback("job-creator/updateJobMainSettings", function(job, cb)
    TriggerCallback("0r-jobcreator:Server:UpdateJobMainSettings", function(result)
        cb(result)
    end, job)
end)

RegisterNUICallback("job-creator/updateJobStatusByIdentity", function(data, cb)
    TriggerCallback("0r-jobcreator:Server:UpdateJobStatusByIdentity", function(result)
        cb(result)
    end, data.identity, data.status)
end)

RegisterNUICallback("job-creator/deleteJob", function(jobIdentity, cb)
    TriggerCallback("0r-jobcreator:Server:DeleteJobByIdentity", function(result)
        cb(result)
    end, jobIdentity)
end)

RegisterNUICallback("job-creator/getAllJobs", function(_, cb)
    cb(JobsClass:getJobs())
end)

RegisterNUICallback("job-creator/addNewJobStep", function(data, cb)
    TriggerCallback("0r-jobcreator:Server:AddJobStep", function(result)
        cb(result)
    end, data.jobIdentity, data.newStep)
end)

RegisterNUICallback("job-creator/updateJobStep", function(data, cb)
    TriggerCallback("0r-jobcreator:Server:UpdateJobStepByStepId", function(result)
        cb(result)
    end, data.jobIdentity, data.stepId, data.updatedStep)
end)

RegisterNUICallback("job-creator/deleteJobStep", function(data, cb)
    TriggerCallback("0r-jobcreator:Server:DeleteJobStepByIdentity", function(result)
        cb(result)
    end, data.jobIdentity, data.stepId)
end)

RegisterNUICallback("job-creator/addNewJobTeleport", function(data, cb)
    TriggerCallback("0r-jobcreator:Server:AddJobTeleport", function(result)
        cb(result)
    end, data.jobIdentity, data.newTeleport)
end)

RegisterNUICallback("job-creator/updateJobTeleport", function(data, cb)
    TriggerCallback("0r-jobcreator:Server:UpdateJobTeleport", function(result)
        cb(result)
    end, data.jobIdentity, data.teleportId, data.updatedTeleport)
end)

RegisterNUICallback("job-creator/addNewJobObject", function(data, cb)
    TriggerCallback("0r-jobcreator:Server:AddJobObject", function(result)
        cb(result)
    end, data.jobIdentity, data.newObject)
end)

RegisterNUICallback("job-creator/updateJobObject", function(data, cb)
    TriggerCallback("0r-jobcreator:Server:UpdateJobObject", function(result)
        cb(result)
    end, data.jobIdentity, data.objectId, data.updatedObject)
end)

RegisterNUICallback("job-creator/deleteJobObject", function(data, cb)
    TriggerCallback("0r-jobcreator:Server:DeleteJobObjectByIdentity", function(result)
        cb(result)
    end, data.jobIdentity, data.objectId)
end)

RegisterNUICallback("job-creator/addNewJobCarSpawner", function(data, cb)
    TriggerCallback("0r-jobcreator:Server:AddJobCarSpawner", function(result)
        cb(result)
    end, data.jobIdentity, data.newCarSpawner)
end)

RegisterNUICallback("job-creator/updateJobCarSpawner", function(data, cb)
    TriggerCallback("0r-jobcreator:Server:UpdateJobCarSpawner", function(result)
        cb(result)
    end, data.jobIdentity, data.carSpawnerId, data.updatedCarSpawner)
end)

RegisterNUICallback("job-creator/addNewJobStash", function(data, cb)
    TriggerCallback("0r-jobcreator:Server:AddJobStash", function(result)
        cb(result)
    end, data.jobIdentity, data.newStash)
end)

RegisterNUICallback("job-creator/updateJobStash", function(data, cb)
    TriggerCallback("0r-jobcreator:Server:UpdateJobStash", function(result)
        cb(result)
    end, data.jobIdentity, data.stashId, data.updatedStash)
end)

RegisterNUICallback("job-creator/deleteJobStash", function(data, cb)
    TriggerCallback("0r-jobcreator:Server:DeleteJobStashByIdentity", function(result)
        cb(result)
    end, data.jobIdentity, data.stashId)
end)

RegisterNUICallback("job-creator/addNewJobMarket", function(data, cb)
    TriggerCallback("0r-jobcreator:Server:AddJobMarket", function(result)
        cb(result)
    end, data.jobIdentity, data.newMarket)
end)

RegisterNUICallback("job-creator/updateJobMarket", function(data, cb)
    TriggerCallback("0r-jobcreator:Server:UpdateJobMarket", function(result)
        cb(result)
    end, data.jobIdentity, data.marketId, data.updatedMarket)
end)

RegisterNUICallback("job-creator/deleteJobMarket", function(data, cb)
    TriggerCallback("0r-jobcreator:Server:DeleteJobMarketByIdentity", function(result)
        cb(result)
    end, data.jobIdentity, data.marketId)
end)

RegisterNUICallback("job-creator/getCurrentLocationCoords", function(_, cb)
    local coords = GetCoordsByFramework(PlayerPedId())
    local x, y, z, w = nil

    x = tonumber(string.format("%.2f", coords.x))
    y = tonumber(string.format("%.2f", coords.y))
    z = tonumber(string.format("%.2f", coords.z))
    w = tonumber(string.format("%.2f", coords.w))

    cb({
        coords = {
            x = x,
            y = y,
            z = z,
            h = w,
        }
    })
end)
