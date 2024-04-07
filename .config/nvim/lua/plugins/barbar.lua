local colors = require 'colors'

return {
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    config = function()
      vim.api.nvim_set_hl(0, 'BufferCurrent', { fg = colors.fg, bg = colors.bg2 })
      vim.api.nvim_set_hl(0, 'BufferCurrentMod', { fg = colors.red, bg = colors.bg2 })
      vim.api.nvim_set_hl(0, 'BufferCurrentSign', { fg = colors.yellow, bg = colors.bg2 })

      vim.api.nvim_set_hl(0, 'BufferVisible', { fg = colors.bg4, bg = colors.bg0 })
      vim.api.nvim_set_hl(0, 'BufferVisibleMod', { fg = colors.red, bg = colors.bg0 })
      vim.api.nvim_set_hl(0, 'BufferVisibleSign', { fg = colors.bg0, bg = colors.bg0 })

      vim.api.nvim_set_hl(0, 'BufferInactive', { fg = colors.bg4, bg = colors.bg0 })
      vim.api.nvim_set_hl(0, 'BufferInactiveMod', { fg = colors.red, bg = colors.bg0 })
      vim.api.nvim_set_hl(0, 'BufferInactiveSign', { fg = colors.bg0, bg = colors.bg0 })

      vim.api.nvim_set_hl(0, 'BufferTabpageFill', { bg = colors.bg0 })
      require('barbar').setup {
        icons = {
          filetype = {
            custom_colors = false,
            enabled = true,
          },
        },
      }

    end,
  },
}
