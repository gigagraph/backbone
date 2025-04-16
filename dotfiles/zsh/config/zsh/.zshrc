function zcompile-many() {
  local f
  for f; do zcompile -R -- "$f".zwc "$f"; done
}

# Prompt (pure)
##
## Docs: https://github.com/sindresorhus/pure

if [ ! -e "${ZSH_CUSTOM_PLUGINS_DIR}/pure-prompt" ]; then
  git clone --branch="v1.23.0" --depth=1 git@github.com:sindresorhus/pure.git "${ZSH_CUSTOM_PLUGINS_DIR}/pure-prompt"
  zcompile-many "${ZSH_CUSTOM_PLUGINS_DIR}"/pure-prompt/{pure.zsh,async.zsh}
fi
fpath+=("${ZSH_CUSTOM_PLUGINS_DIR}/pure-prompt")

autoload -U promptinit; promptinit

## Configure the pure prompt
PURE_CMD_MAX_EXEC_TIME="5" # seconds
PURE_GIT_PULL="0"
PURE_GIT_UNTRACKED_DIRTY="0"
PURE_GIT_DELAY_DIRTY_CHECK="1800" # seconds
PURE_PROMPT_SYMBOL="❯"
PURE_PROMPT_VICMD_SYMBOL="❮"
PURE_GIT_DOWN_ARROW="⇣"
PURE_GIT_UP_ARROW="⇡"
PURE_GIT_STASH_SYMBOL="≡"
zstyle :prompt:pure:git:stash show yes

## Set colors for the pure prompt
### Refer to the following link for the color numbers:
### https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
###
### Note: for now this theme is designed for a dark mode (tested with dark Catpuccin temrinal emulator theme).
zstyle ':prompt:pure:execution_time' color yellow
zstyle ':prompt:pure:git:arrow' color 51 # strong cyan
zstyle ':prompt:pure:git:stash' color magenta
zstyle ':prompt:pure:git:branch' color green
zstyle ':prompt:pure:git:branch:cached' color red
zstyle ':prompt:pure:git:action' color '#fab387' # peach
zstyle ':prompt:pure:git:dirty' color '#f5c2e7' # pink
zstyle ':prompt:pure:path' color blue
zstyle ':prompt:pure:prompt:error' color red
zstyle ':prompt:pure:prompt:success' color '#cba6f7' # mauve
zstyle ':prompt:pure:prompt:continuation' color white
zstyle ':prompt:pure:suspended_jobs' color cyan
zstyle ':prompt:pure:host' color white
zstyle ':prompt:pure:user' color 69 # lavander blue
zstyle ':prompt:pure:user:root' color 208 # orange
zstyle ':prompt:pure:virtualenv' color 240

## Initialize the pure prompt
prompt pure

# zsh options

setopt beep nomatch interactive_comments
unsetopt autocd extendedglob notify

# Shell options

# Disable legacy feature to suspend and result terminal input and unassign the keybidnings for the start and stop characters.
# When enabled (default), by default, it makes CTRL-S and CTRL-Q pause and resume the input in the terminal. These keybindings may interfere with keybindings from other plugins.
stty -ixon ixoff start "" stop ""

# Paths

local TEX_LIVE_BASE_PATH="/usr/local/texlive/current"

typeset -U path PATH
path+=(
  "/usr/lib/llvm-18/bin"
  "/usr/local/go/bin"
  # pipx's install location
  "${HOME}/.local/bin"
  "${TEX_LIVE_BASE_PATH}/bin/"$(uname -m)-*([1])
)
export PATH

# Aliases

alias eza="'eza' --icons='always'"
alias e="'eza' --icons='always'"
alias ela="'eza' -laa --icons='always'"
alias ls="'eza' --icons='always'"
alias tree="'eza' --icons='always' --tree"

alias grep="'rg'"

alias cd="'z'"

alias cat="'bat' --paging='never' --color='always'"

alias c="'clear'"

alias g="'git'"
alias gst="'git' status"

alias q="'exit'"

# Envs

export EDITOR="$(which nvim)"
export VISUAL="${EDITOR}"
export PAGER="$(which nvimpager)"
export MANPAGER="$(which nvimpager)"

# Multibyte characters

setopt COMBINING_CHARS

# History

HISTFILE=~/.histfile
HISTSIZE=5000 SAVEHIST=5000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Keybindings

