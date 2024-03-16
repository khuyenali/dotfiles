-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
--

local opt = vim.opt

opt.ignorecase = false
opt.relativenumber = true
opt.undofile = false
opt.wrap = false
opt.shiftwidth = 2
opt.tabstop = 2
-- opt.softtabstop = 2
opt.scrolloff = 5
opt.expandtab = true
opt.mouse = ""
