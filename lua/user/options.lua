local fn = vim.fn
local opt = vim.opt  -- :set [no]<opt>[?,!]   in vim command

-- :help options
opt.runtimepath:append { fn.stdpath('config')..'-qt' }       --Autoload nvim-qt as a graphic frontend
opt.runtimepath:remove { vim.env.HOME..'-qt' }
opt.list = true                                              --Show hidden symbols
opt.listchars:remove { 'tab' }
opt.listchars:append { tab='▸ ' }                            --Remap hidden symbols signs
opt.clipboard:append { 'unnamedplus' }                       --Unnamed register to clipboard when copy/paste
opt.shortmess:append "c"                     -- don't give |ins-completion-menu| messages

local options = {
    backup = false,                          -- creates a backup file
    swapfile = false,                        -- creates a swapfile
    cmdheight = 2,                           -- more space in the neovim command line for displaying messages
    completeopt = { "menuone", "noselect" }, -- mostly just for cmp
    conceallevel = 0,                        -- so that `` is visible in markdown files
    fileencoding = "utf-8",                  -- the encoding written to a file
    hlsearch = true,                         -- highlight all matches on previous search pattern
    ignorecase = true,                       -- ignore case in search patterns
    smartcase = true,                        -- smart case in search patterns
    mouse = "a",                             -- allow the mouse to be used in neovim
    pumheight = 10,                          -- pop up menu height
    showmode = true,                         -- things like -- INSERT -- beneath
    showtabline = 2,                         -- always show tabs
    cursorline = true,                       -- highlight the current line
    smartindent = true,                      -- make indenting smarter again
    splitbelow = true,                       -- force all horizontal splits to go below current window
    splitright = true,                       -- force all vertical splits to go to the right of current window
    --timeoutlen = 1000,                       -- time to wait for a mapped sequence to complete (in milliseconds) [default = 1000]
    undofile = true,                         -- automatically save your undo history when you write a file and restore undo history when you edit the file again
    updatetime = 300,                        -- faster completion (4000ms default)
    expandtab = true,                        -- convert tabs to spaces
    shiftwidth = 4,                          -- the number of spaces inserted for each indentation
    tabstop = 4,                             -- insert 2 spaces for a tab
    number = true,                           -- set numbered lines
    relativenumber = false,                  -- set relative numbered lines
    numberwidth = 5,                         -- set number column width {default 4}
    signcolumn = "yes",                      -- always show the sign column (on the very left side), otherwise it would shift the text each time
    wrap = false,                            -- display lines as one long line
    scrolloff = 8,                           -- Minimal number of screen lines to keep above and below the cursor.
    sidescrolloff = 8,                       -- Minimal number of columns to keep left and right of the cursor.
    termguicolors = true,                    -- set term gui colors (most terminals support this)
    guifont = "monospace:h12",               -- the font used in graphical neovim applications "font_name:size"
}
for k, v in pairs(options) do
    opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]                 -- '-' now is not a terminal symbol, for example, asdf_asdf is treated as a single word
vim.cmd [[set formatoptions-=cro]]
