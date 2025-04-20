return {
  -- Note: this plugin depends on the system C/C++ toolchain (
  -- C and C++ compiler, libstdc++) and make build system
  "nvim-treesitter/nvim-treesitter",
  name = "nvim-treesitter",
  version = "~0.9.3",
  build = ":TSUpdate",
  pin = false,
  lazy = false,
}
