local M = {
  -----------------
  -- Keybindings --
  -----------------

  {
    'folke/which-key.nvim',
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
  },

  {
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
    opts = {
      mapping = { 'jk' },
    },
  },

  ----------------------------
  -- File pickers/explorers --
  ----------------------------

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'Telescope' },
    keys = {
      {
        '<leader>ff',
        function() require('telescope.builtin').find_files() end,
        desc = 'find files',
      },
      {
        '<C-p>',
        function() require('telescope.builtin').git_files() end,
        desc = 'find git files',
      },
      {
        '<leader>cs',
        function()
          require('telescope.builtin').grep_string { search = vim.fn.input('Grep > ') }
        end,
        desc = 'search for string in files',
      },
    },
    opts = {
      pickers = {
        find_files = {
          follow = true,
        },
      },
    },
  },

  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeOpen', 'NvimTreeClose', 'NvimTreeToggle', 'NvimTreeRefresh', 'NvimTreeFocus' },
    keys = {
      {
        '<leader>tt',
        function() require('nvim-tree.api').tree.toggle() end,
        desc = 'toggle file tree',
      },
    },
    opts = {
      sync_root_with_cwd = true,
      disable_netrw = false,
      hijack_netrw = true,
      hijack_directories = {
        enable = true,
      },
    },
  },

  -----------------
  -- Git support --
  -----------------

  {
    'tpope/vim-fugitive',
    lazy = false,
    keys = {
      { '<leader>gs', vim.cmd.Git, desc = 'git Status' }
    },
  },

  -------------------
  -- Functionality --
  -------------------

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    dependencies = {
      { 'hrsh7th/nvim-cmp' },
    },
    config = function()
      require('nvim-autopairs').setup {}
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end,
  },

  {
    'numToStr/Comment.nvim',
    event = 'BufEnter',
    opts = {},
  },

  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'BufEnter',
    opts = {},
  },

  {
    'folke/zen-mode.nvim',
    keys = {
      {
        '<leader>tz',
        function()
          require('zen-mode').toggle()
        end,
        desc = 'Toggle zen mode'
      }
    },
    opts = {},
  },

  {
    'aserowy/tmux.nvim',
    lazy = false,
    keys = function()
      local tmux = require('tmux')
      return {
        { '<A-h>',   tmux.move_left,     desc = 'switch to window on left', },
        { '<A-j>',   tmux.move_bottom,   desc = 'switch to window on bottom', },
        { '<A-k>',   tmux.move_top,      desc = 'switch to window on top', },
        { '<A-l>',   tmux.move_right,    desc = 'switch to window on right', },
        { '<A-S-h>', tmux.resize_left,   desc = 'move window left', },
        { '<A-S-j>', tmux.resize_bottom, desc = 'move window down', },
        { '<A-S-k>', tmux.resize_top,    desc = 'move window up', },
        { '<A-S-l>', tmux.resize_right,  desc = 'move window right', },
      }
    end,
    opts = {
      navigation = { enable_default_keybindings = false, },
      resize = { enable_default_keybindings = false, },
      copy_sync = { sync_clipboard = false, }
    },
  },
}

return M
