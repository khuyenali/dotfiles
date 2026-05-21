local M = {}

function M.setup()
  require('nvim-autopairs').setup {}

  local cmp = require 'cmp'
  local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
  local luasnip = require 'luasnip'

  require('luasnip.loaders.from_vscode').lazy_load()
  luasnip.config.setup {}
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

  cmp.setup {
    window = {
      completion = {
        side_padding = 1,
        border = 'rounded',
        winhighlight = 'Normal:NormalFloat',
        scrollbar = false,
      },

      documentation = {
        border = 'rounded',
        winhighlight = 'FloatBorder:FloatBorder',
      },
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    completion = { completeopt = 'menu,menuone,noinsert' },

    mapping = cmp.mapping.preset.insert {
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),

      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),

      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },

      ['<C-Space>'] = cmp.mapping.complete {},
    },
    sources = {
      { name = 'lazydev', group_index = 0 },
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
    },
  }
end

return M
