local colors = require 'colors'

return {
  -- Normal = { bg = colors.bg0_h },
  SignColumn = { bg = colors.bg0 },

  NormalFloat = { fg = colors.fg, bg = colors.bg0 },
  FloatBorder = { fg = colors.bg3, bg = colors.bg0 },

  LspInfoBorder = { link = 'FloatBorder' },
  String = { fg = colors.green, italic = false },

  QuickFixLine = { fg = colors.bg0, bg = colors.yellow },

  NormalNC = { bg = colors.bg0_s },

  NvimTreeWindowPicker = { link = 'Statusline' },

  -- Statusline = { bg = '#076678' },
  -- MiniStatuslineFilename = { bg = colors.bg2 },
  -- MiniStatusLineInactive = { fg = '#d79921', bg = colors.bg0 },
  MiniStatusLineInactive = { fg = colors.fg3, bg = colors.bg2 },

  -- MiniStatuslineFilename = { bg = colors.bg4 },
  -- MiniStatusLineInactive = { bg = colors.bg4},

  TelescopeBorder = { fg = colors.fg, bg = colors.bg2 },
  TelescopeNormal = { link = 'NormalFloat' },
  TelescopeResultsBorder = { link = 'FloatBorder' },
  TelescopePromptBorder = { link = 'FloatBorder' },
  TelescopePreviewBorder = { link = 'FloatBorder' },
  TelescopeSelection = { bg = colors.bg2 },

  -- ['@punctuation.bracket'] = { fg = colors.orange },
  -- ['@punctuation.special'] = { fg = colors.orange },
  -- ['@punctuation.delimiter'] = { fg = colors.orange },

  ['@function'] = { fg = colors.blue },
  ['@function.method'] = { fg = colors.blue },
  ['@function.call'] = { fg = colors.blue },
  ['@function.builtin'] = { fg = colors.blue },

  Keyword = { fg = colors.purple },
  ['@keyword.repeat'] = { link = 'Keyword' },
  ['@keyword.operator'] = { link = 'Keyword' },
  ['@keyword.exception'] = { link = 'Keyword' },
  ['@keyword.conditional'] = { link = 'Keyword' },

  ['@variable'] = { fg = colors.fg },
  ['@variable.parameter'] = { fg = colors.red },
  ['@variable.member'] = { fg = colors.red },

  ['@constant'] = { fg = colors.yellow },
  ['@constant.builtin'] = { link = '@constant' },

  ['@constructor'] = { fg = colors.purple },
  ['@operator'] = { fg = colors.aqua },

  LspReferenceRead = { bg = colors.bg2 },
  LspReferenceText = { bg = colors.bg2 },
}
