#!/usr/bin/env bash

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

JJ_CONFIG_DIR="$(jj config path --user)"

# Configs that this repository does not store and user should provide upon running the script. The script will try to get the values from the existing git config, otherwise the script will prompt the user for the config value.
# Add more such private configs here if needed.
JJ_USER_EMAIL="$(jj config get user.email)"
[ -z "${JJ_USER_EMAIL}" ] && read -p "Enter user email to use in jj config:"$'\n' JJ_USER_EMAIL
JJ_USER_NAME="$(jj config get user.name)"
[ -z "${JJ_USER_NAME}" ] && read -p "Enter user name to use in jj config:"$'\n' JJ_USER_NAME

commands_to_run=(
  "mkdir -p ${JJ_CONFIG_DIR}"
  "cp -rf ${SCRIPT_DIR}/config/* ${JJ_CONFIG_DIR}/"
  "jj config set --user user.name '${JJ_USER_NAME}'"
  "jj config set --user user.email '${JJ_USER_EMAIL}'"
)

echo "The script will replace your jj config with the config created from this repo:"
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

