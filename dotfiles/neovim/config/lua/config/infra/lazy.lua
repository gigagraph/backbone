local M = {}

-- Download lazy.nvim if it has not been downloaded yet
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not(vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  local out = ""
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local lazy = require("lazy")

-- Assume that the mapleader and maplocalleader have already been set by the
-- loading script

-- Function that setup lazy.nvim with the plugin configuration managed by the
-- caller
function M.setup_plugins(setup_config)
  -- Caller of the function has control to override the default spec declared here
  local final_config = vim.tbl_deep_extend(
    "force",
    {
      -- All options: https://lazy.folke.io/configuration
    },
    setup_config
  )

  lazy.setup(final_config)
end

return M
