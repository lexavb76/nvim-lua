local pname = 'nvim-autopairs'
local try = require('user.utils').try
local wait = 5
local res, plug = try(wait, require, pname) --try wait sec to load the module
if not res then
    print('Plugin "'..pname..'" is disabled.')
    return
end
--------------------------------------------------------------------------------
plug.setup {
    check_ts = true,
    ts_config = {
        lua = { "string", "source", },
        javascript = { "string", "template_string" },
        java = false,
    },
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    fast_wrap = {
        map = "<M-i>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
    },
}

-- 'Setup nvim-cmp.
local cmp_status_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if cmp_status_ok then
    local cmp
    cmp_status_ok, cmp = pcall(require, "cmp")
    if cmp_status_ok then
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
    end
end
