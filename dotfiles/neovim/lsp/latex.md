# LaTeX

This guide recommends using [`texlab`][texlab] as an implementaion of LSP server for the [LaTeX](../../../system-setup/toolchains/texlive/README.md) typesetting system.

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Rust](../../../system-setup/toolchains/rust/README.md).
> - [LaTeX](../../../system-setup/toolchains/texlive/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends building and installing `texlab` from sources with `cargo`:

```bash
git clone git@github.com:latex-lsp/texlab.git
cd texlab
git checkout "${TEXLIVE_VERSION}"
```

Run the following command to build release distribution and install it:

```bash
cargo install --all-features --locked --path ./crates/texlab
```

## Useful link

- [texlab][texlab]
- [texlab-wiki][texlab-wiki]

[texlab]: https://github.com/latex-lsp/texlab
[texlab-wiki]: https://github.com/latex-lsp/texlab/wiki
