-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
vim.g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
        unstaged = "",
        staged = "S",
        unmerged = "",
        renamed = "➜",
        deleted = "",
        untracked = "U",
        ignored = "◌",
    },
    folder = {
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
    },
}

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
    return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

vim.g.nvim_tree_highlight_opened_files = 3   -- Enable highligting for folders and both file icons and names.
vim.g.nvim_tree_disable_window_picker = 1    -- Don't pick windows when opens new file
vim.g.nvim_tree_git_hl = 1                   -- Enable file highlight for git attributes by setting this property.
vim.cmd([[ autocmd  user_config  BufWritePre  plugins.lua  NvimTreeClose ]])

-- setup function must go the last:
nvim_tree.setup {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {
        "startify",
        "dashboard",
        "alpha",
    },
    auto_close = true,
    open_on_tab = false,
    hijack_cursor = true,                    -- Keeps the cursor on the first letter of the filename
    update_cwd = true,                       -- Changes the tree root directory on `DirChanged` and refreshes
    update_to_buf_dir = {
        enable = true,
        auto_open = true,
    },
    diagnostics = {                          -- Show LSP diagnostics in the signcolumn
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    update_focused_file = {                  -- Update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
        enable      = true,
        update_cwd  = true,                  -- Update the root directory of the tree to the one of the folder containing the file
        ignore_list = {                      -- List of buffer names and filetypes that will not update the root dir of the tree
        },
    },
    system_open = {
        cmd = nil,
        args = {},
    },
    filters = {
        dotfiles = false,
        custom = {},
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 500,
    },
    view = {
        width = 30,
        height = 30,
        hide_root_folder = false,
        side = "left",
        auto_resize = true,
        mappings = {
            custom_only = false,
            list = {
                -- key = table of strings or string,
                -- mode = string (vim-mode),
                -- cb = callback function as a string
                { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
                { key = "h", cb = tree_cb "close_node" },
                { key = "v", cb = tree_cb "vsplit" },
            },
        },
        number = false,
        relativenumber = false,
    },
    actions = {
        open_file = {
            quit_on_open = false,            -- Quit explorer after file is opened (Better to keep false for proper exploring)
        },
    },
    trash = {
        cmd = "trash",
        require_confirm = true,
    },
    quit_on_open = 0,
    git_hl = 1,
    disable_window_picker = 0,
    root_folder_modifier = ":t",
    show_icons = {
        git = 1,
        folders = 1,
        files = 1,
        folder_arrows = 1,
        tree_width = 30,
    },
}
