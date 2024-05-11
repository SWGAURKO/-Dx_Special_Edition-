-- Originally updated 2024-01-29 with .fxap removed
-- Shared by https://discord.gg/zarevstore | UltimateLeaks 

fx_version 'bodacious'
game 'gta5'

description 'izzy-multichar'
version '1.0.0'

ui_page 'html/index.html'

shared_script {
    'config.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

client_scripts {
    'client/main.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/img/*.*',
    'html/js/*.js',
}

lua54 'yes'
dependency '/assetpacks'