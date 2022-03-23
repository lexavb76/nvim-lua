local lsp_installer = require('nvim-lsp-installer')

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = require('plugged.lsp.handlers').on_attach,
        capabilities = require('plugged.lsp.handlers').capabilities,
    }
    -- You must create file with concrete LSP server settings: "../plugged.lsp.settings.<server.name>"
    local server_opts = require("plugged.lsp.settings."..server.name)
    opts = vim.tbl_deep_extend('force', server_opts, opts)
    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)
