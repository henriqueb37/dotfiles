local M = {
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    dependencies = {
      { 'hrsh7th/nvim-cmp' },
    },
    config = function()
      require('nvim-autopairs').setup{}
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
    event = 'VeryLazy',
    config = function()
      require('Comment').setup()
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup{}
    end
  },

  {
    'norcalli/nvim-colorizer.lua',
    event = 'VeryLazy',
    config = function()
      require('colorizer').setup()
    end,
  },

  {
    "folke/zen-mode.nvim",
    keys = {
      { '<leader>z', function ()
        require('zen-mode').toggle()
      end, desc = 'Toggle zen mode'}
    },
    opts = {},
  },

  {
    "aserowy/tmux.nvim",
    lazy = false,
    opts = {},
  },
}

return M

