fx_version "cerulean"
game "gta5"
version "v1.0.4"

ui_page "nui/index.html"

files {
	"nui/index.html",
	"nui/assets/**/*.*",
} 

shared_scripts {
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
	"@mysql-async/lib/MySQL.lua",
    'bridge/**/server.lua',
	"server.lua",
}

lua54 'yes'
