---@diagnostic disable: missing-fields
return {
  'dundalek/lazy-lsp.nvim',
  enabled = true,
  lazy = true,
  event = { 'CursorMoved', 'InsertEnter' },
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' },
    { 'j-hui/fidget.nvim' },
    { 'nvimdev/lspsaga.nvim' },
    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },
    { 'saadparwaiz1/cmp_luasnip' },
    -- Snippets
    {
      'L3MON4D3/LuaSnip',
      opts = {
        enable_autosnippets = true
      },
      build = "make install_jsregexp",
    },
    { 'rafamadriz/friendly-snippets' },
    -- Other
    { 'nvim-telescope/telescope.nvim' },
    { 'creativenull/efmls-configs-nvim' },
    {
      'folke/lazydev.nvim',
      ft = "lua",
      dependencies = { "Bilal2453/luvit-meta" },
      config = function()
        require("lazydev").setup({
          library = {
            { path = "luvit-meta/library", words = { "vim%.uv" } },
          },
        })
      end,
    }
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

        vim.keymap.set('n', 'gd', '<cmd>Lspsaga goto_definition<cr>', desc('goto definition'))
        vim.keymap.set('n', 'gr', '<cmd>Lspsaga finder<cr>', desc('goto reference'))
        vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>', desc('hover'))
        -- vim.keymap.set('n', '<leader>cw', function() vim.lsp.buf.workspace_symbol() end, desc('view workspace symbol'))
        vim.keymap.set('n', '<leader>cd', '<cmd>Lspsaga show_cursor_diagnostics<cr>', desc('view diagnostics'))
        vim.keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>', desc('goto previous diagnostic'))
        vim.keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<cr>', desc('goto next diagnostic'))
        vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<cr>', desc('view code actions'))
        vim.keymap.set('n', '<leader>cr', '<cmd>Lspsaga rename<cr>', desc('rename'))
        vim.keymap.set('i', '<C-k>', function() vim.lsp.buf.signature_help() end, desc('view signature help'))

        -- Format on save
        if client and client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_clear_autocmds({ group = lsp_auto_format_group, buffer = event.buf })
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = lsp_auto_format_group,
            buffer = event.buf,
            callback = function()
              if vim.b.disable_format_on_save then return end
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

    -- Better UI
    require('lspsaga').setup {
      border = 'none',
    }

    -- Server configs
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    local prettier_d = require('efmls-configs.formatters.prettier_d')
    local stylua = require('efmls-configs.formatters.stylua')
    local nixfmt = require('efmls-configs.formatters.nixfmt')
    local languages = {
      javascript = { prettier_d, },
      javascriptreact = { prettier_d, },
      typescript = { prettier_d, },
      typescriptreact = { prettier_d, },
      html = { prettier_d, },
      css = { prettier_d, },
      json = { prettier_d, },
      lua = { stylua },
      nix = { nixfmt }
    }


    require('lazy-lsp').setup {
      excluded_servers = {
        "ccls",                            -- prefer clangd
        "denols",                          -- prefer eslint and ts_ls
        "docker_compose_language_service", -- yamlls should be enough?
        "flow",                            -- prefer eslint and ts_ls
        "ltex",                            -- grammar tool using too much CPU
        "quick_lint_js",                   -- prefer eslint and ts_ls
        "scry",                            -- archived on Jun 1, 2023
        "tailwindcss",                     -- associates with too many filetypes
        "biome",                           -- not mature enough to be default
        "oxlint",                          -- prefer eslint
      },
      preferred_servers = {
        markdown = {},
        python = { "basedpyright", "ruff" },
      },
      default_config = {
        capabilities = lsp_capabilities,
      },
      configs = {
        spyglassmc_language_server = {
          filetypes = { 'mcfunction' }
        },
        efm = {
          filetypes = vim.tbl_keys(languages),
          capabilities = lsp_capabilities,
          init_options = {
            documentFormatting = true,
            documentRangerFormatting = true,
          },
          settings = {
            rootMarkers = { '.git/' },
            languages = languages,
          },
        },
        svelte = {
          settings = {
            svelte = {
              plugin = {
                svelte = {
                  compilerWarnings = {
                    ['a11y_label_has_associated_control'] = 'ignore',
                  },
                },
              },
            },
          },
        },
      },
    }

    -- Completion
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    cmp.setup {
      sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'buffer',  keyword_length = 3 },
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-Tab>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if luasnip.expandable() then
              luasnip.expand()
            elseif cmp.get_active_entry() then
              cmp.confirm({
                select = true,
              })
            end
          end
          fallback()
        end),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end
      }
    }

    -- Load snippets
    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip.loaders.from_lua').load { paths = { vim.fn.stdpath('config') .. '/lua/snippets/' } }

    -- Lsp Indicator
    require('fidget').setup {}
  end,
}
