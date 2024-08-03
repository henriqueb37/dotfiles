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
      configs.setup {
        ensure_installed = { 'lua', 'markdown', 'rust', 'vim', 'vimdoc', },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<CR>',
            scope_incremental = '<CR>',
            node_incremental = '<Tab>',
            node_decremental = '<S-Tab>',
          },
        },

        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']m'] = '@function.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
            },
            goto_previours_end = {
              ['[M'] = '@function.outer',
            },
          }
        },
      }

      local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

      -- Repeat movement with ; and ,
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

      -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
      vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
    end,
  },

  { 'nvim-treesitter/nvim-treesitter-context' },

  { 'nvim-treesitter/nvim-treesitter-textobjects' },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- LSP Support
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.api.nvim_command, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' },
      {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        config = true,
      },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
      { 'nvim-telescope/telescope.nvim' },

      -- Specifics
      { 'creativenull/efmls-configs-nvim' },
    },
    config = function()
      local lsp_auto_format_group = vim.api.nvim_create_augroup('LspAutoFormat', {})
      local lsp_auto_format_ignore = { 'tsserver', }

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          local opts = { buffer = event.buf, remap = false }

          local function desc(description)
            return { unpack(opts), desc = description }
          end

          vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, desc('goto definition'))
          vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, desc('hover'))
          vim.keymap.set('n', '<leader>cw', function() vim.lsp.buf.workspace_symbol() end, desc('view workspace symbol'))
          vim.keymap.set('n', '<leader>cd', function() vim.diagnostic.open_float() end, desc('view diagnostics'))
          vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, desc('goto previous diagnostic'))
          vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, desc('goto next diagnostic'))
          vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, desc('view code actions'))
          vim.keymap.set('n', '<leader>clr', function() require('telescope.builtin').lsp_references() end,
            desc('list references'))
          vim.keymap.set('n', '<leader>cr', function() vim.lsp.buf.rename() end, desc('rename'))
          vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, desc('view signature help'))

          -- Format on save
          if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_clear_autocmds({ group = lsp_auto_format_group, buffer = event.buf })
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = lsp_auto_format_group,
              buffer = event.buf,
              callback = function()
                vim.lsp.buf.format {
                  filter = function(c)
                    return not (vim.tbl_contains(lsp_auto_format_ignore, c.name))
                  end
                }
              end,
            })
          end
        end
      })

      local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

      local default_setup = function(server)
        require('lspconfig')[server].setup {
          capabilities = lsp_capabilities,
        }
      end

      local lua_ls_setup = function()
        require('lspconfig').lua_ls.setup {
          capabilities = lsp_capabilities,
          settings = {
            Lua = {
              runtime = {
                version = 'LuaJIT',
              },
              diagnostics = {
                globals = { 'vim' },
              },
              workspace = {
                library = {
                  vim.env.VIMRUNTIME,
                },
              },
            },
          },
        }
      end

      local efm_setup = function()
        local prettier_d = require('efmls-configs.formatters.prettier_d')

        local languages = {
          javascript = { prettier_d, },
          javascriptreact = { prettier_d, },
          typescript = { prettier_d, },
          typescriptreact = { prettier_d, },
          html = { prettier_d, },
          css = { prettier_d, },
          json = { prettier_d, },
        }

        require('lspconfig').efm.setup {
          filetypes = vim.tbl_keys(languages),
          capabilities = lsp_capabilities,
          init_options = {
            documentFormatting = true,
            documentRangerFormatting = true,
          },
          settings = {
            rootMarkers = { '.git/' },
            languages = languages,
          }
        }
      end

      require('mason').setup {}
      require('mason-lspconfig').setup {
        ensure_installed = { 'lua_ls', 'rust_analyzer', 'efm', },
        handlers = {
          default_setup,
          lua_ls = lua_ls_setup,
          efm = efm_setup,
        }
      }

      local cmp = require('cmp')

      cmp.setup {
        sources = {
          { name = 'path' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'luasnip', keyword_length = 2 },
          { name = 'buffer',  keyword_length = 3 },
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-Space>'] = cmp.mapping.complete(),
          -- ['<CR>'] = cmp.mapping.confirm { select = false },
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        }
      }

      require('luasnip.loaders.from_vscode').lazy_load()

      require('fidget').setup {}
    end,
  },

  -- Language support
  {
    'elkowar/yuck.vim',
  },
}

return M
