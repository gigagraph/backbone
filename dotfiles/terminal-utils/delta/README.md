# `delta`

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Rust](../../system-setup/toolchains/rust/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends building and installing `delta` from sources with `cargo`:

```shell
git clone git@github.com:dandavison/delta.git
cd delta
git checkout "${DELTA_VERSION}"
```

Run the following command to build release distribution and install it:

```shell
cargo install --all-features --locked --path .
```

### Update `.gitconfig`

After the installation, ensure your `.gitconfg` has following to start using `delta` to show diffs:

```gitconfig
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true  # use n and N to move between diff sections
    dark = true      # or light = true, or omit for auto-detection
    side-by-side = true

[merge]
    conflictstyle = zdiff3
```

> [!NOTE]
>
> This repository comes with `.gitconfig` that uses `delta`. See the corresponding [doc for how to set it up](../git/README.md#configuration).

### Integrate `delta` with other programs

#### zsh

See the corresponding section in the [zsh docs file in this repo](../../zsh/README.md#delta).

## Useful links

- [github-delta][github-delta]
- [delta-docs][delta-docs]

[github-delta]: <https://github.com/dandavison/delta>
[delta-docs]: <https://dandavison.github.io/delta/introduction.html>
