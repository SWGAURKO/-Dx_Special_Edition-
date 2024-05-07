function CheckConfigDefaultSettings()
    for key, value in pairs(Config.Default) do
        if not value then
            debugPrint("error", "Value not set. | Config.Default.", key)
        end
    end
end

---@param source number id
---@return Player
function GetPlayerBySource(source)
    return QBCore.Functions.GetPlayer(source)
end

function SaveJobToDatabase(job, author)
    ExecuteSQLQuery(
        "INSERT INTO `0r_jobcreator_jobs` (identity, name, unique_name, perm, notify_type, progressbar_type, skillbar_type, menu_type, target_type, textui_type, start_type, start_ped, blip, status, author) VALUES (:identity, :name, :unique_name, :perm, :notify_type, :progressbar_type, :skillbar_type, :menu_type, :target_type, :textui_type, :start_type, :start_ped, :blip, :status, :author) ON DUPLICATE KEY UPDATE name = :name, unique_name = :unique_name, perm = :perm, notify_type = :notify_type, progressbar_type = :progressbar_type, skillbar_type = :skillbar_type, menu_type = :menu_type, target_type = :target_type, textui_type = :textui_type, start_type = :start_type, start_ped = :start_ped, blip = :blip, status = :status, author = :author;",
        {
            identity = job.identity,
            name = job.name,
            unique_name = job.unique_name,
            perm = job.perm
                and
                (json.encode(job.perm) == "[]"
                    and "{}" or json.encode(job.perm))
                or
                "{}",
            notify_type = job.notify_type,
            progressbar_type = job.progressbar_type,
            skillbar_type = job.skillbar_type,
            menu_type = job.menu_type,
            target_type = job.target_type,
            textui_type = job.textui_type,
            start_type = job.start_type or nil,
            start_ped = job.start_ped
                and
                (json.encode(job.start_ped) == "[]"
                    and "{}" or json.encode(job.start_ped))
                or
                "{}",
            blip = job.blip
                and
                (json.encode(job.blip) == "[]"
                    and "{}" or json.encode(job.blip))
                or "{}",
            status = job.status or "deactive",
            author = job.author
        }, "insert"
    )
    debugPrint("success", "[Save Job]", "The job was successfully saved.", "(Job: " .. job.identity .. ")",
        "(By: " .. GetPlayerName(author.PlayerData.source) .. ")")
end

---@param jobIdentity string
---@param newStep object
---@param updated_by Player
---@return boolean status
function SaveJobStepToDatabase(jobIdentity, step, updated_by)
    local stepId = ExecuteSQLQuery(
        "INSERT INTO `0r_jobcreator_job_steps` (id, job_identity, title, coords, radius, interaction_type, cool_down, required_item, animation, remove_item, give_item, give_money, remove_money, blip, author) VALUES (:id, :job_identity, :title, :coords, :radius, :interaction_type, :cool_down, :required_item, :animation, :remove_item, :give_item, :give_money, :remove_money, :blip, :author) ON DUPLICATE KEY UPDATE title = VALUES(title), coords = VALUES(coords), radius = VALUES(radius), interaction_type = VALUES(interaction_type), cool_down = VALUES(cool_down), required_item = VALUES(required_item), animation = VALUES(animation), remove_item = VALUES(remove_item), give_item = VALUES(give_item), give_money = VALUES(give_money), remove_money = VALUES(remove_money), blip = VALUES(blip), author = VALUES(author);",
        {
            id = step.id,
            job_identity = jobIdentity,
            title = step.title,
            coords = step.coords
                and
                (json.encode(step.coords) == "[]"
                    and "{}" or json.encode(step.coords))
                or
                "{}",
            radius = step.radius,
            interaction_type = step.interaction_type,
            required_item = step.required_item
                and
                (json.encode(step.required_item) == "[]"
                    and "{}" or json.encode(step.required_item))
                or
                "{}",
            cool_down = step.cool_down,
            animation = step.animation
                and
                (json.encode(step.animation) == "[]"
                    and "{}" or json.encode(step.animation))
                or
                "{}",
            remove_item = step.remove_item
                and
                (json.encode(step.remove_item) == "[]"
                    and "{}" or json.encode(step.remove_item))
                or
                "{}",
            give_item = step.give_item
                and
                (json.encode(step.give_item) == "[]"
                    and "{}" or json.encode(step.give_item))
                or
                "{}",
            give_money = step.give_money
                and
                (json.encode(step.give_money) == "[]"
                    and "{}" or json.encode(step.give_money))
                or
                "{}",
            remove_money = step.remove_money
                and
                (json.encode(step.remove_money) == "[]"
                    and "{}" or json.encode(step.remove_money))
                or
                "{}",
            blip = step.blip
                and
                (json.encode(step.blip) == "[]"
                    and "{}" or json.encode(step.blip))
                or
                "{}",
            author = updated_by.PlayerData.citizenid,
        },
        "insert"
    )

    if not stepId or stepId < 1 then
        return false
    end
    debugPrint("success", "[Save Job Step]", "The job step was successfully saved.",
        "Job:", jobIdentity,
        "Step:", step.title,
        "updated by",
        GetPlayerName(updated_by.PlayerData.source)
    )
    return stepId
