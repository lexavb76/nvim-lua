local pname = 'lualine'
local try = require('user.utils').try
local wait = 5
local res, plug = try(wait, require, pname) --try wait sec to load the module
if not res then
    print('Plugin "'..pname..'" is disabled.')
    return
end
--------------------------------------------------------------------------------
plug.setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
    },

    --[[ Available components:
        branch (git branch)
        buffers (shows currently available buffers)
        diagnostics (diagnostics count from your preferred source)
        diff (git diff status)
        encoding (file encoding)
        fileformat (file format)
        filename
        filesize
        filetype
        hostname
        location (location in file in line:column format)
        mode (vim mode)
        progress (%progress in file)
        tabs (shows currently available tabs) ]]

    -- |lualine_a|lualine_b|lualine_c|_____________________________________|lualine_x|lualine_y|lualine_z|
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress', 'filesize'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}
