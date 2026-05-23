local M = {}

function M.setup()
  require('nvim-autopairs').setup {}

  local luasnip = require 'luasnip'
  require('luasnip.loaders.from_vscode').lazy_load()
  luasnip.config.setup {}

  require('blink.cmp').setup {
    keymap = {
      preset = 'default',
      ['<CR>'] = { 'select_and_accept', 'fallback' },
      ['<Tab>'] = {
        function(cmp)
          if cmp.is_menu_visible() then
            return cmp.select_next()
          elseif cmp.snippet_active { direction = 1 } then
            return cmp.snippet_forward()
          else
            return cmp.show()
          end
        end,
        'fallback',
      },
      ['<S-Tab>'] = {
        function(cmp)
          if cmp.is_menu_visible() then
            return cmp.select_prev()
          elseif cmp.snippet_active { direction = -1 } then
            return cmp.snippet_backward()
          end
        end,
        'fallback',
      },
    },
    appearance = {
      nerd_font_variant = 'mono',
    },
    completion = {
      menu = {
        border = 'rounded',
        scrollbar = false,
      },
      documentation = {
        auto_show = false,
        window = {
          border = 'rounded',
        },
      },
    },
    sources = {
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lazydev = {
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },
    snippets = {
      preset = 'luasnip',
    },
    fuzzy = {
      implementation = 'lua',
    },
    signature = {
      enabled = true,
    },
  }
end

return M
