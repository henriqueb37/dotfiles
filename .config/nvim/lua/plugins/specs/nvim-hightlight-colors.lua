return {
  'brenoprata10/nvim-highlight-colors',
  enabled = true,
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = { 'HighlightColors' },
  keys = {
    { "<leader>tc", function() require('nvim-highlight-colors').toggle() end, desc = "toggle highlight colors" },
  },
}
