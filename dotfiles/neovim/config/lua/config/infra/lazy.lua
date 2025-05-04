local M = {}

local lazy = nil

local _set_mt = {
  __metatable = "BkbLazyMt"
}

_set_mt.__index = M

setmetatable(M, _set_mt)

-- Function that setup lazy.nvim with the plugin configuration managed by the caller
function M.setup_plugins(setup_config, lazy_instance)
  local lazy_instance = lazy_instance or lazy or error('Lazy is not initialized. Make sure to call .instance() function first or pass require("lazy") as the last argument to this function explicitly.')

  -- Caller of the function has control to override the default spec declared here
  local final_config = vim.tbl_deep_extend(
    "force",
    {
      -- All options: https://lazy.folke.io/configuration
    },
    setup_config
  )

  lazy_instance.setup(final_config)
end

function M.init()
  if not lazy then
    -- Download lazy.nvim if it has not been downloaded yet
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not(vim.uv or vim.loop).fs_stat(lazypath) then
      local lazyrepo = "https://github.com/folke/lazy.nvim.git"
      local out = vim.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
      if vim.v.shell_error ~= 0 then
        error("Failed to clone lazy.nvim:\n" .. "ErrorMsg: " .. out)
      end
    end
    vim.opt.rtp:prepend(lazypath)

    lazy = require("lazy")

    -- Assume that the mapleader and maplocalleader have already been set by the loading script
  end
end

return M
