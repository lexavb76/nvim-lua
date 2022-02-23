-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
--[[
" vimrc
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.
let g:nvim_tree_create_in_closed_folder = 0 "1 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'notify',
    \     'packer',
    \     'qf'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }
" Dictionary of buffer option names mapped to a list of option values that
" indicates to the window picker that the buffer's window should not be
" selectable.
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 0,
    \ 'files': 0,
    \ 'folder_arrows': 0,
    \ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath.
"if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
"but this will not work when you set indent_markers (because of UI conflict)

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   }
    \ }

nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" NvimTreeOpen, NvimTreeClose, NvimTreeFocus, NvimTreeFindFileToggle, and NvimTreeResize are also available if you need them

set termguicolors " this variable must be enabled for colors to be applied properly

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue
--]]

-- Keymappings:
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map('n', '<Leader>e', ':NvimTreeToggle<CR>', opts) --Toggle file tree
--------------------------------------------------------------------------------
vim.g.nvim_tree_highlight_opened_files = 3   -- Enable highligting for folders and both file icons and names.
vim.g.nvim_tree_disable_window_picker = 1    -- Don't pick windows when opens new file
vim.g.nvim_tree_git_hl = 1                   -- Enable file highlight for git attributes by setting this property.
vim.g.nvim_tree_respect_buf_cwd = 1          -- 0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
vim.cmd([[ autocmd  user_config  BufWritePre  plugins.lua  NvimTreeClose ]])

local tree_cb = require('nvim-tree.config').nvim_tree_callback

-- setup function must go the last:
require('nvim-tree').setup {
    disable_netrw = false, -- Completely disable netrw, default: `false`
    hijack_netrw = true,   -- Hijack netrw windows (overriden if |disable_netrw| is `true`), default: `true`
    hijack_cursor = true,                    -- Keeps the cursor on the first letter of the filename
    update_cwd = true,                       -- Changes the tree root directory on `DirChanged` and refreshes
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
        },
    },
    update_to_buf_dir = {
        enable = true,
        auto_open = true,
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
