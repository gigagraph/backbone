# Python

This setup recommends using the following LSP servers for Python:

- [`basedpyright`][basedpyright].
- [`ruff`][ruff-lsp].

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Python](../../../system-setup/toolchains/python/README.md) with [`uv`](../../../system-setup/toolchains/python/README.md#uv).
>
> [You can verify the versions of the installed toolcahins with the script](../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

### [`basedpyright`][basedpyright] installation

Install `basedpyright` using `uv tool`:

```bash
uv tool install basedpyright
```

### [`ruff`][ruff-lsp] installation

Install `ruff` using `uv tool`:

```bash
uv tool install ruff
```

## Useful links

- [basedpyright][basedpyright]
  - [basedpyright-lsp-settings][basedpyright-lsp-settings]
- [ruff][ruff]
  - [ruff-lsp][ruff-lsp]
    - [ruff-lsp-setup][ruff-lsp-setup]
    - [ruff-lsp-settings][ruff-lsp-settings]

[basedpyright]: https://docs.basedpyright.com/dev/
[basedpyright-lsp-settings]: https://docs.basedpyright.com/dev/configuration/language-server-settings/
[ruff]: https://github.com/python-rope/pylsp-rope
[ruff-lsp]: https://docs.astral.sh/ruff/editors/
[ruff-lsp-setup]: https://docs.astral.sh/ruff/editors/setup/
[ruff-lsp-settings]: https://docs.astral.sh/ruff/editors/settings/
