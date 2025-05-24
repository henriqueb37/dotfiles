return {
  'bluz71/vim-moonfly-colors',
  name = 'moonfly',
  enabled = true,
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.moonflyWinSeparator = 2
    vim.g.moonflyCursorColor = true
    vim.cmd.colorscheme 'moonfly'

    -- local palette = require('moonfly').palette
    -- vim.api.nvim_set_hl(0, 'FloatBorder', { bg = palette.grey11, fg = palette.grey11 })
    -- vim.api.nvim_set_hl(0, 'FloatTitle', { bg = palette.grey11, fg = palette.fg })
    -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = palette.grey11, fg = palette.fg })
    -- vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = palette.grey15 })
    -- vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { bg = palette.grey15, fg = palette.grey15 })
    -- vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = palette.grey15, fg = palette.grey15 })
    -- vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { bg = palette.bg, fg = palette.bg })
    -- vim.api.nvim_set_hl(0, 'TelescopePreviewNormal', { link = 'NormalFloat' })
    -- vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { bg = palette.bg, fg = palette.bg })
    -- vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', { link = 'NormalFloat' })
  end
}
