return {
  'nvim-telescope/telescope.nvim',
  enabled = true,
  tag = '0.1.6',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = { 'Telescope' },
  keys = {
    { '<leader>cs', function() require('telescope.builtin').live_grep() end,                                        desc = 'search for string in files', },
    { '<leader>fc', function() require('telescope.builtin').find_files { cwd = '~/.dotfiles/dot_config/nvim' } end, desc = 'find file in config' },
    { '<leader>fC', function() require('telescope.builtin').find_files { cwd = '~/.dotfiles' } end,                 desc = 'find file in dotfiles' },
    { '<leader>fr', function() require('telescope.builtin').oldfiles() end,                                         desc = 'find recent file' },
  },
  opts = {
    pickers = {
      find_files = {
        follow = true,
        hidden = true,
      },
    },
    defaults = {
      file_ignore_patterns = { "node%_modules/.*", ".git/.*" },
      theme = 'ivy',
    },
  },
}
