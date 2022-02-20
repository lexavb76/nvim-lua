local map = vim.api.nvim_set_keymap
vim.cmd([[
    augroup caps_to_esc
        autocmd!
        autocmd VimEnter       *         lua vim.fn.system({'setxkbmap', '-option', 'caps:escape'})
        autocmd VimLeavePre    *         !setxkbmap -option
        autocmd VimLeave       *         !setxkbmap -option grp:alt_shift_toggle
    augroup end
]])
map('n', '<Space>',         '<NOP>',                   { noremap=true, silent=true })
vim.g.mapleader = ' '
-- Toggle CapsLock to Esc mapping:
map('n', '<Leader><Esc><Esc>', ':!bash -c "( setxkbmap -print | grep symbols | grep caps ) && setxkbmap -option || setxkbmap -option caps:escape; setxkbmap -option grp:alt_shift_toggle"<CR>', { noremap=true, silent=false })
map('n', '<Leader>h',       ':set hlsearch!<CR>',      { noremap=true, silent=true })
map('n', ';',               ':',                       { noremap=true, silent=false })
--map('n', '<Leader>e',       ':Lexplore<CR>',           { noremap=true, silent=true }) --Toggle file tree
map('n', '<Leader>e',       ':NvimTreeToggle<CR>',     { noremap=true, silent=true }) --Toggle file tree
map('t', '<Esc>',           '<C-\\><C-n>',              { noremap=true, silent=true }) -- ESC exit to normal mode in terminal
