#!/usr/bin/env bash

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

NIX_GLOBAL_CONFIGS_DIR="${NIX_CONF_DIR:-/etc}/nix"

# Configs that this repository does not store and user should provide upon running the script.
# The script will try to get the values from the existing nix config, otherwise the script will prompt the user for the config value.
# Add more such private configs here if needed.
NIX_TRUSTED_USERS="$('grep' 'trusted-users' "${NIX_GLOBAL_CONFIGS_DIR}/nix.conf")"
NIX_TRUSTED_USERS="${NIX_TRUSTED_USERS//trusted-users =/}"

if [[ "${NIX_TRUSTED_USERS}" != *" ${USER}"* ]]; then
  # NIX_TRUSTED_USERS="$(echo "${NIX_TRUSTED_USERS}" | sed 's/trusted-users = //') ${USER}"
  NIX_TRUSTED_USERS="${NIX_TRUSTED_USERS} ${USER}"
fi

commands_to_run=(
  "sudo cp -rf ${SCRIPT_DIR}/config/etc/nix.conf ${NIX_GLOBAL_CONFIGS_DIR}/nix.conf"
  "echo 'trusted-users =${NIX_TRUSTED_USERS}' | sudo tee -a ${NIX_GLOBAL_CONFIGS_DIR}/nix.conf"
)

echo "The script will replace your nix config with the config created from this repo:"
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

