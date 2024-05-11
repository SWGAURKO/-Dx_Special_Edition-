if Config.Framework == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
else
    ESX = exports["es_extended"]:getSharedObject()
end

local creatingCharacter = false
local cam = -1
local headingToCam = GetEntityHeading(PlayerPedId())
local camOffset = 2
local PlayerData = {}

local Blips = {}

local Answers = {}
local MugshotsCache = {}
local id = 0

local previousSkinData = nil

local inShopping = false

function GetMugShotBase64(Ped, Transparent)
    Ped = PlayerPedId()
    id = id + 1

    local Handle = RegisterPedheadshotTransparent(Ped)

    if Handle == nil or Handle == 0 then Handle = RegisterPedheadshot(Ped) end

    local timer = 2000
    while ((not Handle or not IsPedheadshotReady(Handle) or not IsPedheadshotValid(Handle)) and timer > 0) do
        Citizen.Wait(10)
        timer = timer - 10
    end

    local MugShotTxd = 'none'
    if (IsPedheadshotReady(Handle) and IsPedheadshotValid(Handle)) then
        MugshotsCache[id] = Handle
        MugShotTxd = GetPedheadshotTxdString(Handle)
    end

    SendNUIMessage({
        type = 'convert',
        pMugShotTxd = MugShotTxd,
        id = id,
    })

    local p = promise.new()
    Answers[id] = p

    return Citizen.Await(p)
end

RegisterNUICallback('Answer', function(data)
    if MugshotsCache[data.Id] then
        UnregisterPedheadshot(MugshotsCache[data.Id])
        MugshotsCache[data.Id] = nil
    end
    Answers[data.Id]:resolve(data.Answer)
    Answers[data.Id] = nil
end)

