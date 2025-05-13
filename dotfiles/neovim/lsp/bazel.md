# Bazel

This setup recommends using the following LSP servers for Bazel build system:

- [`bazelrc-lsp`][bazelrc-lsp].
- [`starpls`][starpls].

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Rust](../../../system-setup/toolchains/rust/README.md).
> - [Bazel](../../../system-setup/toolchains/bazel/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

### [`bazelrc-lsp`][bazelrc-lsp] installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Rust](../../../system-setup/toolchains/rust/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends building and installing `bazelrc-lsp` from sources with `cargo`:

```bash
git clone git@github.com:salesforce-misc/bazelrc-lsp.git
cd bazelrc-lsp
git checkout "${BAZELRC_LSP_VERSION}"
```

Run the following command to build release distribution and install it:

```bash
cargo install --all-features --locked --path .
```

### [`starpls`][starpls] installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Bazel](../../../system-setup/toolchains/bazel/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends building and installing `starpls` from sources using `bazel`:

```bash
git clone git@github.com:withered-magic/starpls.git
cd starpls
git checkout "${STARPLS_VERSION}"
```

Build `starpls` using bazel:

```bash
bazel run -c opt //editors/code:copy_starpls
```

Add the built binary to your `PATH`:

```bash
sudo install -C -D ./editors/code/bin/starpls /usr/local/bin/starpls
```

## Useful links

- [bazelrc-lsp][bazelrc-lsp]
- [starpls][starpls]

[bazelrc-lsp]: https://github.com/salesforce-misc/bazelrc-lsp
[starpls]: https://github.com/withered-magic/starpls
