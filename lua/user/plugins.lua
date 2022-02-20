--print('In plugins.lua...')
local packer = require('packer')
package.loaded['user.packer_init'] = nil
require('user.packer_init')

local ret = packer.startup({
    function(use) -- My plugins here:
        -- --------------------------------------------------------------------------------

        use 'wbthomason/packer.nvim' -- Packer can manage itself: https://github.com/wbthomason/packer.nvim

        local font_location = '~/.local/share/fonts' -- Don't change it
        local font_family = 'Hack'
        local install_font_cmd = 'mkdir -p '..font_location..' && '..default_packages_root..'/opt/nerd-fonts/install '..font_family
        use {
            'kyazdani42/nvim-tree.lua',
            requires = {
                ---[[
                {
                    'ryanoasis/nerd-fonts',
                    opt = true,
                    tag = 'v*',
                    -- TODO: config and run commands do not work properly
                    -- installed fonts manually:
                    --  ~/.local/share/nvim/site/pack/packer/opt/nerd-fonts/install.sh  Hack
                    config = function()
                        vim.fn.system({ 'bash', '-c', install_font_cmd })
                    end,
                    run = install_font_cmd,
                },
                --]]
                {
                    'kyazdani42/nvim-web-devicons', -- optional, for file icon
                },
            },
            config = function()
                vim.g.nvim_tree_highlight_opened_files = 3   -- Enable highligting for folders and both file icons and names.
                vim.g.nvim_tree_disable_window_picker = 1    -- Don't pick windows when opens new file
                vim.g.nvim_tree_git_hl = 1                   -- Enable file highlight for git attributes by setting this property.
                vim.cmd([[ autocmd  user_config  BufWritePre  plugins.lua  NvimTreeClose ]])

                -- setup function must go the last:
                require('nvim-tree').setup {
                    hijack_cursor = true,                    -- Keeps the cursor on the first letter of the filename
                    update_cwd = true,                       -- changes the tree root directory on `DirChanged` and refreshes
                    update_focused_file = {                  -- Update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
                        enable      = true,
                        update_cwd  = true,                  -- Update the root directory of the tree to the one of the folder containing the file
                        ignore_list = {                      -- List of buffer names and filetypes that will not update the root dir of the tree
                        },
                    },
                    diagnostics = {                          -- Show LSP diagnostics in the signcolumn
                        enable = true,
                        show_on_dirs = true,
                    },
                    view = {
                        mappings = {                         -- A list of keymaps that will extend or override the default keymaps
                            -- key = table of strings or string,
                            -- mode = string (vim-mode),
                            -- cb = callback function as a string
                        },
                    },
                    actions = {
                        open_file = {
                            quit_on_open = false,            -- Quit explorer after file is opened (Better to keep false for proper exploring)
                        },
                    },
                }
            end
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