bindkey -v

## Enable to edit the current command in the default text editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'vv' edit-command-line

## Use prefix in the zle to scroll through the commands
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

bindkey '^[[Z' reverse-menu-complete

# Initialize and compile plugins & completions

if [[ "${ZSH_CUSTOM_PLUGINS_DIR}/zoxide-integration.zsh" -nt "${ZSH_CUSTOM_PLUGINS_DIR}/zoxide-integration.zsh.zwc" ]]; then
  zcompile-many "${ZSH_CUSTOM_PLUGINS_DIR}/zoxide-integration.zsh"
fi

if [[ "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-integration.zsh" -nt "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-integration.zsh.zwc" ]]; then
  zcompile-many "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-integration.zsh"
fi

if [ ! -e "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-tab" ]; then
  git clone --branch="v1.1.2" --depth=1 git@github.com:Aloxaf/fzf-tab.git "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-tab"
  zcompile-many "${ZSH_CUSTOM_PLUGINS_DIR}"/fzf-tab/{fzf-tab.plugin.zsh,fzf-tab.zsh,lib/**/*.zsh}
fi

if [ ! -e "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-git" ]; then
  git clone git@github.com:junegunn/fzf-git.sh.git "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-git"
  git -C "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-git" checkout 'f730cfa1860acdb64597a0cf060d4949f1cd02a8'
  zcompile-many "${ZSH_CUSTOM_PLUGINS_DIR}"/fzf-git/fzf-git.sh
fi

if [ ! -e "${ZSH_CUSTOM_PLUGINS_DIR}/fast-syntax-highlighting" ]; then
  git clone git@github.com:zdharma-continuum/fast-syntax-highlighting.git "${ZSH_CUSTOM_PLUGINS_DIR}/fast-syntax-highlighting"
  git -C "${ZSH_CUSTOM_PLUGINS_DIR}/fast-syntax-highlighting" checkout 'cf318e06a9b7c9f2219d78f41b46fa6e06011fd9'
  zcompile-many "${ZSH_CUSTOM_PLUGINS_DIR}"/fast-syntax-highlighting/{fast-syntax-highlighting.plugin.zsh,fast-highlight,fast-string-highlight,fast-theme,share/**/*.zsh}
fi

if [ ! -e "${ZSH_CUSTOM_PLUGINS_DIR}/zsh-autosuggestions" ]; then
  git clone --branch="v0.7.1" --depth=1 git@github.com:zsh-users/zsh-autosuggestions.git "${ZSH_CUSTOM_PLUGINS_DIR}/zsh-autosuggestions"
  zcompile-many "${ZSH_CUSTOM_PLUGINS_DIR}"/zsh-autosuggestions/{zsh-autosuggestions.zsh,src/**/*.zsh}
fi

# Completion scripts

if [ ! -e "${ZSH_COMPLETIONS_DIR}/rust-zsh-completions" ]; then
  git clone --branch="1.16.0" --depth=1 git@github.com:ryutok/rust-zsh-completions.git "${ZSH_COMPLETIONS_DIR}/rust-zsh-completions"
  zcompile-many "${ZSH_COMPLETIONS_DIR}"/rust-zsh-completions/{rust.plugin.zsh,src/_cargo,src/_rustc,src/_rustup}
fi
source "${ZSH_COMPLETIONS_DIR}/rust-zsh-completions/rust.plugin.zsh"

if [ ! -e "${ZSH_COMPLETIONS_DIR}/zsh-completions" ]; then
  git clone --branch="0.35.0" --depth=1 git@github.com:zsh-users/zsh-completions.git "${ZSH_COMPLETIONS_DIR}/zsh-completions"
  zcompile-many "${ZSH_COMPLETIONS_DIR}"/zsh-completions/{zsh-completions.plugin.zsh,src/_*}
fi
source "${ZSH_COMPLETIONS_DIR}/zsh-completions/zsh-completions.plugin.zsh"

# Configure completions

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

fpath+=("${ZSH_COMPLETIONS_DIR}")
autoload -Uz compinit
compinit -d "${ZSH_COMPDUMP}"

[[ "${ZSH_COMPDUMP}.zwc"  -nt "${ZSH_COMPDUMP}" ]] || zcompile-many "${ZSH_COMPDUMP}"
unfunction zcompile-many

