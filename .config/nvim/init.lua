vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require 'options'
require 'mappings'

local overrides = require 'highlight'

local function gh(repo)
  return 'https://github.com/' .. repo
end

local function run_build(name, path, cmd)
  if vim.fn.executable(cmd[1]) == 0 then
    return
  end

  vim.system(cmd, { cwd = path }, function(result)
    if result.code ~= 0 then
      vim.schedule(function()
        vim.notify(('Build failed for %s: %s'):format(name, result.stderr), vim.log.levels.WARN)
      end)
    end
  end)
end

vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('khuyenali-pack-hooks', { clear = true }),
  callback = function(event)
    if event.data.kind ~= 'install' and event.data.kind ~= 'update' then
      return
    end

    local name = event.data.spec.name

    if name == 'LuaSnip' and vim.fn.has 'win32' == 0 then
      run_build(name, event.data.path, { 'make', 'install_jsregexp' })
    elseif name == 'telescope-fzf-native.nvim' then
      run_build(name, event.data.path, { 'make' })
    elseif name == 'nvim-treesitter' then
      vim.schedule(function()
        pcall(vim.cmd.packadd, name)
        pcall(vim.cmd.TSUpdate)
      end)
    end
  end,
})

vim.pack.add({
  { src = gh 'nvim-lua/plenary.nvim' },
  { src = gh 'nvim-tree/nvim-web-devicons' },

  { src = gh 'lukas-reineke/indent-blankline.nvim' },
  { src = gh 'nvim-telescope/telescope.nvim', version = 'master' },
  { src = gh 'nvim-telescope/telescope-fzf-native.nvim' },
  { src = gh 'nvim-telescope/telescope-ui-select.nvim' },

  { src = gh 'neovim/nvim-lspconfig' },
  { src = gh 'mason-org/mason.nvim' },
  { src = gh 'mason-org/mason-lspconfig.nvim' },
  { src = gh 'WhoIsSethDaniel/mason-tool-installer.nvim' },
  { src = gh 'j-hui/fidget.nvim' },
  { src = gh 'folke/lazydev.nvim' },

  { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' },
  { src = gh 'L3MON4D3/LuaSnip' },
  { src = gh 'rafamadriz/friendly-snippets' },
  { src = gh 'windwp/nvim-autopairs' },

  { src = gh 'nvim-mini/mini.nvim' },
  { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = gh 'stevearc/conform.nvim' },
  { src = gh 'nvim-tree/nvim-tree.lua' },

  { src = gh 'github/copilot.vim' },
  { src = gh 'ellisonleao/gruvbox.nvim' },
  { src = gh 'NMAC427/guess-indent.nvim' },
  { src = gh 'folke/todo-comments.nvim' },
  { src = gh 'akinsho/toggleterm.nvim' },
  { src = gh 'ThePrimeagen/harpoon', version = 'harpoon2' },
  { src = gh 'catgoose/nvim-colorizer.lua' },
  { src = gh 'lewis6991/gitsigns.nvim' },
  { src = gh 'folke/which-key.nvim' },
}, { confirm = false, load = true })

require('gruvbox').setup {
  overrides = overrides,
}
vim.cmd.colorscheme 'gruvbox'

require('plugins.indent_line').setup()
require('plugins.telescope').setup()
require('plugins.cmp').setup()
require('plugins.lspconfig').setup()
require('plugins.mini').setup()
require('plugins.treesitter').setup()
require('plugins.conform').setup()
require('plugins.nvim_tree').setup()

require('guess-indent').setup {}
require('todo-comments').setup { signs = false }
require('colorizer').setup()
require('gitsigns').setup {
  signs = {
    add = { text = '┃' },
    change = { text = '┃' },
    untracked = { text = '┃' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}
require('which-key').setup {}

require('toggleterm').setup {
  size = 20,
  open_mapping = [[<M-i>]],
  hide_number = true,
  start_in_insert = true,
  direction = 'float',
  shade_terminals = false,
  shading_factor = 0,
  highlights = {
    FloatBorder = {
      link = 'FloatBorder',
    },
  },
  float_opts = {
    border = 'rounded',
  },
}

local harpoon = require 'harpoon'
harpoon.setup {}

vim.keymap.set('n', '<leader>a', function()
  harpoon:list():add()
end)
vim.keymap.set('n', '<leader>fp', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

local conf = require('telescope.config').values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require('telescope.pickers')
    .new({}, {
      theme = 'dropdown',
      prompt_title = 'Harpoon',
      finder = require('telescope.finders').new_table {
        results = file_paths,
      },
      previewer = false,
      sorter = conf.generic_sorter {},
    })
    :find()
end

vim.keymap.set('n', '<C-e>', function()
  toggle_telescope(harpoon:list())
end, { desc = 'Open harpoon window' })
