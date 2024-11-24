# `fzf`

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Go](../system-setup/toolchains/go/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

Clone the repo and checkout the latest stable version:

```shell
git clone https://github.com/junegunn/fzf
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

### Integrate `fzf` with other programs

#### zsh

See the corresponding section in the [zsh docs file in this repo](../../zsh/README.md#fzf).

#### Neovim

- [ ] TODO

## Useful links

- [github-fzf][github-fzf]
- [fzf-docs][fzf-docs]

[github-fzf]: <https://github.com/junegunn/fzf>
[fzf-docs]: <https://junegunn.github.io/fzf/>
