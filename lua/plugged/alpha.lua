local pname = 'alpha'
local try = require('user.utils').try
local wait = 5
DATE_SORTABLE = os.date "%Y_%m_%d.%H%M%S"
local res, plug = try(wait, require, pname) --try wait sec to load the module
if not res then
    print('Plugin "'..pname..'" is disabled.')
    return
end
--------------------------------------------------------------------------------
local dashboard = require "alpha.themes.dashboard"

math.randomseed(os.time())

local function button(sc, txt, keybind, keybind_opts)
  local b = dashboard.button(sc, txt, keybind, keybind_opts)
  b.opts.hl = "AlphaButton"
  b.opts.hl_shortcut = "AlphaButtonShortcut"
  return b
end

local function footer()
  local _, plugins = try(1, vim.tbl_keys, _G.packer_plugins)
  plugins = type(plugins) == "table" and #plugins or 0
  local v = vim.version()
  local datetime = os.date " %d-%m-%Y   %H:%M:%S"
  return string.format(" %d   v%d.%d.%d  %s", plugins, v.major, v.minor, v.patch, datetime)
end

-- header
dashboard.section.header.val = {
    [[                               __                ]],
    [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
    [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
    [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
    [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
    [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}
--dashboard.section.header.opts.hl = "AlphaCol" .. math.random(5)

-- buttons
dashboard.section.buttons.val = {
  button("SPC f o", "   Recently opened files"),
  button("SPC f p", "🏭  Find project"),
  button("SPC f f", "   Find file"),
  button("SPC f g", "   Find word (live grep)"),
  --button("SPC s s", "  Open session"),
  button("SPC b",   "   New file (double: back to this menu)"),
  button("SPC e",   "   File explorer"),
  button("u",       "   Update plugins (Backup:".." '"..DATE_SORTABLE.."')", "<cmd>PackerSnapshot "..DATE_SORTABLE.."<cr>:PackerSync<cr>"),
  button("q",       "   Quit", "<cmd>qa<cr>"),
}

-- footer
dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = dashboard.section.header.opts.hl

-- quote
table.insert(dashboard.config.layout, { type = "padding", val = 1 })
table.insert(dashboard.config.layout, {
  type = "text",
  val = require "alpha.fortune"(),
  opts = {
    position = "center",
    hl = "AlphaQuote",
  },
})

plug.setup(dashboard.config)

-- hide tabline and statusline on startup screen
vim.api.nvim_create_augroup("alpha_tabline", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = "alpha_tabline",
  pattern = "alpha",
  command = "set showtabline=0 laststatus=0 noruler",
})

vim.api.nvim_create_autocmd("FileType", {
  group = "alpha_tabline",
  pattern = "alpha",
  callback = function()
    vim.api.nvim_create_autocmd("BufUnload", {
      group = "alpha_tabline",
      buffer = 0,
      command = "set showtabline=2 ruler laststatus=3",
    })
  end,
})

-- Keymappings:
-- (which-key plugin style)
local status, wk = pcall(require, 'which-key')
local opts = {
    mode = "n", -- NORMAL mode
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps (in this case mappings are remapped)
    nowait = true, -- use `nowait` when creating keymaps
    expr = false,
}
local mappings = {
    ['<leader>b'] = {'<cmd>Alpha<cr>', 'Toggle beginning page'},
}
if status then
    wk.register(mappings, opts)
else
    -- Old style:
    local function map(mod, lhs, rhs, op)
        op = vim.tbl_extend('force', {noremap = true, silent = true}, op or {})
        vim.api.nvim_set_keymap(mod, lhs, rhs, op)
    end
    map('n', '<leader>b', '<cmd>Alpha<cr>')
end