# zoxide
##
## Docs:
## - https://github.com/ajeetdsouza/zoxide
## - https://github.com/ajeetdsouza/zoxide/wiki

source "${ZSH_CUSTOM_PLUGINS_DIR}/zoxide-integration.zsh"

# bat-extras
##
## Docs: https://github.com/eth-p/bat-extras

### bat-extras configuration
export BATDIFF_USE_DELTA="true"

### Additional completions for the bat-extras scripts.
compdef batdiff=diff
compdef batwatch=watch
compdef batgrep=rg

# fzf
##
## Docs: https://github.com/junegunn/fzf

local FZF_CUSTOM_FLAGS=(
  "--wrap"
  "--ansi"
)

local FZF_CUSTOM_KEYBINDINGS=(
  "--bind=ctrl-e:preview-down"
  "--bind=ctrl-y:preview-up"
  "--bind=ctrl-w:toggle-preview-wrap"
)

# Options the fzf command
export FZF_COMPLETION_OPTS="${FZF_CUSTOM_FLAGS}"

export FZF_DEFAULT_OPTS="${FZF_CUSTOM_FLAGS}"
export FZF_DEFAULT_COMMAND="$(tr -d '\n' <<EOF
  fd
    --exclude='.git'
    --hidden
    --color=always
    --strip-cwd-prefix
EOF
)"

local FZF_FILE_PREVIEW_COMMAND='bat -n --color=always {}'
local FZF_DIRECTORY_PREVIEW_COMMAND='eza -a --icons=always --color=always --tree --level=3 {}'

export FZF_COMPLETION_TRIGGER='**'

# Options for path completion (e.g. vim **<TAB>)
export FZF_COMPLETION_PATH_OPTS="
  --preview '${FZF_FILE_PREVIEW_COMMAND} || ${FZF_DIRECTORY_PREVIEW_COMMAND}'
  ${FZF_CUSTOM_KEYBINDINGS}
  ${FZF_CUSTOM_FLAGS}"

# Options for directory completion (e.g. cd **<TAB>)
export FZF_COMPLETION_DIR_OPTS="
  --preview '${FZF_DIRECTORY_PREVIEW_COMMAND}'
  ${FZF_CUSTOM_KEYBINDINGS}
  ${FZF_CUSTOM_FLAGS}"

export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_CTRL_T_OPTS="${FZF_COMPLETION_PATH_OPTS}"

export FZF_ALT_C_COMMAND="${FZF_DEFAULT_COMMAND} --type=directory"
export FZF_ALT_C_OPTS="${FZF_COMPLETION_DIR_OPTS}"

source "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-integration.zsh"

# For the compatibility reasons, shells may interpret ESC immediately followed by a letter as ALT pressed with the letter.
# Pressing ESC followed by 'C' will trigger the fzf-integration's ALT-C. Therefore, rebind ALT-C to ALT-Q.
# https://github.com/junegunn/fzf/issues/1238#issuecomment-381083777
bindkey -r '^[c'
bindkey '^[q' fzf-cd-widget

# fzf-tab
##
## Docs: https://github.com/Aloxaf/fzf-tab
##
## fzf-tab must be sourced after the `compinit` but before the zsh-autosuggestions.

source "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-tab/fzf-tab.plugin.zsh"

# fzf-git
## Docs: https://github.com/junegunn/fzf-git.sh

source "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-git/fzf-git.sh"

function _fzf_git_fzf() {
  'fzf' \
    ${FZF_CUSTOM_FLAGS} \
    ${FZF_CUSTOM_KEYBINDINGS} \
    "$@"
}

# fast-syntax-highlighting
##
## Docs: https://github.com/zdharma-continuum/fast-syntax-highlighting

source "${ZSH_CUSTOM_PLUGINS_DIR}/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

# zsh-autosuggestions
##
## Docs: https://github.com/zsh-users/zsh-autosuggestions
##
## Should come after fast-syntax-highlighting.

# This plugin may cause the plugin to not work in certain scenarios.
# It requires the config maintainer to call _zsh_autosuggest_bind_widgets manually in either of the following cases:
# - any of the widget lists change
# - if you or another plugin wrap any of the autosuggest widgets
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

source "${ZSH_CUSTOM_PLUGINS_DIR}/zsh-autosuggestions/zsh-autosuggestions.zsh"
