#!/usr/bin/env bash

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

MINIKUBE_CONFIG_DIR="${HOME}/.minikube/config"

commands_to_run=(
  "echo 'Linking config for minikube to ${MINIKUBE_CONFIG_DIR}'"
  "rm -rf ${MINIKUBE_CONFIG_DIR}"
  "ln -s ${SCRIPT_DIR}/config/ ${MINIKUBE_CONFIG_DIR}"
)

echo "The script will replace your minkube config (${MINIKUBE_CONFIG_DIR}) with the configs from this repo:"
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
