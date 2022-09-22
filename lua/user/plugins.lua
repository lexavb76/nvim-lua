--print('In plugins.lua...')
_M = {}
local packer = require('packer')
package.loaded['user.packer_init'] = nil
require('user.packer_init')  -- All packer plugin configuration
local ret = packer.startup({
    function(use) -- My plugins here:
        -- DEFAULT_PACKAGES_ROOT = ~/.local/share/nvim/site/pack/packer'

        -- !!! Never disable !!! ----------------------------------------------------------------------------------
        use 'wbthomason/packer.nvim'      -- Packer can manage itself: https://github.com/wbthomason/packer.nvim
        _M.configure_plug = function(plug)
            package.loaded[plug] = nil -- Force to reload plugin to reread user keymappins
            require(plug)
        end
        use { 'lewis6991/impatient.nvim', -- Speed up modules loading time
            config = _M.configure_plug('impatient'),
        }
        use 'nvim-lua/popup.nvim'         -- An implementation of the Popup API from vim in Neovim
        use 'nvim-lua/plenary.nvim'       -- Useful lua functions used by lots of plugins
                    -- Set up patched fonts with glyphs --
        local font_location = '~/.local/share/fonts' -- Don't change it
        local font_family = 'Hack'
        --Have to use auxiliary namespace _M to get into the internal function scope. Local variables do not work.
        _M.install_font_cmd = 'mkdir -p '..font_location..' && '..DEFAULT_PACKAGES_ROOT..'/start/nerd-fonts/install.sh '..font_family
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
        use { "folke/which-key.nvim", -- Prompts keymappins in popup menu. Manages all keymappins.
            commit = "bd4411a", --For proper work with v0.7.2
            config = _M.configure_plug('plugged.which-key'),
        }
        -----------------------------------------------------------------------------------------------------------
        -- Ordinary plugins there:

        use { 'windwp/nvim-autopairs',      -- Autopairs, integrates with both cmp and treesitter
            config = _M.configure_plug('plugged.nvim-autopairs'),
        }
        use { 'numToStr/Comment.nvim',      -- Easily comment stuff
            after = 'which-key.nvim',
            commit = "4086630", --For proper work with v0.7.2
            requires = 'JoosepAlviste/nvim-ts-context-commentstring',
            config = _M.configure_plug('plugged.comment'),
        }
        use { 'kyazdani42/nvim-tree.lua',   -- Filesystem explorer
            after = 'which-key.nvim',
            commit = "4bd919a", --For proper work with v0.7.2
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
            config = _M.configure_plug('plugged.nvim-tree'),
        }
        use { 'folke/tokyonight.nvim',      -- Colorscheme
            branch = 'main',
            config = _M.configure_plug('plugged.tokyonight'),
        }
        use { 'nvim-treesitter/nvim-treesitter', -- Tree-sitter based highlighting
            config = _M.configure_plug('plugged.nvim-treesitter'),
            run = ':TSUpdate' -- Run install script after install/update only
        }
        use { 'RRethy/nvim-treesitter-endwise', -- Adds end automatically to Lua, bash, Vimscript, Ruby, ...
            after = 'nvim-treesitter',
            config = function()  --  Is called every time you load the plugin
                require('nvim-treesitter.configs').setup {
                    endwise = { enable = true, }
                }
            end
        }
        use { 'hrsh7th/nvim-cmp', -- The completion plugin
            branch = 'main',
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
                { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' }, -- functions signature completion
                -- { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
                -- 'lukas-reineke/cmp-under-comparator',
            },
            config = _M.configure_plug('plugged.nvim-cmp'),
        }
        use 'neovim/nvim-lspconfig' -- enable LSP
        use { 'williamboman/nvim-lsp-installer', after = 'nvim-lspconfig', -- simple to use language server installer
            config = _M.configure_plug('plugged.lsp.lsp-installer'),
        }
        use { "akinsho/toggleterm.nvim", -- Terminal
            branch = 'main',
            commit = "8cba5c2", --For proper work with v0.7.2
            after = 'which-key.nvim',
            config = _M.configure_plug('plugged.toggleterm'),
        }
        use { "nvim-telescope/telescope.nvim", -- Fuzzy finder
            after = {'plenary.nvim', 'which-key.nvim'},
            config = _M.configure_plug('plugged.telescope'),
            run = ':checkhealth telescope', -- Run install script after install/update only

        }
        use { "ahmedkhalf/project.nvim", -- Extention for telescope for project management
            after = 'telescope.nvim',
            config = _M.configure_plug('plugged.project'),
        }
        use { "nvim-telescope/telescope-symbols.nvim", -- Extention for telescope for symbols library
            after = 'telescope.nvim',
        }
        use { "LinArcX/telescope-env.nvim", -- Extention for telescope for environment variables
            after = 'telescope.nvim',
            config = function()
                require('telescope').load_extension('env')
            end,
        }
        use { "nvim-lualine/lualine.nvim", -- Status line
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
            config = _M.configure_plug('plugged.lualine'),
        }
        use { "lewis6991/gitsigns.nvim", -- Git visualisation
            requires = { 'nvim-lua/plenary.nvim' },
            config = _M.configure_plug('plugged.gitsigns'),
        }
        use { "goolord/alpha-nvim", -- Greeter
            branch = 'main',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
            config = _M.configure_plug('plugged.alpha'),
        }
        -----------------------------------------------------------------------------------------------------------
        if PACKER_BOOTSTRAP then
            packer.sync()
        end
    end,
})
return ret

