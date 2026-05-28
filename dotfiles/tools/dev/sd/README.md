# `sd`

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Rust](../../../../system-setup/toolchains/rust/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends building and installing `sd` from sources with `cargo`:

```bash

git clone git@github.com:chmln/sd.git
cd sd
git checkout "${SD_VERSION}"
```

Run the following command to build release distribution and install it:

```bash
cargo install --all-features --locked --path ./sd-cli
```

After the build is finished, install the manpage:

```bash
sudo cp ./gen/sd.1 /usr/local/share/man/man1
```

### Integrate `ds` with other programs

#### zsh

See the corresponding section in the [zsh docs file in this repo](../../zsh/README.md#sd) to install `zsh` completions.

## Useful links

- [sd]

[sd]: https://github.com/chmln/sd
