fx_version 'bodacious'
game 'gta5'

client_scripts {
    -- Strip these out when not actively testing
    '@night-game/lib/shared/required.lua',
    '@night-game/lib/shared/logging.lua',
    '@night-game/lib/client/debug.lua',

    'cl_floaty.lua',
    'rendertarget.lua',

    -- Disable when not in use!
    'testing.lua',
}

description 'Convenient little render targets, all floaty and ready to draw on!'
author 'Demonen'