local skinData = {
    ["model"] = "mp_m_freemode_01",
    ["migrate"] = "true",
    ["face"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["face2"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["facemix"] = {
        skinMix = 0,
        shapeMix = 0,
        defaultSkinMix = 0.0,
        defaultShapeMix = 0.0,
    },
    ["pants"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["hair"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["eyebrows"] = {
        item = -1,
        texture = 1,
        defaultItem = -1,
        defaultTexture = 1,
    },
    ["beard"] = {
        item = -1,
        texture = 1,
        defaultItem = -1,
        defaultTexture = 1,
    },
    ["blush"] = {
        item = -1,
        texture = 1,
        defaultItem = -1,
        defaultTexture = 1,
    },
    ["lipstick"] = {
        item = -1,
        texture = 1,
        defaultItem = -1,
        defaultTexture = 1,
    },
    ["makeup"] = {
        item = -1,
        texture = 1,
        defaultItem = -1,
        defaultTexture = 1,
    },
    ["ageing"] = {
        item = -1,
        texture = 0,
        defaultItem = -1,
        defaultTexture = 0,
    },
    ["arms"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["t-shirt"] = {
        item = 1,
        texture = 0,
        defaultItem = 15,
        defaultTexture = 0,
    },
    ["torso2"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["vest"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["bag"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["shoes"] = {
        item = 0,
        texture = 0,
        defaultItem = 1,
        defaultTexture = 0,
    },
    ["mask"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["hat"] = {
        item = -1,
        texture = 0,
        defaultItem = -1,
        defaultTexture = 0,
    },
    ["glass"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["ear"] = {
        item = -1,
        texture = 0,
        defaultItem = -1,
        defaultTexture = 0,
    },
    ["watch"] = {
        item = -1,
        texture = 0,
        defaultItem = -1,
        defaultTexture = 0,
    },
    ["bracelet"] = {
        item = -1,
        texture = 0,
        defaultItem = -1,
        defaultTexture = 0,
    },
    ["accessory"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["decals"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["eye_color"] = {
        item = -1,
        texture = 0,
        defaultItem = -1,
        defaultTexture = 0,
    },
    ["moles"] = {
        item = 0,
        texture = 0,
        defaultItem = -1,
        defaultTexture = 0,
    },
    ["nose_0"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["nose_1"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["nose_2"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["nose_3"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },

    ["nose_4"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["nose_5"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["cheek_1"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["cheek_2"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["cheek_3"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["eye_opening"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["lips_thickness"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["jaw_bone_width"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["eyebrown_high"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["eyebrown_forward"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["jaw_bone_back_lenght"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["chimp_bone_lowering"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["chimp_bone_lenght"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["chimp_bone_width"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["chimp_hole"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["neck_thikness"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
}

local clothingCategories = {
    ["arms"]                 = { type = "variation", id = 3 },
    ["t-shirt"]              = { type = "variation", id = 8 },
    ["torso2"]               = { type = "variation", id = 11 },
    ["pants"]                = { type = "variation", id = 4 },
    ["vest"]                 = { type = "variation", id = 9 },
    ["shoes"]                = { type = "variation", id = 6 },
    ["bag"]                  = { type = "variation", id = 5 },
    ["hair"]                 = { type = "hair", id = 2 },
    ["eyebrows"]             = { type = "overlay", id = 2 },
    ["face"]                 = { type = "face", id = 2 },
    ["face2"]                = { type = "face", id = 2 },
    ["facemix"]              = { type = "face", id = 2 },
    ["beard"]                = { type = "overlay", id = 1 },
    ["blush"]                = { type = "overlay", id = 5 },
    ["lipstick"]             = { type = "overlay", id = 8 },
    ["makeup"]               = { type = "overlay", id = 4 },
    ["ageing"]               = { type = "ageing", id = 3 },
    ["mask"]                 = { type = "mask", id = 1 },
    ["hat"]                  = { type = "prop", id = 0 },
    ["glass"]                = { type = "prop", id = 1 },
    ["ear"]                  = { type = "prop", id = 2 },
    ["watch"]                = { type = "prop", id = 6 },
    ["bracelet"]             = { type = "prop", id = 7 },
    ["accessory"]            = { type = "variation", id = 7 },
    ["decals"]               = { type = "variation", id = 10 },
    ["eye_color"]            = { type = "eye_color", id = 1 },
    ["moles"]                = { type = "moles", id = 1 },
    ["jaw_bone_width"]       = { type = "cheek", id = 1 },
    ["jaw_bone_back_lenght"] = { type = "cheek", id = 1 },
    ["lips_thickness"]       = { type = "nose", id = 1 },
    ["nose_0"]               = { type = "nose", id = 1 },
    ["nose_1"]               = { type = "nose", id = 1 },
    ["nose_2"]               = { type = "nose", id = 2 },
    ["nose_3"]               = { type = "nose", id = 3 },
    ["nose_4"]               = { type = "nose", id = 4 },
    ["nose_5"]               = { type = "nose", id = 5 },
    ["cheek_1"]              = { type = "cheek", id = 1 },
    ["cheek_2"]              = { type = "cheek", id = 2 },
    ["cheek_3"]              = { type = "cheek", id = 3 },
    ["eyebrown_high"]        = { type = "nose", id = 1 },
    ["eyebrown_forward"]     = { type = "nose", id = 2 },
    ["eye_opening"]          = { type = "nose", id = 1 },
    ["chimp_bone_lowering"]  = { type = "chin", id = 1 },
    ["chimp_bone_lenght"]    = { type = "chin", id = 2 },
    ["chimp_bone_width"]     = { type = "cheek", id = 3 },
    ["chimp_hole"]           = { type = "cheek", id = 4 },
    ["neck_thikness"]        = { type = "cheek", id = 5 },
}
local faceProps = {
    [1] = { ["Prop"] = -1, ["Texture"] = -1 },
    [2] = { ["Prop"] = -1, ["Texture"] = -1 },
    [3] = { ["Prop"] = -1, ["Texture"] = -1 },
    [4] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 },
    [5] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 },
    [6] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 },
}

function GetMaxValues(isSingle, key, push)
    local maxModelValues = {
        ["arms"]                 = { type = "character", item = 0, texture = 0 },
        ["eye_color"]            = { type = "hair", item = 0, texture = 0 },
        ["t-shirt"]              = { type = "character", item = 0, texture = 0 },
        ["torso2"]               = { type = "character", item = 0, texture = 0 },
        ["pants"]                = { type = "character", item = 0, texture = 0 },
        ["shoes"]                = { type = "character", item = 0, texture = 0 },
        ["face"]                 = { type = "character", item = 0, texture = 0 },
        ["face2"]                = { type = "character", item = 0, texture = 0 },
        ["facemix"]              = { type = "character", shapeMix = 0, skinMix = 0 },
        ["vest"]                 = { type = "character", item = 0, texture = 0 },
        ["accessory"]            = { type = "character", item = 0, texture = 0 },
        ["decals"]               = { type = "character", item = 0, texture = 0 },
        ["bag"]                  = { type = "character", item = 0, texture = 0 },
        ["moles"]                = { type = "hair", item = 0, texture = 0 },
        ["hair"]                 = { type = "hair", item = 0, texture = 0 },
        ["eyebrows"]             = { type = "hair", item = 0, texture = 0 },
        ["beard"]                = { type = "hair", item = 0, texture = 0 },
        ["eye_opening"]          = { type = "hair", id = 1 },
        ["jaw_bone_width"]       = { type = "hair", item = 0, texture = 0 },
        ["jaw_bone_back_lenght"] = { type = "hair", item = 0, texture = 0 },
        ["lips_thickness"]       = { type = "hair", item = 0, texture = 0 },
        ["cheek_1"]              = { type = "hair", item = 0, texture = 0 },
        ["cheek_2"]              = { type = "hair", item = 0, texture = 0 },
        ["cheek_3"]              = { type = "hair", item = 0, texture = 0 },
        ["eyebrown_high"]        = { type = "hair", item = 0, texture = 0 },
        ["eyebrown_forward"]     = { type = "hair", item = 0, texture = 0 },
        ["nose_0"]               = { type = "hair", item = 0, texture = 0 },
        ["nose_1"]               = { type = "hair", item = 0, texture = 0 },
        ["nose_2"]               = { type = "hair", item = 0, texture = 0 },
        ["nose_3"]               = { type = "hair", item = 0, texture = 0 },
        ["nose_4"]               = { type = "hair", item = 0, texture = 0 },
        ["nose_5"]               = { type = "hair", item = 0, texture = 0 },
        ["chimp_bone_lowering"]  = { type = "hair", item = 0, texture = 0 },
        ["chimp_bone_lenght"]    = { type = "hair", item = 0, texture = 0 },
        ["chimp_bone_width"]     = { type = "hair", item = 0, texture = 0 },
        ["chimp_hole"]           = { type = "hair", item = 0, texture = 0 },
        ["neck_thikness"]        = { type = "hair", item = 0, texture = 0 },
        ["blush"]                = { type = "hair", item = 0, texture = 0 },
        ["lipstick"]             = { type = "hair", item = 0, texture = 0 },
        ["makeup"]               = { type = "hair", item = 0, texture = 0 },
        ["ageing"]               = { type = "hair", item = 0, texture = 0 },
        ["mask"]                 = { type = "accessoires", item = 0, texture = 0 },
        ["hat"]                  = { type = "accessoires", item = 0, texture = 0 },
        ["glass"]                = { type = "accessoires", item = 0, texture = 0 },
        ["ear"]                  = { type = "accessoires", item = 0, texture = 0 },
        ["watch"]                = { type = "accessoires", item = 0, texture = 0 },
        ["bracelet"]             = { type = "accessoires", item = 0, texture = 0 },
    }

    local ped = PlayerPedId()
    for k, v in pairs(clothingCategories) do
        if v.type == "variation" then
            maxModelValues[k].item = GetNumberOfPedDrawableVariations(ped, v.id)
            maxModelValues[k].texture = GetNumberOfPedTextureVariations(ped, v.id, GetPedDrawableVariation(ped, v.id)) -
            1
        end

        if v.type == "hair" then
            maxModelValues[k].item = GetNumberOfPedDrawableVariations(ped, v.id)
            maxModelValues[k].texture = 45
        end

        if v.type == "mask" then
            maxModelValues[k].item = GetNumberOfPedDrawableVariations(ped, v.id)
            maxModelValues[k].texture = GetNumberOfPedTextureVariations(ped, v.id, GetPedDrawableVariation(ped, v.id))
        end

        if v.type == "face" then
            maxModelValues[k].item = 45
            maxModelValues[k].texture = 15
        end

        if v.type == "face2" then
            maxModelValues[k].item = 45
            maxModelValues[k].texture = 15
        end

        if v.type == "facemix" then
            maxModelValues[k].shapeMix = 10
            maxModelValues[k].skinMix = 10
        end

        if v.type == "ageing" then
            maxModelValues[k].item = GetNumHeadOverlayValues(v.id)
            maxModelValues[k].texture = 0
        end

        if v.type == "overlay" then
            maxModelValues[k].item = GetNumHeadOverlayValues(v.id)
            maxModelValues[k].texture = 45
        end

        if v.type == "prop" then
            maxModelValues[k].item = GetNumberOfPedPropDrawableVariations(ped, v.id)
            maxModelValues[k].texture = GetNumberOfPedPropTextureVariations(ped, v.id, GetPedPropIndex(ped, v.id))
        end

        if v.type == "eye_color" then
            maxModelValues[k].item = 31
            maxModelValues[k].texture = 0
        end

        if v.type == "moles" then
            maxModelValues[k].item = GetNumHeadOverlayValues(9) - 1
            maxModelValues[k].texture = 10
        end

        if v.type == "nose" then
            maxModelValues[k].item = 30
            maxModelValues[k].texture = 0
        end

        if v.type == "cheek" then
            maxModelValues[k].item = 30
            maxModelValues[k].texture = 0
        end

        if v.type == "chin" then
            maxModelValues[k].item = 30
            maxModelValues[k].texture = 0
        end
    end

    if push ~= nil then
        return maxModelValues
    else
        if isSingle then
            SendNUIMessage({
                action = "updateMaxSinle",
                maxValues = maxModelValues,
                key = key
            })
        else
            SendNUIMessage({
                action = "updateMax",
                maxValues = maxModelValues
            })
        end
    end
end

function enableCam()
    local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 2.0, 0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, true)
        SetCamCoord(cam, coords.x, coords.y, coords.z + 0.2)
        SetCamRot(cam, 0.0, 0.0, GetEntityHeading(PlayerPedId()) + 180)
    end

    if customCamLocation ~= nil then
        SetCamCoord(cam, customCamLocation.x, customCamLocation.y, customCamLocation.z)
        SetCamRot(cam, 0.0, 0.0, customCamLocation.w)
    end

    headingToCam = GetEntityHeading(PlayerPedId()) + 90
    camOffset = 2.0
end

function resetClothing(data)
    local ped = PlayerPedId()

    SetPedHeadBlendData(ped, data["face"].item, data["face2"].item, nil, data["face"].texture, data["face2"].texture, nil,
        data["facemix"].shapeMix, data["facemix"].skinMix, nil, true)

    SetPedComponentVariation(ped, 4, data["pants"].item, 0, 0)
    SetPedComponentVariation(ped, 4, data["pants"].item, data["pants"].texture, 0)

    SetPedComponentVariation(ped, 2, data["hair"].item, 0, 0)
    SetPedHairColor(ped, data["hair"].texture, data["hair"].texture)

    SetPedHeadOverlay(ped, 2, data["eyebrows"].item, 1.0)
    SetPedHeadOverlayColor(ped, 2, 1, data["eyebrows"].texture, 0)

    SetPedHeadOverlay(ped, 1, data["beard"].item, 1.0)
    SetPedHeadOverlayColor(ped, 1, 1, data["beard"].texture, 0)

    SetPedHeadOverlay(ped, 5, data["blush"].item, 1.0)
    SetPedHeadOverlayColor(ped, 5, 1, data["blush"].texture, 0)

    SetPedHeadOverlay(ped, 8, data["lipstick"].item, 1.0)
    SetPedHeadOverlayColor(ped, 8, 1, data["lipstick"].item, 0)

    SetPedHeadOverlay(ped, 4, data["makeup"].item, 1.0)
    SetPedHeadOverlayColor(ped, 4, 1, data["makeup"].texture, 0)

    SetPedHeadOverlay(ped, 3, data["ageing"].item, 1.0)
    SetPedHeadOverlayColor(ped, 3, 1, data["ageing"].texture, 0)

    SetPedComponentVariation(ped, 3, data["arms"].item, 0, 2)
    SetPedComponentVariation(ped, 3, data["arms"].item, data["arms"].texture, 0)

    SetPedComponentVariation(ped, 8, data["t-shirt"].item, 0, 2)
    SetPedComponentVariation(ped, 8, data["t-shirt"].item, data["t-shirt"].texture, 0)

    SetPedComponentVariation(ped, 9, data["vest"].item, 0, 2)
    SetPedComponentVariation(ped, 9, data["vest"].item, data["vest"].texture, 0)

    SetPedComponentVariation(ped, 11, data["torso2"].item, 0, 2)
    SetPedComponentVariation(ped, 11, data["torso2"].item, data["torso2"].texture, 0)

    SetPedComponentVariation(ped, 6, data["shoes"].item, 0, 2)
    SetPedComponentVariation(ped, 6, data["shoes"].item, data["shoes"].texture, 0)

    SetPedComponentVariation(ped, 1, data["mask"].item, 0, 2)
    SetPedComponentVariation(ped, 1, data["mask"].item, data["mask"].texture, 0)

    SetPedComponentVariation(ped, 10, data["decals"].item, 0, 2)
    SetPedComponentVariation(ped, 10, data["decals"].item, data["decals"].texture, 0)

    SetPedComponentVariation(ped, 7, data["accessory"].item, 0, 2)
    SetPedComponentVariation(ped, 7, data["accessory"].item, data["accessory"].texture, 0)

    SetPedComponentVariation(ped, 5, data["bag"].item, 0, 2)
    SetPedComponentVariation(ped, 5, data["bag"].item, data["bag"].texture, 0)
    SetPedEyeColor(ped, data['eye_color'].item)
    SetPedHeadOverlay(ped, 9, data['moles'].item, data['moles'].texture)
    SetPedFaceFeature(ped, 0, data['nose_0'].item)
    SetPedFaceFeature(ped, 1, data['nose_1'].item)
    SetPedFaceFeature(ped, 2, data['nose_2'].item)
    SetPedFaceFeature(ped, 3, data['nose_3'].item)
    SetPedFaceFeature(ped, 4, data['nose_4'].item)
    SetPedFaceFeature(ped, 5, data['nose_5'].item)
    SetPedFaceFeature(ped, 6, data['eyebrown_high'].item)
    SetPedFaceFeature(ped, 7, data['eyebrown_forward'].item)
    SetPedFaceFeature(ped, 8, data['cheek_1'].item)
    SetPedFaceFeature(ped, 9, data['cheek_2'].item)
    SetPedFaceFeature(ped, 10, data['cheek_3'].item)
    SetPedFaceFeature(ped, 11, data['eye_opening'].item)
    SetPedFaceFeature(ped, 12, data['lips_thickness'].item)
    SetPedFaceFeature(ped, 13, data['jaw_bone_width'].item)
    SetPedFaceFeature(ped, 14, data['jaw_bone_back_lenght'].item)
    SetPedFaceFeature(ped, 15, data['chimp_bone_lowering'].item)
    SetPedFaceFeature(ped, 16, data['chimp_bone_lenght'].item)
    SetPedFaceFeature(ped, 17, data['chimp_bone_width'].item)
    SetPedFaceFeature(ped, 18, data['chimp_hole'].item)
    SetPedFaceFeature(ped, 19, data['neck_thikness'].item)

    if data["hat"].item ~= -1 and data["hat"].item ~= 0 then
        SetPedPropIndex(ped, 0, data["hat"].item, data["hat"].texture, true)
    else
        ClearPedProp(ped, 0)
    end

    if data["glass"].item ~= -1 and data["glass"].item ~= 0 then
        SetPedPropIndex(ped, 1, data["glass"].item, data["glass"].texture, true)
    else
        ClearPedProp(ped, 1)
    end

    if data["ear"].item ~= -1 and data["ear"].item ~= 0 then
        SetPedPropIndex(ped, 2, data["ear"].item, data["ear"].texture, true)
    else
        ClearPedProp(ped, 2)
    end

    if data["watch"].item ~= -1 and data["watch"].item ~= 0 then
        SetPedPropIndex(ped, 6, data["watch"].item, data["watch"].texture, true)
    else
        ClearPedProp(ped, 6)
    end

    if data["bracelet"].item ~= -1 and data["bracelet"].item ~= 0 then
        SetPedPropIndex(ped, 7, data["bracelet"].item, data["bracelet"].texture, true)
    else
        ClearPedProp(ped, 7)
    end
end

function GetPositionByRelativeHeading(ped, head, dist)
    local pedPos = GetEntityCoords(ped)

    local finPosx = pedPos.x + math.cos(head * (math.pi / 180)) * dist
    local finPosy = pedPos.y + math.sin(head * (math.pi / 180)) * dist

    return finPosx, finPosy
end

function openMenu()
    if Config.Framework == "qb" then
        QBCore.Functions.TriggerCallback("sh-creation:getSkinDatas", function(data)
            creatingCharacter = true

            PlayerData = QBCore.Functions.GetPlayerData()

            local gender = QBCore.Functions.GetPlayerData().charinfo.gender

            if gender == 0 then
                skinData.model = "mp_m_freemode_01"
            else
                skinData.model = "mp_f_freemode_01"
            end

            local bucket = math.random(0, 65535)

            TriggerServerEvent('sh-creation:server:setBucket', bucket)

            GetMaxValues(false, nil)
            SendNUIMessage({
                action = "open",
                currentClothing = skinData,
                gender = gender,
                saved = data
            })

            SetNuiFocus(true, true)
            SetCursorLocation(0.9, 0.25)
            FreezeEntityPosition(PlayerPedId(), true)
            enableCam()
        end)
    else
        ESX.TriggerServerCallback("sh-creation:getSkinDatas", function(data)
            creatingCharacter = true

            local gender = ESX.GetPlayerData().sex == "m" and 0 or 1

            if gender == 0 then
                skinData.model = "mp_m_freemode_01"
            else
                skinData.model = "mp_f_freemode_01"
            end

            local bucket = math.random(0, 65535)

            TriggerServerEvent('sh-creation:server:setBucket', bucket)

            GetMaxValues(false, nil)
            SendNUIMessage({
                action = "open",
                currentClothing = skinData,
                gender = gender,
                saved = data
            })

            SetNuiFocus(true, true)
            SetCursorLocation(0.9, 0.25)
            FreezeEntityPosition(PlayerPedId(), true)
            enableCam()
        end)
    end
end

function openClothingMenu()
    if Config.Framework == "qb" then
        QBCore.Functions.TriggerCallback("sh-creation:getClothingDatas", function(data)
            QBCore.Functions.TriggerCallback("sh-creation:getCurrentSkinData", function(_)
                previousSkinData = json.encode(_)

                local gender = QBCore.Functions.GetPlayerData().charinfo.gender

                skinData = _

                SendNUIMessage({
                    action = "openClothing",
                    gender = gender,
                    saved = data,
                    price = Config.ClothingShopPrice
                })

                GetMaxValues(false, nil)

                SendNUIMessage({
                    action = "setValues",
                    values = json.encode(_),
                })

                GetMaxValues(false, nil)

                SetNuiFocus(true, true)
                SetCursorLocation(0.9, 0.25)
                FreezeEntityPosition(PlayerPedId(), true)
                enableCam()

                inShopping = true
            end)
        end)
    else
        ESX.TriggerServerCallback("sh-creation:getClothingDatas", function(data)
            ESX.TriggerServerCallback("sh-creation:getCurrentSkinData", function(_)
                previousSkinData = json.encode(_)

                local gender = ESX.GetPlayerData().sex == "m" and 0 or 1

                skinData = _

                SendNUIMessage({
                    action = "openClothing",
                    gender = gender,
                    saved = data,
                    price = Config.ClothingShopPrice
                })

                GetMaxValues(false, nil)

                SendNUIMessage({
                    action = "setValues",
                    values = json.encode(_),
                })

                GetMaxValues(false, nil)

                SetNuiFocus(true, true)
                SetCursorLocation(0.9, 0.25)
                FreezeEntityPosition(PlayerPedId(), true)
                enableCam()

                inShopping = true
            end)
        end)
    end
end

function openClothingRoomMenu()
    if Config.Framework == "qb" then
        QBCore.Functions.TriggerCallback("sh-creation:getClothingDatas", function(data)
            QBCore.Functions.TriggerCallback("sh-creation:getCurrentSkinData", function(_)
                previousSkinData = json.encode(_)

                local gender = QBCore.Functions.GetPlayerData().charinfo.gender

                skinData = _

                SendNUIMessage({
                    action = "openClothingRoom",
                    gender = gender,
                    saved = data
                })

                GetMaxValues(false, nil)

                SendNUIMessage({
                    action = "setValues",
                    values = json.encode(_),
                })

                GetMaxValues(false, nil)

                SetNuiFocus(true, true)
                SetCursorLocation(0.9, 0.25)
                FreezeEntityPosition(PlayerPedId(), true)
                enableCam()

                inShopping = true
            end)
        end)
    else
        ESX.TriggerServerCallback("sh-creation:getClothingDatas", function(data)
            ESX.TriggerServerCallback("sh-creation:getCurrentSkinData", function(_)
                previousSkinData = json.encode(_)

                local gender = ESX.GetPlayerData().sex == "m" and 0 or 1

                skinData = _

                SendNUIMessage({
                    action = "openClothingRoom",
                    gender = gender,
                    saved = data
                })

                GetMaxValues(false, nil)

                SendNUIMessage({
                    action = "setValues",
                    values = json.encode(_),
                })

                GetMaxValues(false, nil)

                SetNuiFocus(true, true)
                SetCursorLocation(0.9, 0.25)
                FreezeEntityPosition(PlayerPedId(), true)
                enableCam()

                inShopping = true
            end)
        end)
    end
end

function openBarberMenu()
    if Config.Framework == "qb" then
        QBCore.Functions.TriggerCallback("sh-creation:getBarberDatas", function(data)
            QBCore.Functions.TriggerCallback("sh-creation:getCurrentSkinData", function(_)
                previousSkinData = json.encode(_)

                local gender = QBCore.Functions.GetPlayerData().charinfo.gender

                skinData = _

                SendNUIMessage({
                    action = "openBarber",
                    gender = gender,
                    saved = data,
                    price = Config.ClothingShopPrice
                })

                GetMaxValues(false, nil)

                SendNUIMessage({
                    action = "setValues",
                    values = json.encode(_),
                })

                GetMaxValues(false, nil)

                SetNuiFocus(true, true)
                SetCursorLocation(0.9, 0.25)
                FreezeEntityPosition(PlayerPedId(), true)
                enableCam()

                inShopping = true
            end)
        end)
    else
        ESX.TriggerServerCallback("sh-creation:getBarberDatas", function(data)
            ESX.TriggerServerCallback("sh-creation:getCurrentSkinData", function(_)
                previousSkinData = json.encode(_)

                local gender = ESX.GetPlayerData().sex == "m" and 0 or 1

                skinData = _

                SendNUIMessage({
                    action = "openBarber",
                    gender = gender,
                    saved = data,
                    price = Config.ClothingShopPrice
                })

                GetMaxValues(false, nil)

                SendNUIMessage({
                    action = "setValues",
                    values = json.encode(_),
                })

                GetMaxValues(false, nil)

                SetNuiFocus(true, true)
                SetCursorLocation(0.9, 0.25)
                FreezeEntityPosition(PlayerPedId(), true)
                enableCam()

                inShopping = true
            end)
        end)
    end
end

function openSurgeryMenu()
    if Config.Framework == "qb" then
        QBCore.Functions.TriggerCallback("sh-creation:getSurgeryDatas", function(data)
            QBCore.Functions.TriggerCallback("sh-creation:getCurrentSkinData", function(_)
                previousSkinData = json.encode(_)

                local gender = QBCore.Functions.GetPlayerData().charinfo.gender

                skinData = _

                SendNUIMessage({
                    action = "openSurgery",
                    gender = gender,
                    saved = data,
                    price = Config.ClothingShopPrice
                })

                GetMaxValues(false, nil)

                SendNUIMessage({
                    action = "setValues",
                    values = json.encode(_),
                })

                GetMaxValues(false, nil)

                SetNuiFocus(true, true)
                SetCursorLocation(0.9, 0.25)
                FreezeEntityPosition(PlayerPedId(), true)
                enableCam()

                inShopping = true
            end)
        end)
    else
        ESX.TriggerServerCallback("sh-creation:getSurgeryDatas", function(data)
            ESX.TriggerServerCallback("sh-creation:getCurrentSkinData", function(_)
                previousSkinData = json.encode(_)

                local gender = ESX.GetPlayerData().sex == "m" and 0 or 1

                skinData = _

                SendNUIMessage({
                    action = "openSurgery",
                    gender = gender,
                    saved = data,
                    price = Config.ClothingShopPrice
                })

                GetMaxValues(false, nil)

                SendNUIMessage({
                    action = "setValues",
                    values = json.encode(_),
                })

                GetMaxValues(false, nil)

                SetNuiFocus(true, true)
                SetCursorLocation(0.9, 0.25)
                FreezeEntityPosition(PlayerPedId(), true)
                enableCam()

                inShopping = true
            end)
        end)
    end
end

function disableCam()
    RenderScriptCams(false, true, 250, 1, 0)
    DestroyCam(cam, false)

    FreezeEntityPosition(PlayerPedId(), false)
end

function ChangeVariation(data)
    local ped = PlayerPedId()
    local clothingCategory = data.clothingType
    local type = data.type
    local item = data.articleNumber

    if clothingCategory == "pants" then
        if type == "item" then
            SetPedComponentVariation(ped, 4, item, 0, 0)
            skinData["pants"].item = item
        elseif type == "texture" then
            local curItem = GetPedDrawableVariation(ped, 4)
            SetPedComponentVariation(ped, 4, curItem, item, 0)
            skinData["pants"].texture = item
        end
    elseif clothingCategory == "face" then
        if type == "item" then
            SetPedHeadBlendData(ped, tonumber(item), skinData["face2"].item, nil, skinData["face"].texture,
                skinData["face2"].texture, nil, skinData["facemix"].shapeMix, skinData["facemix"].skinMix, nil, true)
            skinData["face"].item = item
        elseif type == "texture" then
            SetPedHeadBlendData(ped, skinData["face"].item, skinData["face2"].item, nil, item, skinData["face2"].texture,
                nil, skinData["facemix"].shapeMix, skinData["facemix"].skinMix, nil, true)
            skinData["face"].texture = item
        end
    elseif clothingCategory == "face2" then
        if type == "item" then
            SetPedHeadBlendData(ped, skinData["face"].item, tonumber(item), nil, skinData["face"].texture,
                skinData["face2"].texture, nil, skinData["facemix"].shapeMix, skinData["facemix"].skinMix, nil, true)
            skinData["face2"].item = item
        elseif type == "texture" then
            SetPedHeadBlendData(ped, skinData["face"].item, skinData["face2"].item, nil, skinData["face"].texture, item,
                nil, skinData["facemix"].shapeMix, skinData["facemix"].skinMix, nil, true)
            skinData["face2"].texture = item
        end
    elseif clothingCategory == "facemix" then
        if type == "skinMix" then
            SetPedHeadBlendData(ped, skinData["face"].item, skinData["face2"].item, nil, skinData["face"].texture,
                skinData["face2"].texture, nil, skinData["facemix"].shapeMix, item, nil, true)
            skinData["facemix"].skinMix = item
        elseif type == "shapeMix" then
            SetPedHeadBlendData(ped, skinData["face"].item, skinData["face2"].item, nil, skinData["face"].texture,
                skinData["face2"].texture, nil, item, skinData["facemix"].skinMix, nil, true)
            skinData["facemix"].shapeMix = item
        end
    elseif clothingCategory == "hair" then
        SetPedHeadBlendData(ped, skinData["face"].item, skinData["face2"].item, nil, skinData["face"].texture,
            skinData["face2"].texture, nil, skinData["facemix"].shapeMix, skinData["facemix"].skinMix, nil, true)
        if type == "item" then
            SetPedComponentVariation(ped, 2, item, 0, 0)
            skinData["hair"].item = item
        elseif type == "texture" then
            SetPedHairColor(ped, item, item)
            skinData["hair"].texture = item
        end
    elseif clothingCategory == "eyebrows" then
        if type == "item" then
            SetPedHeadOverlay(ped, 2, item, 1.0)
            skinData["eyebrows"].item = item
        elseif type == "texture" then
            SetPedHeadOverlayColor(ped, 2, 1, item, 0)
            skinData["eyebrows"].texture = item
        end
    elseif clothingCategory == "beard" then
        if type == "item" then
            SetPedHeadOverlay(ped, 1, item, 1.0)
            skinData["beard"].item = item
        elseif type == "texture" then
            SetPedHeadOverlayColor(ped, 1, 1, item, 0)
            skinData["beard"].texture = item
        end
    elseif clothingCategory == "blush" then
        if type == "item" then
            SetPedHeadOverlay(ped, 5, item, 1.0)
            skinData["blush"].item = item
        elseif type == "texture" then
            SetPedHeadOverlayColor(ped, 5, 1, item, 0)
            skinData["blush"].texture = item
        end
    elseif clothingCategory == "lipstick" then
        if type == "item" then
            SetPedHeadOverlay(ped, 8, item, 1.0)
            skinData["lipstick"].item = item
        elseif type == "texture" then
            SetPedHeadOverlayColor(ped, 8, 1, item, 0)
            skinData["lipstick"].texture = item
        end
    elseif clothingCategory == "makeup" then
        if type == "item" then
            SetPedHeadOverlay(ped, 4, item, 1.0)
            skinData["makeup"].item = item
        elseif type == "texture" then
            SetPedHeadOverlayColor(ped, 4, 1, item, 0)
            skinData["makeup"].texture = item
        end
    elseif clothingCategory == "ageing" then
        if type == "item" then
            SetPedHeadOverlay(ped, 3, item, 1.0)
            skinData["ageing"].item = item
        elseif type == "texture" then
            SetPedHeadOverlayColor(ped, 3, 1, item, 0)
            skinData["ageing"].texture = item
        end
    elseif clothingCategory == "arms" then
        if type == "item" then
            SetPedComponentVariation(ped, 3, item, 0, 2)
            skinData["arms"].item = item
        elseif type == "texture" then
            local curItem = GetPedDrawableVariation(ped, 3)
            SetPedComponentVariation(ped, 3, curItem, item, 0)
            skinData["arms"].texture = item
        end
    elseif clothingCategory == "eye_color" then
        if type == "item" then
            SetPedEyeColor(ped, item)
            skinData["eye_color"].item = item
        end
    elseif clothingCategory == "moles" then
        if type == "item" then
            SetPedHeadOverlay(ped, 9, item, 1.0)
            skinData["moles"].item = item
        elseif type == "texture" then
            local curItem = GetPedDrawableVariation(ped, 9)
            local newitem = (item / 10)
            SetPedHeadOverlayColor(ped, 9, curItem, newitem)
            skinData["moles"].texture = item
        end
    elseif clothingCategory == "nose_0" then
        if type == "item" then
            local newitem = (item / 10)
            SetPedFaceFeature(ped, 0, newitem)
            skinData["nose_0"].item = item
        end
    elseif clothingCategory == "nose_1" then
        if type == "item" then
            local newitem = (item / 10)
            SetPedFaceFeature(ped, 1, newitem)
            skinData["nose_1"].item = item
        end
    elseif clothingCategory == "nose_2" then
        if type == "item" then
            local newitem = (item / 10)
            SetPedFaceFeature(ped, 2, newitem)
            skinData["nose_2"].item = item
        end
    elseif clothingCategory == "nose_3" then
        if type == "item" then
            local newitem = (item / 10)
            SetPedFaceFeature(ped, 3, newitem)
            skinData["nose_3"].item = item
        end
    elseif clothingCategory == "nose_4" then
        if type == "item" then
            local newitem = (item / 10)
            SetPedFaceFeature(ped, 4, newitem)
            skinData["nose_4"].item = item
        end
    elseif clothingCategory == "nose_5" then
        if type == "item" then
            local newitem = (item / 10)
            SetPedFaceFeature(ped, 5, newitem)
            skinData["nose_5"].item = item
        end
    elseif clothingCategory == "eyebrown_high" then
        if type == "item" then
            local newitem = (item / 10)
            SetPedFaceFeature(ped, 6, newitem)
            skinData["eyebrown_high"].item = item
        end
    elseif clothingCategory == "eyebrown_forward" then
        if type == "item" then
            local newitem = (item / 10)
            SetPedFaceFeature(ped, 7, newitem)
            skinData["eyebrown_forward"].item = item
        end
    elseif clothingCategory == "cheek_1" then
        if type == "item" then
            local newitem = (item / 10)
            SetPedFaceFeature(ped, 8, newitem)
            skinData["cheek_1"].item = item
        end
    elseif clothingCategory == "cheek_2" then
        if type == "item" then
            local newitem = (item / 10)
            SetPedFaceFeature(ped, 9, newitem)
            skinData["cheek_1"].item = item
        end
    elseif clothingCategory == "cheek_3" then
        if type == "item" then
            local newitem = (item / 10)
            SetPedFaceFeature(ped, 10, newitem)
            skinData["cheek_3"].item = item
        end
    elseif clothingCategory == "eye_opening" then
        if type == "item" then
            local newitem = (item / 10)
            SetPedFaceFeature(ped, 11, newitem)
            skinData["eye_opening"].item = item
        end
    elseif clothingCategory == "lips_thickness" then
        if type == "item" then
            local newitem = (item / 10)
            SetPedFaceFeature(ped, 12, newitem)
            skinData["lips_thickness"].item = item
        end
    elseif clothingCategory == "jaw_bone_width" then
        if type == "item" then
            local newitem = (item / 10)
            SetPedFaceFeature(ped, 13, newitem)
            skinData["jaw_bone_width"].item = item
        end
    elseif clothingCategory == "jaw_bone_back_lenght" then
        if type == "item" then
            local newitem = (item / 10)
            SetPedFaceFeature(ped, 14, newitem)
            skinData["jaw_bone_back_lenght"].item = item
        end
    elseif clothingCategory == "chimp_bone_lowering" then
        if type == "item" then
            local newitem = (item / 10)
            SetPedFaceFeature(ped, 15, newitem)
            skinData["chimp_bone_lowering"].item = item
        end
    elseif clothingCategory == "chimp_bone_lenght" then
        if type == "item" then
            local newitem = (item / 10)
            SetPedFaceFeature(ped, 16, newitem)
            skinData["chimp_bone_lenght"].item = item
        end
    elseif clothingCategory == "chimp_bone_width" then
        if type == "item" then
            local newitem = (item / 10)
            SetPedFaceFeature(ped, 17, newitem)
            skinData["chimp_bone_width"].item = item
        end
    elseif clothingCategory == "chimp_hole" then
        if type == "item" then
            local newitem = (item / 10)
            SetPedFaceFeature(ped, 18, newitem)
            skinData["chimp_hole"].item = item
        end
    elseif clothingCategory == "neck_thikness" then
        if type == "item" then
            local newitem = (item / 10)
            SetPedFaceFeature(ped, 19, newitem)
            skinData["chimp_hole"].item = item
        end
    elseif clothingCategory == "t-shirt" then
        if type == "item" then
            SetPedComponentVariation(ped, 8, item, 0, 2)
            skinData["t-shirt"].item = item
        elseif type == "texture" then
            local curItem = GetPedDrawableVariation(ped, 8)
            SetPedComponentVariation(ped, 8, curItem, item, 0)
            skinData["t-shirt"].texture = item
        end
    elseif clothingCategory == "vest" then
        if type == "item" then
            SetPedComponentVariation(ped, 9, item, 0, 2)
            skinData["vest"].item = item
        elseif type == "texture" then
            SetPedComponentVariation(ped, 9, skinData["vest"].item, item, 0)
            skinData["vest"].texture = item
        end
    elseif clothingCategory == "bag" then
        if type == "item" then
            SetPedComponentVariation(ped, 5, item, 0, 2)
            skinData["bag"].item = item
        elseif type == "texture" then
            SetPedComponentVariation(ped, 5, skinData["bag"].item, item, 0)
            skinData["bag"].texture = item
        end
    elseif clothingCategory == "decals" then
        if type == "item" then
            SetPedComponentVariation(ped, 10, item, 0, 2)
            skinData["decals"].item = item
        elseif type == "texture" then
            SetPedComponentVariation(ped, 10, skinData["decals"].item, item, 0)
            skinData["decals"].texture = item
        end
    elseif clothingCategory == "accessory" then
        if type == "item" then
            SetPedComponentVariation(ped, 7, item, 0, 2)
            skinData["accessory"].item = item
        elseif type == "texture" then
            SetPedComponentVariation(ped, 7, skinData["accessory"].item, item, 0)
            skinData["accessory"].texture = item
        end
    elseif clothingCategory == "torso2" then
        if type == "item" then
            SetPedComponentVariation(ped, 11, item, 0, 2)
            skinData["torso2"].item = item
        elseif type == "texture" then
            local curItem = GetPedDrawableVariation(ped, 11)
            SetPedComponentVariation(ped, 11, curItem, item, 0)
            skinData["torso2"].texture = item
        end
    elseif clothingCategory == "shoes" then
        if type == "item" then
            SetPedComponentVariation(ped, 6, item, 0, 2)
            skinData["shoes"].item = item
        elseif type == "texture" then
            local curItem = GetPedDrawableVariation(ped, 6)
            SetPedComponentVariation(ped, 6, curItem, item, 0)
            skinData["shoes"].texture = item
        end
    elseif clothingCategory == "mask" then
        if type == "item" then
            SetPedComponentVariation(ped, 1, item, 0, 2)
            skinData["mask"].item = item
        elseif type == "texture" then
            local curItem = GetPedDrawableVariation(ped, 1)
            SetPedComponentVariation(ped, 1, curItem, item, 0)
            skinData["mask"].texture = item
        end
    elseif clothingCategory == "hat" then
        if type == "item" then
            if item ~= -1 then
                SetPedPropIndex(ped, 0, item, skinData["hat"].texture, true)
            else
                ClearPedProp(ped, 0)
            end
            skinData["hat"].item = item
        elseif type == "texture" then
            SetPedPropIndex(ped, 0, skinData["hat"].item, item, true)
            skinData["hat"].texture = item
        end
    elseif clothingCategory == "glass" then
        if type == "item" then
            if item ~= -1 then
                SetPedPropIndex(ped, 1, item, skinData["glass"].texture, true)
                skinData["glass"].item = item
            else
                ClearPedProp(ped, 1)
            end
        elseif type == "texture" then
            SetPedPropIndex(ped, 1, skinData["glass"].item, item, true)
            skinData["glass"].texture = item
        end
    elseif clothingCategory == "ear" then
        if type == "item" then
            if item ~= -1 then
                SetPedPropIndex(ped, 2, item, skinData["ear"].texture, true)
            else
                ClearPedProp(ped, 2)
            end
            skinData["ear"].item = item
        elseif type == "texture" then
            SetPedPropIndex(ped, 2, skinData["ear"].item, item, true)
            skinData["ear"].texture = item
        end
    elseif clothingCategory == "watch" then
        if type == "item" then
            if item ~= -1 then
                SetPedPropIndex(ped, 6, item, skinData["watch"].texture, true)
            else
                ClearPedProp(ped, 6)
            end
            skinData["watch"].item = item
        elseif type == "texture" then
            SetPedPropIndex(ped, 6, skinData["watch"].item, item, true)
            skinData["watch"].texture = item
        end
    elseif clothingCategory == "bracelet" then
        if type == "item" then
            if item ~= -1 then
                SetPedPropIndex(ped, 7, item, skinData["bracelet"].texture, true)
            else
                ClearPedProp(ped, 7)
            end
            skinData["bracelet"].item = item
        elseif type == "texture" then
            SetPedPropIndex(ped, 7, skinData["bracelet"].item, item, true)
            skinData["bracelet"].texture = item
        end
    end

    if type ~= "texture" then
        GetMaxValues(true, clothingCategory)
    end
end

function ChangeToSkinNoUpdate(skin)
    local model = GetHashKey(skin)
    Citizen.CreateThread(function()
        RequestModel(model)
        while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 2)

        for k, v in pairs(skinData) do
            if skin == "mp_m_freemode_01" or skin == "mp_f_freemode_01" then
                ChangeVariation({
                    clothingType = k,
                    articleNumber = v.defaultItem,
                    type = "item",
                })
            else
                if k ~= "face" and k ~= "hair" and k ~= "face2" then
                    ChangeVariation({
                        clothingType = k,
                        articleNumber = v.defaultItem,
                        type = "item",
                    })
                end
            end

            if skin == "mp_m_freemode_01" or skin == "mp_f_freemode_01" then
                ChangeVariation({
                    clothingType = k,
                    articleNumber = v.defaultTexture,
                    type = "texture",
                })
            else
                if k ~= "face" and k ~= "hair" and k ~= "face2" then
                    ChangeVariation({
                        clothingType = k,
                        articleNumber = v.defaultTexture,
                        type = "texture",
                    })
                end
            end
        end
    end)
end

function SaveSkin()
    local model = GetEntityModel(PlayerPedId())
    local clothing = json.encode(skinData)
    TriggerServerEvent("sh-creation:saveSkin", model, clothing)
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

if Config.Framework == "qb" then
    AddEventHandler('onResourceStart', function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then return end
        PlayerData = QBCore.Functions.GetPlayerData()
    end)

    RegisterNetEvent('QBCore:Client:UpdateObject', function()
        QBCore = exports['qb-core']:GetCoreObject()
    end)
else
    AddEventHandler('onResourceStart', function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then return end
    end)
end

RegisterNetEvent('sh-creation:client:CreateCharacter')
AddEventHandler('sh-creation:client:CreateCharacter', function()
    if Config.Framework == "qb" then
        QBCore.Functions.GetPlayerData(function(pData)
            local skin = "mp_m_freemode_01"

            openMenu()

            if pData.charinfo.gender == 1 then
                skin = "mp_f_freemode_01"
            end

            ChangeToSkinNoUpdate(skin)
            SendNUIMessage({
                action = "ResetValues",
            })
        end)
    else
        local skin = "mp_m_freemode_01"

        openMenu()

        local gender = ESX.GetPlayerData().sex == "m" and 0 or 1

        if gender == 1 then
            skin = "mp_f_freemode_01"
        end

        ChangeToSkinNoUpdate(skin)
        SendNUIMessage({
            action = "ResetValues",
        })
    end
end)

RegisterNetEvent("sh-creation:loadSavedSkin")
AddEventHandler("sh-creation:loadSavedSkin", function(model, data)
    model = model ~= nil and tonumber(model) or false
    Citizen.CreateThread(function()
        RequestModel(model)
        while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 2)
        data = json.decode(data)
        TriggerEvent('sh-creation:client:loadData', data, PlayerPedId())
    end)
end)

RegisterNetEvent('sh-creation:client:loadData', function(data, ped)
    if ped == nil then ped = PlayerPedId() end

    for i = 0, 11 do
        SetPedComponentVariation(ped, i, 0, 0, 0)
    end

    for i = 0, 7 do
        ClearPedProp(ped, i)
    end

    if not data["facemix"] or not data["face2"] then
        data["facemix"] = skinData["facemix"]
        data["facemix"].shapeMix = data["facemix"].defaultShapeMix
        data["facemix"].skinMix = data["facemix"].defaultSkinMix
        data["face2"] = skinData["face2"]
    end

    SetPedHeadBlendData(ped, data["face"].item, data["face2"].item, nil, data["face"].texture, data["face2"].texture, nil,
        data["facemix"].shapeMix, data["facemix"].skinMix, nil, true)

    SetPedComponentVariation(ped, 4, data["pants"].item, 0, 0)
    SetPedComponentVariation(ped, 4, data["pants"].item, data["pants"].texture, 0)

    SetPedComponentVariation(ped, 2, data["hair"].item, 0, 0)
    SetPedHairColor(ped, data["hair"].texture, data["hair"].texture)

    SetPedHeadOverlay(ped, 2, data["eyebrows"].item, 1.0)
    SetPedHeadOverlayColor(ped, 2, 1, data["eyebrows"].texture, 0)

    SetPedHeadOverlay(ped, 1, data["beard"].item, 1.0)
    SetPedHeadOverlayColor(ped, 1, 1, data["beard"].texture, 0)

    SetPedHeadOverlay(ped, 5, data["blush"].item, 1.0)
    SetPedHeadOverlayColor(ped, 5, 1, data["blush"].texture, 0)

    SetPedHeadOverlay(ped, 8, data["lipstick"].item, 1.0)
    SetPedHeadOverlayColor(ped, 8, 1, data["lipstick"].texture, 0)

    SetPedHeadOverlay(ped, 4, data["makeup"].item, 1.0)
    SetPedHeadOverlayColor(ped, 4, 1, data["makeup"].texture, 0)

    SetPedHeadOverlay(ped, 3, data["ageing"].item, 1.0)
    SetPedHeadOverlayColor(ped, 3, 1, data["ageing"].texture, 0)

    SetPedComponentVariation(ped, 3, data["arms"].item, 0, 2)
    SetPedComponentVariation(ped, 3, data["arms"].item, data["arms"].texture, 0)

    SetPedComponentVariation(ped, 8, data["t-shirt"].item, 0, 2)
    SetPedComponentVariation(ped, 8, data["t-shirt"].item, data["t-shirt"].texture, 0)

    SetPedComponentVariation(ped, 9, data["vest"].item, 0, 2)
    SetPedComponentVariation(ped, 9, data["vest"].item, data["vest"].texture, 0)

    SetPedComponentVariation(ped, 11, data["torso2"].item, 0, 2)
    SetPedComponentVariation(ped, 11, data["torso2"].item, data["torso2"].texture, 0)

    SetPedComponentVariation(ped, 6, data["shoes"].item, 0, 2)
    SetPedComponentVariation(ped, 6, data["shoes"].item, data["shoes"].texture, 0)

    SetPedComponentVariation(ped, 1, data["mask"].item, 0, 2)
    SetPedComponentVariation(ped, 1, data["mask"].item, data["mask"].texture, 0)

    SetPedComponentVariation(ped, 10, data["decals"].item, 0, 2)
    SetPedComponentVariation(ped, 10, data["decals"].item, data["decals"].texture, 0)

    SetPedComponentVariation(ped, 7, data["accessory"].item, 0, 2)
    SetPedComponentVariation(ped, 7, data["accessory"].item, data["accessory"].texture, 0)

    SetPedComponentVariation(ped, 5, data["bag"].item, 0, 2)
    SetPedComponentVariation(ped, 5, data["bag"].item, data["bag"].texture, 0)

    if data["hat"].item ~= -1 and data["hat"].item ~= 0 then
        SetPedPropIndex(ped, 0, data["hat"].item, data["hat"].texture, true)
    else
        ClearPedProp(ped, 0)
    end

    if data["glass"].item ~= -1 and data["glass"].item ~= 0 then
        SetPedPropIndex(ped, 1, data["glass"].item, data["glass"].texture, true)
    else
        ClearPedProp(ped, 1)
    end

    if data["ear"].item ~= -1 and data["ear"].item ~= 0 then
        SetPedPropIndex(ped, 2, data["ear"].item, data["ear"].texture, true)
    else
        ClearPedProp(ped, 2)
    end

    if data["watch"].item ~= -1 and data["watch"].item ~= 0 then
        SetPedPropIndex(ped, 6, data["watch"].item, data["watch"].texture, true)
    else
        ClearPedProp(ped, 6)
    end

    if data["bracelet"].item ~= -1 and data["bracelet"].item ~= 0 then
        SetPedPropIndex(ped, 7, data["bracelet"].item, data["bracelet"].texture, true)
    else
        ClearPedProp(ped, 7)
    end

    if data["eye_color"].item ~= -1 and data["eye_color"].item ~= 0 then
        SetPedEyeColor(ped, data['eye_color'].item)
    end

    if data["moles"].item ~= -1 and data["moles"].item ~= 0 then
        SetPedHeadOverlay(ped, 9, data['moles'].item, (data['moles'].texture / 10))
    end

    SetPedFaceFeature(ped, 0, (data['nose_0'].item / 10))
    SetPedFaceFeature(ped, 1, (data['nose_1'].item / 10))
    SetPedFaceFeature(ped, 2, (data['nose_2'].item / 10))
    SetPedFaceFeature(ped, 3, (data['nose_3'].item / 10))
    SetPedFaceFeature(ped, 4, (data['nose_4'].item / 10))
    SetPedFaceFeature(ped, 5, (data['nose_5'].item / 10))
    SetPedFaceFeature(ped, 6, (data['eyebrown_high'].item / 10))
    SetPedFaceFeature(ped, 7, (data['eyebrown_forward'].item / 10))
    SetPedFaceFeature(ped, 8, (data['cheek_1'].item / 10))
    SetPedFaceFeature(ped, 9, (data['cheek_2'].item / 10))
    SetPedFaceFeature(ped, 10, (data['cheek_3'].item / 10))
    SetPedFaceFeature(ped, 11, (data['eye_opening'].item / 10))
    SetPedFaceFeature(ped, 12, (data['lips_thickness'].item / 10))
    SetPedFaceFeature(ped, 13, (data['jaw_bone_width'].item / 10))
    SetPedFaceFeature(ped, 14, (data['jaw_bone_back_lenght'].item / 10))
    SetPedFaceFeature(ped, 15, (data['chimp_bone_lowering'].item / 10))
    SetPedFaceFeature(ped, 16, (data['chimp_bone_lenght'].item / 10))
    SetPedFaceFeature(ped, 17, (data['chimp_bone_width'].item / 10))
    SetPedFaceFeature(ped, 18, (data['chimp_hole'].item / 10))
    SetPedFaceFeature(ped, 19, (data['neck_thikness'].item / 10))
    skinData = data
end)

RegisterNUICallback('mouseData', function(data)
    local ped = PlayerPedId()
    local heading = GetEntityHeading(ped)
    heading = heading + data.deltaX * 0.2
    SetEntityHeading(ped, heading)
end)

RegisterNUICallback('setupCam', function(data, cb)
    local value = data.value
    local pedPos = GetEntityCoords(PlayerPedId())
    if value == 1 then
        camOffset = 0.75
        local cx, cy = GetPositionByRelativeHeading(PlayerPedId(), headingToCam, camOffset)
        SetCamCoord(cam, cx, cy, pedPos.z + 0.65)
        PointCamAtCoord(cam, pedPos.x, pedPos.y, pedPos.z + 0.65)
    elseif value == 2 then
        camOffset = 1.0
        local cx, cy = GetPositionByRelativeHeading(PlayerPedId(), headingToCam, camOffset)
        SetCamCoord(cam, cx, cy, pedPos.z + 0.2)
        PointCamAtCoord(cam, pedPos.x, pedPos.y, pedPos.z + 0.2)
    elseif value == 3 then
        camOffset = 1.0
        local cx, cy = GetPositionByRelativeHeading(PlayerPedId(), headingToCam, camOffset)
        SetCamCoord(cam, cx, cy, pedPos.z + -0.5)
        PointCamAtCoord(cam, pedPos.x, pedPos.y, pedPos.z + -0.5)
    else
        camOffset = 2.0
        local cx, cy = GetPositionByRelativeHeading(PlayerPedId(), headingToCam, camOffset)
        SetCamCoord(cam, cx, cy, pedPos.z + 0.2)
        PointCamAtCoord(cam, pedPos.x, pedPos.y, pedPos.z + 0.2)
    end
    cb('ok')
end)

RegisterNUICallback('close', function(_, cb)
    SetNuiFocus(false, false)
    creatingCharacter = false
    disableCam()
    FreezeEntityPosition(PlayerPedId(), false)

    TriggerServerEvent('sh-creation:server:setBucket', 0)

    inShopping = false
    cb('ok')
end)

RegisterNUICallback('closeWithoutPay', function(_, cb)
    SetNuiFocus(false, false)
    creatingCharacter = false
    disableCam()
    FreezeEntityPosition(PlayerPedId(), false)

    TriggerServerEvent('sh-creation:server:setBucket', 0)

    inShopping = false

    TriggerEvent('sh-creation:client:loadData', json.decode(previousSkinData), PlayerPedId())
    cb('ok')
end)

RegisterNUICallback('updateSkin', function(data, cb)
    ChangeVariation(data)
    cb('ok')
end)

RegisterNUICallback('setGender', function(data, cb)
    if Config.Framework == "qb" then
        local playerData = QBCore.Functions.GetPlayerData()
        if data.gender == 0 then
            ChangeToSkinNoUpdate(Config.ManPlayerModel)
        else
            ChangeToSkinNoUpdate(Config.WomanPlayerModel)
        end
    else
        local gender = ESX.GetPlayerData().sex == "m" and 0 or 1

        if gender == 0 then
            ChangeToSkinNoUpdate(Config.ManPlayerModel)
        else
            ChangeToSkinNoUpdate(Config.WomanPlayerModel)
        end
    end
end)

local ped = PlayerPedId()

local cachedHeading = GetEntityHeading(ped)
local cachedCoords = GetEntityCoords(ped)

RegisterNUICallback('photoMode', function(data, cb)
    local ped = PlayerPedId()

    DoScreenFadeOut(500)
    Citizen.Wait(500)
    if data.status == false then
        SetEntityCoords(ped, cachedCoords.x, cachedCoords.y, cachedCoords.z - 1)
        SetEntityHeading(ped, cachedHeading)

        TriggerServerEvent('sh-creation:server:setBucket', 0)

        DoScreenFadeIn(500)
        enableCam()
    else
        cachedHeading = GetEntityHeading(ped)
        cachedCoords = GetEntityCoords(ped)

        ped = PlayerPedId()
        SetEntityCoords(ped, -1596.07, -1127.56, 1.26)
        SetEntityHeading(ped, 267.44)
        SetEntityVisible(ped, true)
        FreezeEntityPosition(ped, true)
        Citizen.Wait(500)
        DoScreenFadeIn(500)

        local bucket = math.random(0, 65535)

        TriggerServerEvent('sh-creation:server:setBucket', bucket)

        PointCamAtPedBone(cam, ped, 31086, 0.0, 0.0, 0.0, true)
        local coords = GetOffsetFromEntityInWorldCoords(ped, 0, 1.1, 0)
        SetCamCoord(cam, coords.x, coords.y, coords.z + 0.6)
        SetCamRot(cam, 0.0, 0.0, GetEntityHeading(ped) + 180)

        SetCamUseShallowDofMode(cam, true)
        SetCamNearDof(cam, 0.7)
        SetCamFarDof(cam, 5.3)
        SetCamDofStrength(cam, 1.0)

        while DoesCamExist(cam) do
            SetUseHiDof()
            Citizen.Wait(0)
        end
    end
end)

RegisterNUICallback('saveSkin', function(_, cb)
    SaveSkin()
    cb('ok')
end)

function SaveClothing()
    local model = GetEntityModel(PlayerPedId())
    local clothing = json.encode(skinData)
    TriggerServerEvent("sh-creation:saveSkin", model, clothing)
end

RegisterNUICallback('saveClothing', function(_, cb)
    SaveClothing()
    cb('ok')
end)

RegisterNUICallback('buyClothing', function(_, cb)
    if Config.Framework == "qb" then
        QBCore.Functions.TriggerCallback("sh-creation:server:buyClothing", function(data)
            cb(data)
        end, _.type)
    else
        ESX.TriggerServerCallback("sh-creation:server:buyClothing", function(data)
            cb(data)
        end, _.type)
    end
end)

RegisterNUICallback('saveSkinData', function(_, cb)
    local ped = PlayerPedId()
    local mugshot = GetMugShotBase64(ped, true)

    local data = {
        model = GetEntityModel(ped),
        skin = skinData,
        skin2 = _.values,
        mugshot = mugshot,
        type = _.type
    }

    if Config.Framework == "qb" then
        QBCore.Functions.TriggerCallback("sh-creation:saveSkinData", function(_data)
            cb(_data)
        end, data)
    else
        ESX.TriggerServerCallback("sh-creation:saveSkinData", function(_data)
            cb(_data)
        end, data)
    end
end)

RegisterNUICallback('loadSkinData', function(_, cb)
    if Config.Framework == "qb" then
        QBCore.Functions.TriggerCallback("sh-creation:getSkinData", function(data)
            if _.type == "clothing" or _.type == "clothing_room" then
                local cahcedSkinData = json.decode(data[1].skin)

                for k, v in pairs(cahcedSkinData) do
                    if clothingCategories[k] then
                        if clothingCategories[k].type == "variation" then
                            skinData[k].item = v.item
                            skinData[k].texture = v.texture
                        end
                    end
                end

                TriggerEvent('sh-creation:client:loadData', skinData, PlayerPedId())

                SendNUIMessage({
                    action = "setValues",
                    values = json.encode(skinData),
                })

                GetMaxValues(false, nil)
            elseif _.type == "barber" then
                local cahcedSkinData = json.decode(data[1].skin)

                for k, v in pairs(cahcedSkinData) do
                    if clothingCategories[k] then
                        if clothingCategories[k].type == "hair" then
                            skinData[k].item = v.item
                            skinData[k].texture = v.texture
                        end

                        if k == "beard" then
                            skinData[k].item = v.item
                            skinData[k].texture = v.texture
                        end
                    end
                end

                TriggerEvent('sh-creation:client:loadData', skinData, PlayerPedId())

                SendNUIMessage({
                    action = "setValues",
                    values = json.encode(skinData),
                })

                GetMaxValues(false, nil)
            elseif _.type == "surgery" then
                local cahcedSkinData = json.decode(data[1].skin)

                for k, v in pairs(cahcedSkinData) do
                    if clothingCategories[k] then
                        if clothingCategories[k].type == "overlay" then
                            if k ~= "beard" then
                                skinData[k].item = v.item
                                skinData[k].texture = v.texture
                            end
                        end

                        if clothingCategories[k].type == "face" then
                            if k == "facemix" then
                                skinData[k].skinMix = v.skinMix
                                skinData[k].shapeMix = v.shapeMix
                            else
                                skinData[k].item = v.item
                                skinData[k].texture = v.texture
                            end
                        end

                        if clothingCategories[k].type == "eye_color" then
                            skinData[k].item = v.item
                            skinData[k].texture = v.texture
                        end

                        if clothingCategories[k].type == "moles" then
                            skinData[k].item = v.item
                            skinData[k].texture = v.texture
                        end

                        if clothingCategories[k].type == "cheek" then
                            skinData[k].item = v.item
                            skinData[k].texture = v.texture
                        end

                        if clothingCategories[k].type == "nose" then
                            skinData[k].item = v.item
                            skinData[k].texture = v.texture
                        end

                        if clothingCategories[k].type == "chin" then
                            skinData[k].item = v.item
                            skinData[k].texture = v.texture
                        end
                    end
                end

                TriggerEvent('sh-creation:client:loadData', skinData, PlayerPedId())

                SendNUIMessage({
                    action = "setValues",
                    values = json.encode(skinData),
                })

                GetMaxValues(false, nil)
            else
                skinData = json.decode(data[1].skin)

                GetMaxValues(false, nil)

                TriggerEvent('sh-creation:client:loadData', skinData, PlayerPedId())

                GetMaxValues(false, nil)

                SendNUIMessage({
                    action = "setValues",
                    values = data[1].skin,
                })

                GetMaxValues(false, nil)

                SendNUIMessage({
                    action = "setValues",
                    values = data[1].skin,
                })

                GetMaxValues(false, nil)
            end
        end, _)
    else
        ESX.TriggerServerCallback("sh-creation:getSkinData", function(data)
            if _.type == "clothing" then
                local cahcedSkinData = json.decode(data[1].skin)

                for k, v in pairs(cahcedSkinData) do
                    if clothingCategories[k] then
                        if clothingCategories[k].type == "variation" then
                            skinData[k].item = v.item
                            skinData[k].texture = v.texture
                        end
                    end
                end

                TriggerEvent('sh-creation:client:loadData', skinData, PlayerPedId())

                SendNUIMessage({
                    action = "setValues",
                    values = json.encode(skinData),
                })

                GetMaxValues(false, nil)
            elseif _.type == "barber" then
                local cahcedSkinData = json.decode(data[1].skin)

                for k, v in pairs(cahcedSkinData) do
                    if clothingCategories[k] then
                        if clothingCategories[k].type == "hair" then
                            skinData[k].item = v.item
                            skinData[k].texture = v.texture
                        end

                        if k == "beard" then
                            skinData[k].item = v.item
                            skinData[k].texture = v.texture
                        end
                    end
                end

                TriggerEvent('sh-creation:client:loadData', skinData, PlayerPedId())

                SendNUIMessage({
                    action = "setValues",
                    values = json.encode(skinData),
                })

                GetMaxValues(false, nil)
            elseif _.type == "surgery" then
                local cahcedSkinData = json.decode(data[1].skin)

                for k, v in pairs(cahcedSkinData) do
                    if clothingCategories[k] then
                        if clothingCategories[k].type == "overlay" then
                            if k ~= "beard" then
                                skinData[k].item = v.item
                                skinData[k].texture = v.texture
                            end
                        end

                        if clothingCategories[k].type == "face" then
                            if k == "facemix" then
                                skinData[k].skinMix = v.skinMix
                                skinData[k].shapeMix = v.shapeMix
                            else
                                skinData[k].item = v.item
                                skinData[k].texture = v.texture
                            end
                        end

                        if clothingCategories[k].type == "eye_color" then
                            skinData[k].item = v.item
                            skinData[k].texture = v.texture
                        end

                        if clothingCategories[k].type == "moles" then
                            skinData[k].item = v.item
                            skinData[k].texture = v.texture
                        end

                        if clothingCategories[k].type == "cheek" then
                            skinData[k].item = v.item
                            skinData[k].texture = v.texture
                        end

                        if clothingCategories[k].type == "nose" then
                            skinData[k].item = v.item
                            skinData[k].texture = v.texture
                        end

                        if clothingCategories[k].type == "chin" then
                            skinData[k].item = v.item
                            skinData[k].texture = v.texture
                        end
                    end
                end

                TriggerEvent('sh-creation:client:loadData', skinData, PlayerPedId())

                SendNUIMessage({
                    action = "setValues",
                    values = json.encode(skinData),
                })

                GetMaxValues(false, nil)
            else
                skinData = json.decode(data[1].skin)

                GetMaxValues(false, nil)

                TriggerEvent('sh-creation:client:loadData', skinData, PlayerPedId())

                GetMaxValues(false, nil)

                SendNUIMessage({
                    action = "setValues",
                    values = data[1].skin,
                })

                GetMaxValues(false, nil)

                SendNUIMessage({
                    action = "setValues",
                    values = data[1].skin,
                })

                GetMaxValues(false, nil)
            end
        end, _)
    end
end)

RegisterNUICallback('deleteSkinData', function(_, cb)
    if Config.Framework == "qb" then
        QBCore.Functions.TriggerCallback("sh-creation:deleteSkinData", function(_data)
            cb(_data)
        end, _)
    else
        ESX.TriggerServerCallback("sh-creation:deleteSkinData", function(_data)
            cb(_data)
        end, _)
    end
end)

RegisterNUICallback('randomChar', function(data)
    local ped = PlayerPedId()
    local type = data.type
    local maxValues = GetMaxValues(false, nil, true)

    if type == "clothing" then
        for k, v in pairs(skinData) do
            if clothingCategories[k] then
                if clothingCategories[k].type == "variation" then
                    skinData[k].item = math.random(0, maxValues[k].item)
                    skinData[k].texture = math.random(0, maxValues[k].texture)
                end
            end
        end

        TriggerEvent('sh-creation:client:loadData', skinData, PlayerPedId())

        SendNUIMessage({
            action = "setValues",
            values = json.encode(skinData),
        })

        GetMaxValues(false, nil)
    elseif type == "surgery" then
        for k, v in pairs(skinData) do
            if clothingCategories[k] then
                if clothingCategories[k].type == "overlay" then
                    if k ~= "beard" then
                        skinData[k].item = math.random(0, maxValues[k].item)
                        skinData[k].texture = math.random(0, maxValues[k].texture)
                    end
                end

                if clothingCategories[k].type == "face" then
                    if k == "facemix" then
                        skinData[k].skinMix = math.random(0, maxValues[k].skinMix)
                        skinData[k].shapeMix = math.random(0, maxValues[k].shapeMix)
                    else
                        skinData[k].item = math.random(0, maxValues[k].item)
                        skinData[k].texture = math.random(0, maxValues[k].texture)
                    end
                end

                if clothingCategories[k].type == "eye_color" then
                    skinData[k].item = math.random(0, maxValues[k].item)
                    skinData[k].texture = math.random(0, maxValues[k].texture)
                end

                if clothingCategories[k].type == "moles" then
                    skinData[k].item = math.random(0, maxValues[k].item)
                    skinData[k].texture = math.random(0, maxValues[k].texture)
                end

                if clothingCategories[k].type == "cheek" then
                    skinData[k].item = math.random(0, maxValues[k].item)
                    skinData[k].texture = math.random(0, maxValues[k].texture)
                end

                if clothingCategories[k].type == "nose" then
                    skinData[k].item = math.random(0, maxValues[k].item)
                    skinData[k].texture = math.random(0, maxValues[k].texture)
                end

                if clothingCategories[k].type == "chin" then
                    skinData[k].item = math.random(0, maxValues[k].item)
                    skinData[k].texture = math.random(0, maxValues[k].texture)
                end
            end
        end

        TriggerEvent('sh-creation:client:loadData', skinData, PlayerPedId())

        SendNUIMessage({
            action = "setValues",
            values = json.encode(skinData),
        })

        GetMaxValues(false, nil)
    elseif type == "barber" then
        for k, v in pairs(skinData) do
            if clothingCategories[k] then
                if clothingCategories[k].type == "hair" then
                    skinData[k].item = math.random(0, maxValues[k].item)
                    skinData[k].texture = math.random(0, maxValues[k].texture)
                end

                if k == "beard" then
                    skinData[k].item = math.random(0, maxValues[k].item)
                    skinData[k].texture = math.random(0, maxValues[k].texture)
                end
            end
        end

        TriggerEvent('sh-creation:client:loadData', skinData, PlayerPedId())

        SendNUIMessage({
            action = "setValues",
            values = json.encode(skinData),
        })

        GetMaxValues(false, nil)
    else
        for k, v in pairs(skinData) do
            if clothingCategories[k] then
                skinData[k].item = math.random(0, maxValues[k].item)
                skinData[k].texture = math.random(0, maxValues[k].texture)
            end
        end

        TriggerEvent('sh-creation:client:loadData', skinData, PlayerPedId())

        SendNUIMessage({
            action = "setValues",
            values = json.encode(skinData),
        })

        GetMaxValues(false, nil)
    end
end)

function CreateBlip(blipConfig, coords)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, blipConfig.sprite)
    SetBlipColour(blip, blipConfig.color)
    SetBlipScale(blip, blipConfig.scale)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(blipConfig.name)
    EndTextCommandSetBlipName(blip)
    return blip
end

function SetupBlips()
    for k, _ in pairs(Config.Stores) do
        if _.type ~= "clothing_room" then
            local blipConfig = Config.BlipType[Config.Stores[k].type]
            if blipConfig.showBlip then
                local blip = CreateBlip(blipConfig, Config.Stores[k].coords)
                Blips[#Blips + 1] = blip
            end
        end
    end
end

Citizen.CreateThread(function()
    while true do
        if not inShopping then
            Citizen.Wait(0)

            for k, store in pairs(Config.Stores) do
                if store.inZone then
                    if IsControlJustPressed(0, 38) then
                        if Config.Framework == "qb" then
                            QBCore.Functions.GetPlayerData(function(pData)
                                if store.type == "clothing" then
                                    openClothingMenu()
                                elseif store.type == "barber" then
                                    openBarberMenu()
                                elseif store.type == "surgery" then
                                    openSurgeryMenu()
                                elseif store.type == "clothing_room" then
                                    local job = pData.job.name
                                    if job == store.job then
                                        openClothingRoomMenu()
                                    end
                                end
                            end)
                        else
                            if store.type == "clothing" then
                                openClothingMenu()
                            elseif store.type == "barber" then
                                openBarberMenu()
                            elseif store.type == "surgery" then
                                openSurgeryMenu()
                            elseif store.type == "clothing_room" then
                                xPlayer = ESX.GetPlayerData()
                                local job = xPlayer.job.name
                                if job == store.job then
                                    openClothingRoomMenu()
                                end
                            end
                        end

                        SendNUIMessage({
                            action = "contextClose"
                        })
                    end
                end
            end
        else
            Citizen.Wait(500)
        end
    end
end)

function enterZone(k)
    if not Config.Stores[k].inZone then
        if Config.Stores[k].type == "clothing" then
            Config.Stores[k].inZone = true

            if Config.Framework == "qb" then
                exports['qb-core']:DrawText('[E] - Clothing', 'left')
            else
                SendNUIMessage({
                    action = "contextOpen",
                    text = "Open Clothing",
                })
            end
        elseif Config.Stores[k].type == "barber" then
            Config.Stores[k].inZone = true

            if Config.Framework == "qb" then
                exports['qb-core']:DrawText('[E] - Barber', 'left')
            else
                SendNUIMessage({
                    action = "contextOpen",
                    text = "Open Barber",
                })
            end
        elseif Config.Stores[k].type == "surgery" then
            Config.Stores[k].inZone = true

            if Config.Framework == "qb" then
                exports['qb-core']:DrawText('[E] - Surgery', 'left')
            else
                SendNUIMessage({
                    action = "contextOpen",
                    text = "Open Surgery",
                })
            end
        elseif Config.Stores[k].type == "clothing_room" then
            QBCore.Functions.GetPlayerData(function(pData)
                local job = pData.job.name
                if Config.Stores[k].job == job then
                    Config.Stores[k].inZone = true

                    if Config.Framework == "qb" then
                        exports['qb-core']:DrawText('[E] - Clothing Room', 'left')
                    else
                        SendNUIMessage({
                            action = "contextOpen",
                            text = "Clothing Room",
                        })
                    end
                end
            end)
        end
    end
end

function leaveZone(k)
    if Config.Stores[k].inZone == true then
        if Config.Framework == "qb" then
            exports['qb-core']:HideText()
        else
            SendNUIMessage({
                action = "contextClose"
            })
        end
        Config.Stores[k].inZone = false
    end
end

Citizen.CreateThread(function()
    SetupBlips()

    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local inZone = false

        for k, store in pairs(Config.Stores) do
            local storeCoords = vector3(store.coords.x, store.coords.y, store.coords.z)
            local distance = #(coords - storeCoords)

            if distance < 4.0 then
                inZone = true
                enterZone(k)
            else
                leaveZone(k)
                inZone = false
            end
        end

        if not inZone then
            Citizen.Wait(500)
        end
    end
end)

RegisterNetEvent('sh-creation:client:openMenu')
AddEventHandler('sh-creation:client:openMenu', function()
    if Config.Framework == "qb" then
        QBCore.Functions.GetPlayerData(function(pData)
            local skin = "mp_m_freemode_01"

            openMenu()

            if pData.charinfo.gender == 1 then
                skin = "mp_f_freemode_01"
            end

            ChangeToSkinNoUpdate(skin)
            SendNUIMessage({
                action = "ResetValues",
            })
        end)
    else
        local skin = "mp_m_freemode_01"

        openMenu()

        local gender = ESX.GetPlayerData().sex == "m" and 0 or 1

        if gender == 1 then
            skin = "mp_f_freemode_01"
        end

        ChangeToSkinNoUpdate(skin)
        SendNUIMessage({
            action = "ResetValues",
        })
    end
end)

if Config.Framework ~= "qb" then
    RegisterCommand('reloadskin', function()
        local xPlayer = ESX.GetPlayerData()

        ESX.TriggerServerCallback('sh-creation:getCurrentSkinData', function(skin)
            local playerPed = PlayerPedId()
            TriggerEvent('sh-creation:client:loadData', skin, PlayerPedId())
        end)
    end)
end
