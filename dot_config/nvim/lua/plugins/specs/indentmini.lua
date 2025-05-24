return {
  'nvimdev/indentmini.nvim',
  enabled = true,
  event = { 'UIEnter' },
  config = function()
    require('indentmini').setup {}
    -- moonfly colors
    vim.cmd.highlight('IndentLine guifg=#202020')
    vim.cmd.highlight('IndentLineCurrent guifg=#748999')
  end
}