end

function DeleteJobStepToDatabase(jobIdentity, stepId, deleted_by)
    ExecuteSQLQuery(
        "DELETE FROM `0r_jobcreator_job_steps` WHERE job_identity = :job_identity AND id = :id",
        {
            job_identity = jobIdentity,
            id = stepId,
        },
        "query"
    )
    debugPrint("success", "[Delete Job Step]", "The job step was successfully deleted.",
        "(Job: " .. jobIdentity .. ")",
        "(Step: " .. stepId .. ")",
        "(By: " .. deleted_by.getName() .. ")")
end

function UpdateJobStatusToDatabase(jobIdentity, status, updated_by)
    ExecuteSQLQuery(
        "UPDATE `0r_jobcreator_jobs` SET status = ? WHERE identity = ?",
        {
            status,
            jobIdentity
        }, "update"
    )
    debugPrint("success", "[Save Job]", "The job status was successfully saved.", "(Job: " .. jobIdentity .. ")",
        "(New status: " .. status .. ")",
        "(By: " .. GetPlayerName(updated_by.PlayerData.source) .. ")"
    )
end

function DeleteJobToDatabase(jobIdentity, deleted_by)
    ExecuteSQLQuery(
        "DELETE FROM `0r_jobcreator_jobs` WHERE identity = :identity",
        {
            identity = jobIdentity
        },
        "query"
    )
    debugPrint("success", "[Delete Job]", "The job was successfully deleted.", "(Job: " .. jobIdentity .. ")",
        "(By: " .. GetPlayerName(deleted_by.PlayerData.source) .. ")")
end

function DeleteJobObjectToDatabase(jobIdentity, objectId, deleted_by)
    ExecuteSQLQuery(
        "DELETE FROM `0r_jobcreator_job_objects` WHERE job_identity = :job_identity AND id = :id",
        {
            job_identity = jobIdentity,
            id = objectId,
        },
        "query"
    )
    debugPrint("success", "[Delete Job Object]", "The job object was successfully deleted.",
        "(Job: " .. jobIdentity .. ")",
        "(Object: " .. objectId .. ")",
        "(By: " .. GetPlayerName(deleted_by.PlayerData.source) .. ")")
end

function SaveJobTeleportToDatabase(jobIdentity, teleport, updated_by)
    local teleportId = ExecuteSQLQuery(
        "INSERT INTO `0r_jobcreator_job_teleports` (id, job_identity, name, interaction_type, type, entry_coords, exit_coords, author) VALUES (:id, :job_identity, :name, :interaction_type, :type, :entry_coords, :exit_coords, :author) ON DUPLICATE KEY UPDATE name = VALUES(name), interaction_type = VALUES(interaction_type), type = VALUES(type), entry_coords = VALUES(entry_coords), exit_coords = VALUES(exit_coords), author = VALUES(author);",
        {
            id = teleport.id,
            job_identity = jobIdentity,
            name = teleport.name,
            interaction_type = teleport.interaction_type,
            type = teleport.type,
            entry_coords = teleport.entry_coords
                and
                (json.encode(teleport.entry_coords) == "[]"
                    and "{}" or json.encode(teleport.entry_coords))
                or
                "{}"
            ,
            exit_coords = teleport.exit_coords
                and
                (json.encode(teleport.exit_coords) == "[]"
                    and "{}" or json.encode(teleport.exit_coords))
                or
                "{}"
            ,
            author = updated_by.PlayerData.citizenid,
        },
        "insert"
    )

    if not teleportId or teleportId < 1 then
        return false
    end
    debugPrint("success", "[Save Job Teleport]", "The job teleport was successfully saved.",
        "Job:", jobIdentity,
        "Teleport:", teleport.name,
        "updated by",
        GetPlayerName(updated_by.PlayerData.source)
    )
    return teleportId
