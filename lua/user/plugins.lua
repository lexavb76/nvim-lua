--print('In plugins.lua...')
_M = {}
local packer = require('packer')
package.loaded['user.packer_init'] = nil
require('user.packer_init')  -- All packer plugin configuration
local ret = packer.startup({
    function(use) -- My plugins here:
        -- default_packages_root = ~/.local/share/nvim/site/pack/packer'
        -----------------------------------------------------------------------------------------------------------
        local font_location = '~/.local/share/fonts' -- Don't change it
        local font_family = 'Hack'
        --Have to use auxiliary namespace _M to get into the internal function scope. Local variables do not work.
        _M.install_font_cmd = 'mkdir -p '..font_location..' && '..default_packages_root..'/start/nerd-fonts/install.sh '..font_family

        -- !!! Never disable !!! ----------------------------------------------------------------------------------
        use { 'wbthomason/packer.nvim',     -- Packer can manage itself: https://github.com/wbthomason/packer.nvim
            requires = {
                "nvim-lua/plenary.nvim",        -- Useful lua functions used by lots of plugins
                "nvim-lua/popup.nvim",          -- An implementation of the Popup API from vim in Neovim
            }
        }
        -----------------------------------------------------------------------------------------------------------
        -- Ordinary plugins there:

        use { "windwp/nvim-autopairs",      -- Autopairs, integrates with both cmp and treesitter
            config = function() require('plugged.nvim-autopairs') end
        }
        --[[
        use "numToStr/Comment.nvim"         -- Easily comment stuff
        --]]
        use { 'kyazdani42/nvim-tree.lua',   -- Filesystem explorer
            requires = {
                { 'ryanoasis/nerd-fonts',   -- It is not a plugin actually just fonts with glyphs
                    opt = false,
                    tag = 'v*',
                    -- You may install fonts manually:
                    --  ~/.local/share/nvim/site/pack/packer/start/nerd-fonts/install.sh  Hack
                    config = function()  --  Is called every time you load the plugin
                        --vim.fn.system({ 'bash', '-c', _M.install_font_cmd })  -- Uncomment if you want to install new font_family
                        --vim.cmd('!'.._M.install_font_cmd..' --help' )         -- Just the way to get the list of all font_family. Uncomment if needed.
                    end,
                    run = _M.install_font_cmd,  -- Run install script after install/update only
                },
                'kyazdani42/nvim-web-devicons', -- optional, for file icons
            },
            config = function() require('plugged.nvim-tree') end
        }
        use { 'folke/tokyonight.nvim',      -- Colorscheme
            disable = false,
            branch = 'main',
            config = function() require('plugged.tokyonight') end,
        }
        use { 'nvim-treesitter/nvim-treesitter', -- Tree-sitter based highlighting
            config = function() require('plugged.nvim-treesitter') end,
            run = ':TSUpdate'
        }

        -- --------------------------------------------------------------------------------
        if packer_bootstrap then
            packer.sync()
        end
    end,
})
-- vim.notify('felix='..type(ret))
return ret
