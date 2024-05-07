-- Get the core object from the "qb-core" resource.
QBCore = exports["qb-core"]:GetCoreObject()

JobsClass = {
    jobs = {},
    cool_down = {},
    __index = self,
    init = function(object)
        local newObject = object or { jobs = {}, cool_down = {} }
        setmetatable(newObject, self)
        self.__index = self
        return newObject
    end
}

if Config.Default.InventoryType == "ox_inventory" then
    if hasResource("ox_inventory") then
        ox_inventory = exports.ox_inventory
    end
end
