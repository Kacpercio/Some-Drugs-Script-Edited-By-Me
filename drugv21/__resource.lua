resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_scripts {
  '@es_extended/locale.lua',
  'locales/cs.lua',
  'locales/en.lua',
  'config.lua',
  'client/util.lua',
   'client/meth.lua',
   'client/weed.lua',
  'client/prodejC.lua',
  'client/opium.lua',
  'client/kokain.lua'
}


server_scripts {
  '@es_extended/locale.lua',
  '@ox_inventory/modules/Items',   
  'locales/cs.lua',
  'locales/en.lua',
  'config.lua',
  'server/weed.lua',
  'server/utily.lua',
  'config_server.lua',
  'server/prodejS.lua',
  'server/opium.lua',
  'server/meth.lua',
  'server/kokain.lua'
  
}