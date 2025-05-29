return {
  'echasnovski/mini.files',
  enabled = true,
  version = '*',
  keys = {
    {
      '<leader>ff',
      function()
        ---@diagnostic disable-next-line undefined_global
        MiniFiles.open()
      end,
      desc = 'file explorer',
    },
  },
  opts = {
    windows = {
      max_number = 4,
      preview = true,
    }
  }
}
