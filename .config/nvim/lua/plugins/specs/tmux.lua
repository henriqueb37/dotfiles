return {
  'aserowy/tmux.nvim',
  enabled = function() return vim.env.TMUX and vim.env.TMUX ~= "" end,
  event = 'VeryLazy',
  keys = function()
    local tmux = require('tmux')
    return {
      { '<A-h>',   tmux.move_left,     mode = { "n", "t" }, desc = 'switch to window on left', },
      { '<A-j>',   tmux.move_bottom,   mode = { "n", "t" }, desc = 'switch to window on bottom', },
      { '<A-k>',   tmux.move_top,      mode = { "n", "t" }, desc = 'switch to window on top', },
      { '<A-l>',   tmux.move_right,    mode = { "n", "t" }, desc = 'switch to window on right', },
      { '<A-S-h>', tmux.resize_left,   mode = { "n", "t" }, desc = 'move window left', },
      { '<A-S-j>', tmux.resize_bottom, mode = { "n", "t" }, desc = 'move window down', },
      { '<A-S-k>', tmux.resize_top,    mode = { "n", "t" }, desc = 'move window up', },
      { '<A-S-l>', tmux.resize_right,  mode = { "n", "t" }, desc = 'move window right', },
    }
  end,
  opts = {
    navigation = { enable_default_keybindings = false, },
    resize = { enable_default_keybindings = false, },
    copy_sync = { sync_clipboard = false, }
  },
}
