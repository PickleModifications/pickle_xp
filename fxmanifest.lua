fx_version "cerulean"
game "gta5"
version "v1.1.0"
author "Pickle Mods - Updated for QBox & ox_lib"
description "XP System with multi-framework support"

ui_page "nui/index.html"

files {
	"nui/index.html",
	"nui/assets/**/*.*",
} 

shared_scripts {
	'@ox_lib/init.lua',
	"config.lua",
	"locales/locale.lua",
    "locales/translations/*.lua",
	"shared.lua",
}

client_scripts {
    'bridge/**/client.lua',
	"client.lua",
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
    'bridge/**/server.lua',
	"server.lua",
}

dependencies {
	'oxmysql',
	'ox_lib'
}

lua54 'yes'
