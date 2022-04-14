local pname = 'gitsigns'
local try = require('user.utils').try
local wait = 5
local res, plug = try(wait, require, pname) --try wait sec to load the module
if not res then
    print('Plugin "'..pname..'" is disabled.')
    return
end
--------------------------------------------------------------------------------
plug.setup {
    signs = {
        add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        interval = 1000,
        follow_files = true
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    yadm = {
        enable = false
    },
    on_attach = function(bufnr)
        -- Keymappings:
        -- (which-key plugin style)
        local status, wk = pcall(require, 'which-key')
        local opts = {
            mode = "n", -- NORMAL mode
            prefix = "",
            buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps (in this case mappings are remapped)
            nowait = true, -- use `nowait` when creating keymaps
            expr = true,
        }
        local mappings = {
            ['n'] = {
                [']c'] = {"&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", 'Next hunk'},
                ['[c'] = {"&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", 'Prev hunk'},
                ['<leader>g'] = {
                    name = 'git',
                    ['s'] = {"v:true ? ':Gitsigns stage_hunk<CR>' : ''", 'Stage hunk'}, --v:true hack is needed because expr=true option is set
                    ['r'] = {"v:true ? ':Gitsigns reset_hunk<CR>' : ''", 'Reset hunk'},
                    ['S'] = {"v:true ? '<cmd>Gitsigns stage_buffer<CR>' : ''", 'Stage buffer'},
                    ['u'] = {"v:true ? '<cmd>Gitsigns undo_stage_hunk<CR>' : ''", 'Undo Stage hunk'},
                    ['R'] = {"v:true ? '<cmd>Gitsigns reset_buffer<CR>' : ''", 'Reset buffer'},
                    ['p'] = {"v:true ? '<cmd>Gitsigns preview_hunk<CR>' : ''", 'Preview hunk'},
                    ['B'] = {[[v:true ? '<cmd>lua require"gitsigns".blame_line{full=true}<CR>' : '']], 'Git blame'},
                    ['b'] = {"v:true ? '<cmd>Gitsigns toggle_current_line_blame<CR>' : ''", 'Toggle line blame'},
                    ['d'] = {"v:true ? '<cmd>Gitsigns diffthis<CR>' : ''", 'Diff against index'},
                    ['D'] = {[[v:true ? '<cmd>lua require"gitsigns".diffthis("~1")<CR>' : '']], 'Diff against previous commit'},
                    ['t'] = {"v:true ? '<cmd>Gitsigns toggle_deleted<CR>' : ''", 'Toggle deleted'},
                },
            },
            ['v'] = {
                ['<leader>g'] = {
                    name = 'git',
                    ['s'] = {"v:true ? ':Gitsigns stage_hunk<CR>' : ''", 'Stage hunk'},
                    ['r'] = {"v:true ? ':Gitsigns reset_hunk<CR>' : ''", 'Reset hunk'},
                },
            },
            ['o'] = { --TODO: doesn't work
                ['ih'] = {"v:true ? ':<C-U>Gitsigns select_hunk<CR>' : ''", 'Select hunk'},
            },
            ['x'] = {
                ['ih'] = {"v:true ? ':<C-U>Gitsigns select_hunk<CR>' : ''", 'Select hunk'},
            },
        }
        for mode, mapping in pairs(mappings) do
            if status then
                opts.mode = mode
                wk.register(mapping, opts)
            else
                -- Old style:
                local function map(mod, lhs, rhs, op)
                    op = vim.tbl_extend('force', {noremap = true, silent = true}, op or {})
                    vim.api.nvim_buf_set_keymap(bufnr, mod, lhs, rhs, op)
                end
                -- Navigation
                map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
                map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

                -- Actions
                map('n', '<leader>gs', ':Gitsigns stage_hunk<CR>')
                map('v', '<leader>gs', ':Gitsigns stage_hunk<CR>')
                map('n', '<leader>gr', ':Gitsigns reset_hunk<CR>')
                map('v', '<leader>gr', ':Gitsigns reset_hunk<CR>')
                map('n', '<leader>gS', '<cmd>Gitsigns stage_buffer<CR>')
                map('n', '<leader>gu', '<cmd>Gitsigns undo_stage_hunk<CR>')
                map('n', '<leader>gR', '<cmd>Gitsigns reset_buffer<CR>')
                map('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<CR>')
                map('n', '<leader>gB', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
                map('n', '<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
                map('n', '<leader>gd', '<cmd>Gitsigns diffthis<CR>')
                map('n', '<leader>gD', '<cmd>lua require"gitsigns".diffthis("~1")<CR>')
                map('n', '<leader>gt', '<cmd>Gitsigns toggle_deleted<CR>')

                -- Text object
                map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>') --TODO: doesn't work
                map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            end
        end
    end,
}

