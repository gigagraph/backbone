return {
  "nvim-telescope/telescope-fzf-native.nvim",
  name = "telescope-fzf-native.nvim",
  build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
  version = "6fea601bd2b694c6f2ae08a6c6fab14930c60e2c",
  pin = false,
  lazy = false,
}
