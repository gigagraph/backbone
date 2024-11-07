#!/usr/bin/env bash

LLVM_VERSION=18

sudo apt install -y \
  libllvm-${LLVM_VERSION}-ocaml-dev \
  libllvm${LLVM_VERSION} \
  llvm-${LLVM_VERSION} \
  llvm-${LLVM_VERSION}-dev \
  llvm-${LLVM_VERSION}-doc \
  llvm-${LLVM_VERSION}-examples \
  llvm-${LLVM_VERSION}-runtime \
  clang-${LLVM_VERSION} \
  clang-tools-${LLVM_VERSION} \
  clang-${LLVM_VERSION}-doc \
  libclang-common-${LLVM_VERSION}-dev \
  libclang-${LLVM_VERSION}-dev \
  libclang1-${LLVM_VERSION} \
  clang-format-${LLVM_VERSION} \
  python3-clang-${LLVM_VERSION} \
  clangd-${LLVM_VERSION} \
  clang-tidy-${LLVM_VERSION} \
  libclang-rt-${LLVM_VERSION}-dev \
  libpolly-${LLVM_VERSION}-dev \
  libfuzzer-${LLVM_VERSION}-dev \
  lldb-${LLVM_VERSION} \
  lld-${LLVM_VERSION} \
  libc++-${LLVM_VERSION}-dev \
  libc++abi-${LLVM_VERSION}-dev \
  libomp-${LLVM_VERSION}-dev \
  libclc-${LLVM_VERSION}-dev \
  libunwind-${LLVM_VERSION}-dev \
  libmlir-${LLVM_VERSION}-dev mlir-${LLVM_VERSION}-tools \
  libbolt-${LLVM_VERSION}-dev bolt-${LLVM_VERSION} \
  flang-${LLVM_VERSION} \
  libclang-rt-${LLVM_VERSION}-dev-wasm32 \
  libclang-rt-${LLVM_VERSION}-dev-wasm64 \
  libc++-${LLVM_VERSION}-dev-wasm32 \
  libc++abi-${LLVM_VERSION}-dev-wasm32 \
  libclang-rt-${LLVM_VERSION}-dev-wasm32 \
  libclang-rt-${LLVM_VERSION}-dev-wasm64                           
