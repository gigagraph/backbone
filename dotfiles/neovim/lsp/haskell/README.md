# Haskell

This setup recommends using [`haskell-language-server`][hls] as an implementaion of LSP server for [Haskell](../../../../system-setup/toolchains/haskell/README.md) programming language.

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Haskell](../../../../system-setup/toolchains/haskell/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends [installing `hls` via `ghcup`][hls-installation]:

```bash
ghcup install hls
```

> [!NOTE]
>
> This setup's [`setup-config.sh`](../../setup-config.sh) replaces global configuration for `fourmolu` with the [`fourmolu.yaml` from this repository](./fourmolu/config/fourmolu.yaml).

> [!NOTE]
>
> In addition to installing `hls`, this guide recommends installing the [`haskell-tools.nvim`][github-haskell-tools-nvim] `neovim` plguin.

## Useful links

- [github-hls][github-hls]
- [hls][hls]
- [hls-installation][hls-installation]
- [hls-configuration][hls-configuration]
- [github-fourmolu][github-fourmolu]
- [fourmolu-config][fourmolu-config]
- [github-haskell-tools-nvim][github-haskell-tools-nvim]

[github-hls]: https://github.com/haskell/haskell-language-server
[hls]: https://haskell-language-server.readthedocs.io/en/latest/
[hls-installation]: https://haskell-language-server.readthedocs.io/en/latest/installation.html
[hls-configuration]: https://haskell-language-server.readthedocs.io/en/latest/configuration.html
[github-fourmolu]: https://github.com/fourmolu/fourmolu
[fourmolu-config]: https://fourmolu.github.io/config/
[github-haskell-tools-nvim]: https://github.com/MrcJkb/haskell-tools.nvim
