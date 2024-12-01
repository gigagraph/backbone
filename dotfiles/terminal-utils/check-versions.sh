#!/usr/bin/env bash

TOOL_VERSION_CMDS=(
  "git --version"
  "fzf --version"
  "rg --version"
  "eza --version"
  "zoxide --version"
  "bat --version"
  "delta --version"
)

for TOOL_VERSION_CMD in "${TOOL_VERSION_CMDS[@]}"; do
  echo "--------------------------------------------------------------------------------"
  echo "${TOOL_VERSION_CMD}"
  echo "================================================================================"
  eval "${TOOL_VERSION_CMD}"
  echo "================================================================================"
done

