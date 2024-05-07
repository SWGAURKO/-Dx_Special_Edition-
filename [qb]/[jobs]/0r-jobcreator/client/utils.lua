--- A simple wrapper around SendNUIMessage that you can use to
--- dispatch actions to the React frame.
---
---@param action string The action you wish to target
---@param data any The data you wish to send along with this action
function SendReactMessage(action, data)
    SendNUIMessage({
        action = action,
        data = data
    })
end

---@param system ("qb_notify" | "ox_notify" | "okok_notify" | "custom_notify") System to be used
---@param title string Notification title
---@param type string inform / success / error
---@param duration? number (optional) Duration in miliseconds, custom notify.
---@param icon? string (optional) icon , custom notify.
---@param text? string (optional) text, custom notify.
function SendNotify(system, title, type, duration, icon, text)
    system = system and system or "qb_notify"
    if system == "qb_notify" then
        QBCore.Functions.Notify(title, type)
    elseif system == "ox_notify" then
        if hasResource("ox_lib") then
            lib.notify({
                title = title,
                type = type,
                duration = duration,
                icon = icon,
                description = text
            })
        else
            debugPrint("error", "ox_lib not found.")
        end
    elseif system == "okok_notify" then
        if hasResource("okokNotify") then
            exports["okokNotify"]:Alert(title, text, duration, type, true)
        else
            debugPrint("error", "okokNotify not found.")
        end
    elseif system == "custom_notify" then
        CustomNotify(nil, title, type, text, duration)
    end
end

---@param dict string
function loadAnimDict(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(0)
        end
    end
end

---@param model number | string
function loadModel(model)
    if HasModelLoaded(model) then
        return
    end
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
end

function TriggerCallback(name, cb, ...)
    return QBCore.Functions.TriggerCallback(name, function(...)
        cb(...)
    end, ...)
end

--- Creates a pedestrian with the specified model and coordinates.
--- @param _model string Model hash
--- @param _coords table Coordinates {x, y, z}
--- @param options table Options table {heading, scenario, freeze, invincible, blockingEvents}
--- @return boolean status The handle of the created ped or false if it couldn't be created.
function CreatePedWithOptions(_model, _coords, options)
    if not options then
        options = {}
    end
    if not _model or not _coords then
        return false
    end
    local model = _model
    loadModel(model)
    local coords = _coords
    local heading = options.heading or coords.h or 0.0
    local scenario = options.scenario or "WORLD_HUMAN_STAND_MOBILE"
    local freeze = options.freeze or true
    local invincible = options.invincible or true
    local blockingEvents = options.blockingEvents or true
    local ped = CreatePed(0, model, coords.x, coords.y, coords.z - 1, heading, false, true)
    if ped == 0 then
        return false
    end
    TaskStartScenarioInPlace(ped, scenario, 0, true)
    if freeze then
        FreezeEntityPosition(ped, true)
    end
    if invincible then
        SetEntityInvincible(ped, true)
    end
    if blockingEvents then
        SetBlockingOfNonTemporaryEvents(ped, true)
    end
    return ped
end

function int2float(integer)
    return integer + 0.0
end

-- Draws 3D text at the specified world coordinates.
---@param x (number) The X-coordinate of the text in the world.
---@param y (number) The Y-coordinate of the text in the world.
---@param z (number) The Z-coordinate of the text in the world.
---@param text (string) The text to be displayed.
function DrawText3D(coords, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords.x, coords.y, coords.z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 70, 134, 123, 75)
    ClearDrawOrigin()
end

---@param vehicle (number) Vehicle entity
---@param plate (string) Vehicle plate text
---@param model (string) Entity model
function OnDeleteVehicle(vehicle, plate, model)
    -- [WARNING] You don't need to delete the vehicle. After that it will already be removed
    -- Maybe you want to remove the car keys. You can do that here. If you are using such a script
    debugPrint("success", "Delete spawned vehicle.")
end

---@param vehicle (number) Vehicle entity
---@param plate (string) Vehicle plate text
---@param model (string) Entity model
function OnSpawnedVehicle(vehicle, plate, model)
    -- Maybe you want to give the car keys. You can do that here. If you are using such a script
    TriggerEvent("vehiclekeys:client:SetOwner", plate)
    debugPrint("success", "New vehicle spawned.")
end
