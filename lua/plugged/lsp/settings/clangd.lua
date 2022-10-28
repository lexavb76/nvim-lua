local util = require 'lspconfig/util'
local root_pattern = util.root_pattern
return {
    opts = {
        cmd = { "clangd" },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        root_dir = root_pattern(
                '.clangd',
                '.clang-tidy',
                '.clang-format',
                'compile_commands.json',
                'compile_flags.txt',
                'configure.ac',
                '.git'
            ),
        single_file_support = true,
    },
    setup = require("lspconfig").clangd.setup,
}
