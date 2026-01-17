fx_version 'cerulean'
game 'gta5'

name 'ls-armory'
author 'Azure(TheStoicBear)'
description 'Lore-friendly Weapon Shop (safe weapons + attachments) with Mors Mutual-style NUI'
version '1.0.0'

lua54 'yes'

shared_scripts {
  '@ox_lib/init.lua',
  'config.lua',
}

server_scripts {
  'config_server.lua',
  'server.lua',
}

client_scripts {
  'client.lua',
}

ui_page 'html/index.html'

files {
  'html/index.html',
  'html/style.css',
  'html/app.js',
  'html/assets/weapon_placeholder.svg',
}

dependencies {
  'ox_lib',
}
