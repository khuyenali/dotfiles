local M = {}

local parsers = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc' }
local installing = {}

local function installed_parser_map(treesitter)
  local installed = {}
  for _, parser in ipairs(treesitter.get_installed 'parsers') do
    installed[parser] = true
  end
  return installed
end

local function available_parser_map(treesitter)
  local available = {}
  for _, parser in ipairs(treesitter.get_available()) do
    available[parser] = true
  end
  return available
end

local function start_treesitter(bufnr)
  pcall(vim.treesitter.start, bufnr)

  if vim.bo[bufnr].filetype ~= 'ruby' then
    vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

local function install_parser_for_buffer(treesitter, bufnr, available)
  if vim.g.khuyenali_skip_treesitter_auto_install or vim.fn.executable 'tree-sitter' ~= 1 then
    return
  end

  local filetype = vim.bo[bufnr].filetype
  local parser = vim.treesitter.language.get_lang(filetype)
  if not parser or not available[parser] then
    return
  end

  if installing[parser] then
    return
  end

  local installed = installed_parser_map(treesitter)
  if installed[parser] then
    return
  end

  installing[parser] = true
  treesitter.install(parser):await(function(err)
    installing[parser] = nil

    if err then
      vim.schedule(function()
        vim.notify(('Failed to install Treesitter parser %s: %s'):format(parser, err), vim.log.levels.WARN)
      end)
      return
    end

    vim.schedule(function()
      for _, open_bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(open_bufnr) and vim.treesitter.language.get_lang(vim.bo[open_bufnr].filetype) == parser then
          start_treesitter(open_bufnr)
        end
      end
    end)
  end)
end

function M.setup()
  local treesitter = require 'nvim-treesitter'
  treesitter.setup {
    install_dir = vim.fn.stdpath 'data' .. '/site',
  }

  local available = available_parser_map(treesitter)

  if vim.g.khuyenali_skip_treesitter_auto_install then
    -- Parser installation is being handled by the caller.
  elseif vim.fn.executable 'tree-sitter' == 1 then
    local installed = installed_parser_map(treesitter)
    local missing = {}
    for _, parser in ipairs(parsers) do
      if available[parser] and not installed[parser] then
        table.insert(missing, parser)
      end
    end

    if #missing > 0 then
      treesitter.install(missing)
    end
  else
    vim.notify('Skipping Treesitter parser install until tree-sitter-cli is available', vim.log.levels.WARN)
  end

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('khuyenali-treesitter', { clear = true }),
    callback = function(event)
      install_parser_for_buffer(treesitter, event.buf, available)
      start_treesitter(event.buf)
    end,
  })
end

return M
