return {
  'github/copilot.vim',
  enabled = false,
  cmd = { 'Copilot', },
  config = function()
    vim.cmd(':Copilot disable')
    vim.g.copilot_filetypes = {
      ['*'] = false,
      javascript = true,
      typescript = true,
    }
  end
}
