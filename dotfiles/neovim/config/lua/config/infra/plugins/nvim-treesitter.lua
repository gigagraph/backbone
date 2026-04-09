return {
  -- Note: this plugin depends on the system C/C++ toolchain (
  -- C and C++ compiler, libstdc++) and make build system
  "nvim-treesitter/nvim-treesitter",
  name = "nvim-treesitter",
  version = "4916d6592ede8c07973490d9322f187e07dfefac",
  build = ":TSUpdate",
  pin = false,
  lazy = false,
}
