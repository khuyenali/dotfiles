local configs = require("nvchad.configs.lspconfig")

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

--local on_attach = require("nvchad.configs.lspconfig").on_attach
--local capabilities = require("nvchad.configs.lspconfig").capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require("lspconfig")

-- if you just want default config for the servers then put them in a table
local servers = {
  "html",
  "cssls",
  "tsserver",

  "pyright",

  "bashls",

  "rust_analyzer",
  "r_language_server",

  "bufls",
  "gopls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

lspconfig["clangd"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
})
