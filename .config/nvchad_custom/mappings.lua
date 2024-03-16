---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    ["<leader>ls"] = "",
    ["<leader>f"] = "",
    ["<leader>fm"] = "",
    ["K"] = "",
    ["j"] = "",
    ["k"] = "",
  },

  i = {
    ["<C-b>"] = "",
    ["<C-e>"] = "",
    ["<C-h>"] = "",
    ["<C-j>"] = "",
    ["<C-k>"] = "",
    ["<C-l>"] = "",
  },
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>ww"] = { ":set wrap! <CR>", "toggle wrap" },
    ["<leader>s"] = { "/", "search word" },
    ["<leader>gb"] = { ':execute "!git blame -L"  . eval(line(".")-5) . ",+10 %"<CR>', "search word" },

    ["n"] = { "nzzzv", "next word middle screen" },
    ["N"] = { "Nzzzv", "previous word middle screen" },
    ["J"] = { "mzJ`z", "concat word without moving cursor" },

    ["Y"] = { "y$", "yank the rest" },

    ["<C-Left>"] = { ":vertical resize +5 <CR>", "resize to left" },
    ["<C-Right>"] = { ":vertical resize -5 <CR>", "resize to right" },
    ["<C-Up>"] = { ":resize +5 <CR>", "resize to up" },
    ["<C-Down>"] = { ":resize -5 <CR>", "resize to down" },

    ["<C-w>h"] = { "<C-w>H", "swap windows" },
    ["<C-w>j"] = { "<C-w>J", "swap windows" },
    ["<C-w>k"] = { "<C-w>K", "swap windows" },
    ["<C-w>l"] = { "<C-w>L", "swap windows" },

    ["<expr>k"] = { 'v:count > 5 ? "m\'" . v:count : "") . "k"', "escape jump" },
    ["<expr>j"] = { 'v:count > 5 ? "m\'" . v:count : "") . "j"', "escape jump" },

    ["<leader>h"] = { "^", "head alernative" },
    ["<leader>l"] = { "$", "tail alernative" },

    -- overwrite
    ["<leader>n"] = { "<cmd> set nu! rnu! <CR>", "toggle line number" },
  },

  v = {
    -- ["p"] = { '"_dP', "virutal paste without overwrite clipboard" },
    ['"'] = { '<esc>`>a"<esc>`<i"<esc>', "auto bracket" },
    ["'"] = { "<esc>`>a'<esc>`<i'<esc>", "auto bracket" },
    ["("] = { "<esc>`>a)<esc>`<i(<esc>", "auto bracket" },
    ["["] = { "<esc>`>a]<esc>`<i[<esc>", "auto bracket" },
  },
}

-- more keybinds!
M.lspconfig = {
  n = {
    ["gh"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature_help",
    },

    ["<leader>d"] = {
      function()
        vim.diagnostic.open_float()
      end,
      "Floating diagnostic",
    },

    ["<leader>i"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    },

    ["<leader>k"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },

    ["ga"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "LSP implementation",
    },

  },
}

return M
