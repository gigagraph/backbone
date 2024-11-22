# zsh options

setopt beep nomatch
unsetopt autocd extendedglob notify

# Path

typeset -U path PATH
path=(
  ${path}
  /usr/lib/llvm-18/bin
  /usr/local/go/bin
)
export PATH

# Aliases

## TODO

# Envs

export EDITOR="$(which nvim)"
export VISUAL="${EDITOR}"

# Multibyte characters

setopt COMBINING_CHARS

# History

HISTFILE=~/.histfile
HISTSIZE=5000 SAVEHIST=5000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Keybindings

bindkey -v

# Use prefix in the zle to scroll through the commands
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

function bind_after_zvm() {
  bindkey '^p' history-search-backward
  bindkey '^n' history-search-forward
}

bindkey '^[[Z' reverse-menu-complete

# zsh-vim-mode (ZVM)
## Docs: https://github.com/jeffreytse/zsh-vi-mode

zvm_after_init_commands+=(
  bind_after_zvm
)

# Antidote
## https://getantidote.github.io/install

ANTIDOTE_PATH="${HOME}/.antidote"

# Set the root name of the plugins files (.txt and .zsh) antidote will use.
zsh_plugins_txt="${ZDOTDIR:-~}/.zsh_plugins.txt"
zsh_plugins_zsh="${XDG_STATE_HOME}/.zsh_plugins.zsh"

# Ensure the .zsh_plugins.txt file exists so you can add plugins.
[[ -f "${zsh_plugins_txt}" ]] || touch "${zsh_plugins_txt}"

# Lazy-load antidote from its functions directory.
fpath=("${ANTIDOTE_PATH}/functions" ${fpath})
autoload -Uz antidote

# Generate a new static file whenever .zsh_plugins.txt is updated.
if [[ ! "${zsh_plugins_zsh}" -nt "${zsh_plugins_txt}" ]]; then
  antidote bundle <"${zsh_plugins_txt}" >|"${zsh_plugins_zsh}"
fi

# Source your static plugins file.
source "${zsh_plugins_zsh}"

# Completions

setopt NOCORRECT

zstyle ':completion:*' auto-description 'arg: %d'
zstyle ':completion:*' completer _complete _ignored _correct _approximate _prefix
zstyle ':completion:*' expand suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'Completing [%d]'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt '%SAt [%l] (%p): Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+r:|[._-]=** r:|=**' '+l:|=* r:|=*'
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' menu select=long
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at [%l] (%p)%s'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' verbose true
zstyle :compinstall filename "${HOME}/.config/zsh/.zshrc"

ZSH_COMPDUMP="${ZSH_CACHE_DIR}/.zcompdump-${HOST}"

fpath=("${ZSH_COMPLETIONS_DIR}" $fpath)
autoload -Uz compinit
compinit -d "${ZSH_COMPDUMP}"

# Prompt (starship)
## Docs: https://starship.rs/config/

[ -f "${ZSH_CUSTOM_PLUGINS_DIR}/starship_init" ] && source "${ZSH_CUSTOM_PLUGINS_DIR}/starship_init"

# zsh-syntax-highlighting
## In order for this to work, you must first clone the plugin manually.
##
## Must be at the end as per docs:
## https://github.com/zsh-users/zsh-syntax-highlighting/blob/0.8.0/INSTALL.md

[ -f "${ZSH_CUSTOM_PLUGINS_DIR}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "${ZSH_CUSTOM_PLUGINS_DIR}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
