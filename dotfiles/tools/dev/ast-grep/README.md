# `ast-grep`

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Rust](../../../../system-setup/toolchains/rust/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends building and installing `ast-grep` from sources with `cargo`:

```bash
git clone git@github.com:ast-grep/ast-grep.git
cd ast-grep
git checkout "${AST_GREP_VERSION}"
```

Run the following command to build release distribution and install it:

```bash
cargo install --all-features --locked --path ./crates/cli
```

### Integrate `ast-grep` with other programs

#### zsh

See the corresponding section in the [zsh docs file in this repo](../../zsh/README.md#ast-grep) to install `zhs` [completions][ast-grep-completions].

## Useful links

- [ast-grep]
- [github-ast-grep]
- [ast-grep-completions]

[ast-grep]: https://ast-grep.github.io/
[github-ast-grep]: https://github.com/ast-grep/ast-grep
[ast-grep-completions]: https://ast-grep.github.io/guide/tooling-overview.html#shell-completions
