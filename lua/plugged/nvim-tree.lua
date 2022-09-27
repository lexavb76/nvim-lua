local pname = 'nvim-tree'
local try = require('user.utils').try
local wait = 5
local res, plug = try(wait, require, pname) --try wait sec to load the module
if not res then
    print('Plugin "'..pname..'" is disabled.')
    return
end
--------------------------------------------------------------------------------
-- Keymappings:
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
-- (which-key plugin style)
local wk_opts = {
    mode = "n", -- NORMAL mode
    prefix = "",
    buffer = nil, -- nil: Global mappings. 0: Current buffer. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps (in this case mappings are remapped)
    nowait = true, -- use `nowait` when creating keymaps
}
local status, wk  = pcall(require, 'which-key')
if status then
    local mappings= {
        ['<leader>e'] = {'<cmd>NvimTreeToggle<CR> | <cmd>NvimTreeRefresh<CR>', 'File explorer toggle'},
    }
    wk.register(mappings, wk_opts)
else
    -- Old style
    map('n', '<Leader>e', ':NvimTreeToggle<CR> | :NvimTreeRefresh<CR>', opts) --Toggle file tree
end
--------------------------------------------------------------------------------
vim.cmd([[autocmd  user_config  BufWritePre  plugins.lua  NvimTreeClose]])

local tree_cb = require('nvim-tree.config').nvim_tree_callback

-- setup function must go the last:
plug.setup {
    disable_netrw = false, -- Completely disable netrw, default: `false`
    hijack_netrw = true,   -- Hijack netrw windows (overriden if |disable_netrw| is `true`), default: `true`
    hijack_cursor = true,                    -- Keeps the cursor on the first letter of the filename
    update_cwd = true,                       -- Changes the tree root directory on `DirChanged` and refreshes
    respect_buf_cwd = true,                  -- Will change cwd of nvim-tree to that of new buffer's when opening nvim-tree. false by default.
    update_focused_file = {                  -- Update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
        enable      = true,
        update_cwd  = true,                  -- Update the root directory of the tree to the one of the folder containing the file
        ignore_list = {                      -- List of buffer names and filetypes that will not update the root dir of the tree
        },
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
    actions = {
        open_file = {
            quit_on_open = false,            -- Quit explorer after file is opened (Better to keep false for proper exploring)
            resize_window = false,
            window_picker = {
                enable = false,              -- Pick windows when opens new file
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                exclude = {
                    filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                    buftype = { "nofile", "terminal", "help" },
                },
            },
        },
    },
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    view = {
        width = 30,
        hide_root_folder = false,
        side = "left",
        mappings = {
            custom_only = false,
            list = {
                -- key = table of strings or string,
                -- mode = string (vim-mode),
                -- cb = callback function as a string
                { key = { "l", "<CR>" }, cb = tree_cb "edit" },
                { key = "<C-CR>", cb = tree_cb "edit_no_picker" },
                { key = "h", cb = tree_cb "toggle_help" },
                { key = "O", cb = tree_cb "cd" },
                { key = "o", cb = tree_cb "preview" },
                { key = "v", cb = tree_cb "vsplit" },
            },
        },
        number = false,
        relativenumber = false,
    },
    renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = true,              -- Enable file highlight for git attributes by setting this property.
        full_name = false,
        highlight_opened_files = "all",    -- "icon | name | all". Enable highligting for file icons or folders' namew or both.

        root_folder_modifier = ":~",
        indent_width = 2,
        indent_markers = {
          enable = false,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
        icons = {
          webdev_colors = true,
          git_placement = "before",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
    },

    --[[
    },
    open_on_setup = false,
    ignore_ft_on_setup = {
        "startify",
        "dashboard",
        "alpha",
    },
    auto_close = true,
    open_on_tab = false,
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
    trash = {
        cmd = "trash",
        require_confirm = true,
    },
    quit_on_open = 0,
    root_folder_modifier = ":t",
    show_icons = {
        git = 1,
        folders = 1,
        files = 1,
        folder_arrows = 1,
        tree_width = 30,
    },
    --]]
}
