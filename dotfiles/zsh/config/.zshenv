# XDG
# https://specifications.freedesktop.org/basedir-spec/latest/

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"

# ZSH

ZSH_CACHE_DIR="${XDG_CACHE_HOME}/zsh"
ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
