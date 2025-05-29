return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        component_separators = '',
        section_separators = '',
      },
      sections = {
        lualine_a = {
          { 'mode', },
        },
        lualine_b = {},
        lualine_c = { 'filename', 'branch', 'diff', },
        lualine_x = { 'diagnostics', 'filetype', 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}
