fx_version 'cerulean'
games { 'gta5' }

author 'alixithink'
description 'Los Santos Truck Simulator'
version '0.0.1'

resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

client_script {
    "config.lua",
    "@NativeUI/NativeUI.lua",
    "blips/c-blips.lua",
    "during/c-during.lua",
    "functions/c-functions.lua",
    "menu/c-menu.lua",
    "starting/c-starting.lua"
}
server_script {
    "config.lua",
    "s-script.lua"
}