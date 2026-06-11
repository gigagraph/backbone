#!/usr/bin/env bash

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

PI_CONFIG_DIR="${HOME}/.pi/agent"
PI_MAIN_CONFIG_FILE="${PI_CONFIG_DIR}/settings.json"

commands_to_run=(
  # nvim & nvim-pager
  "echo 'Linking config for pi to ${PI_CONFIG_DIR}'"

  "mkdir -p '${PI_CONFIG_DIR}'"

  "rm -rf '${PI_MAIN_CONFIG_FILE}'"
  "cp -f '${SCRIPT_DIR}/config/settings.json' '${PI_MAIN_CONFIG_FILE}'"
)

echo "The script will replace your pi config with the configs from this repo:"
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
