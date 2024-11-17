#!/usr/bin/env bash

# https://specifications.freedesktop.org/basedir-spec/latest/
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

ZENV_FILE_PATH="${HOME}/.zshenv"
ZSH_CONFIG_DIR="${XDG_CONFIG_HOME}/zsh"

DOTFILES_DIR="${SCRIPT_DIR}/config"

commands_to_run=(
  "rm -rf ${ZENV_FILE_PATH}"
  "rm -rf ${ZSH_CONFIG_DIR}"
  "ln -s ${DOTFILES_DIR}/.zshenv ${ZENV_FILE_PATH}"
  "ln -s ${DOTFILES_DIR}/zsh/ ${ZSH_CONFIG_DIR}"
)

echo "The script will replace your zsh config with the config from this repo:"
for command in "${commands_to_run[@]}"; do
  echo "\$ ${command}"
done

echo "Run the commands?"
select yn in "yes" "no"; do
  case "${yn}" in
    'yes' )
      for command in "${commands_to_run[@]}"; do
        eval "${command}"
      done
      break;;

    * ) break;;

  esac
done
