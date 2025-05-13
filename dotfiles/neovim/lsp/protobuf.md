# Protocol Buffers

This setup recommends using [buf][buf] as an implementaion of LSP server for [Protocol Buffers][protobuf].

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Go](../../../system-setup/toolchains/go/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends installing `buf` from sources following the [official installtion instructions][buf-installation-source].

Go to https://pkg.go.dev/github.com/bufbuild/buf/cmd/buf and find the latest version (`BUF_VERSION`).

Install `buf` using `go install`:

```bash
go install "github.com/bufbuild/buf/cmd/buf@v${BUF_VERSION}"
```

## Useful links

- [buf][buf]
- [buf-installation-source][buf-installation-source]

[buf]: https://github.com/bufbuild/buf
[buf-installation-source]: https://buf.build/docs/cli/installation/#source
[protobuf]: https://protobuf.dev/
