local currentResourceName = GetCurrentResourceName()
local debugIsEnabled = Config.DebugPrint
CustomInventory = {}

--- Prints the contents of a table with optional indentation.
---
--- @param table (table) The table to be printed.
--- @param indent? (number, optional) The level of indentation for formatting.
function printTable(table, indent)
    if not indent then indent = 0 end
    if not table then return end
    if type(table) == "table" then
        for k, v in pairs(table) do
            formatting = string.rep("  ", indent) .. k .. ": "
            if type(v) == "table" then
                print(formatting)
                printTable(v, indent + 1)
            elseif type(v) == "boolean" then
                print(formatting .. tostring(v))
            else
                print(formatting .. v)
            end
        end
    else
        print(table)
    end
end

---@param name string resource name
---@return boolean
function hasResource(name)
    return GetResourceState(name):find("start") ~= nil
end

--- A simple debug print function that is dependent on a convar
--- will output a nice prettfied message if debugMode is on
---@param _type "success" | "error"
function debugPrint(_type, ...)
    if not debugIsEnabled then return end
    local color = _type == "success" and "^2" or "^1"
    local args = { ... }

    local appendStr = ""
    for _, v in ipairs(args) do
        appendStr = appendStr .. " " .. tostring(v)
    end
    local msgTemplate = "^3[%s]%s^0%s"
    local finalMsg = msgTemplate:format(currentResourceName, color, appendStr)
    print(finalMsg)
end

--- Removes items of a specific type from a table based on specified criteria.
--- Primarily uses the 'type' parameter to filter items and compares them with other parameters.
---
--- @param _table table: The table from which items will be removed.
--- @param type string: The type of items to be removed.
--- @param ... any: Other comparison parameters, varying depending on the type.
function table_remove(_table, type, ...)
    local args = { ... }
    for key, value in pairs(_table) do
        if value.type == type then
            if type == "car_spawner" then
                if value.jobIdentity == args[1] and value.spawnerId == args[2] then
                    table.remove(_table, key)
                end
            elseif type == "teleport" then
                if value.jobIdentity == args[1] and value.teleportId == args[2] then
                    table.remove(_table, key)
                end
            elseif type == "start_ped" then
                if value.jobIdentity == args[1] then
                    table.remove(_table, key)
                end
            elseif type == "step" then
                if value.jobIdentity == args[1] and value.stepId == args[2] then
                    table.remove(_table, key)
                end
            elseif type == "stash" then
                if value.jobIdentity == args[1] and value.stashId == args[2] then
                    table.remove(_table, key)
                end
            elseif type == "market" then
                if value.jobIdentity == args[1] and value.marketId == args[2] then
                    table.remove(_table, key)
                end
            end
        end
    end
end

---@param source number | nil Player server id or nil, if value is nil, Trigger client event.
---@param title string
---@param type "error" | "success" | "info" | any
---@param text string
---@param duration number miliseconds
function CustomNotify(source, title, type, text, duration)
    if source and source > 0 then -- Server Notify
        -- TriggerClientEvent("EventName", source, ?, ?, ?, ?)
    else                          -- Client Notify
        -- exports["ExportName"]:Alert(?, ?, ?, ?)
    end
end

---@param source number Player server id
---@param itemName string item name
---@return number itemCount
function CustomInventory.GetItemCount(source, itemName)
    -- local itemCount = exports.["CustomInventory"]:GetItemCount(?, ?)
    -- return itemCount
end

---@param source number Player server id
---@param itemName string
---@param itemCount number
---@return boolean result
function CustomInventory.AddItem(source, itemName, itemCount)
    -- exports.["CustomInventory"]:AddItem(?, ?)
end

---@param source number Player server id
---@param itemName string
---@param itemCount number
---@return boolean result
function CustomInventory.RemoveItem(source, itemName, itemCount)
    -- exports.["CustomInventory"]:RemoveItem(?, ?)
end

---@param source number Player server id
---@param type string
---@param amount number
---@param reason string
---@return boolean result
function CustomInventory.AddMoney(source, type, amount, reason)
    -- exports.["AddMoney"]:AddMoney(?, ?)
end

---@param source number Player server id
---@param type string
---@param amount number
---@param reason string
---@return boolean result
function CustomInventory.RemoveMoney(source, type, amount, reason)
    -- exports.["RemoveMoney"]:RemoveMoney(?, ?)
end

---@class Stash
---@field id number
---@field job_identity string
---@field name string
---@field interaction_type string
---@field coords vector4

---@param source number Player server id
---@param stash Stash
function CustomInventory.OpenStash(source, stash)
    -- exports.["OpenStash"]:OpenStash(?, ?)
end

---@class progressbar
---@field title string
---@field disable_movement "yes" | "no"

---@class skillbar
---@field needed_attempts number

---@class vector4
---@field x number
---@field y number
---@field z number
---@field w number

---@class prop
---@field is_required "yes" | "no"
---@field model string
---@field bone number
---@field coords vector4
---@field rotation vector4

---@class animationOption
---@field name string
---@field dict string
---@field flags number
---@field duration number
---@field type "skillbar" | "progressbar"
---@field progressbar progressbar
---@field skillbar skillbar
---@field prop prop
---@param options animationOption
function CustomProgressbar(options)
    -- local success = exports.["CustomProgressbar"]:CustomProgressbar(?)
    -- return success
end

---@param options animationOption
function CustomSkillbar(options)
    -- local success = exports.["CustomSkillbar"]:CustomSkillbar(?)
    -- return success
end
