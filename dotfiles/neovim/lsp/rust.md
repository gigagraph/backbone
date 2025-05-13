# Rust LSP

This guide recommends using [`rust-analyzer`][github-rust-analyzer] as an implementation of LSP server for the Rust programming language.

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Rust](../../../system-setup/toolchains/rust/README.md).
> - [C/C++](../../../system-setup/toolchains/llvm/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends using [`rustup` to manage `rust-analyzer` installation][rust-analyzer-book-bin-install].

Users should ensure they are using the toolchain you plan to use for development. Generally the `stable` toolchain should be a good choice. Users can view the existing installed toolchains and set up the current one with the following commands:

```bash
rustup toolchain list
rustup override set <toolchain>
```

When users selected the toolchain, they can install `rust-analyzer` using `rustup`:

```bash
rustup component add rust-analyzer
```

> [!NOTE]
>
> `rust-analyzer` depends on `cc`, so [ensure that you have it on your `PATH`](../../../system-setup/toolchains/llvm/README.md#set-as-default-cc-cpp-and-c++-with-update-alternatives).

## Useful links

- [github-rust-analyzer][github-rust-analyzer]
- [rust-analyzer-book][rust-analyzer-book]
  - [rust-analyzer-book-installation][rust-analyzer-book-installation]
  - [rust-analyzer-book-bin-install][rust-analyzer-book-bin-install]
  - [rust-analyzer-setup-editors][rust-analyzer-setup-editors]
  - [rust-analyzer-configure][rust-analyzer-configure]
- [rustacenvim][rustacenvim]

[github-rust-analyzer]: https://github.com/rust-lang/rust-analyzer
[rust-analyzer-book]: https://rust-analyzer.github.io/book/
[rust-analyzer-book-installation]: https://rust-analyzer.github.io/book/installation.html
[rust-analyzer-book-bin-install]: https://rust-analyzer.github.io/book/rust_analyzer_binary.html#rustup
[rust-analyzer-setup-editors]: https://rust-analyzer.github.io/book/other_editors.html
[rust-analyzer-configure]: https://rust-analyzer.github.io/book/configuration.html
[rustacenvim]: https://github.com/mrcjkb/rustaceanvim
