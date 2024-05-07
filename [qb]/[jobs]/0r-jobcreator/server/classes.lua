function JobsClass:loadJobs()
    local function decodeJSONJobStepFields(step)
        local fieldsToDecode = {
            "blip",
            "coords",
            "required_item",
            "animation",
            "remove_item",
            "give_item",
            "give_money",
            "remove_money"
        }
        for _, field in pairs(fieldsToDecode) do
            if step[field] then
                step[field] = json.decode(step[field])
            end
        end
    end

    local function decodeJSONJobTeleportFields(teleport)
        local fieldsToDecode = {
            "entry_coords",
            "exit_coords"
        }
        for _, field in pairs(fieldsToDecode) do
            if teleport[field] then
                teleport[field] = json.decode(teleport[field])
            end
        end
    end

    local function decodeJSONJobObjectFields(object)
        local fieldsToDecode = {
            "coords"
        }
        for _, field in pairs(fieldsToDecode) do
            if object[field] then
                object[field] = json.decode(object[field])
            end
        end
    end

    local function decodeJSONJobCarSpawnerFields(spawner)
        local fieldsToDecode = {
            "coords",
            "car_spawner_coords",
            "cars"
        }
        for _, field in pairs(fieldsToDecode) do
            if spawner[field] then
                spawner[field] = json.decode(spawner[field])
            end
        end
    end

    local function decodeJSONJobStashFields(stash)
        decodeJSONJobObjectFields(stash)
    end

    local function decodeJSONJobMarketFields(market)
        local fieldsToDecode = {
            "ped_coords",
            "items",
        }
        for _, field in pairs(fieldsToDecode) do
            if market[field] then
                market[field] = json.decode(market[field])
            end
        end
    end

    local queryJobs = "SELECT * FROM `0r_jobcreator_jobs`"
    local queryJobSteps = "SELECT * FROM `0r_jobcreator_job_steps` WHERE job_identity = ?"
    local queryJobTeleports = "SELECT * FROM `0r_jobcreator_job_teleports` WHERE job_identity = ?"
    local queryJobObjects = "SELECT * FROM `0r_jobcreator_job_objects` WHERE job_identity = ?"
    local queryJobCarSpawners = "SELECT * FROM `0r_jobcreator_job_car_spawners` WHERE job_identity = ?"
    local queryJobStashes = "SELECT * FROM `0r_jobcreator_job_stashes` WHERE job_identity = ?"
    local queryJobMarkets = "SELECT * FROM `0r_jobcreator_job_markets` WHERE job_identity = ?"
    local jobs = ExecuteSQLQuery(queryJobs, {}, "query")

    for i = 1, #jobs do
        local row = jobs[i]
        local jobIdentity = row.identity
        self.jobs[jobIdentity] = row
        self.jobs[jobIdentity].blip = json.decode(row.blip)
        self.jobs[jobIdentity].perm = json.decode(row.perm)
        self.jobs[jobIdentity].start_ped = json.decode(row.start_ped)
        -- --
        local jobSteps = ExecuteSQLQuery(queryJobSteps, { jobIdentity }, "query")
        local steps = {}
        for j = 1, #jobSteps do
            local step = jobSteps[j]
            decodeJSONJobStepFields(step)
            steps[step.id] = step
        end
        self.jobs[jobIdentity].steps = steps
        -- --
        local jobTeleports = ExecuteSQLQuery(queryJobTeleports, { jobIdentity }, "query")
        local teleports = {}
        for j = 1, #jobTeleports do
            local teleport = jobTeleports[j]
            decodeJSONJobTeleportFields(teleport)
            teleports[teleport.id] = teleport
        end
        self.jobs[jobIdentity].teleports = teleports
        -- --
        local jobObjects = ExecuteSQLQuery(queryJobObjects, { jobIdentity }, "query")
        local objects = {}
        for j = 1, #jobObjects do
            local object = jobObjects[j]
            decodeJSONJobObjectFields(object)
            objects[object.id] = object
        end
        self.jobs[jobIdentity].objects = objects
        -- --
        local jobCarSpawners = ExecuteSQLQuery(queryJobCarSpawners, { jobIdentity }, "query")
        local spawners = {}
        for j = 1, #jobCarSpawners do
            local spawner = jobCarSpawners[j]
            decodeJSONJobCarSpawnerFields(spawner)
            spawners[spawner.id] = spawner
        end
        self.jobs[jobIdentity].carSpawners = spawners
        -- --
        local jobStashes = ExecuteSQLQuery(queryJobStashes, { jobIdentity }, "query")
        local stashes = {}
        for j = 1, #jobStashes do
            local stash = jobStashes[j]
            decodeJSONJobStashFields(stash)
            stashes[stash.id] = stash
        end
        self.jobs[jobIdentity].stashes = stashes
        -- --
        local jobMarkets = ExecuteSQLQuery(queryJobMarkets, { jobIdentity }, "query")
        local markets = {}
        for j = 1, #jobMarkets do
            local market = jobMarkets[j]
            decodeJSONJobMarketFields(market)
            markets[market.id] = market
        end
        self.jobs[jobIdentity].markets = markets
        -- --
    end
end

function JobsClass:getJobs()
    return self.jobs
end

