local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },

      -- "mfussenegger/nvim-jdtls",
    },
    config = function()
      vim.diagnostic.config {
        virtual_text = false,
        signs = true,
        underline = true,
      }
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = overrides.gitsigns,
  },

  {
    "NvChad/nvterm",
    opts = overrides.nvterm,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "mfussenegger/nvim-jdtls",
    event = "BufEnter",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      vim.diagnostic.config {
        virtual_text = false,
        signs = true,
        underline = true,
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          local config = {
            cmd = { "/home/khuyenali/.local/jdt-language-server/bin/jdtls" },
            root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
            require("plugins.configs.lspconfig").on_attach,
            on_attach = require("plugins.configs.lspconfig").on_attach,
            capabilities = require("plugins.configs.lspconfig").capabilities,
          }
          require("jdtls").start_or_attach(config)
        end,
      })
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },
}

return plugins
