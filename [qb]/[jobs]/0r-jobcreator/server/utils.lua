--- Function that executes database queries
---
--- @param query: The SQL query to execute
--- @param params: Parameters for the SQL query (in table form)
--- @param type ("insert" | "update" | "query" | "scalar" | "single" | "prepare"): Parameters for the SQL query (in table form)
--- @return query any Results of the SQL query
function ExecuteSQLQuery(query, params, type)
    if type == "insert" then
        return MySQL.insert.await(query, params)
    elseif type == "update" then
        return MySQL.update.await(query, params)
    elseif type == "query" then
        return MySQL.query.await(query, params)
    elseif type == "scalar" then
        return MySQL.scalar.await(query, params)
    elseif type == "single" then
        return MySQL.single.await(query, params)
    elseif type == "prepare" then
        return MySQL.prepare.await(query, params)
    else
        error("Invalid queryType: " .. tostring(type or "?"))
    end
end

---@param input string The input string that needs to be processed.
---@return string
function stringToUnique(input)
    local turkishChars = {
        ["ı"] = "i",
        ["ğ"] = "g",
        ["ü"] = "u",
        ["ş"] = "s",
        ["ö"] = "o",
        ["ç"] = "c",
        ["I"] = "i",
        ["Ğ"] = "g",
        ["Ü"] = "u",
        ["Ş"] = "s",
        ["Ö"] = "o",
        ["Ç"] = "c",
        ["İ"] = "i",
    }
    local output = input:lower()
    for turkishChar, replacement in pairs(turkishChars) do
        output = output:gsub(turkishChar, replacement)
    end
    output = output:gsub("%s", "_")
    return output
end

---@param system ("qb_notify" | "ox_notify" | "okok_notify" | "custom_notify") System to be used
---@param source number Player source id
---@param title string Notification text
---@param type string inform / success / error
---@param text? string (optional) description, custom notify.
---@param duration? number (optional) Duration in miliseconds, custom notify.
function SendNotifyServerside(system, source, title, type, text, duration)
    system = system or Config.Default.NotifyType
    if not duration then duration = 1000 end
    if system == "qb_notify" then
        TriggerClientEvent("QBCore:Notify", source, title, type)
    elseif system == "ox_notify" then
        if hasResource("ox_lib") then
            TriggerClientEvent("ox_lib:notify", source, {
                title = title,
                type = type,
                description = text,
            })
        else
            debugPrint("error", "ox_lib not found.")
        end
    elseif system == "okok_notify" then
        if hasResource("okokNotify") then
            TriggerClientEvent("okokNotify:Alert", source, title, text, duration, type, true)
        else
            debugPrint("error", "okokNotify not found.")
        end
    elseif system == "custom_notify" then
        CustomNotify(source, title, type, text, duration)
    else
        debugPrint("error", "An error occurred.")
        TriggerClientEvent("QBCore:Notify", source, title, type)
    end
end

---@param source number id
---@param permission string Permission name
---@return boolean
function CheckPlayerPermission(source, permission)
    local perm = QBCore.Functions.HasPermission(source, "admin")
    if not perm then
        SendNotifyServerside(nil,
            source,
            "You are not authorised.",
            "error"
        )
    end
    return perm
end
