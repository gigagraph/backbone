# CSS

This setup recommends using the following LSP servers for CSS:

- `cssls` (a part of [vscode-langservers-extracted, covered in the Web README.md](./README.md#vscode-langservers-extracted-installation)).
- [`css_variables`][css-variables] for support for CSS variables.

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Node](../../../../system-setup/toolchains/node/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

### `css_variables` instalaltion

This guide recommends installing [`css-variables-language-server` from `npm` registry][css-variables-language-server-npm] using the following command:

```bash
npm install -g css-variables-language-server
```

## Useful links

- [css-variables][css-variables]
  - [css-variables-language-server-npm][css-variables-language-server-npm]
- [stylelint][stylelint]
- [some-sass-lsp][some-sass-lsp]
- [tailwindcss-lsp][tailwindcss-lsp]

[css-variables]: https://github.com/vunguyentuan/vscode-css-variables/tree/master/packages/css-variables-language-server
[css-variables-language-server-npm]: https://www.npmjs.com/package/css-variables-language-server
[stylelint]: https://stylelint.io/
[some-sass-lsp]: https://github.com/wkillerud/some-sass/tree/main/packages/language-server
[tailwindcss-lsp]: https://github.com/tailwindlabs/tailwindcss-intellisense
