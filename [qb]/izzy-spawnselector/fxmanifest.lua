-- Originally updated 2024-03-28 with .fxap removed
-- Shared by https://discord.gg/zarevstore | UltimateLeaks 

fx_version 'adamant'
lua54 'on'
game 'gta5'

author "GENER4L"

description 'Spawn Selector for Izzy Shop'


ui_page "html/index.html"

files {
    'html/**/**.**'
}

client_script { 
    "config.lua",
    "main/client.lua"
}

server_script { 
    '@mysql-async/lib/MySQL.lua',
    "settings.lua",
    "config.lua",
    "main/server.lua",
}

resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

dependency '/assetpacks'
dependency '/assetpacks'