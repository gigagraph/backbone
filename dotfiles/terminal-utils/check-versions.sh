#!/usr/bin/env bash

TOOL_VERSION_CMDS=(
  "fzf --version"
  "rg --version"
)

for TOOL_VERSION_CMD in "${TOOL_VERSION_CMDS[@]}"; do
  echo "--------------------------------------------------------------------------------"
  echo "${TOOL_VERSION_CMD}"
  echo "================================================================================"
  eval "${TOOL_VERSION_CMD}"
  echo "================================================================================"
done

