#!/usr/bin/env bash

# https://specifications.freedesktop.org/basedir-spec/latest/
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

CODIUM_CONFIG_DIR="${XDG_CONFIG_HOME}/VSCodium/User"
CODIUM_USER_WORKSPACE_DIR="${HOME}/.vscode-oss"

commands_to_run=(
  "mkdir -p ${CODIUM_CONFIG_DIR}"
  "mkdir -p ${CODIUM_USER_WORKSPACE_DIR}"

  "${SCRIPT_DIR}/install-exts.sh"

  "rm -rf ${CODIUM_CONFIG_DIR}/settings.json"
  "ln -s ${SCRIPT_DIR}/config/settings.json ${CODIUM_CONFIG_DIR}/settings.json"
  "rm -rf ${CODIUM_CONFIG_DIR}/keybindings.json"
  "ln -s ${SCRIPT_DIR}/config/keybindings.json ${CODIUM_CONFIG_DIR}/keybindings.json"
)

echo "The script will replace your kitty config with the config from this repo:"
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
