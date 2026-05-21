local M = {}

function M.setup()
  local actions = require 'telescope.actions'

  require('telescope').setup {
    defaults = {
      entry_prefix = '   ',
      selection_caret = ' > ',
      prompt_prefix = '   ',
      initial_mode = 'insert',
      selection_strategy = 'reset',
      path_display = { 'truncate' },
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--hidden',
        '--glob=!.git/',
      },
    },

    pickers = {
      live_grep = {
        theme = 'dropdown',
      },

      grep_string = {
        theme = 'dropdown',
      },

      find_files = {
        theme = 'dropdown',
        path_display = { 'smart' },
        previewer = false,
      },

      buffers = {
        theme = 'dropdown',
        previewer = false,
        mappings = {
          i = {
            ['<C-d>'] = actions.delete_buffer,
          },
          n = {
            ['dd'] = actions.delete_buffer,
          },
        },
      },

      planets = {
        show_pluto = true,
        show_moon = true,
      },

      colorscheme = {
        enable_preview = true,
      },

      lsp_references = {
        theme = 'dropdown',
        initial_mode = 'normal',
        path_display = { 'smart' },
      },

      lsp_definitions = {
        theme = 'dropdown',
        initial_mode = 'normal',
      },

      lsp_declarations = {
        theme = 'dropdown',
        initial_mode = 'normal',
      },

      lsp_implementations = {
        theme = 'dropdown',
        initial_mode = 'normal',
      },
    },
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(),
      },
    },
  }

  pcall(require('telescope').load_extension, 'fzf')
  pcall(require('telescope').load_extension, 'ui-select')

  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
  vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
  vim.keymap.set('n', '<leader>fw', function()
    builtin.live_grep { debounce = 500 }
  end, { desc = '[F]ind by [G]rep' })
  vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
  vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
  vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = '[ ] Find existing buffers' })
  vim.keymap.set('n', '<leader>hl', builtin.highlights, { desc = '[H]ight [L]ight' })

  vim.keymap.set('n', '<leader>s/', function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end, { desc = '[F]ind [/] in Open Files' })

  vim.keymap.set('n', '<leader>sn', function()
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
  end, { desc = '[F]ind [N]eovim files' })
end

return M
