# `fzf`

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Go](../../system-setup/toolchains/go/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

Clone the repo and checkout the latest stable version:

```shell
git clone git@github.com:junegunn/fzf.git
cd fzf
git checkout "${FZF_VERSION}"
```

Build the project:

```shell
make
```

Install the built binary on your system:

```shell
sudo install -C -D ./target/fzf-* /usr/local/bin/fzf
```

Install the manpages:

```shell
sudo cp -R ./man/* /usr/local/share/man/
```

### Integrate `fzf` with other programs

#### zsh

See the corresponding section in the [zsh docs file in this repo](../../zsh/README.md#fzf).

#### Neovim

- [ ] TODO

#### `bat`

You can use [`bat`](../bat/README.md) to preview files in `fzf`. See the following resources for more details:
- [`bat`'s doc][bat-fzf-integration].
- [`fzf`'s doc][fzf-preview].
- [`.zshrc` in this repo](../../zsh/config/zsh/.zshrc).

## Theming

- TODO:
  - https://github.com/junegunn/fzf#fzf-theme-playground
  - https://github.com/junegunn/fzf/blob/master/ADVANCED.md#color-themes

## Useful links

- [github-fzf][github-fzf]
- [fzf-docs][fzf-docs]
- [bat-fzf-integration][bat-fzf-integration]
- [fzf-preview][fzf-preview]

[github-fzf]: <https://github.com/junegunn/fzf>
[fzf-docs]: <https://junegunn.github.io/fzf/>
[bat-fzf-integration]: <https://github.com/sharkdp/bat?tab=readme-ov-file#fzf>
[fzf-preview]: <https://github.com/sharkdp/bat?tab=readme-ov-file#fzf>
