# SQL

This setup recommends using [`sqls`][github-sqls] as an implementaion of LSP server for SQL query langugage.

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Go](../../../system-setup/toolchains/go/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends installing `sqls` following the [official installtion instructions][github-sqls].

Go to https://pkg.go.dev/github.com/sqls-server/sqls and find the latest version (`SQLS_VERSION`).

Install `gopls` using `go install`:

```bash
go install "github.com/sqls-server/sqls@v${SQLS_VERSION}"
```

## Useful links

- [github-sqls][github-sqls]

[github-sqls]: https://github.com/sqls-server/sqls
