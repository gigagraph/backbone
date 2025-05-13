# CSS

This setup recommends using the following LSP servers for CSS:

- `cssls` (a part of [vscode-langservers-extracted, covered in the Web README.md](../README.md#vscode-langservers-extracted-installation)).
- [`css_variables`][css-variables] to support CSS variables.
- [`somesass_ls`][some-sass-lsp] to support SCSS and SASS.
- [`stylelint-lsp`][stylelint].
- [`tailwindcss`][tailwindcss-lsp].

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Node](../../../../../system-setup/toolchains/node/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

### `css_variables` instalaltion

This guide recommends installing [`css-variables-language-server` from `npm` registry][css-variables-language-server-npm] using the following command:

```bash
npm install -g css-variables-language-server
```

### `somesass_ls` instalaltion

This guide recommends installing [`somesass_ls` from `npm` registry][some-sass-lsp-npm] using the following command:

```bash
npm install -g some-sass-language-server
```

### `stylelint-lsp` instalaltion

This guide recommends installing [`stylelint-lsp` from `npm` registry][stylelint-lsp] using the following command:

```bash
npm install -g stylelint-lsp
```

### `tailwindcss` instalaltion

This guide recommends installing [`tailwindcss` from `npm` registry][tailwindcss-lsp-github] using the following command:

```bash
npm install -g @tailwindcss/language-server
```

## Useful links

- [css-variables][css-variables]
  - [css-variables-language-server-npm][css-variables-language-server-npm]
- [some-sass-lsp][some-sass-lsp]
  - [some-sass-lsp-github][some-sass-lsp-github]
  - [some-sass-lsp-npm][some-sass-lsp-npm]
- [stylelint][stylelint]
  - [stylelint-github][stylelint-github]
  - [stylelint-lsp][stylelint-lsp]
- [tailwindcss-lsp][tailwindcss-lsp]
  - [tailwindcss-lsp-github][tailwindcss-lsp-github]

[css-variables]: https://github.com/vunguyentuan/vscode-css-variables/tree/master/packages/css-variables-language-server
[css-variables-language-server-npm]: https://www.npmjs.com/package/css-variables-language-server
[some-sass-lsp]: https://wkillerud.github.io/some-sass/index.html
[some-sass-lsp-github]: https://github.com/wkillerud/some-sass/tree/main/packages/language-server
[some-sass-lsp-npm]: https://www.npmjs.com/package/some-sass-language-server
[stylelint]: https://stylelint.io/
[stylelint-github]: https://github.com/stylelint/stylelint
[stylelint-lsp]: https://github.com/bmatcuk/stylelint-lsp
[tailwindcss-lsp]: https://github.com/tailwindlabs/tailwindcss-intellisense
[tailwindcss-lsp-github]: https://www.npmjs.com/package/@tailwindcss/language-server
