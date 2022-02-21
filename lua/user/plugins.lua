--print('In plugins.lua...')
_M = {}
local packer = require('packer')
package.loaded['user.packer_init'] = nil
require('user.packer_init')

local ret = packer.startup({
    function(use) -- My plugins here:
        -- --------------------------------------------------------------------------------
        local font_location = '~/.local/share/fonts' -- Don't change it
        local font_family = 'Hack'
        --Have to use auxiliary namespace _M to get into the internal function scope. Local variables do not work.
        _M.install_font_cmd = 'mkdir -p '..font_location..' && '..default_packages_root..'/start/nerd-fonts/install.sh '..font_family

        use 'wbthomason/packer.nvim'        -- Packer can manage itself: https://github.com/wbthomason/packer.nvim
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
            disable = false,  -- Disable plugin
            branch = 'main',
            config = function() vim.cmd('colorscheme tokyonight') end,
        }

        if packer_bootstrap then
            packer.sync()
        end
    end,
    -- --------------------------------------------------------------------------------
    -- Automatically set up your configuration after cloning packer.nvim
    --[[ Put this at the end after all plugins
    config = {
        display = {
            --open_fn = function() return require('packer.util').float { border = 'rounded' } end,
            open_fn = nil
        }
    }
    --]]
})
--print(vim.inspect(ret))
return ret
