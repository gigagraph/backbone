# `bat`

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Rust](../../system-setup/toolchains/rust/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

Ensure you install [`fzf`](../fzf/README.md) before proceeding.

This guide recommends building and installing `bat` from sources with `cargo`:

```shell
git clone git@github.com:sharkdp/bat.git
cd bat
git checkout "${BAT_VERSION}"
```

Run the following command to build release distribution and install it:

```shell
cargo install --all-features --locked --path .
```

After the build is finished, install the manpage:

```shell
sudo cp ./target/release/build/bat-*/**/manual/bat.1 /usr/local/share/man/man1
```

- TODO: install extras

### Integrate `bat` with other programs

#### zsh

See the corresponding section in the [zsh docs file in this repo](../../zsh/README.md#bat).

#### `fzf`

You can use `bat` to preview files in [`fzf`](../fzf/README.md). See the [`fzf`'s](../fzf/README.md) doc for details.

#### `ripgrep`

- TODO

### Customization

- TODO: https://github.com/junegunn/fzf/blob/master/ADVANCED.md#color-themes

## Useful links

- [github-bat][github-bat]
- [github-bat-extras][github-bat-extras]

[github-bat]: <https://github.com/sharkdp/bat>
[github-bat-extras]: <https://github.com/eth-p/bat-extras>
