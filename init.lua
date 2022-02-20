local fn = vim.fn
-- default_packages_root = ~/.local/share/nvim/site/pack/packer'
default_packages_root = fn.stdpath('data')..'/site/pack/packer'
local install_path = default_packages_root..'/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    print('Install packer...')
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
-- Search in ~/.config/nvim/lua  directory:
package.path = fn.stdpath('config')..'/lua/?.lua;'..package.path

vim.cmd([[
    augroup user_config
        autocmd!
        autocmd VimEnter       *                               PackerSync
        autocmd BufWritePost packer_init.lua  source <afile> | PackerCompile
        autocmd BufWritePost plugins.lua      source <afile> | PackerSync
        autocmd BufWritePost init.lua         source <afile>
        autocmd BufWritePost keymappings.lua  source <afile>
        autocmd BufWritePost options.lua      source <afile>
    augroup end
]])

require ('user.keymappings')
require ('user.options')
require ('user.plugins')
                                                                                
vim.cmd([[exe 'cd '.stdpath('config')]])
--vim.cmd([[exe 'edit '.stdpath('config').'/init.lua']])
