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

--local tree_cb = require('nvim-tree.config').nvim_tree_callback

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function get_opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end


  -- Default mappings. Feel free to modify or remove as you wish.
  --
  -- BEGIN_DEFAULT_ON_ATTACH
  vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node,          get_opts('CD'))
  vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer,     get_opts('Open: In Place'))
  vim.keymap.set('n', '<C-k>', api.node.show_info_popup,              get_opts('Info'))
  vim.keymap.set('n', '<C-r>', api.fs.rename_sub,                     get_opts('Rename: Omit Filename'))
  vim.keymap.set('n', '<C-t>', api.node.open.tab,                     get_opts('Open: New Tab'))
  vim.keymap.set('n', '<C-v>', api.node.open.vertical,                get_opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>', api.node.open.horizontal,              get_opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<BS>',  api.node.navigate.parent_close,        get_opts('Close Directory'))
  vim.keymap.set('n', '<CR>',  api.node.open.edit,                    get_opts('Open'))
  vim.keymap.set('n', '<Tab>', api.node.open.preview,                 get_opts('Open Preview'))
  vim.keymap.set('n', '>',     api.node.navigate.sibling.next,        get_opts('Next Sibling'))
  vim.keymap.set('n', '<',     api.node.navigate.sibling.prev,        get_opts('Previous Sibling'))
  vim.keymap.set('n', '.',     api.node.run.cmd,                      get_opts('Run Command'))
  vim.keymap.set('n', '-',     api.tree.change_root_to_parent,        get_opts('Up'))
  vim.keymap.set('n', 'a',     api.fs.create,                         get_opts('Create'))
  vim.keymap.set('n', 'bmv',   api.marks.bulk.move,                   get_opts('Move Bookmarked'))
  vim.keymap.set('n', 'B',     api.tree.toggle_no_buffer_filter,      get_opts('Toggle No Buffer'))
  vim.keymap.set('n', 'c',     api.fs.copy.node,                      get_opts('Copy'))
  vim.keymap.set('n', 'C',     api.tree.toggle_git_clean_filter,      get_opts('Toggle Git Clean'))
  vim.keymap.set('n', '[c',    api.node.navigate.git.prev,            get_opts('Prev Git'))
  vim.keymap.set('n', ']c',    api.node.navigate.git.next,            get_opts('Next Git'))
  vim.keymap.set('n', 'd',     api.fs.remove,                         get_opts('Delete'))
  vim.keymap.set('n', 'D',     api.fs.trash,                          get_opts('Trash'))
  vim.keymap.set('n', 'E',     api.tree.expand_all,                   get_opts('Expand All'))
  vim.keymap.set('n', 'e',     api.fs.rename_basename,                get_opts('Rename: Basename'))
  vim.keymap.set('n', ']e',    api.node.navigate.diagnostics.next,    get_opts('Next Diagnostic'))
  vim.keymap.set('n', '[e',    api.node.navigate.diagnostics.prev,    get_opts('Prev Diagnostic'))
  vim.keymap.set('n', 'F',     api.live_filter.clear,                 get_opts('Clean Filter'))
  vim.keymap.set('n', 'f',     api.live_filter.start,                 get_opts('Filter'))
  vim.keymap.set('n', 'g?',    api.tree.toggle_help,                  get_opts('Help'))
  vim.keymap.set('n', 'gy',    api.fs.copy.absolute_path,             get_opts('Copy Absolute Path'))
  vim.keymap.set('n', 'H',     api.tree.toggle_hidden_filter,         get_opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'I',     api.tree.toggle_gitignore_filter,      get_opts('Toggle Git Ignore'))
  vim.keymap.set('n', 'J',     api.node.navigate.sibling.last,        get_opts('Last Sibling'))
  vim.keymap.set('n', 'K',     api.node.navigate.sibling.first,       get_opts('First Sibling'))
  vim.keymap.set('n', 'm',     api.marks.toggle,                      get_opts('Toggle Bookmark'))
  vim.keymap.set('n', 'o',     api.node.open.edit,                    get_opts('Open'))
  vim.keymap.set('n', 'O',     api.node.open.no_window_picker,        get_opts('Open: No Window Picker'))
  vim.keymap.set('n', 'p',     api.fs.paste,                          get_opts('Paste'))
  vim.keymap.set('n', 'P',     api.node.navigate.parent,              get_opts('Parent Directory'))
  vim.keymap.set('n', 'q',     api.tree.close,                        get_opts('Close'))
  vim.keymap.set('n', 'r',     api.fs.rename,                         get_opts('Rename'))
  vim.keymap.set('n', 'R',     api.tree.reload,                       get_opts('Refresh'))
  vim.keymap.set('n', 's',     api.node.run.system,                   get_opts('Run System'))
  vim.keymap.set('n', 'S',     api.tree.search_node,                  get_opts('Search'))
  vim.keymap.set('n', 'U',     api.tree.toggle_custom_filter,         get_opts('Toggle Hidden'))
  vim.keymap.set('n', 'W',     api.tree.collapse_all,                 get_opts('Collapse'))
  vim.keymap.set('n', 'x',     api.fs.cut,                            get_opts('Cut'))
  vim.keymap.set('n', 'y',     api.fs.copy.filename,                  get_opts('Copy Name'))
  vim.keymap.set('n', 'Y',     api.fs.copy.relative_path,             get_opts('Copy Relative Path'))
  vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,           get_opts('Open'))
  vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, get_opts('CD'))
  -- END_DEFAULT_ON_ATTACH


  -- Mappings migrated from view.mappings.list
  --
  -- You will need to insert "your code goes here" for any mappings with a custom action_cb
  vim.keymap.set('n', 'l', api.node.open.edit, get_opts('Open'))
  vim.keymap.set('n', '<CR>', api.node.open.edit, get_opts('Open'))
  vim.keymap.set('n', '<C-CR>', api.node.open.no_window_picker, get_opts('Open: No Window Picker'))
  vim.keymap.set('n', 'h', api.tree.toggle_help, get_opts('Help'))
  vim.keymap.set('n', 'O', api.tree.change_root_to_node, get_opts('CD'))
  vim.keymap.set('n', 'o', api.node.open.preview, get_opts('Open Preview'))
  vim.keymap.set('n', 'v', api.node.open.vertical, get_opts('Open: Vertical Split'))

end

-- setup function must go the last:
plug.setup {
    on_attach = on_attach,
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
        side = "left",
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
