--[[
tokyonight_italic_comments 	true 	Make comments italic
tokyonight_italic_keywords 	true 	Make keywords italic
tokyonight_italic_functions 	false 	Make functions italic
tokyonight_italic_variables 	false 	Make variables and identifiers italic
tokyonight_transparent 	false 	Enable this to disable setting the background color
tokyonight_hide_inactive_statusline 	false 	Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard StatusLine and LuaLine.
tokyonight_transparent_sidebar 	false 	Sidebar like windows like NvimTree get a transparent background
tokyonight_dark_sidebar 	true 	Sidebar like windows like NvimTree get a darker background
tokyonight_dark_float 	true 	Float windows like the lsp diagnostics windows get a darker background.
tokyonight_colors 	{} 	You can override specific color groups to use other groups or a hex color
tokyonight_day_brightness 	0.3 	Adjusts the brightness of the colors of the Day style. Number between 0 and 1, from dull to vibrant colors
tokyonight_lualine_bold 	false 	When true, section headers in the lualine theme will be bold
vim.g.tokyonight_style = "storm"          -- The theme comes in three styles: ["storm"], a darker variant "night" and "day".
vim.g.tokyonight_terminal_colors = true   -- [true] Configure the colors used when opening a :terminal
vim.g.tokyonight_italic_functions = true  -- [false] Make functions italic
vim.g.tokyonight_sidebars = {             -- Set a darker background on sidebar-like windows.
    "qf",
    "vista_kind",
    "terminal",
    "packer",
}
-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
--]]

-- Load the colorscheme
vim.cmd[[colorscheme tokyonight]]
