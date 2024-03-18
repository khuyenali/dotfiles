-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}
local lineColor = "#928375"

---@type Base46HLGroupsList
M.override = {
	-- Telescope
	TelescopeBorder = { fg = "red" },
	TelescopeResultsTitle = { fg = "black", bg = "yellow" },

	-- Nvimtree
	NvimTreeOpenedFolderName = { fg = "green", bold = true },
	NvimTreeWinSeparator = { fg = lineColor },

	-- Git sign
	DiffAdd = { fg = "green" },
	DiffChange = { fg = lineColor },
	DiffDelete = { fg = "red" },

	-- Treesister
	["@punctuation.bracket"] = { fg = "yellow" },
	["@punctuation.spcial"] = { fg = "yellow" },
	["@punctuation.delimiter"] = { fg = "yellow" },
	["@comment"] = { fg = lineColor },

	-- IndentLine
	IndentBlanklineChar = { fg = "grey", nocombine = true },
	IndentBlanklineSpaceChar = { fg = "grey", nocombine = true },
	IndentBlanklineContextChar = { fg = lineColor, nocombine = true },

	-- Cmp windows
	CmpBorder = { fg = "red" },
	CmpDocBorder = { fg = "red" },

	-- Line number (left bar)
	LineNr = { fg = "light_grey" },
	CursorLineNr = { fg = "yellow" },

	CursorLine = { bg = "one_bg" },
	WinSeparator = { fg = lineColor },
	Comment = { fg = lineColor },

	-- Character = { fg = 'white' }, -- wrong
}

---@type HLTable
-- M.add = {
--
-- }

return M
