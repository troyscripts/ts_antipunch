fx_version 'cerulean'
game 'gta5'

author 'Troy Scripts'
description 'Anti weapon whip, combatcontrole en first person; vereist ts_bridge 0.0.5'
version '1.8.4'

-- Bestaande laadvolgorde behouden: teksten, config, bridgecontrole, configcontrole.
shared_scripts {
    'locales/*.lua',
    'shared/locale.lua',
    'config/config.lua',
    'shared/bridge_check.lua',
    'shared/config_check.lua'
}

client_script 'client/main.lua'
server_script 'server/main.lua'

dependency 'ts_bridge'
ts_bridge_min_version '0.0.5'
