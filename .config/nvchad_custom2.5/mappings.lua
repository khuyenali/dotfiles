require "nvchad.mappings"

local nomap = vim.keymap.del

nomap("n", "<leader>fm")

nomap("i", "<C-b>")
nomap("i", "<C-e>")
nomap("i", "<C-h>")
nomap("i", "<C-j>")
nomap("i", "<C-k>")
nomap("i", "<C-l>")

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "enter command mode" })
map("n", "<leader>ww", ":set wrap! <CR>", { desc = "toggle wrap" })
map("n", "<leader>s", "/", { desc = "search word" })
map("n", "<leader>gb", ':execute "!git blame -L"  . eval(line(".")-5) . ",+10 %"<CR>', { desc = "search word" })

map("n", "n", "nzzzv", { desc = "next word middle screen" })
map("n", "N", "Nzzzv", { desc = "previous word middle screen" })
map("n", "J", "mzJ`z", { desc = "concat word without moving cursor" })

map("n", "Y", "y$", { desc = "yank the rest" })

map("n", "<C-Left>", ":vertical resize +5 <CR>", { desc = "resize to left" })
map("n", "<C-Right>", ":vertical resize -5 <CR>", { desc = "resize to right" })
map("n", "<C-Up>", ":resize +5 <CR>", { desc = "resize to up" })
map("n", "<C-Down>", ":resize -5 <CR>", { desc = "resize to down" })

map("n", "<C-w>h", "<C-w>H", { desc = "swap windows" })
map("n", "<C-w>j", "<C-w>J", { desc = "swap windows" })
map("n", "<C-w>k", "<C-w>K", { desc = "swap windows" })
map("n", "<C-w>l", "<C-w>L", { desc = "swap windows" })

map("n", "<expr>k", 'v:count > 5 ? "m\'" . v:count : "") . "k"', { desc = "escape jump" })
map("n", "<expr>j", 'v:count > 5 ? "m\'" . v:count : "") . "j"', { desc = "escape jump" })

map("n", "<leader>h", "^", { desc = "head alernative" })
map("n", "<leader>l", "$", { desc = "tail alernative" })
map("n", "<leader>n", "<cmd> set nu! rnu! <CR>", { desc = "toggle line number" })

map("v", '"', '<esc>`>a"<esc>`<i"<esc>', { desc = "auto bracket" })
map("v", "'", "<esc>`>a'<esc>`<i'<esc>", { desc = "auto bracket" })
map("v", "(", '<esc>`>a)<esc>`<i(<esc>', { desc = "auto bracket" })
map("v", "[", '<esc>`>a]<esc>`<i[<esc>', { desc = "auto bracket" })


map("n", "gh",
  function()
    vim.lsp.buf.signature_help()
  end, { desc = "LSP signature_help" })

map("n", "<leader>d",
  function()
    vim.diagnostic.open_float()
  end, { desc = "Floating diagnostic" })

map("n", "<leader>i",
  function()
    require("conform").format { lsp_fallback = true }
  end,
  { desc = "LSP formatting" })

map("n", "<leader>k",
  function()
    vim.lsp.buf.hover()
  end,
  { desc = "LSP hover" })

map("n", "ga",
  function()
    vim.lsp.buf.implementation()
  end,
  { desc = "LSP implementation" })
