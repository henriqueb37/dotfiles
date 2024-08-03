local M = {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  {
    'shellRaining/hlchunk.nvim',
    event = { 'UIEnter' },
    opts = {
      chunk = {
        enable = true,
        use_treesitter = true,
        exclude_filetypes = {
          netrw = true,
          startup = true,
        },
      },
      blank = {
        enable = true,
        chars = { '·' },
        exclude_filetypes = {
          netrw = true,
          startup = true,
        },
      },
      indent = {
        enable = true,
        exclude_filetypes = {
          netrw = true,
          startup = true,
        },
      },
    }
  },

  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      highlight = {
        pattern = '.*\\s<(KEYWORDS)[ :]'
      },
      search = {
        pattern = '\\s(KEYWORDS)[\\s:]'
      }
    }
  },

  {
    'norcalli/nvim-colorizer.lua',
    event = 'VeryLazy',
    config = function()
      require('colorizer').setup()
    end,
  },

  {
    'startup-nvim/startup.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = false,
    config = function()
      require('startup').setup { theme = 'dashboard' }
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    config = function()
      ---@diagnostic disable-next-line: undefined-field
      require('lualine').setup {
        options = {
          component_separators = '|',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {
            { 'mode', separator = { left = '' }, right_padding = 2 },
          },
          lualine_b = { 'filename', 'branch' },
          lualine_c = { 'diff', 'diagnostics' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
      }
    end,
  },
}
return M
