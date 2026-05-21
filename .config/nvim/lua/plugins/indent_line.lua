local M = {}

function M.setup()
  local hooks = require 'ibl.hooks'
  hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
  require('ibl').setup {
    scope = {
      enabled = false,
    },
  }
end

return M
