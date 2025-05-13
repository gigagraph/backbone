# JavaScript

This setup recommends using the following LSP servers for JavaScript:

- `eslint` (a part of [vscode-langservers-extracted, covered in the Web README.md](./README.md#vscode-langservers-extracted-installation)).
- [`quick-lint-js`][quick-lint-js].
- [`typescript-language-server`](./typescript.md#typescript-language-server).

## Instalaltion

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Node](../../../../system-setup/toolchains/node/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

### `quick-lint-js` instalaltion

This guide recommends installing [`quick-lint-js` from `npm` registry][quick-lint-js-npm] using the following command:

```bash
npm install -g quick-lint-js
```

## Useful links

- [quick-lint-js][quick-lint-js]
  - [quick-lint-js-install][quick-lint-js-install]
    - [quick-lint-js-install-neovim][quick-lint-js-install-neovim]
  - [quick-lint-js-configuration][quick-lint-js-configuration]
- [quick-lint-js-github][quick-lint-js-github]
  - [quick-lint-js-vim-plugin-github][quick-lint-js-vim-plugin-github]
- [quick-lint-js-npm][quick-lint-js-npm]

[quick-lint-js]: https://quick-lint-js.com/
[quick-lint-js-install]: https://quick-lint-js.com/install/
[quick-lint-js-install-neovim]: https://quick-lint-js.com/install/neovim/npm-posix/
[quick-lint-js-configuration]: https://quick-lint-js.com/config/
[quick-lint-js-github]: https://github.com/quick-lint/quick-lint-js
[quick-lint-js-vim-plugin-github]: https://github.com/quick-lint/quick-lint-js/tree/master/plugin/vim
[quick-lint-js-npm]: https://www.npmjs.com/package/quick-lint-js