end

function SaveJobObjectToDatabase(jobIdentity, object, updated_by)
    local objectId = ExecuteSQLQuery(
        "INSERT INTO `0r_jobcreator_job_objects` (id, job_identity, name, coords, type, model_hash, is_network, net_mission_entity, door_flag, author) VALUES (:id, :job_identity, :name, :coords, :type, :model_hash, :is_network, :net_mission_entity, :door_flag, :author) ON DUPLICATE KEY UPDATE name = VALUES(name), coords = VALUES(coords), type = VALUES(type), model_hash = VALUES(model_hash), is_network = VALUES(is_network), net_mission_entity = VALUES(net_mission_entity), door_flag = VALUES(door_flag), author = VALUES(author);",
        {
            id = object.id,
            job_identity = jobIdentity,
            name = object.name,
            coords = object.coords
                and
                (json.encode(object.coords) == "[]" and
                    "{}"
                    or
                    json.encode(object.coords)
                ),
            type = object.type,
            model_hash = object.model_hash,
            is_network = object.is_network,
            net_mission_entity = object.net_mission_entity,
            door_flag = object.door_flag,
            author = updated_by.PlayerData.citizenid,
        },
        "insert"
    )

    if not objectId or objectId < 1 then
        return false
    end
    debugPrint("success", "[Save Job Object]", "The job object was successfully saved.",
        "Job:", jobIdentity,
        "Object:", object.name,
        "updated by",
        GetPlayerName(updated_by.PlayerData.source)
    )
    return objectId
end

function SaveJobCarSpawnerToDatabase(jobIdentity, carSpawner, updated_by)
    local carSpawnerId = ExecuteSQLQuery(
        "INSERT INTO `0r_jobcreator_job_car_spawners` (id, job_identity, name, interaction_type, coords, car_spawner_coords, cars, author) VALUES (:id, :job_identity, :name, :interaction_type, :coords, :car_spawner_coords, :cars, :author) ON DUPLICATE KEY UPDATE name = VALUES(name), interaction_type = VALUES(interaction_type), coords = VALUES(coords), car_spawner_coords = VALUES(car_spawner_coords), cars = VALUES(cars), author = VALUES(author);",
        {
            id = carSpawner.id,
            job_identity = jobIdentity,
            name = carSpawner.name,
            interaction_type = carSpawner.interaction_type,
            coords = carSpawner.coords
                and
                (json.encode(carSpawner.coords) == "[]" and
                    "{}"
                    or
                    json.encode(carSpawner.coords)
                ),
            car_spawner_coords = carSpawner.car_spawner_coords
                and
                (json.encode(carSpawner.car_spawner_coords) == "[]" and
                    "{}"
                    or
                    json.encode(carSpawner.car_spawner_coords)
                ),
            cars = carSpawner.cars
                and
                (json.encode(carSpawner.cars) == "[]" and
                    "{}"
                    or
                    json.encode(carSpawner.cars)
                ),
            author = updated_by.PlayerData.citizenid,
        },
        "insert"
    )

    if not carSpawnerId or carSpawnerId < 1 then
        return false
    end
    debugPrint("success", "[Save Job Car Spawner]", "The job car spawner was successfully saved.",
        "Job:", jobIdentity,
        "Spawner:", carSpawner.name,
        "updated by",
        GetPlayerName(updated_by.PlayerData.source)
    )
    return carSpawnerId
end

function SaveJobStashToDatabase(jobIdentity, stash, updated_by)
    local stashId = ExecuteSQLQuery(
        "INSERT INTO `0r_jobcreator_job_stashes` (id, job_identity, name, unique_name, interaction_type, coords, size, slots, author) VALUES (:id, :job_identity, :name, :unique_name, :interaction_type, :coords, :size, :slots, :author) ON DUPLICATE KEY UPDATE name = VALUES(name), unique_name = VALUES(unique_name), interaction_type = VALUES(interaction_type), coords = VALUES(coords), size = VALUES(size), slots = VALUES(slots), author = VALUES(author);",
        {
            id = stash.id,
            job_identity = jobIdentity,
            name = stash.name,
            unique_name = stash.unique_name,
            interaction_type = stash.interaction_type,
            coords = stash.coords
                and
                (json.encode(stash.coords) == "[]" and
                    "{}"
                    or
                    json.encode(stash.coords)
                ),
            size = stash.size,
            slots = stash.slots,
            author = updated_by.PlayerData.citizenid,
        },
        "insert"
    )

    if not stashId or stashId < 1 then
        return false
    end
    debugPrint("success", "[Save Job Stash]", "The job stash was successfully saved.",
        "Job:", jobIdentity,
        "Stash:", stash.name,
        "updated by",
        GetPlayerName(updated_by.PlayerData.source)
    )
    return stashId
