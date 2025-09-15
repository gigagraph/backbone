#!/usr/bin/env bash

# Prerequisites:
# - yq

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

CODEX_THIS_REPO_CONFIG_FILE_PATH="${SCRIPT_DIR}/config/config.toml"

CODEX_HOME="${CODEX_HOME:-${HOME}/.codex}"
CODEX_CONFIG_FILE_PATH="${CODEX_HOME}/config.toml"

# Configs that this repository does not store and user should provide upon running the script. The script will try to get the values from the existing config, otherwise the script will prompt the user for the config value.
# Add more such private configs here if needed.
OLLAMA_BASE_URL="$( (yq -oyaml '.model_providers[].base_url | select(. != null and . != "")' "${CODEX_CONFIG_FILE_PATH}" 2> /dev/null || true) | head -1 )"
[ -z "${OLLAMA_BASE_URL}" ] && read -p "Enter the ollama base url to use for the codex config (${CODEX_CONFIG_FILE_PATH}):"$'\n' OLLAMA_BASE_URL

commands_to_run=(
  "cp -rf ${CODEX_THIS_REPO_CONFIG_FILE_PATH} ${CODEX_CONFIG_FILE_PATH}"
)

ollama_model_providers=( $(yq -oyaml '.model_providers | keys[] | select(. == "ollama*")' "${CODEX_THIS_REPO_CONFIG_FILE_PATH}" 2> /dev/null || true) )
for ollama_model_provider in "${ollama_model_providers[@]}"; do
model_provider_definition_line_number_command='$(grep "\[model_providers.'"${ollama_model_provider}"'\]" --line-number --line-regexp "${CODEX_CONFIG_FILE_PATH}" | awk -F: '\''{ print $1 }'\'')'

commands_to_run+=(
  "sed -i \"${model_provider_definition_line_number_command}a\base_url = \\\"${OLLAMA_BASE_URL}\\\"\" '${CODEX_CONFIG_FILE_PATH}'"
)
done

echo "The script will replace your codex config (${CODEX_CONFIG_FILE_PATH}) with the config created from this repo:"
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
