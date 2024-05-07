name "Jim-Bars"
author "Jimathy"
version "v1.2.2"
description "Bar Job Script By Jimathy"
fx_version "cerulean"
game "gta5"

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	'client/*.lua',
}

server_scripts { 'server/server.lua' }

shared_scripts { 'config.lua', 'locations/*.lua', 'locales/*.lua', 'shared/*.lua' }

lua54 'yes'