end

function DeleteJobStashToDatabase(jobIdentity, stashId, deleted_by)
    ExecuteSQLQuery(
        "DELETE FROM `0r_jobcreator_job_stashes` WHERE job_identity = :job_identity AND id = :id",
        {
            job_identity = jobIdentity,
            id = stashId,
        },
        "query"
    )
    debugPrint("success", "[Delete Job Stash]", "The job stash was successfully deleted.",
        "(Job: " .. jobIdentity .. ")",
        "(Stash: " .. stashId .. ")",
        "(By: " .. GetPlayerName(deleted_by.PlayerData.source) .. ")")
end

function SaveJobMarketToDatabase(jobIdentity, market, updated_by)
    local marketId = ExecuteSQLQuery(
        "INSERT INTO `0r_jobcreator_job_markets` (id, job_identity, name, interaction_type, ped_coords, ped_model_hash, items, author) VALUES (:id, :job_identity, :name, :interaction_type, :ped_coords, :ped_model_hash, :items, :author) ON DUPLICATE KEY UPDATE name = VALUES(name), interaction_type = VALUES(interaction_type), ped_coords = VALUES(ped_coords), ped_model_hash = VALUES(ped_model_hash), items = VALUES(items), author = VALUES(author);",
        {
            id = market.id,
            job_identity = jobIdentity,
            name = market.name,
            interaction_type = market.interaction_type,
            ped_coords = market.ped_coords
                and
                (json.encode(market.ped_coords) == "[]" and
                    "{}"
                    or
                    json.encode(market.ped_coords)
                ),
            ped_model_hash = market.ped_model_hash,
            items = market.items
                and
                (json.encode(market.items) == "[]" and
                    "{}"
                    or
                    json.encode(market.items)
                ),
            author = updated_by.PlayerData.citizenid,
        },
        "insert"
    )

    if not marketId or marketId < 1 then
        return false
    end
    debugPrint("success", "[Save Job Market]", "The job market was successfully saved.",
        "Job:", jobIdentity,
        "Market:", market.name,
        "updated by",
        GetPlayerName(updated_by.PlayerData.source)
    )
    return marketId
end

function DeleteJobMarketToDatabase(jobIdentity, marketId, deleted_by)
    ExecuteSQLQuery(
        "DELETE FROM `0r_jobcreator_job_markets` WHERE job_identity = :job_identity AND id = :id",
        {
            job_identity = jobIdentity,
            id = marketId,
        },
        "query"
    )
    debugPrint("success", "[Delete Job Market]", "The job market was successfully deleted.",
        "(Job: " .. jobIdentity .. ")",
        "(Market: " .. marketId .. ")",
        "(By: " .. GetPlayerName(deleted_by.PlayerData.source) .. ")")
end

---@param coordToCheck vector4
---@return boolean status
function JobCoordAreaCheck(coordsToCheck, radius, identity, stepId)
    local jobs = JobsClass.jobs
    for _, job in pairs(jobs) do
        if job.identity ~= identity then
            local jobStartPedCoords = job.start_ped and job.start_ped.coords or nil
            if jobStartPedCoords then
                for _, coordToCheck in pairs(coordsToCheck) do
                    local firstVec = nil
                    local success, err = pcall(function()
                        firstVec = vector3(coordToCheck.x, coordToCheck.y, coordToCheck.z)
                    end)
                    if not success then
                        return true, nil, err
                    end
                    local secondVec = vector3(jobStartPedCoords.x, jobStartPedCoords.y, jobStartPedCoords.z)
                    local distance = #(secondVec - firstVec)
                    if distance <= radius + 1.5 then
                        local info = "Job: " .. job.identity
                        return true, info, false
                    end
                end
            end
        end
        for _, step in pairs(job.steps) do
            if (job.identity ~= identity or (job.identity == identity and step.id ~= stepId)) then
                for _, coords in pairs(step.coords) do
                    local firstVec = vector3(coords.x, coords.y, coords.z)
                    for _, coordToCheck in pairs(coordsToCheck) do
                        local secondVec = nil
                        local success, err = pcall(function()
                            secondVec = vector3(coordToCheck.x, coordToCheck.y, coordToCheck.z)
                        end)
                        if not success then
                            return true, nil, err
                        end
                        local distance = #(firstVec - secondVec)
                        local totalRadius = (tonumber(step.radius) or 0.0) + (tonumber(radius) or 0.0)
                        if distance <= totalRadius + 1.5 then
                            local info = "Job: " .. job.identity .. " & Step: " .. step.title
                            return true, info, false
                        end
                    end
                end
            end
        end
    end
    return false, nil
