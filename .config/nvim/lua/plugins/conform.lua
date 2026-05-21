local M = {}

function M.setup()
  require('conform').setup {
    notify_on_error = true,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'black' },
      javascript = { { 'prettier' } },
    },
  }
end

return M
