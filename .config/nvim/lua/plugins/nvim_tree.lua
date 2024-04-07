return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        filters = {
          dotfiles = true,
        },
        view = {
          relativenumber = true,
          signcolumn = 'no',
          width = 35,
        },
        update_focused_file = {
          enable = true,
          update_root = false,
        },
        git = {
          enable = true,
          ignore = true,
        },
      }

      vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { desc = 'Nvimtree Toggle window' })
      vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeFocus<CR>', { desc = 'Nvimtree Focus window' })
    end,
  },
}
