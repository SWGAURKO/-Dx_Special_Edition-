fx_version("cerulean")
games({ "gta5" })
author("aliko. <Discord: aliko.>")
description("Fivem Job Creator Script, QB Framework")
version("1.0.1")
lua54("yes")

shared_scripts {
    "@ox_lib/init.lua", -- if you are using ox
    "shared/**/*"
}

client_scripts({
    "@PolyZone/client.lua",
    "@PolyZone/CircleZone.lua",
    "@PolyZone/ComboZone.lua",
    "client/variables.lua",
    "client/utils.lua",
    "client/classes.lua",
    "client/functions.lua",
    "client/events.lua",
    "client/nui.lua",
    "client/threads.lua"
});

server_scripts({
    "@oxmysql/lib/MySQL.lua",
    "server/variables.lua",
    "server/utils.lua",
    "server/classes.lua",
    "server/functions.lua",
    "server/callbacks.lua",
    "server/events.lua",
    "server/commands.lua",
    "server/threads.lua"
});

ui_page("web/build/index.html")

files({
    "locales/**/*",
    "web/build/index.html",
    "web/build/**/*"
})

dependencies {
    "PolyZone"
}

escrow_ignore {
    "locales/**/*",
    "shared/**/*",
    "client/**/*",
    "server/**/*",
    "web/**/*",
}

dependency '/assetpacks'