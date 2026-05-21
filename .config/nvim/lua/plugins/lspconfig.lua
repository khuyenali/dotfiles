local M = {}

function M.setup()
  require('fidget').setup {}
  require('lazydev').setup {
    library = {
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
  }

  local diagnostic_signs = {
    [vim.diagnostic.severity.ERROR] = '✘',
    [vim.diagnostic.severity.WARN] = '󰀪 ',
    [vim.diagnostic.severity.HINT] = '󰌶 ',
    [vim.diagnostic.severity.INFO] = ' ',
  }

  vim.diagnostic.config {
    virtual_text = false,
    signs = {
      text = diagnostic_signs,
      numhl = {
        [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
        [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
        [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
        [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
      },
    },
    float = {
      style = 'minimal',
      border = 'rounded',
    },
  }

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('khuyenali-lsp-attach', { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      map('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
      map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
      map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
      map('K', function()
        vim.lsp.buf.hover { border = 'rounded' }
      end, 'Hover Documentation')
      map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client ~= nil then
        client.server_capabilities.semanticTokensProvider = nil
      end

      if client and client.server_capabilities.documentHighlightProvider then
        local group = vim.api.nvim_create_augroup('khuyenali-lsp-highlight-' .. event.buf, { clear = true })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = group,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = group,
          callback = vim.lsp.buf.clear_references,
        })
      end
    end,
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

  local servers = {
    lua_ls = {
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
        },
      },
    },

    pyright = {
      settings = {
        python = {
          analysis = {
            typeCheckingMode = 'off',
          },
        },
      },
    },

    ts_ls = {
      init_options = {
        preferences = {
          disableSuggestions = true,
        },
      },
    },

    clangd = {
      cmd = { 'clangd', '--fallback-style=llvm', '--offset-encoding=utf-16' },
    },
  }

  require('mason').setup {
    ui = {
      border = 'rounded',
    },
  }

  local server_names = vim.tbl_keys(servers)
  table.sort(server_names)

  require('mason-lspconfig').setup {
    ensure_installed = server_names,
    automatic_enable = false,
  }

  require('mason-tool-installer').setup {
    ensure_installed = {
      'prettier',
      'stylua',
      'tree-sitter-cli',
    },
  }

  for name, server in pairs(servers) do
    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
    vim.lsp.config(name, server)
  end

  vim.lsp.enable(server_names)
end

return M
