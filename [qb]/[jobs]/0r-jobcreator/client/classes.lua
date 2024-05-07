function JobsClass:loadJobsToClient(jobs)
    self.jobs = jobs
    return jobs
end

function JobsClass:getJobs()
    return self.jobs
end

function JobsClass:addIfNotExist(job)
    if self.jobs[job.identity] then
        self.jobs[job.identity] = job
        return job
    end
    self.jobs[job.identity] = job
    return job
end

function JobsClass:getJobByIdentity(identity)
    if not identity then return false end
    return self.jobs[identity]
end

function JobsClass:isJobExistByIdentity(identity)
    if not identity then return false end
    return self.jobs[identity] and true or false
end

function JobsClass:isJobAvailable(identity)
    local job = self:getJobByIdentity(identity)
    return job and job.status == "active"
end

function JobsClass:getJobStepById(jobIdentity, stepId)
    local job = self:getJobByIdentity(jobIdentity)
    if job then
        return job.steps[stepId]
    end
    return false
end

function JobsClass:updateJobStatusByJobIdentity(identity, status)
    if not self.jobs[identity] then return end
    self.jobs[identity].status = status
end

function JobsClass:deleteJob(jobIdentity)
    self.jobs[jobIdentity] = nil
end

function JobsClass:addStep(jobIdentity, newStep)
    if not self:isJobExistByIdentity(jobIdentity) then return end
    if not self.jobs[jobIdentity].steps then
        self.jobs[jobIdentity].steps = {}
    end
    self.jobs[jobIdentity].steps[newStep.id] = newStep
end

function JobsClass:updateJobStepByIdentity(jobIdentity, updatedStep)
    if not self:isJobExistByIdentity(jobIdentity) or not self.jobs[jobIdentity].steps then
        return
    end
    self.jobs[jobIdentity].steps[updatedStep.id] = updatedStep
end

function JobsClass:deleteJobStepByIdentity(jobIdentity, stepId)
    self.jobs[jobIdentity].steps[stepId] = nil
end

function JobsClass:updateJobMainSettings(options)
    if not self:isJobExistByIdentity(options.identity) then return end
    self.jobs[options.identity] = options
end

function JobsClass:addTeleport(jobIdentity, newTeleport)
    if not self:isJobExistByIdentity(jobIdentity) then return end
    if not self.jobs[jobIdentity].teleports then
        self.jobs[jobIdentity].teleports = {}
    end
    self.jobs[jobIdentity].teleports[newTeleport.id] = newTeleport
end

function JobsClass:updateJobTeleportByIdentity(jobIdentity, updatedTeleport)
    if not self:isJobExistByIdentity(jobIdentity) or not self.jobs[jobIdentity].teleports then
        return
    end
    self.jobs[jobIdentity].teleports[updatedTeleport.id] = updatedTeleport
end

function JobsClass:getJobTeleportById(jobIdentity, teleportId)
    local job = self:getJobByIdentity(jobIdentity)
    if job then
        return job.teleports[teleportId]
    end
    return false
end

function JobsClass:addObject(jobIdentity, newObject)
    if not self:isJobExistByIdentity(jobIdentity) then return false end
    if not self.jobs[jobIdentity].objects then
        self.jobs[jobIdentity].objects = {}
    end
    self.jobs[jobIdentity].objects[newObject.id] = newObject
    return newObject
end

function JobsClass:updateJobObjectByIdentity(jobIdentity, updatedObject)
    if not self:isJobExistByIdentity(jobIdentity) or not self.jobs[jobIdentity].objects then
        return false
    end
    self.jobs[jobIdentity].objects[updatedObject.id] = updatedObject
    return updatedObject
end

function JobsClass:deleteJobObjectByIdentity(jobIdentity, objectId)
    self.jobs[jobIdentity].objects[objectId] = nil
end

function JobsClass:getJobObjectById(jobIdentity, objectId)
    local job = self:getJobByIdentity(jobIdentity)
    if job then
        return job.objects[objectId]
    end
    return false
end

function JobsClass:addCarSpawner(jobIdentity, newCarSpawner)
    if not self:isJobExistByIdentity(jobIdentity) then return false end
    if not self.jobs[jobIdentity].carSpawners then
        self.jobs[jobIdentity].carSpawners = {}
    end
    self.jobs[jobIdentity].carSpawners[newCarSpawner.id] = newCarSpawner
    return newCarSpawner
end

function JobsClass:updateJobCarSpawnerByIdentity(jobIdentity, updatedCarSpawner)
    if not self:isJobExistByIdentity(jobIdentity) or not self.jobs[jobIdentity].carSpawners then
        return false
    end
    self.jobs[jobIdentity].carSpawners[updatedCarSpawner.id] = updatedCarSpawner
    return updatedCarSpawner
end

function JobsClass:getJobCarSpawnerById(jobIdentity, spawnerId)
    local job = self:getJobByIdentity(jobIdentity)
    if job then
        return job.carSpawners[spawnerId]
    end
    return false
end

function JobsClass:addStash(jobIdentity, newStash)
    if not self:isJobExistByIdentity(jobIdentity) then return false end
    if not self.jobs[jobIdentity].stashes then
        self.jobs[jobIdentity].stashes = {}
    end
    self.jobs[jobIdentity].stashes[newStash.id] = newStash
    return newStash
end

function JobsClass:updateJobStashByIdentity(jobIdentity, updatedStash)
    if not self:isJobExistByIdentity(jobIdentity) or not self.jobs[jobIdentity].stashes then
        return false
    end
    self.jobs[jobIdentity].stashes[updatedStash.id] = updatedStash
    return updatedStash
end

function JobsClass:getJobStashById(jobIdentity, stashId)
    local job = self:getJobByIdentity(jobIdentity)
    if job then
        return job.stashes[stashId]
    end
    return false
end

function JobsClass:deleteJobStashByIdentity(jobIdentity, stashId)
    self.jobs[jobIdentity].stashes[stashId] = nil
end

function JobsClass:addMarket(jobIdentity, newMarket)
    if not self:isJobExistByIdentity(jobIdentity) then return false end
    if not self.jobs[jobIdentity].markets then
        self.jobs[jobIdentity].markets = {}
    end
    self.jobs[jobIdentity].markets[newMarket.id] = newMarket
    return newMarket
end

function JobsClass:updateJobMarketByIdentity(jobIdentity, updatedMarket)
    if not self:isJobExistByIdentity(jobIdentity) or not self.jobs[jobIdentity].markets then
        return false
    end
    self.jobs[jobIdentity].markets[updatedMarket.id] = updatedMarket
    return updatedMarket
end

function JobsClass:getJobMarketById(jobIdentity, marketId)
    local job = self:getJobByIdentity(jobIdentity)
    if job then
        return job.markets[marketId]
    end
    return false
end

function JobsClass:deleteJobMarketByIdentity(jobIdentity, marketId)
    self.jobs[jobIdentity].markets[marketId] = nil
end
