#!/usr/bin/env -S nvim --headless -c ':lua test_bkb_all()' -u

-- Note, users can also run this file interactively using the following command:
-- nvim -u './tests/minimal_init.lua'

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.rtp:append("./")
vim.opt.rtp:append("../config")

local bpu = require("config.infra.utils")

-- Test dependencies
-- plenary
local plenary_lazy_spec = bpu:declare_lazy_spec(
  "config.infra.plugins.plenary",
  {}
)

local lazy_plugin_infra = require("config.infra.lazy")
lazy_plugin_infra.setup_plugins({
  -- All options: https://lazy.folke.io/configuration
  spec = bpu.final_lazy_spec,
  install = {
    missing = true,
  },
  rocks = {
    enabled = true,
  },
  checker = {
    -- Disable checking for autoupdates, because this is a test runner that is primarily intended for a non-interactive use
    enabled = false,
  },
})

local Path = require("plenary.path")
local THIS_SCRIPT_ABSOLUTE_PATH_STR = Path.new(debug.getinfo(1, "S").source:sub(2)):absolute()
local CONFIG_DIR_PATH_STR = Path.new(THIS_SCRIPT_ABSOLUTE_PATH_STR):parent():joinpath("../config"):absolute()

function test_bkb_all()
  local plenary_test_harness = require("plenary.test_harness")

  local test_dirs_glob = tostring(Path.new(CONFIG_DIR_PATH_STR):joinpath("**/tests/"))
  local test_directories = vim.split(vim.fn.glob(test_dirs_glob), "\n", { trimempty = true })

  for _, test_dir in pairs(test_directories) do
    local plenary_test_args = test_dir .. " " .. vim.inspect({
      init = THIS_SCRIPT_ABSOLUTE_PATH_STR
    }):gsub("\n", " ")

    plenary_test_harness.test_directory_command(plenary_test_args)
  end
end
