return {
  "nvim-telescope/telescope-fzf-native.nvim",
  name = "telescope-fzf-native.nvim",
  build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
  version = "1f08ed60cafc8f6168b72b80be2b2ea149813e55",
  pin = false,
  lazy = false,
}
