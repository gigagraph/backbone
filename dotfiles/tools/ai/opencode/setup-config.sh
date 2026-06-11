#!/usr/bin/env bash

# https://specifications.freedesktop.org/basedir-spec/latest/
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

OPENCODE_CONFIG_DIR="${XDG_CONFIG_HOME}/opencode"
OPENCODE_MAIN_CONFIG_FILE="${OPENCODE_CONFIG_DIR}/opencode.json"
OPENCODE_TUI_CONFIG_FILE="${OPENCODE_CONFIG_DIR}/tui.json"

commands_to_run=(
  # nvim & nvim-pager
  "echo 'Linking config for opencode to ${OPENCODE_CONFIG_DIR}'"

  "mkdir -p '${OPENCODE_CONFIG_DIR}'"

  "rm -rf '${OPENCODE_MAIN_CONFIG_FILE}'"
  "ln -s '${SCRIPT_DIR}/config/opencode.json' '${OPENCODE_MAIN_CONFIG_FILE}'"

  "rm -rf '${OPENCODE_TUI_CONFIG_FILE}'"
  "ln -s '${SCRIPT_DIR}/config/tui.json' '${OPENCODE_TUI_CONFIG_FILE}'"
)

echo "The script will replace your opencode config with the configs from this repo:"
for command in "${commands_to_run[@]}"; do
  echo "\$ ${command}"
done

echo "Run the commands?"
select yn in "yes" "no"; do
  case "${yn}" in
    'yes')
      for command in "${commands_to_run[@]}"; do
        eval "${command}"
      done
      break
      ;;

    *) break ;;

  esac
done
