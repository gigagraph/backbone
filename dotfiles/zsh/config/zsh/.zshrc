# zsh built-in

## Options and variables

setopt beep nomatch
unsetopt autocd extendedglob notify

HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# TODO: research the following option
# setopt CORRECT
# What are the ae options and can I disable them?

## Completions

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

autoload -Uz compinit
compinit -d "${ZSH_COMPDUMP}"

## zsh keybindings

bindkey -v

# TODO: install history-substring-search?
# Use prefix in the zle to scroll through the commands
bindkey '^[[A' history-search-backward
bindkey '^p' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^n' history-search-forward

# Plugins

## TODO

# Aliases

## TODO

# Path

typeset -U path PATH
path=(
  ${path}
  /usr/lib/llvm-18/bin
  /usr/local/go/bin
)
export PATH
