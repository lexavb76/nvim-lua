--print('In plugins.lua...')
_M = {}
local packer = require('packer')
package.loaded['user.packer_init'] = nil
require('user.packer_init')  -- All packer plugin configuration
local ret = packer.startup({
    function(use) -- My plugins here:
        -- default_packages_root = ~/.local/share/nvim/site/pack/packer'

        -- !!! Never disable !!! ----------------------------------------------------------------------------------
        use 'wbthomason/packer.nvim'      -- Packer can manage itself: https://github.com/wbthomason/packer.nvim
        use 'nvim-lua/popup.nvim'         -- An implementation of the Popup API from vim in Neovim
        use 'nvim-lua/plenary.nvim'       -- Useful lua functions used by lots of plugins
                    -- Set up patched fonts with glyphs --
        local font_location = '~/.local/share/fonts' -- Don't change it
        local font_family = 'Hack'
        --Have to use auxiliary namespace _M to get into the internal function scope. Local variables do not work.
        _M.install_font_cmd = 'mkdir -p '..font_location..' && '..default_packages_root..'/start/nerd-fonts/install.sh '..font_family
        use { 'ryanoasis/nerd-fonts',     -- It is not a plugin actually just fonts with glyphs
            opt = false,
            tag = 'v*', -- The last tag, matching wildcard 'v*'
            -- You may install fonts manually:
            --  ~/.local/share/nvim/site/pack/packer/start/nerd-fonts/install.sh  Hack
            config = function()  --  Is called every time you load the plugin
                --vim.fn.system({ 'bash', '-c', _M.install_font_cmd })  -- Uncomment if you want to install new font_family
                --vim.cmd('!'.._M.install_font_cmd..' --help' )         -- Just the way to get the list of all font_family. Uncomment if needed.
            end,
            run = _M.install_font_cmd,  -- Run install script after install/update only
        }
        -----------------------------------------------------------------------------------------------------------
        -- Ordinary plugins there:

        use { 'windwp/nvim-autopairs',      -- Autopairs, integrates with both cmp and treesitter
            config = function() local plug = 'plugged.nvim-autopairs'
                package.loaded[plug] = nil -- Force to reload plugin to reread user keymappins
                require(plug)
            end
        }
        use { 'numToStr/Comment.nvim',      -- Easily comment stuff
            requires = 'JoosepAlviste/nvim-ts-context-commentstring',
            config = function() local plug = 'plugged.comment'
                package.loaded[plug] = nil -- force to reload plugin to reread user keymappins
                require(plug)
            end
        }
        use { 'kyazdani42/nvim-tree.lua',   -- Filesystem explorer
            disable = false,
            requires = 'kyazdani42/nvim-web-devicons', -- optional, for file icons
            config = function() local plug = 'plugged.nvim-tree'
                package.loaded[plug] = nil -- force to reload plugin to reread user keymappins
                require(plug)
            end
        }
        use { 'folke/tokyonight.nvim',      -- Colorscheme
            disable = false,
            branch = 'main',
            config = function() local plug = 'plugged.tokyonight'
                package.loaded[plug] = nil -- force to reload plugin to reread user keymappins
                require(plug)
            end
        }
        use { 'nvim-treesitter/nvim-treesitter', -- Tree-sitter based highlighting
            config = function() local plug = 'plugged.nvim-treesitter'
                package.loaded[plug] = nil -- force to reload plugin to reread user keymappins
                require(plug)
            end,
            run = ':TSUpdate'
        }
        use { 'hrsh7th/nvim-cmp', -- The completion plugin
            requires = {
                { 'L3MON4D3/LuaSnip', --snippet engine
                    requires = 'rafamadriz/friendly-snippets', -- a bunch of snippets to use
                },
                { 'saadparwaiz1/cmp_luasnip', -- API between cmp_luasnip and nvim-cmp
                    after = 'nvim-cmp' -- Is loaded after nvim-cmp
                    -- opt = true, -- Is implied if 'after' field is not nil
                },
                { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }, -- buffer completions
                { 'hrsh7th/cmp-path', after = 'nvim-cmp' }, -- path completions
                { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }, -- cmdline completions
                { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' }, -- nvim-cmp source for neovim Lua API
                { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }, -- LSP completion
                -- { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
                -- 'hrsh7th/cmp-nvim-lsp-signature-help',
                -- 'lukas-reineke/cmp-under-comparator',
            },
            config = function() local plug = 'plugged.nvim-cmp'
                package.loaded[plug] = nil -- force to reload plugin to reread user keymappins
                require(plug)
            end,
        }
        use 'neovim/nvim-lspconfig' -- enable LSP
        use { 'williamboman/nvim-lsp-installer', after = 'nvim-lspconfig', -- simple to use language server installer
            config = function() local plug = 'plugged.lsp.lsp-installer'
                package.loaded[plug] = nil -- force to reload plugin to reread user keymappins
                require(plug)
            end,
        }
        use { "akinsho/toggleterm.nvim", -- Terminal
            config = function() local plug = 'plugged.toggleterm'
                package.loaded[plug] = nil -- force to reload plugin to reread user keymappins
                require(plug)
            end,
        }
        -----------------------------------------------------------------------------------------------------------
        if packer_bootstrap then
            packer.sync()
        end
    end,
})
return ret

