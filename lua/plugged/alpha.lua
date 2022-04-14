local pname = 'alpha'
local try = require('user.utils').try
local wait = 5
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
dashboard.section.header.val = 'Felix'
--dashboard.section.header.opts.hl = "AlphaCol" .. math.random(5)

-- buttons
dashboard.section.buttons.val = {
  button("SPC e",   "   File explorer"),
  button("SPC f o", "   Recently opened files"),
  button("SPC f f", "   Find file"),
  button("SPC f w", "   Find word"),
  button("SPC f p", "🏭  Find project"),
  --button("SPC s s", "  Open session"),
  --button("SPC c n", "  New file"),
  --button("SPC p u", "  Update plugins"),
  button("q",       "   Quit", "<Cmd>qa<CR>"),
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
