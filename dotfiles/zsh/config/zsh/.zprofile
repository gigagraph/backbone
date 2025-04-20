# XDG

[[ ! -d "${XDG_CONFIG_HOME}" ]] && mkdir -p "${XDG_CONFIG_HOME}"
[[ ! -d "${XDG_CACHE_HOME}" ]] && mkdir -p "${XDG_CACHE_HOME}"
[[ ! -d "${XDG_STATE_HOME}" ]] && mkdir -p "${XDG_STATE_HOME}"

# ZSH
[[ ! -d "${ZSH_CACHE_DIR}" ]] && mkdir -p "${ZSH_CACHE_DIR}"
[[ ! -d "${ZSH_CUSTOM_PLUGINS_DIR}" ]] && mkdir -p "${ZSH_CUSTOM_PLUGINS_DIR}"
[[ ! -d "${ZSH_COMPLETIONS_DIR}" ]] && mkdir -p "${ZSH_COMPLETIONS_DIR}"

# nvm
[ -s "${NVM_DIR}/nvm.sh" ] && source "${NVM_DIR}/nvm.sh"
