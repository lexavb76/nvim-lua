local pname = 'mason-lspconfig'
local try = require('user.utils').try
--local sleep = require('user.utils').sleep
local wait = 5
local res, plug = try(wait, require, pname) --try wait sec to load the module
if not res then
    print('Plugin "'..pname..'" is disabled.')
    return
end
--------------------------------------------------------------------------------
local inst_config =
{
    ensure_installed = {
        "bashls",
        "clangd",
        "pyright",
        "lua_ls",
    },

    -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
    -- This setting has no relation with the `ensure_installed` setting.
    -- Can either be:
    --   - false: Servers are not automatically installed.
    --   - true: All servers set up via lspconfig are automatically installed.
    --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
    --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
    automatic_installation = false,

    -- See `:h mason-lspconfig.setup_handlers()`
    ---@type table<string, fun(server_name: string)>?
    handlers = nil,
}

plug.setup(inst_config)

-- Register a handler that will be called for all installed servers.
-- You must create file with concrete LSP server settings: "../plugged.lsp.settings.<server.name>"
-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

local opts = {}

for _, server_name in pairs(inst_config.ensure_installed) do
    opts[server_name] = {
        on_attach    = require('plugged.lsp.handlers').on_attach,
        capabilities = require('plugged.lsp.handlers').capabilities,
    }
    local server = require("plugged.lsp.settings."..server_name)
    opts[server_name] = vim.tbl_deep_extend('force', server.opts, opts[server_name])
    server.setup(opts[server_name])
end
