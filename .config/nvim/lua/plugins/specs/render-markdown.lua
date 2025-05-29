return {
  'MeanderingProgrammer/render-markdown.nvim',
  enabled = true,
  lazy = true,
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  ft = { 'markdown' },
  config = function()
    require('render-markdown').setup {
      heading = {
        backgrounds = { '', '', '', '', '', '' }
      }
    }

    local getHL = require('utils.getHL').getHL
    local bg = getHL('Normal').bg
    ---@type string[]
    local markups = { 'RenderMarkdownH{}', 'markdownH{}', '@markup.heading.{}.markdown' }
    for i = 1, 6 do
      local fg = getHL('RenderMarkdownH' .. i).fg
      for _, m in pairs(markups) do
        vim.api.nvim_set_hl(0, m:gsub("{}", i), { bg = fg, fg = bg })
      end
    end
  end
}
