# Haskell

## Installation

Download `bootstrap-haskell` for your system from [the official website](https://get-ghcup.haskell.org):

```bash
BOOTSTRAP_HASKELL_TARGET_PATH="./bootstrap-haskell"

curl -o "${BOOTSTRAP_HASKELL_TARGET_PATH}" --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org
chmod +x "${BOOTSTRAP_HASKELL_TARGET_PATH}"
```

Ensure the system has the necessary dependencies:

```bash
sudo apt update -y
sudo apt install -y \
  build-essential \
  curl \
  libffi-dev \
  libffi8 \
  libgmp-dev \
  libgmp10 \
  libncurses-dev \
  pkg-config
```

Run the interactive installer. Follow the instructions and setup `ghcup` and `haskell-language-server` on your machine:

```bash
env \
  "BOOTSTRAP_HASKELL_NONINTERACTIVE=1" \
  "BOOTSTRAP_HASKELL_DOWNLOADER=curl" \
  "BOOTSTRAP_HASKELL_NO_UPGRADE=" \
  "BOOTSTRAP_HASKELL_MINIMAL=" \
  "GHCUP_USE_XDG_DIRS=1" \
  "BOOTSTRAP_HASKELL_INSTALL_HLS=1" \
  "BOOTSTRAP_HASKELL_INSTALL_NO_STACK_HOOK=1" \
  "BOOTSTRAP_HASKELL_ADJUST_BASHRC=" \
    "${BOOTSTRAP_HASKELL_TARGET_PATH}"
```

Add the following `bin` directories to your `PATH` in your shell's `rc` file, e.g.:

```bash
export PATH="${HOME}/.ghcup/bin,${HOME}/.cabal/bin,${PATH}"
```

Then users should ensure that `ghcup` installed the recommended versions of Haskell tools:

```bash
ghcup tui
```

### Completions

#### `zsh` completions for `ghcup`

Clone the `ghcup` repo and checkout the sources for your currently installed version:

```bash
git clone git@github.com:haskell/ghcup-hs.git
cd ghcup-hs
git checkout "${GHCUP_VERSION}"
```

Assuming that `ZSH_COMPLETIONS_DIR` env points to a path on your system that is present in `fpath`, copy the completions script from the repo to `ZSH_COMPLETIONS_DIR`:

```bash
cp "./scripts/shell-completions/${SHELL##*/}" "${ZSH_COMPLETIONS_DIR}/_ghcup"
```

#### `zsh` completions for `ghc`

If you use [zsh](../../../dotfiles/zsh/README.md) your should install `zsh-completions`. See the [docs from this repo](../../../dotfiles/zsh/README.md#plugins) for more details.

#### `zsh` completions for `stack`

If you use [zsh](../../../dotfiles/zsh/README.md) `zsh-completions` plugin provides completions for `stack`. See the [docs from this repo](../../../dotfiles/zsh/README.md#plugins) for more details.

However, this guide recommends [setting up completions for `stack` using `stack`][stack-autocompletions]. Assuming that `ZSH_COMPLETIONS_DIR` env points to a path on your system that is present in `fpath`, run the following script:

```bash
stack "--${SHELL##*/}-completion-script" stack > "${ZSH_COMPLETIONS_DIR}/_stack"
```

#### `zsh` completions for `cabal`

If you use [zsh](../../../dotfiles/zsh/README.md), it should come with the [default comptions script for `cabal`](https://github.com/zsh-users/zsh/blob/master/Completion/Unix/Command/_cabal).

### Updating

#### Upgrade `ghcup`

```bash
ghcup upgrade
```

#### Upgrade the Haskell toolchain

Install the desired version of the Haskell tool using `ghcup` and optionally remove the old one, e.g.:

```bash
ghcup tui
```

## Useful links

- [ghcup][ghcup]
- [ghcup-installation][ghcup-installation]
  - [ghcup-manual-installation][ghcup-manual-installation]
- [ghcup-user-guide][ghcup-user-guide]
- [stack-autocompletions][stack-autocompletions]
- [github-coot-zsh-haskell][github-coot-zsh-haskell]

[ghcup]: https://www.haskell.org/ghcup/
[ghcup-installation]: https://www.haskell.org/ghcup/install/
[ghcup-manual-installation]: https://www.haskell.org/ghcup/install/#manual-installation
[ghcup-user-guide]: https://www.haskell.org/ghcup/guide/
[stack-autocompletions]: https://docs.haskellstack.org/en/v1.9.3/shell_autocompletion/
[github-coot-zsh-haskell]: https://github.com/coot/zsh-haskell
