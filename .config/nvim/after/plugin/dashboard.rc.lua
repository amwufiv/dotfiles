local status, db = pcall(require, "dashboard")



db.header_pad = 5
db.center_pad = 8
db.footer_pad = 0
db.custom_header = {
    '',
    '██╗   ██╗███████╗██╗██╗   ██╗',
    '██║   ██║██╔════╝██║██║   ██║',
    '██║   ██║█████╗  ██║██║   ██║',
    '██║   ██║██╔══╝  ██║╚██╗ ██╔╝',
    '╚██████╔╝██║     ██║ ╚████╔╝ ',
    ' ╚═════╝ ╚═╝     ╚═╝  ╚═══╝  ',
}

-- db.custom_header = {
--     '',
--     '  _    _ ______ _______      __',
--     ' | |  | |  ____|_   _\\ \\    / /',
--     ' | |  | | |__    | |  \\ \\  / / ',
--     ' | |  | |  __|   | |   \\ \\/ /  ',
--     ' | |__| | |     _| |_   \\  /   ',
--     '  \\____/|_|    |_____|   \\/     ',
--     '',
-- }

db.custom_center= {
  {
    icon = '  ',
    desc = 'Recently opened files                   ',
    action =  'Telescope oldfiles',
    shortcut = 'SPC f r'
  },
  {
    icon = '  ',
    desc = 'Find file                               ',
    action = 'Telescope find_files find_command=rg,--hidden,--files',
    shortcut = 'SPC f f'
  },
  {
    icon = '  ',
    desc = 'Find project                            ',
    action = 'Telescope projects',
    shortcut = 'SPC f p'
  }
}
db.custom_footer = {}
