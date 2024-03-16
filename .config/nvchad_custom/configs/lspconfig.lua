local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = {
  "html",
  "cssls",
  "tsserver",

  "pyright",

  "bashls",

  "rust_analyzer",
  "r_language_server",

  "emmet_language_server",

  "bufls",
  "gopls",
}

for i, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig["clangd"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
}
