-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<C-n>', ':cn<CR>zz', { desc = '[N]ext item in quick fix list' })
vim.keymap.set('n', '<C-p>', ':cp<CR>zz', { desc = '[P]revious item in quick fix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = 'File Save' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-w>h', '<C-w>H', { desc = 'Move windows' })
vim.keymap.set('n', '<C-w>j', '<C-w>J', { desc = 'Move windows' })
vim.keymap.set('n', '<C-w>k', '<C-w>K', { desc = 'Move windows' })
vim.keymap.set('n', '<C-w>l', '<C-w>L', { desc = 'Move windows' })

vim.keymap.set('n', '<leader>ww', ':set wrap! <CR>', { desc = 'toggle wrap' })
vim.keymap.set('n', '<leader>gb', ':execute "!git blame -L"  . eval(line(".")-5) . ",+10 %"<CR>', { desc = 'git blame' })

vim.keymap.set('n', 'n', 'nzzzv', { desc = 'next word middle screen' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'previous word middle screen' })
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'concat word without moving cursor' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down with center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up with center' })

vim.keymap.set('n', '<C-Left>', ':vertical resize +5 <CR>', { desc = 'resize to left' })
vim.keymap.set('n', '<C-Right>', ':vertical resize -5 <CR>', { desc = 'resize to right' })
vim.keymap.set('n', '<C-Up>', ':resize +5 <CR>', { desc = 'resize to up' })
vim.keymap.set('n', '<C-Down>', ':resize -5 <CR>', { desc = 'resize to down' })

vim.keymap.set('n', '<leader>n', '<cmd>NvimTreeToggle<CR>', { desc = 'Nvimtree Toggle window' })
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeFocus<CR>', { desc = 'Nvimtree Focus window' })

vim.keymap.set('n', '<leader>l', '<cmd> set nu! rnu! <CR>', { desc = 'toggle line number' })
-- vim.keymap.set('n', '<expr>k', 'v:count > 5 ? "m\'" . v:count : "") . "k"', { desc = 'escape jump' })
-- vim.keymap.set('n', '<expr>j', 'v:count > 5 ? "m\'" . v:count : "") . "j"', { desc = 'escape jump' })

vim.keymap.set('n', '<leader>i', function()
  require('conform').format { lsp_fallback = true }
end, { desc = 'LSP formatting' })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim.api.nvim_create_autocmd({ 'UIEnter', 'BufReadPost', 'BufNewFile' }, {
--   group = vim.api.nvim_create_augroup('filepost', { clear = true }),
--   callback = function(args)
--     local file = vim.api.nvim_buf_get_name(args.buf)
--     local buftype = vim.api.nvim_buf_get_option(args.buf, 'buftype')
--
--     if not vim.g.ui_entered and args.event == 'UIEnter' then
--       vim.g.ui_entered = true
--     end
--
--     if file ~= '' and buftype ~= 'nofile' and vim.g.ui_entered then
--       vim.api.nvim_exec_autocmds('User', { pattern = 'FilePost', modeline = false })
--     end
--   end,
-- })
