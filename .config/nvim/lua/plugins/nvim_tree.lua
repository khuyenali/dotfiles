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

    end,
  },
}
