# Web

This guide refers to the following languages under the general "Web stack" term:

- HTML.
- [CSS/SCSS/SASS](./css.md).
- [JavaScript](./javascript.md).
- [TypeScript](./typescript.md).

Some LSP installations implement functionality for multiple languages. This pages covers such LSPs. For LSPs that apply only to a specific language from the stack, refer to the corresponding page for the language.

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Node](../../../../system-setup/toolchains/node/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

### [`emmet-language-server`][emmet-language-server] installation

This guide recommends installing [`emmet-language-server` from `npm` registry][emmet-language-server-npm] using the following command:

```bash
npm install -g @olrtg/emmet-language-server@latest
```

> [!NOTE]
>
> In addition to installing `emmet-language-server`, this guide recommends installing the [`nvim-emmet`](../../../../dotfiles/nvim/README.md#nvim-emmet) `neovim` plguin.

`emmet-language-server` returns snippets for emmet abbreviations. Unfortunately, by default, `neovim` does not expand them, so the default `neovim` completions do not work. To make `neovim` expand such LSP completions, this guide recommends installing [`blink.cmp`](../../../../dotfiles/nvim/README.md#blink-cmp) completion engine plugin, [`LuaSnip`](../../../../dotfiles/nvim/README.md#luasnip) snippet engine, and configuring them to work together.

## Useful links

- [emmet-language-server][emmet-language-server]
- [emmet-language-server-npm][emmet-language-server-npm]
- [nvim-emmet][nvim-emmet]
- [vscode-langservers-extracted][vscode-langservers-extracted]

[emmet-language-server]: https://github.com/olrtg/emmet-language-server
[emmet-language-server-npm]: https://www.npmjs.com/package/@olrtg/emmet-language-server
[nvim-emmet]: https://github.com/olrtg/nvim-emmet
[vscode-langservers-extracted]: https://github.com/hrsh7th/vscode-langservers-extracted
