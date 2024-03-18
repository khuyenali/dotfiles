local options = {
	-- lsp_fallback = true,

	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		markdown = { "prettier" },
		jsx = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		c = { "clang_format" },
		cpp = { "clang_format" },
		go = { "goimports" },
		rust = { "rustfmt" },
		python = { "black" },
	},
}

require("conform").setup(options)
