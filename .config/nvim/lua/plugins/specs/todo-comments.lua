return {
  'folke/todo-comments.nvim',
  enabled = true,
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    highlight = {
      pattern = '.*\\s<(KEYWORDS)[ :]'
    },
    search = {
      pattern = '\\s(KEYWORDS)[\\s:]'
    }
  }
}
