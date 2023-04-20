local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.cmd([[
    augroup when_exit
        autocmd!
        autocmd VimLeavePre    *         exe "mksession! ".stdpath('cache')."/Session.vim"
    augroup end
]])
--
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v", -- Visual + Select mode
--   visual_block_mode = "x", -- Only Visual mode
--   term_mode = "t",
--   command_mode = "c",

--Remap space as leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Toggle CapsLock to Esc mapping (works for Ubuntu 20.04 but does not work for 22.04):
--map('n', '<Leader><Esc><Esc>', ':!bash -c "( setxkbmap -print | grep symbols | grep caps ) && setxkbmap -option || setxkbmap -option caps:escape; setxkbmap -option grp:alt_shift_toggle"<CR>', { noremap=true, silent=false })
map('n', '<Leader>h', ':set hlsearch!<CR>', opts)
map('n', ';', ':', { noremap=true, silent=false })
map('n', '<Leader>e', ':Lexplore<CR>', opts) --Toggle file tree by default Netrw. May be overridden by plugins.
map("n", "H", "<<", opts)
map("n", "L", ">>", opts)

-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts) -- Navigation
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-c>", "<C-w>c", opts) -- Close current window
map("n", "<C- >", "<C-w>w", opts) -- Move between windows
map("n", "<C-CR>", "<C-w>T", opts) -- Open window in new tab

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
map("n", "<A-C-j>", ":bnext<CR>", opts)
map("n", "<A-C-k>", ":bprevious<CR>", opts)

-- Navigate tabs
map("n", "<A-k>", ":tabnext<CR>", opts)
map("n", "<A-j>", ":tabprevious<CR>", opts)

map("n", "<leader>s", ":setlocal spell!<CR>", opts) -- Toggle spell checking

-- Visual --
-- Stay in indent mode
map("v", "H", "<gv", opts)
map("v", "L", ">gv", opts)
--map("v", "p", '"_dP', opts)
map("v", "J", ":move '>+1<CR>gv-gv", opts) -- Move text up and down
map("v", "K", ":move '<-2<CR>gv-gv", opts)
