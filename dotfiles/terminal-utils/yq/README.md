# `yq`

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Go](../../system-setup/toolchains/go/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends installing `yq` using [`go install`](https://go.dev/ref/mod#go-install).

```shell
go install "github.com/mikefarah/yq/v4@${YQ_VERSION}"
```

Ensure that you have [`go` variables in the `${PATH}`](../../../system-setup/toolchains/go/README.md#installation).

### Integrate `yq` with other programs

#### zsh

See the corresponding section in the [zsh docs file in this repo](../../zsh/README.md#yq).

## Useful links

- [github-yq][github-yq].
- [yq-docs][yq-docs].
- [go-install-docs][go-install-docs].

[github-yq]: https://github.com/mikefarah/yq
[yq-docs]: https://mikefarah.gitbook.io/yq
[go-install-docs]: https://go.dev/ref/mod#go-install
