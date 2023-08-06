return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    config = function()
      require('hlchunk').setup{
        chunk = {
          exclude_filetypes = {
            netrw = true,
          },
        },
        blank = {
          chars = { '·' },
        },
      }
    end
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },

  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    config = function()
      require('lualine').setup{
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
