local M = {}

M.treesitter = {
	ensure_installed = {
		"vim",
		"lua",
		"html",
		"css",
		"javascript",
		"typescript",
		"tsx",
		"c",
		"markdown",
		"markdown_inline",
	},
	indent = {
		enable = true,
		-- disable = {
		--   "python"
		-- },
	},
}

M.mason = {
	ensure_installed = {
		-- lua stuff
		"lua-language-server",
		"stylua",

		-- web dev stuff
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"deno",
		"prettier",

		-- c/cpp stuff
		-- "clangd",
		-- "clang-format",
	},
}

M.telescope = {
	defaults = {
		sorting_strategy = "descending",
		file_ignore_patterns = { "node_modules", ".git" },
		layout_config = {
			horizontal = {
				prompt_position = "bottom",
			},
		},
	},
}

M.gitsigns = {
	signs = {
		add = { hl = "DiffAdd", text = "┃", numhl = "GitSignsAddNr" },
		change = { hl = "DiffChange", text = "┃", numhl = "GitSignsChangeNr" },
		untracked = { hl = "GitSignsAdd", text = "┃", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
	},
}

M.nvterm = {
	terminals = {
		type_opts = {
			float = {
				relative = "editor",
				row = 0.05,
				col = 0.05,
				width = 0.90,
				height = 0.85,
				border = "single",
			},
		},
	},
}

-- git support in nvimtree
M.nvimtree = {
	git = {
		enable = true,
	},

	renderer = {
		highlight_git = true,
		icons = {
			show = {
				git = true,
			},
		},
	},
}

return M
