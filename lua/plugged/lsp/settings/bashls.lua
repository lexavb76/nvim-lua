return {
    cmd = { "bash-language-server", "start" },
    cmd_env = {
          GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)"
    },
    filetypes = { "sh" },
    root_dir = require('lspconfig').util.find_git_ancestor,
    single_file_support = true
}
