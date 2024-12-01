#!/usr/bin/env bash

# https://specifications.freedesktop.org/basedir-spec/latest/
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

GIT_CONFIG_DIR="${XDG_CONFIG_HOME}/git"

# Configs that this repository does not store and user should provide upon running the script. The script will try to get the values from the existing git config, otherwise the script will prompt the user for the config value.
# Add more such private configs here if needed.
GIT_USER_EMAIL="$(git config --global user.email)"
[ -z "${GIT_USER_EMAIL}" ] && read -p "Enter user email to use in .gitconfig:"$'\n' GIT_USER_EMAIL
GIT_USER_NAME="$(git config --global user.name)"
[ -z "${GIT_USER_NAME}" ] && read -p "Enter user name to use in .gitconfig:"$'\n' GIT_USER_NAME

commands_to_run=(
  "cp -rf ${SCRIPT_DIR}/config/* ${GIT_CONFIG_DIR}/"
  "git config --global user.email '${GIT_USER_EMAIL}'"
  "git config --global user.name '${GIT_USER_NAME}'"
)

echo "The script will replace your git config with the config created from this repo:"
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
