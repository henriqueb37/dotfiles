return {
  'epwalsh/obsidian.nvim',
  enabled = false,
  version = '*',
  ft = 'markdown',
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = 'pessoal',
        path = '~/Documentos/obsidian/pessoal',
      },
    },
    ui = {
      enable = false,
    },
  },
}
