Config = {}
--------------------------------
-- [Date Format]

Config.DateFormat = '%H:%M' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

-- [Staff Groups]

Config.StaffGroups = {
	'god',
	'admin'
}

--------------------------------
-- [Clear Player Chat]

Config.AllowPlayersToClearTheirChat = true

Config.ClearChatCommand = 'clear'

--------------------------------
-- [Staff]

Config.EnableStaffCommand = false

Config.StaffCommand = 'staff'

Config.AllowStaffsToClearEveryonesChat = true

Config.ClearEveryonesChatCommand = 'clearall'

-- [Staff Only Chat]

Config.EnableStaffOnlyCommand = false

Config.StaffOnlyCommand = 'staffchat'

--------------------------------
-- [Advertisements]

Config.EnableAdvertisementCommand = false

Config.AdvertisementCommand = 'ad'

Config.AdvertisementPrice = 10000

Config.AdvertisementCooldown = 5 -- in minutes

--------------------------------
-- [Twitch]

Config.EnableTwitchCommand = false

Config.TwitchCommand = 'event'

-- Types of identifiers: license: | xbl: | live: | discord: | fivem: | ip:
Config.TwitchList = {
	'license:db52328bb7966675e7ab83cd14ebb8eadb3235cc' -- Example, change this
}

--------------------------------
-- [Youtube]

Config.EnableYoutubeCommand = false

Config.YoutubeCommand = 'youtube'

-- Types of identifiers: steam: | license: | xbl: | live: | discord: | fivem: | ip:
Config.YoutubeList = {
	'license:db52328bb7966675e7ab83cd14ebb8eadb3235cc' -- Example, change this
}

--------------------------------
-- [Twitter]

Config.EnableTwitterCommand = false

Config.TwitterCommand = 'twitter'

--------------------------------
-- [Police]

Config.EnablePoliceCommand = true

Config.PoliceCommand = 'police'

Config.PoliceJobName = 'police'

--------------------------------
-- [Ambulance]

Config.EnableAmbulanceCommand = true

Config.AmbulanceCommand = 'ambulance'

Config.AmbulanceJobName = 'ambulance'

--------------------------------
-- [OOC]

Config.EnableOOCCommand = false

Config.OOCCommand = 'ooc'

Config.OOCDistance = 150.0

--------------------------------