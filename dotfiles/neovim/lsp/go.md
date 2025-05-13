# Go LSP

This setup recommends using [gopls][github-gopls] as an implementaion of LSP server for Go programming langugage.

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Go](../../../system-setup/toolchains/go/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends installing `gopls` following the [official installtion instructions][github-gopls].

Go to https://golng.org/x/tools/gopls and find the latest version (`GOPLS_VERSION`).

Install `gopls` using `go install`:

```bash
go install "golang.org/x/tools/gopls@v${GOPLS_VERSION}"
```

This setup also recommends using `gopls` together with `gofumpt` code formatter. Therefore, users should also install `gofumpt` using the following command:

```bash
go install "mvdan.cc/gofumpt@v${GOFUMPT_VERSION}"
```

## Useful links

- [github-gopls][github-gopls]
- [gopls-nvim-install][gopls-nvim-install]
- [gopls-config][gopls-config]

[github-gopls]: https://github.com/golang/tools/tree/master/gopls
[gopls-nvim-install]: https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim
[gopls-config]: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
