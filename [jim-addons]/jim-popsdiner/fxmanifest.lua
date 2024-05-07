name "Jim-PopsDiner"
author "Jimathy"
version "1.6.3"
description "PopsDiner Script By Jimathy"
fx_version "cerulean"
game "gta5"
lua54 'yes'

client_scripts { '@PolyZone/client.lua', '@PolyZone/BoxZone.lua', '@PolyZone/EntityZone.lua', '@PolyZone/CircleZone.lua', '@PolyZone/ComboZone.lua', 'client/*.lua', }
server_scripts { 'server/*.lua' }
shared_scripts { 'config.lua', 'locales/*.lua', 'shared/*.lua' }