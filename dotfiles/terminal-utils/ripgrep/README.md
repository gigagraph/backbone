# `ripgrep`

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Rust](../../system-setup/toolchains/rust/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

Install the dependencies:

```shell
sudo apt update -y
sudo apt install -y \
  libpcre2-dev \
  libpcre2-posix3 \
  pcre2-utils
```

This guide recommends installing `ripgrep` with `cargo`:

```shell
cargo install ripgrep --all-features --locked
```

After you installed `ripgrep`, install the manpage:

```shell
rg --generate=man | sudo dd of=/usr/local/share/man/man1/rg.1
```

### Integrate `ripgrep` with other programs

#### zsh

See the corresponding section in the [zsh docs file in this repo](../../zsh/README.md#ripgrep).

#### `bat`

See the corresponding section in the [`bat` docs in this repo](../bat/README.md).

## Useful links

- [github-ripgrep][github-ripgrep]

[github-ripgrep]: <https://github.com/BurntSushi/ripgrep>
