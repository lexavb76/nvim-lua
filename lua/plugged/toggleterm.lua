local toggleterm = require("toggleterm")

toggleterm.setup({
    size = 20,
    open_mapping = '<leader>t',
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 1,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float", -- 'horizontal', 'vertical', 'tab', 'float'
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})

local opts = {noremap = true}
-- Keymappings
function _G.set_terminal_keymaps()
    local map = vim.api.nvim_buf_set_keymap
    map(0, 't', '<Esc>', '<C-\\><C-n>',       opts) -- ESC exit to normal mode in terminal
    map(0, "t", "<C-h>", "<C-\\><C-n><C-w>h", opts) -- Windows navigation
    map(0, "t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
    map(0, "t", "<C-k>", "<C-\\><C-n><C-w>k", opts)
    map(0, "t", "<C-l>", "<C-\\><C-n><C-w>l", opts)
    map(0, "t", "<A-j>", "<C-\\><C-n>:bnext<CR>",     opts)
    map(0, "t", "<A-k>", "<C-\\><C-n>:bprevious<CR>", opts)
    map(0, "t", "<A-C-j>", "<C-\\><C-n>:tabnext<CR>",     opts)
    map(0, "t", "<A-C-k>", "<C-\\><C-n>:tabprevious<CR>", opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
-- vim.cmd('autocmd! TermOpen term://* lua require("toggleterm.terminal").Terminal:change_dir(vim.fn.getcwd())')

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end

local node = Terminal:new({ cmd = "node", hidden = true })

function _NODE_TOGGLE()
    node:toggle()
end

local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })

function _NCDU_TOGGLE()
    ncdu:toggle()
end

local htop = Terminal:new({ cmd = "htop", hidden = true })

function _HTOP_TOGGLE()
    htop:toggle()
end

local bash = Terminal:new({ cmd = "bash", hidden = true, dir = vim.fn.expand('%:p:h') })

function _BASH_TOGGLE()
    -- bash:exec('cd /tmp')
    bash:toggle()
end
-- vim.api.nvim_set_keymap('n', '<leader>t', ':lua _BASH_TOGGLE()<cr>', opts)
