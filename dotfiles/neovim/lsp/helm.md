# Helm

This setup recommends using [`helm-ls`][github-helm-ls] as an implementaion of LSP server for [Helm][helm].

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Go](../../../system-setup/toolchains/go/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends installing `helm-ls` from sources using `go install`:

Go to https://pkg.go.dev/github.com/mrjosh/helm-ls and find the latest version (`HELM_LS_VERSION`).

Install `helm-ls` using `go install`:

```bash
go install "github.com/mrjosh/helm-ls@v${HELM_LS_VERSION}"
```

This command will install `helm-ls` as `helm-ls` binary. However, `helm-ls` assumes that the binary's name is `helm_ls`. Therefore, users should make a symlink to the actual binary in a directory on your `PATH`:

```bash
ln -s "$(which helm-ls)" "${HOME}/.local/bin/helm_ls"
```

> [!NOTE]
>
> In addition to installing `helm-ls`, this guide recommends installing the [`helm-ls.nvim`][github-helm-ls-nvim] `neovim` plguin.

> [!NOTE]
>
> This LSP uses [`yaml-language-server`](./yaml.md) to provide additional capabilities for Helm templates, like values files schema validation and autocompletions. Users should install `yaml-language-server` as well.

## Useful links

- [github-helm-ls][github-helm-ls]
- [helm][helm]
- [github-helm-ls-nvim][github-helm-ls-nvim]
- [helm-ls-nvim-installing][helm-ls-nvim-installing]

[github-helm-ls]: https://github.com/mrjosh/helm-ls
[helm]: https://helm.sh/
[github-helm-ls-nvim]: https://github.com/qvalentin/helm-ls.nvim
[helm-ls-nvim-installing]: https://github.com/qvalentin/helm-ls.nvim#installing
