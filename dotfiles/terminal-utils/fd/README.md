# [`fd`][fd-github]

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
  make
```

<!-- TODO: clone sources and install from sources: -->

This guide recommends building and installing `fd` from sources with `cargo`:

```shell
git clone git@github.com:sharkdp/fd.git
cd fd
git checkout "${FD_VERSION}"
```

Run the following command to build release distribution and install it:

```shell
cargo install --all-features --locked --path .
```

After the build is finished, install the manpage:

```shell
sudo cp ./doc/fd.1 /usr/local/share/man/man1
```

### Integrate `fd` with other programs

#### zsh

See the corresponding section in the [zsh docs file in this repo](../../zsh/README.md#fd).

#### `fzf`

You can use `fd` to [list files and directories for `fzf`][fd-fzf-integration], including in the terminal integration. See the [`fzf`'s](../fzf/README.md#fd) doc for details.

## Useful links

[fd-github]: <https://github.com/sharkdp/fd>
[fd-fzf-integration]: <https://github.com/sharkdp/fd?tab=readme-ov-file#using-fd-with-fzf>
