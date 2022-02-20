-- Use a protected call so we don't error out on first use
--[[
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end
--]]
local packer = require('packer')

---[[
packer.reset()
packer.init({
    display = {
        -- Floating window when sync
        --open_fn = function() return require('packer.util').float { border = 'rounded' } end,
        open_fn = nil,
    },
    git = {
        clone_timeout = 36000,
    }
})
--]]
