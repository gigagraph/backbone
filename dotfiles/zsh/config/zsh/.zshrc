# zsh options

setopt beep nomatch
unsetopt autocd extendedglob notify

# Shell options

# Disable legacy feature to suspend and result terminal input and unassign the keybidnings for the start and stop characters.
# When enabled (default), by default, it makes CTRL-S and CTRL-Q pause and resume the input in the terminal. These keybindings may interfere with keybindings from other plugins.
stty -ixon ixoff start "" stop ""

# Path

typeset -U path PATH
path=(
  ${path}
  /usr/lib/llvm-18/bin
  /usr/local/go/bin
)
export PATH

# Aliases

alias eza="'eza' --icons"
alias e="'eza' --icons"
alias ela="'eza' -la --icons"
alias ls="'eza' --icons"
alias tree="'eza' --icons --tree"

alias c="'clear'"

alias g="'git'"

alias grep="'rg'"

alias cd="'z'"

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

  # Unbind this key to enable fzf-git keybindings to work
  bindkey -r '^g'
}

bindkey '^[[Z' reverse-menu-complete

# zsh-vi-mode (ZVM)
## Docs: https://github.com/jeffreytse/zsh-vi-mode

typeset -U zvm_after_init_commands
zvm_after_init_commands+=(
  "bind_after_zvm"
)
export ZVM_INIT_MODE="sourcing"

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
##
## Docs: https://starship.rs/config/

[ -f "${ZSH_CUSTOM_PLUGINS_DIR}/starship_init" ] && source "${ZSH_CUSTOM_PLUGINS_DIR}/starship_init"

# fzf
##
## Docs: https://github.com/junegunn/fzf

[ -f "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-integration.zsh" ] && source "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-integration.zsh"

# fzf-tab
##
## Docs: https://github.com/Aloxaf/fzf-tab
##
## fzf-tab must be sourced after the `compinit` but before the zsh-autosuggestions.

[ -f "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-tab/fzf-tab.plugin.zsh" ] && source "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-tab/fzf-tab.plugin.zsh"

# zoxide
##
## Docs:
## - https://github.com/ajeetdsouza/zoxide
## - https://github.com/ajeetdsouza/zoxide/wiki

[ -f "${ZSH_CUSTOM_PLUGINS_DIR}/zoxide-integration.zsh" ] && source "${ZSH_CUSTOM_PLUGINS_DIR}/zoxide-integration.zsh"

# fast-syntax-highlighting
##
## Docs: https://github.com/zdharma-continuum/fast-syntax-highlighting

[ -f "${ZSH_CUSTOM_PLUGINS_DIR}/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ] && source "${ZSH_CUSTOM_PLUGINS_DIR}/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

# zsh-autosuggestions
##
## Docs: https://github.com/zsh-users/zsh-autosuggestions
##
## Should come after fast-syntax-highlighting.

[ -f "${ZSH_CUSTOM_PLUGINS_DIR}/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "${ZSH_CUSTOM_PLUGINS_DIR}/zsh-autosuggestions/zsh-autosuggestions.zsh"
