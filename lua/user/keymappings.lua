local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

vim.cmd([[
    augroup caps_to_esc
        autocmd!
        autocmd VimEnter       *         lua vim.fn.system({'setxkbmap', '-option', 'caps:escape'})
        autocmd VimLeavePre    *         !setxkbmap -option
        autocmd VimLeave       *         !setxkbmap -option grp:alt_shift_toggle
    augroup end
]])
--
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

--Remap space as leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Toggle CapsLock to Esc mapping:
map('n', '<Leader><Esc><Esc>', ':!bash -c "( setxkbmap -print | grep symbols | grep caps ) && setxkbmap -option || setxkbmap -option caps:escape; setxkbmap -option grp:alt_shift_toggle"<CR>', { noremap=true, silent=false })
map('n', '<Leader>h',       ':set hlsearch!<CR>',      { noremap=true, silent=true })
map('n', ';',               ':',                       { noremap=true, silent=false })
--map('n', '<Leader>e',       ':Lexplore<CR>',           { noremap=true, silent=true }) --Toggle file tree
map('n', '<Leader>e',       ':NvimTreeToggle<CR>',     { noremap=true, silent=true }) --Toggle file tree

-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)

-- Navigate tabs
map("n", "<A-k>", ":tabnext<CR>", opts)
map("n", "<A-j>", ":tabprevious<CR>", opts)

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
--map("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
map('t', '<Esc>', '<C-\\><C-n>',       term_opts) -- ESC exit to normal mode in terminal
map("t", "<C-h>", "<C-\\><C-n><C-w>h", term_opts) -- Windows navigation
map("t", "<C-j>", "<C-\\><C-n><C-w>j", term_opts)
map("t", "<C-k>", "<C-\\><C-n><C-w>k", term_opts)
map("t", "<C-l>", "<C-\\><C-n><C-w>l", term_opts)
map("t", "<A-C-j>", "<C-\\><C-n>:bnext<CR>",     term_opts)
map("t", "<A-C-k>", "<C-\\><C-n>:bprevious<CR>", term_opts)
map("t", "<A-k>", "<C-\\><C-n>:tabnext<CR>",     term_opts)
map("t", "<A-j>", "<C-\\><C-n>:tabprevious<CR>", term_opts)
