-- init.lua

-- disable annoying deprecation alert
---@diagnostic disable-next-line
vim.deprecate = function() end

-- load the rest of the config
require('mappings')
require('plugins')
require('options')
