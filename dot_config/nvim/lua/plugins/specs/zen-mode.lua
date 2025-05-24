return {
  'folke/zen-mode.nvim',
  enabled = true,
  keys = {
    {
      '<leader>tz',
      function()
        require('zen-mode').toggle()
      end,
      desc = 'toggle zen mode'
    }
  },
  opts = {},
}