end

function TeleportCoordAreaCheck(entry_coords, exit_coords, radius, jobIdentity, teleportId)
    local jobs = JobsClass.jobs
    entry_coords = vector3(entry_coords.x, entry_coords.y, entry_coords.z)
    exit_coords = vector3(exit_coords.x, exit_coords.y, exit_coords.z)
    for identity, job in pairs(jobs) do
        local teleports = job.teleports
        for _, teleport in pairs(teleports) do
            if teleport.id ~= teleportId then
                local _entry_coord = vector3(teleport.entry_coords.x, teleport.entry_coords.y, teleport.entry_coords.z)
                local _exit_coord = vector3(teleport.exit_coords.x, teleport.exit_coords.y, teleport.exit_coords.z)
                local success, err = pcall(function()
                    entry_coords = vector3(entry_coords.x, entry_coords.y, entry_coords.z)
                    exit_coords = vector3(exit_coords.x, exit_coords.y, exit_coords.z)
                end)
                if not success then
                    return true, nil, err
                end
                local distance1 = #(_entry_coord - entry_coords)
                local distance2 = #(_exit_coord - exit_coords)
                local distance3 = #(_entry_coord - exit_coords)
                local distance4 = #(_exit_coord - entry_coords)
                if distance1 <= radius
                    or distance2 <= radius
                    or distance3 <= radius
                    or distance4 <= radius
                then
                    local info = "Job: " .. job.identity .. " & Teleport: " .. teleport.name
                    return true, info, false
                end
            end
        end
    end
    return false, nil
end

---@param src string Player server id
---@param job Job
---@param step Step
function LastProcessTheStep(src, job, step)
    local xPlayer = GetPlayerBySource(src)
    local stepGiveItem = step.give_item
    if stepGiveItem.is_required == "yes" then
        PlayerAddItem(xPlayer, stepGiveItem.item_name, tonumber(stepGiveItem.count))
    end
    local stepRemoveItem = step.remove_item
    if stepRemoveItem.is_required == "yes" then
        local hasItem, amount = PlayerHasItem(xPlayer, stepRemoveItem.item_name)
        if not hasItem or amount < tonumber(stepRemoveItem.count) then
            SendNotifyServerside(job.notify_type,
                src,
                _t("JobCreator.dont_have_necessary_items",
                    (stepRemoveItem.item_name .. " " .. (tonumber(stepRemoveItem.count or 0) - amount))),
                "error"
            )
            return false
        end
        PlayerRemoveItem(xPlayer, stepRemoveItem.item_name, tonumber(stepRemoveItem.count))
    end
    local stepGiveMoney = step.give_money
    if stepGiveMoney.is_required == "yes" then
        PlayerAddMoney(xPlayer, stepGiveMoney.type, stepGiveMoney.amount, stepGiveMoney.reason)
    end
    local stepRemoveMoney = step.remove_money
    if stepRemoveMoney.is_required == "yes" then
        PlayerRemoveMoney(xPlayer, stepRemoveMoney.type, stepRemoveMoney.amount, stepRemoveMoney.reason)
    end
    JobsClass:setStepCooldownEndTime(src, job.identity, step.id, step.cool_down)
    return true
end

function PlayerHasItem(Player, itemName)
    if Config.Default.InventoryType == "qb_inventory" then
        local result = Player.Functions.GetItemsByName(itemName)
        local itemCount = 0
        for _, item in ipairs(result) do
            if item.amount then
                itemCount = itemCount + item.amount
            end
        end
        if itemCount > 0 then
            return true, itemCount
        else
            return false, 0
        end
    elseif Config.Default.InventoryType == "ox_inventory" then
        local itemCount = ox_inventory:GetItemCount(Player.PlayerData.source, itemName)
        if itemCount > 0 then
            return true, itemCount
        else
            return false, 0
        end
    elseif Config.Default.InventoryType == "custom" then
        local itemCount = CustomInventory.GetItemCount(Player.PlayerData.source, itemName)
        if itemCount > 0 then
            return true, itemCount
        else
            return false, 0
        end
    end
