local M = {
  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    config = function()
      local configs = require('nvim-treesitter.configs')

      ---@diagnostic disable-next-line: missing-fields
      configs.setup({
        ensure_installed = { 'lua', 'vim', 'vimdoc', 'markdown', },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  { 'nvim-treesitter/nvim-treesitter-context' },

  -- Git support
  {
    'tpope/vim-fugitive',
    lazy = false,
    keys = {
      { '<leader>gs', vim.cmd.Git, desc = 'Git Status' }
    },
  },

  -- LSP
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.api.nvim_command, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' },
      {
        "j-hui/fidget.nvim",
        tag = "legacy",
        config = true,
      },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snipets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    },
    config = function()
      local lsp = require('lsp-zero').preset('recommended')

      local cmp_action = require('lsp-zero').cmp_action()

      lsp.nvim_workspace({
        library = vim.api.nvim_get_runtime_file('', true)
      })

      lsp.setup_nvim_cmp{
        mappings = lsp.defaults.cmp_mappings{
          ['<Tab>'] = cmp_action.luasnip_supertab(),
          ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
        }
      }

      lsp.on_attach(function(_, bufnr)
        local opts = { buffer = bufnr, remap = false }

        local function desc(description)
          return { unpack(opts), desc = description }
        end

        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, desc('goto definition'))
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, desc('hover'))
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, desc('view workspace symbol'))
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, desc('view diagnostics'))
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, desc('goto next diagnostic'))
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, desc('goto previous diagnostic'))
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, desc('view code actions'))
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, desc('view references'))
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, desc('rename'))
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, desc('view signature help'))
      end)

      lsp.setup()
    end,
  }
}

return M

