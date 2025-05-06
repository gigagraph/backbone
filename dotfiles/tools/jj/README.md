# `jj`

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Rust](../../system-setup/toolchains/rust/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

Install the dependencies:

```bash
sudo apt update -y
sudo apt install -y \
  libssl-dev \
  openssl \
  pkg-config \
  build-essential
```

This guide recommends building and installing `jj` from sources with `cargo` (users would need to use `git` to clone `jj` 😉):

```bash
git clone git@github.com:jj-vcs/jj.git
cd jj
git checkout "${JJ_VERSION}"
```

Run the following command to build release distribution and install it:

```bash
cargo install --all-features --locked --bin jj jj-cli
```

Run jj to install the manpages:

```bash
sudo "$(which jj)" util install-man-pages /usr/local/share/man
```

### Integrate `jj` with other programs

#### zsh

See the corresponding section in the [zsh docs file in this repo](../../zsh/README.md#jj) to install `zhs` [completions][jj-install-completions].

## Configuration

> [!NOTE]
>
> Ensure you have the following terminal utils to use this config:
> - [`delta`](../terminal-utils/delta/README.md).
>
> You can verify the versions of the installed toolcahins with the followin script located relative to the repo root: `./dotfiles/terminal-utils/check-versions.sh`.

[User's `jj` configuration should reside in `jj config path --user`](https://git-scm.com/docs/git-config#Documentation/git-config.txt---global).

> [!NOTE]
>
> Find more info about `jj`'s config by running `jj help -k config`.

Users's `jj` configuration should reside in the directory printed by the command `jj config path --user`.

Use the config from this repository on your system by creating symlinking the user config default directory to the config dir in this repo (the script will prompt you for confirmation before running any configuration commands):

```bash
./setup-config.sh
```

## Useful links

- [jj-github][jj-github]
- [jj-docs][jj-docs]
  - [jj-installation][jj-installation]
  - [jj-install-completions][jj-install-completions]
- [jj-getting-started-tutorial][jj-getting-started-tutorial]
- [jj-glossay][jj-glossay]

[jj-github]: https://github.com/jj-vcs/jj
[jj-docs]: https://jj-vcs.github.io/jj/latest/
[jj-installation]: https://jj-vcs.github.io/jj/latest/install-and-setup/
[jj-install-completions]: https://jj-vcs.github.io/jj/latest/install-and-setup/#command-line-completion
[jj-getting-started-tutorial]: https://www.youtube.com/watch?v=cZqFaMlufDY
[jj-glossay]: https://jj-vcs.github.io/jj/latest/glossary/