end

function PlayerRemoveItem(Player, itemName, itemCount)
    if Config.Default.InventoryType == "qb_inventory" then
        local result = Player.Functions.RemoveItem(itemName, itemCount)
        return result
    elseif Config.Default.InventoryType == "ox_inventory" then
        local result = ox_inventory:RemoveItem(Player.PlayerData.source, itemName, itemCount)
        return result
    elseif Config.Default.InventoryType == "custom" then
        local result = CustomInventory.RemoveItem(Player.PlayerData.source, itemName, itemCount)
        return result
    end
end

function PlayerAddItem(Player, itemName, itemCount)
    if Config.Default.InventoryType == "qb_inventory" then
        local result = Player.Functions.AddItem(itemName, itemCount)
        return result
    elseif Config.Default.InventoryType == "ox_inventory" then
        if ox_inventory:CanCarryItem(Player.PlayerData.source, itemName, itemCount) then
            local result, reason = ox_inventory:AddItem(Player.PlayerData.source, itemName, itemCount)
            return result
        else
            return false
        end
    elseif Config.Default.InventoryType == "custom" then
        local result = CustomInventory.AddItem(Player.PlayerData.source, itemName, itemCount)
        return result
    end
end

function PlayerAddMoney(Player, type, amount, reason)
    if Config.Default.InventoryType == "qb_inventory" then
        local result = Player.Functions.AddMoney(type, tonumber(amount), reason)
        return result
    elseif Config.Default.InventoryType == "ox_inventory" then
        local result = Player.Functions.AddMoney(type, tonumber(amount), reason)
        return result
    elseif Config.Default.InventoryType == "custom" then
        local result = CustomInventory.AddMoney(Player.PlayerData.source, type, tonumber(amount), reason)
        return result
    end
end

function PlayerRemoveMoney(Player, type, amount, reason)
    if Config.Default.InventoryType == "qb_inventory" then
        local result = Player.Functions.RemoveMoney(type, tonumber(amount), reason)
        return result
    elseif Config.Default.InventoryType == "ox_inventory" then
        local result = Player.Functions.RemoveMoney(type, tonumber(amount), reason)
        return result
    elseif Config.Default.InventoryType == "custom" then
        local result = CustomInventory.RemoveMoney(Player.PlayerData.source, type, tonumber(amount), reason)
        return result
    end
end

function PlayerHasMoney(Player, type, amount)
    if type == "bank" then
        local bankAmount = Player.PlayerData.money.bank
        return bankAmount >= amount
    elseif type == "cash" then
        local cashAmount = Player.PlayerData.money.cash
        return cashAmount >= amount
    end
    return false
end

function CreateJobIdentity()
    local uniqueFound = false
    local identity = nil
    while not uniqueFound do
        identity = tostring(QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(5)):upper()
        local result = ExecuteSQLQuery("SELECT COUNT(*) as count FROM `0r_jobcreator_jobs` WHERE identity = ?",
            { identity }, "prepare")
        if result == 0 then
            uniqueFound = true
        end
    end
    return identity
end

function CheckJobUniqueNameAvailable(name, identity)
    local uniqueName = stringToUnique(name)
    local jobs = JobsClass:getJobs()
    for key, job in pairs(jobs) do
        if key ~= identity and job.unique_name == uniqueName then
            return false
        end
    end
    local result = ExecuteSQLQuery(
        "SELECT COUNT(*) as count FROM `0r_jobcreator_jobs` WHERE unique_name = ? AND identity != ?",
        { uniqueName, identity }, "prepare")
    if result == 0 then
        return uniqueName
    end
    return false
end

function ThreadCoolDownController()
    if #(JobsClass.cool_down) > 0 then
        local coolDown = JobsClass.cool_down
        local currentTime = os.time()

        for playerSrc, jobs in pairs(coolDown) do
            local emptyPlayer = true
            for jobIdentity, steps in pairs(jobs) do
                local emptyJob = true
                for stepId, cooldownTime in pairs(steps) do
                    if cooldownTime < currentTime then
                        JobsClass.cool_down[playerSrc][jobIdentity][stepId] = nil
                    else
                        emptyJob = false
                    end
                end
                if emptyJob then
                    JobsClass.cool_down[playerSrc][jobIdentity] = nil
                else
                    emptyPlayer = false
                end
            end
            if emptyPlayer then
                JobsClass.cool_down[playerSrc] = nil
            end
        end
    end
    Wait(60000)
end
