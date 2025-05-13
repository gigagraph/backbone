#!/usr/bin/env bash

# https://specifications.freedesktop.org/basedir-spec/latest/
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

NVIM_CONFIG_DIR="${XDG_CONFIG_HOME}/nvim"
NVIM_DATA_DIR="${XDG_DATA_HOME}/nvim"
NVIM_CUSTOM_PLUGINS_DIR="${NVIM_DATA_DIR}/bkb-plugins"

NVIMPAGER_CONFIG_DIR="${XDG_CONFIG_HOME}/nvimpager"
NVIMPAGER_DATA_DIR="${XDG_DATA_HOME}/nvimpager"
NVIMPAGER_CUSTOM_PLUGINS_DIR="${NVIMPAGER_DATA_DIR}/bkb-plugins"

MARKSMAN_CONFIG_DIR="${XDG_CONFIG_HOME}/marksman"

FOURMOLU_CONFIG_PATH="${XDG_CONFIG_HOME}/fourmolu.yaml"

commands_to_run=(
  # nvim & nvim-pager
  "echo 'Linking config for neovim & nvim pager to ${NVIM_CONFIG_DIR} and ${NVIMPAGER_CONFIG_DIR} respectively'"
  "rm -rf ${NVIM_CONFIG_DIR}"
  "rm -rf ${NVIMPAGER_CONFIG_DIR}"
  "ln -s ${SCRIPT_DIR}/config/ ${NVIM_CONFIG_DIR}"
  "ln -s ${SCRIPT_DIR}/config/ ${NVIMPAGER_CONFIG_DIR}"
  "echo 'Linking custoim plugins dir from neovim for nvim pager (${NVIM_CUSTOM_PLUGINS_DIR} -> ${NVIMPAGER_CUSTOM_PLUGINS_DIR})'"
  "ln -s ${NVIM_CUSTOM_PLUGINS_DIR} ${NVIMPAGER_CUSTOM_PLUGINS_DIR}"

  # Marksman
  "echo 'Linking config for marksman ${MARKSMAN_CONFIG_DIR}'"
  "rm -rf ${MARKSMAN_CONFIG_DIR}"
  "ln -s ${SCRIPT_DIR}/lsp/markdown/marksman/config ${MARKSMAN_CONFIG_DIR}"

  # Fourmolu
  "echo 'Linking config for fourmolu ${FOURMOLU_CONFIG_PATH}'"
  "rm -rf ${FOURMOLU_CONFIG_PATH}"
  "ln -s ${SCRIPT_DIR}/lsp/haskell/fourmolu/config/fourmolu.yaml ${FOURMOLU_CONFIG_PATH}"
)

echo "The script will replace your neovim config and LSP configs with the configs from this repo:"
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
