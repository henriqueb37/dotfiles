local function find_files()
  require('telescope.builtin').find_files()
end

local function git_files()
  require('telescope.builtin').git_files()
end

local function grep_string()
  require('telescope.builtin').grep_string{ search=vim.fn.input("Grep > ") }
end


local function toggle_tree()
  require('nvim-tree.api').tree.toggle()
end


return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'Telescope' },
    keys = {
      { '<leader>pf', find_files, desc = 'find files' },
      { '<C-p>', git_files, desc = 'find git files' },
      { '<leader>ps', grep_string, desc = 'search for string in files' },
    },
  },

  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeOpen', 'NvimTreeClose', 'NvimTreeToggle', 'NvimTreeRefresh', 'NvimTreeFocus' },
    keys = {
      { '<leader>t', toggle_tree, desc = 'toggle file tree' }
    },
    opts = {},
  }
}

