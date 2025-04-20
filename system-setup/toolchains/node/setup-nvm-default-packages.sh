#!/usr/bin/env bash

# Verify that ${NVM_DIR} points to a valid path
if [ ! -e "${NVM_DIR}" ]; then
  echo "Error: \${NVM_DIR} '${NVM_DIR}' is not pointing to an existing path."
  exit 1
fi

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

NVM_DEFAULT_PACKAGES_PATH="${NVM_DIR}/default-packages"

commands_to_run=(
  "rm -rf ${NVM_DEFAULT_PACKAGES_PATH}"
  "ln -s ${SCRIPT_DIR}/nvm-default-packages ${NVM_DEFAULT_PACKAGES_PATH}"
)

echo "The script will replace your ${NVM_DIR}/default-packages file with the config from this repo:"
for command in "${commands_to_run[@]}"; do
  echo "\$ ${command}"
done

DIFF_COMMAND="diff ${SCRIPT_DIR}/nvm-default-packages ${NVM_DEFAULT_PACKAGES_PATH}"
echo "Here is the output of '${DIFF_COMMAND}':"
eval "${DIFF_COMMAND}"

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

