#!/usr/bin/env bash

TOOL_VERSION_CMDS=(
  "bat --version"
  "delta --version"
  "entr version"
  "eza --version"
  "fd --version"
  "fzf --version"
  "rg --version"
  "yq --version"
  "zoxide --version"
)

for TOOL_VERSION_CMD in "${TOOL_VERSION_CMDS[@]}"; do
  echo "--------------------------------------------------------------------------------"
  echo "${TOOL_VERSION_CMD}"
  echo "================================================================================"
  eval "${TOOL_VERSION_CMD}"
  echo "================================================================================"
done

