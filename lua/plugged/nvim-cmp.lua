local cmp = require('cmp')
local luasnip = require('luasnip')
require('luasnip/loaders/from_vscode').lazy_load()

local check_backspace = function()
    local col = vim.fn.col '.' - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
end

--   פּ ﯟ    some other good icons
local kind_icons = {
    Text = ' <Text>',
    Method = 'm <Method>',
    Function = ' <Function>',
    Constructor = ' <Constructor>',
    Field = ' <Field>',
    Variable = ' <Variable>',
    Class = ' <Class>',
    Interface = ' <Interface>',
    Module = ' <Module>',
    Property = ' <Property>',
    Unit = ' <Unit>',
    Value = ' <Value>',
    Enum = ' <Enum>',
    Keyword = ' <Keyword>',
    Snippet = ' <Snippet>',
    Color = ' <Color>',
    File = '🗄️<File>',
    Reference = ' <Reference>',
    Folder = ' <Folder>',
    EnumMember = ' <EnumMember>',
    Constant = ' <Constant>',
    Struct = ' <Struct>',
    Event = ' <Event>',
    Operator = ' <Operator>',
    TypeParameter = ' <Type>',
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = {
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif check_backspace() then
              fallback()
            else
              fallback()
            end
        end, {
            'i',
            's',
        }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            'i',
            's',
        }),
    },
    formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
            -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatinates the icons with the name of the item kind
            vim_item.menu = ({
                nvim_lsp = '[LSP]',
                nvim_lsp_signature_help = '[LSP_sign]',
                nvim_lua = '[Api]',
                luasnip = '[Snippet]',
                buffer = '[Buffer]',
                path = '[Path]',
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        { name = 'luasnip',
            options = { use_show_condition = false } -- To disable filtering completion candidates by snippet's show_condition
        },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'buffer' },
        { name = 'path' },
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    window = {
        documentation = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered(),
    },
    experimental = {
        ghost_text = true,
        native_menu = false,
    },
}

cmp.setup.cmdline(':', {
    sources = {
        { name = 'cmdline' },
        { name = 'path' },
    }
})

cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})
