require 'options'
require 'mappings'
local colors = require 'colors'

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      require('gruvbox').setup {
        overrides = {
          SignColumn = { bg = colors.bg0 },

          NormalFloat = { fg = colors.fg, bg = colors.bg0 },
          FloatBorder = { fg = colors.bg3, bg = colors.bg0 },

          LspInfoBorder = { link = 'FloatBorder' },

          -- Statusline = { bg = '#076678' },
          -- MiniStatuslineFilename = { bg = colors.bg2 },
          MiniStatusLineInactive = { fg = '#d79921', bg = colors.bg1 },

          -- MiniStatuslineFilename = { bg = colors.bg4 },
          -- MiniStatusLineInactive = { bg = colors.bg4},

          TelescopeBorder = { fg = colors.fg, bg = colors.bg2 },
          TelescopeNormal = { link = 'NormalFloat' },
          TelescopeResultsBorder = { link = 'FloatBorder' },
          TelescopePromptBorder = { link = 'FloatBorder' },
          TelescopePreviewBorder = { link = 'FloatBorder' },
          TelescopeSelection = { bg = colors.bg2 },

          -- ['@punctuation.bracket'] = { fg = colors.orange },
          -- ['@punctuation.special'] = { fg = colors.orange },
          -- ['@punctuation.delimiter'] = { fg = colors.orange },

          ['@function'] = { fg = colors.blue },
          ['@function.method'] = { fg = colors.blue },
          ['@function.call'] = { fg = colors.blue },
          ['@function.builtin'] = { fg = colors.blue },

          Keyword = { fg = colors.purple },
          ['@keyword.repeat'] = { link = 'Keyword' },
          ['@keyword.operator'] = { link = 'Keyword' },
          ['@keyword.exception'] = { link = 'Keyword' },
          ['@keyword.conditional'] = { link = 'Keyword' },

          ['@variable'] = { fg = colors.fg },
          ['@variable.parameter'] = { fg = colors.red },
          ['@variable.member'] = { fg = colors.red },

          ['@constant'] = { fg = colors.yellow },
          ['@constant.builtin'] = { link = '@constant' },

          ['@constructor'] = { fg = colors.purple },
          ['@operator'] = { fg = colors.aqua },

          LspReferenceRead = { bg = colors.bg2 },
          LspReferenceText = { bg = colors.bg2 },
        },
      }
      vim.cmd 'colorscheme gruvbox'

      -- vim.cmd [[colorscheme gruvbox-material]]
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },

  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup {
        size = 20,
        open_mapping = [[<M-i>]],
        hide_number = true,
        start_in_insert = true,
        direction = 'float',
        -- shade_terminals = false,
        shade_terminals = true,
        shading_factor = 0, --
        highlights = {
          -- Normal = {
          --   guibg = '<VALUE-HERE>',
          -- },
          -- NormalFloat = {
          --   link = 'Normal',
          -- },
          FloatBorder = {
            link = 'FloatBorder',
          },
        },
        float_opts = {
          border = 'rounded',
          background = 'light',
        },
      }
    end,
  },

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon.setup {}

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():append()
      end)
      vim.keymap.set('n', '<leader>fp', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      -- basic telescope configuration
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
    end,
  },

  -- {
  --   'kevinhwang91/nvim-bqf',
  --   config = function()
  --     require('bqf').setup {
  --       auto_enable = true,
  --       magic_window = true,
  --       auto_resize_height = false,
  --       preview = {
  --         auto_preview = false,
  --         show_title = true,
  --         delay_syntax = 50,
  --         wrap = false,
  --       },
  --       func_map = {
  --         tab = 't',
  --         openc = 'o',
  --         drop = 'O',
  --         split = 's',
  --         vsplit = 'v',
  --         stoggleup = 'M',
  --         stoggledown = 'm',
  --         stogglevm = 'm',
  --         filterr = 'f',
  --         filter = 'F',
  --         prevhist = '<',
  --         nexthist = '>',
  --         sclear = 'c',
  --         ptoggleitem = 'p',
  --         ptoggleauto = 'a',
  --         ptogglemode = 'P',
  --       },
  --     }
  --   end,
  -- },

  {
    'norcalli/nvim-colorizer.lua',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('colorizer').setup()
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        untracked = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup {}

      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      }
    end,
  },

  require 'plugins.indent_line',
  require 'plugins.telescope',
  require 'plugins.lspconfig',
  require 'plugins.cmp',
  require 'plugins.mini',
  require 'plugins.treesitter',
  require 'plugins.conform',
  require 'plugins.nvim_tree',
}, {
  ui = {
    border = 'rounded',
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },

  performance = {
    rtp = {
      disabled_plugins = {
        '2html_plugin',
        'tohtml',
        'getscript',
        'getscriptPlugin',
        'gzip',
        'logipat',
        'netrw',
        'netrwPlugin',
        'netrwSettings',
        'netrwFileHandlers',
        'matchit',
        'tar',
        'tarPlugin',
        'rrhelper',
        'spellfile_plugin',
        'vimball',
        'vimballPlugin',
        'zip',
        'zipPlugin',
        'tutor',
        'rplugin',
        'syntax',
        'synmenu',
        'optwin',
        'compiler',
        'bugreport',
        'ftplugin',
      },
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
