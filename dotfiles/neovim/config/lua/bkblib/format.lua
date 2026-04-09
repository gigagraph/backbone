local M = {}

-- Global option that determines if autoformatting is enabled
vim.g.autoformat = true

-- Decide whether autoformat is enabled for this buffer right now.
--- @param bufnr? integer Buffer number.
--- @return boolean # True if autoformatting is enabled in the current buffer, false otherwise.
function M.is_enabled(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if vim.b[bufnr] then
    if vim.b[bufnr].autoformat == nil then
      return vim.g.autoformat
    else
      return vim.b[bufnr].autoformat
    end
  else
    return vim.g.autoformat
  end
end

-- Set global autoformat explicitly (true / false)
--- @param value boolean
function M.set_global_autoformat(value)
  if type(value) ~= "boolean" then
    error("autoformat value must be boolean")
  end

  vim.g.autoformat = value
  vim.notify(("Autoformat (global) set to: %s"):format(value and "ON" or "OFF"))
end

-- Toggle autoformat globally or for the current buffer.
--- @class bkblib.format.ToggleOpts
--- @field bufnr? integer When `global` is false, `bufrn` will toggle autoformatting for this buffer.
--- Not assigning the value means the current buffer.
--- @field global? boolean If true, autoformatting is toggled globally.
---
---@param opts? bkblib.format.ToggleOpts
function M.toggle(opts)
  opts = opts or {}
  local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()

  if opts.global then
    vim.g.autoformat = not vim.g.autoformat
    vim.notify(("Autoformat (global): %s"):format(vim.g.autoformat and "ON" or "OFF"))
  else
    local cur = M.is_enabled(bufnr)
    vim.b[bufnr].autoformat = not cur
    vim.notify(("Autoformat (buffer): %s"):format(vim.b[bufnr].autoformat and "ON" or "OFF"))
  end
end

-- Format using LSP (sync on save is the reliable choice)
--- @class bkblib.format.FormatOpts
--- @field bufnr? integer
--- @field force? boolean If true, the corresponding `bufnr` is respected regardless of M.is_enabled.
--- False, by default.
--- @field timeout_ms? integer
--- @field client_id? integer
---
--- @param opts? bkblib.format.FormatOpts
function M.format(opts)
  -- TODO: there is a bug with finding a language (after restarting LSP)

  opts = opts or {
    bufnr = vim.api.nvim_get_current_buf(),
    force = false,
    timeout_ms = 3000,
    client_id = nil,
  }

  if M.is_enabled(opts.bufnr) or opts.force then
    local has_lsp_client = false
    local client_id = opts.client_id
    -- Only try if some client attached to this buffer supports formatting
    if client_id then
      has_lsp_client = true
    else
      local clients = vim.lsp.get_clients({ bufnr = opts.bufnr, method = "textDocument/formatting" })
      if #clients > 0 then
        has_lsp_client = true
        -- If there is more than 1 client, select the 1st one
        client_id = clients[1].id
      end
    end

    if has_lsp_client then
      vim.lsp.buf.format({
        id = client_id,
        bufnr = opts.bufnr,
        async = false, -- important for BufWritePre
        timeout_ms = opts.timeout_ms,
      })
    end
  end
end

return M
