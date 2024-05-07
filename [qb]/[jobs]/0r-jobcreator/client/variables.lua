-- Get the core object from the "qb-core" resource.
QBCore                 = exports["qb-core"]:GetCoreObject()

-- Retrieve player data using the QBCore object.
PlayerData             = QBCore.Functions.GetPlayerData()

gPlayer                = {
    inZone = false,
    zoneInfo = nil,
    onDuty = false,
    job = nil,
    spawnedCar = false
}

gCreatedTargetZones    = {}
gCreatedTargetEntities = {}
gCreatedZones          = {}
gCreatedBlips          = {}
gSpawnedPeds           = {}
gCreatedDrawTexts      = {}
gCreatedObjects        = {}

JobsClass              = {
    jobs = {},
    __index = self,
    init = function(object)
        local newObject = object or {
            jobs = {}
        }
        setmetatable(newObject, self)
        self.__index = self
        return newObject
    end
}

if hasResource("ox_target") then
    ox_target = exports.ox_target
end

if Config.Default.InventoryType == "ox_inventory" then
    if hasResource("ox_inventory") then
        ox_inventory = exports.ox_inventory
    end
end