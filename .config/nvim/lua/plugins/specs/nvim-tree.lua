return {
  'nvim-tree/nvim-tree.lua',
  enabled = true,
  dependencies = {
    { 's1n7ax/nvim-window-picker', opts = { hint = 'floating-letter' } },
  },
  cmd = { 'NvimTreeOpen', 'NvimTreeClose', 'NvimTreeToggle', 'NvimTreeRefresh', 'NvimTreeFocus' },
  keys = {
    {
      '<leader>tt',
      function() require('nvim-tree.api').tree.toggle() end,
      desc = 'toggle file tree',
    },
  },
  config = function()
    require('nvim-tree').setup {
      sync_root_with_cwd = true,
      disable_netrw = false,
      hijack_netrw = true,
      hijack_directories = {
        enable = true,
      },
      actions = {
        open_file = {
          window_picker = {
            picker = require('window-picker').pick_window,
          },
        },
      },
    }
  end,
}
