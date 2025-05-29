return {
  "toppair/peek.nvim",
  enabled = true,
  ft = 'markdown',
  build = "deno task --quiet build:fast",
  config = function()
    require("peek").setup({
      app = "firefox",
    })
    vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
    vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
  end,
}
