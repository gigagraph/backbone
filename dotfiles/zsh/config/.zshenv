# XDG
# https://specifications.freedesktop.org/basedir-spec/latest/
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"
XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"

# ZSH
ZSH_CACHE_DIR="${XDG_CACHE_HOME}/zsh"
ZSH_CUSTOM_PLUGINS_DIR="${HOME}/.zsh_custom_plugins"
ZSH_COMPLETIONS_DIR="${ZSH_CUSTOM_PLUGINS_DIR}/completions"

ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# nvm
export NVM_DIR="${HOME}/.nvm"

# Rust
. "${HOME}/.cargo/env"
