return {
  'folke/which-key.nvim',
  enabled = true,
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {},
  config = function(_, opts)
    require('which-key').setup(opts)
    require('utils.wk-prefixes').register()
  end,
}
