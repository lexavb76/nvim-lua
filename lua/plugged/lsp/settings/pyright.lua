local lsp = require("lspconfig")
local util = lsp.util
return {
    opts = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_dir = function(fname)
            local root_files = {
                'pyproject.toml',
                'setup.py',
                'setup.cfg',
                'requirements.txt',
                'Pipfile',
                'pyrightconfig.json',
            }
            return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname) or
                util.path.dirname(fname)
        end,
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "workspace",
                    useLibraryCodeForTypes = false,
                    typeCheckingMode = "off",
                },
            },
        },
    },
    setup = lsp.pyright.setup,
}
