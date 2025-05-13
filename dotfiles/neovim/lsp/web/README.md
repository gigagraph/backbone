# Web

This guide refers to the following languages under the general "Web stack" term:

- [HTML][html] (support implemented by [vscode-langservers-extracted](vscode-langservers-extracted-installation)).
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

### [vscode-langservers-extracted][vscode-langservers-extracted] installation

This guide recommends installing [`vscode-langservers-extracted` from `npm` registry][vscode-langservers-extracted] using the following command:

```bash
npm install -g vscode-langservers-extracted@latest
```

This LSP implementaion contains LSP servers extracted from VS Code for multiple languages. To make `neovim` use specific LSPs from this bundle, enable the LSP server that corresponds to the language:

- [HTML][html]: `html`.
- [JSON][json]: `jsonls`.
- [CSS][css]: `cssls` (find more on CSS in [`./css.md`](./css.md)).
- [Javascript][javascript]: `eslint` (find more on JS in [`./javascript.md`](./javascript.md)).

### Note on completions and snippets

`emmet-language-server` and vscode-langservers-extracted return snippets for emmet abbreviations and other completions. Unfortunately, by default, `neovim` does not expand snippets, so the default `neovim` completions do not work. To make `neovim` expand LSP snippet completions, this guide recommends installing [`blink.cmp`](../../../../dotfiles/nvim/README.md#blink-cmp) completion engine plugin, [`LuaSnip`](../../../../dotfiles/nvim/README.md#luasnip) snippet engine, and configuring them to work together.

## Useful links

- [html][html]
- [json][json]
- [css][css]
- [javascript][javascript]
- [emmet-language-server][emmet-language-server]
- [emmet-language-server-npm][emmet-language-server-npm]
- [nvim-emmet][nvim-emmet]
- [vscode-langservers-extracted][vscode-langservers-extracted]

[html]: https://developer.mozilla.org/en-US/docs/Web/HTML
[json]: https://www.json.org/json-en.html
[css]: https://developer.mozilla.org/en-US/docs/Web/CSS
[javascript]: https://developer.mozilla.org/en-US/docs/Web/JavaScript
[emmet-language-server]: https://github.com/olrtg/emmet-language-server
[emmet-language-server-npm]: https://www.npmjs.com/package/@olrtg/emmet-language-server
[nvim-emmet]: https://github.com/olrtg/nvim-emmet
[vscode-langservers-extracted]: https://github.com/hrsh7th/vscode-langservers-extracted