function JobsClass:getJobByIdentity(identity)
    if not identity then return false end
    return self.jobs[identity]
end

function JobsClass:isJobExistByIdentity(identity)
    if not identity then return false end
    return self.jobs[identity] and true or false
end

function JobsClass:addJob(options)
    self.jobs[options.identity] = options
    return options
end

function JobsClass:updateJobMainSettings(identity, newValues)
    if not self:isJobExistByIdentity(identity) then return false end
    self.jobs[identity].name = newValues.name
    self.jobs[identity].unique_name = newValues.unique_name
    self.jobs[identity].perm = newValues.perm
    self.jobs[identity].notify_type = newValues.notify_type
    self.jobs[identity].progressbar_type = newValues.progressbar_type
    self.jobs[identity].skillbar_type = newValues.skillbar_type
    self.jobs[identity].menu_type = newValues.menu_type
    self.jobs[identity].target_type = newValues.target_type
    self.jobs[identity].textui_type = newValues.textui_type
    self.jobs[identity].start_type = newValues.start_type
    self.jobs[identity].start_ped = newValues.start_ped
    self.jobs[identity].blip = newValues.blip
    self.jobs[identity].author = newValues.author
    return self.jobs[identity]
end

function JobsClass:getJobStepById(jobIdentity, stepId)
    local job = self:getJobByIdentity(jobIdentity)
    if job then
        return job.steps[stepId]
    end
    return false
end

function JobsClass:updateJobStatusByJobIdentity(identity, status)
    if not self:isJobExistByIdentity(identity) then return false end
    self.jobs[identity].status = (status) and "active" or "deactive"
    return status and "active" or "deactive"
end

function JobsClass:deleteJob(jobIdentity)
    self.jobs[jobIdentity] = nil
    return true
end

function JobsClass:addStep(jobIdentity, newStep)
    if not self:isJobExistByIdentity(jobIdentity) then return false end
    if not self.jobs[jobIdentity].steps then
        self.jobs[jobIdentity].steps = {}
    end
    self.jobs[jobIdentity].steps[newStep.id] = newStep
    return newStep
end

function JobsClass:updateJobStepByIdentity(jobIdentity, updatedStep)
    if not self:isJobExistByIdentity(jobIdentity) or not self.jobs[jobIdentity].steps then
        return false
    end
    self.jobs[jobIdentity].steps[updatedStep.id] = updatedStep
    return updatedStep
end

function JobsClass:deleteJobStepByIdentity(jobIdentity, stepId)
    self.jobs[jobIdentity].steps[stepId] = nil
end

function JobsClass:setStepCooldownEndTime(playerSrc, jobIdentity, stepId, cooldownSeconds)
    local job = self.jobs[jobIdentity]
    if job then
        local step = self:getJobStepById(jobIdentity, stepId)
        if step then
            if not self.cool_down[playerSrc] then
                self.cool_down[playerSrc] = {}
            end
            if not self.cool_down[playerSrc][jobIdentity] then
                self.cool_down[playerSrc][jobIdentity] = {}
            end
            self.cool_down[playerSrc][jobIdentity][stepId] = os.time() + cooldownSeconds
        end
    end
end

function JobsClass:isStepOnCooldownById(playerSrc, jobIdentity, stepId)
    local job = self.jobs[jobIdentity]
    if job then
        local step = self:getJobStepById(jobIdentity, stepId)
        if step then
            local is_cooling = false
            if self.cool_down[playerSrc] and self.cool_down[playerSrc][jobIdentity] and self.cool_down[playerSrc][jobIdentity][stepId] then
                is_cooling = os.time() < self.cool_down[playerSrc][jobIdentity][stepId]
            end

            if not is_cooling then
                if self.cool_down[playerSrc] and self.cool_down[playerSrc][jobIdentity] then
                    self.cool_down[playerSrc][jobIdentity][stepId] = nil
                end
                return false, nil
            end
            return true, (os.difftime(self.cool_down[playerSrc][jobIdentity][stepId], os.time()))
        else
            if self.cool_down[playerSrc] then
                self.cool_down[playerSrc][jobIdentity] = nil
            end
        end
    else
        self.cool_down[playerSrc] = nil
    end
    return false
end

function JobsClass:addTeleport(jobIdentity, newTeleport)
    if not self:isJobExistByIdentity(jobIdentity) then return false end
    if not self.jobs[jobIdentity].teleports then
        self.jobs[jobIdentity].teleports = {}
    end
    self.jobs[jobIdentity].teleports[newTeleport.id] = newTeleport
    return newTeleport
end

function JobsClass:updateJobTeleportByIdentity(jobIdentity, updatedTeleport)
    if not self:isJobExistByIdentity(jobIdentity) or not self.jobs[jobIdentity].teleports then
        return false
    end
    self.jobs[jobIdentity].teleports[updatedTeleport.id] = updatedTeleport
    return updatedTeleport
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

function JobsClass:getJobObjectById(jobIdentity, objectId)
    local job = self:getJobByIdentity(jobIdentity)
    if job then
        return job.objects[objectId]
    end
    return false
end

function JobsClass:deleteJobObjectByIdentity(jobIdentity, objectId)
    self.jobs[jobIdentity].objects[objectId] = nil
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
