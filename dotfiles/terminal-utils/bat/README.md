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

```bash
git clone git@github.com:sharkdp/bat.git
cd bat
git checkout "${BAT_VERSION}"
```

Run the following command to build release distribution and install it:

```bash
cargo install --all-features --locked --path .
```

After the build is finished, install the manpage:

```bash
sudo cp ./target/release/build/bat-*/**/manual/bat.1 /usr/local/share/man/man1
```

#### Install `bat-extras`

This guide recommends installing [`bat-extras`][github-bat-extras] from sources.

Ensure you have the dependenices installed:

```bash
sudo apt update -y
sudo apt install -y gawk
```

Clone the repo:

```bash
git clone git@github.com:eth-p/bat-extras.git
cd bat-extras
git checkout "${BAT_EXTRAS_VERSION}"
```

Build the scripts and test them:

```bash
./build.sh
./test.sh
```

Install the preffered scripts. This guide installs only [`batgrep`][batgrep], [`batwatch`][batwatch], and [`batdiff`][batdiff]:

```bash
BAT_EXTRAS_TO_INSTALL=(
  "batgrep"
  "batwatch"
  "batdiff"
)
for BAT_EXTRA_TO_INSTALL in "${BAT_EXTRAS_TO_INSTALL[@]}"; do
  sudo install -C -D "./bin/${BAT_EXTRA_TO_INSTALL}" "/usr/local/bin/${BAT_EXTRA_TO_INSTALL}"
done
```

Install the mangapages:

```bash
BAT_EXTRAS_TO_INSTALL=(
  "batgrep"
  "batwatch"
  "batdiff"
)
for BAT_EXTRA_TO_INSTALL in "${BAT_EXTRAS_TO_INSTALL[@]}"; do
  sudo install -C -D "./man/${BAT_EXTRA_TO_INSTALL}.1" "/usr/local/share/man/man1/${BAT_EXTRA_TO_INSTALL}.1"
done
```

### Integrate `bat` with other programs

#### zsh

See the corresponding section in the [zsh docs file in this repo](../../zsh/README.md#bat).

#### `fzf`

You can use `bat` to preview files in [`fzf`](../fzf/README.md). See the [`fzf`'s](../fzf/README.md#bat) doc for details.

#### `ripgrep`

Use `batgrep` from [`bat-extras`](#install-bat-extras) to display the output of `ripgrep` with `bat`.

### Customization

- TODO: https://github.com/junegunn/fzf/blob/master/ADVANCED.md#color-themes

## Useful links

- [github-bat][github-bat]
- [github-bat-extras][github-bat-extras]
  - [batgrep][batgrep]
  - [batwatch][batwatch]
  - [batdiff][batdiff]

[github-bat]: <https://github.com/sharkdp/bat>
[github-bat-extras]: <https://github.com/eth-p/bat-extras>
[batgrep]: <https://github.com/eth-p/bat-extras/blob/master/doc/batgrep.md>
[batwatch]: <https://github.com/eth-p/bat-extras/blob/master/doc/batwatch.md>
[batdiff]: <https://github.com/eth-p/bat-extras/blob/master/doc/batdiff.md>
