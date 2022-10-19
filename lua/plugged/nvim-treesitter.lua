local pname = 'nvim-treesitter.configs'
local try = require('user.utils').try
local wait = 5
local res, plug = try(wait, require, pname) --try wait sec to load the module
if not res then
    print('Plugin "'..pname..'" is disabled.')
    return
end
--------------------------------------------------------------------------------
plug.setup {
    ensure_installed = "all", -- "all", or a list of languages
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    ignore_install = { "" }, -- List of parsers to ignore installing
    autopairs = {
        enable = true,
    },
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = { "" }, -- list of language that will be disabled
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true, disable = { "" } },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
}
