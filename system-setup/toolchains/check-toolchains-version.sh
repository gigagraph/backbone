#!/usr/bin/env bash

TOOLCHAIN_VERSION_CMDS=(
  "clang --version"
  "clang++ --version"
  "python3.12 --version"
  "pipx --version"
  "uv --version && uvx --version"
  "go version"
  "rustc --version && cargo --version"
  "fnm --version && node --version && npm --version && pnpm --version"
  "java --version && javac --version"
  "perl --version"
  "luajit -v"
  "luarocks --version"
  "lualatex --version"
  "docker version"
  "tree-sitter --version"
)

for TOOLCHAIN_VERSION_CMD in "${TOOLCHAIN_VERSION_CMDS[@]}"; do
  echo "--------------------------------------------------------------------------------"
  echo "${TOOLCHAIN_VERSION_CMD}"
  echo "================================================================================"
  eval "${TOOLCHAIN_VERSION_CMD}"
  echo "================================================================================"
done
