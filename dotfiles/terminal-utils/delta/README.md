# `delta`

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Rust](../../system-setup/toolchains/rust/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends building and installing `delta` from sources with `cargo`:

```bash
git clone git@github.com:dandavison/delta.git
cd delta
git checkout "${DELTA_VERSION}"
```

Run the following command to build release distribution and install it:

```bash
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

[merge]
    conflictstyle = zdiff3
```

> [!NOTE]
>
> This repository comes with `.gitconfig` that uses `delta`. See the corresponding [doc for how to set it up](../../tools/git/README.md#configuration).

### Configure `jj`

After the installation, ensure your [`jj`'s config has following to start using `delta` to show diffs][jj-delta-integration]:

```toml
[ui]
pager = "delta"
paginate = "auto"
conflict-marker-style = "snapshot"

[merge-tools.delta]
diff-args = ["--color-only", "--line-numbers"]

[ui.diff]
format = "git"
```

> [!NOTE]
>
> This repository comes with `jj`'s `config.toml` that uses `delta`. See the corresponding [doc for how to set it up](../../tools/jj/README.md#configuration).

### Integrate `delta` with other programs

#### zsh

See the corresponding section in the [zsh docs file in this repo](../../zsh/README.md#delta).

## Useful links

- [github-delta][github-delta]
- [delta-docs][delta-docs]
- [jj-delta-integration][jj-delta-integration]

[github-delta]: <https://github.com/dandavison/delta>
[delta-docs]: <https://dandavison.github.io/delta/introduction.html>
[jj-delta-integration]: <https://jj-vcs.github.io/jj/latest/config/#processing-contents-to-be-paged>
