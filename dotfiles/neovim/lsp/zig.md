# Zig

This setup recommends using [`zls`][zls] and [`ziggy lsp`][ziggy-lsp] as an implementation of LSP server for the Zig programming language and the Ziggy language respectively.

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Zig](../../../system-setup/toolchains/zig/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

### [`zls`][zls] installation

> [!IMPORTANT]
>
> `zls` minor version must correspond to the `zig` minor version. Keep them in sync.

This guide recommends building `zls` from sources.

Clone the repo:

```bash
git clone git@github.com:zigtools/zls.git
cd zls
git checkout "${ZLS_VERSION}"
```

Build:

```bash
zig build -Doptimize=ReleaseSafe
```

Install it systemwide:

```bash
sudo install -C -D ./zig-out/bin/zls /usr/local/bin/zls
```

### `ziggy lsp`

Follow these instructions to install [`ziggy`](../../../system-setup/toolchains/zig/README.md#ziggy), which comes with the `ziggy lsp` subcommand.

## Useful links

- [zls]
- [zls-nvim]
- [gh-zls]
- [ziggy-lsp]
- [ziggy-neovim]

[zls]: https://zigtools.org/zls/install/
[zls-nvim]: https://zigtools.org/zls/editors/vim/nvim/
[gh-zls]: https://github.com/zigtools/zls
[ziggy-lsp]: https://ziggy-lang.io/documentation/ziggy-lsp/
[ziggy-neovim]: https://ziggy-lang.io/documentation/editors/neovim/
