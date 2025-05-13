# LSP - Language Server Protocol

Supported LSP servers:

- [Lua](./lua.md).
- [C and C++ (+ CUDA)](./c-cpp.md).
- [Rust](./rust.md).
- [Go](./go.md).
- [Python](./python.md).
- [Markdown](./markdown/README.md).
- [SQL](./sql.md).
- [Bash](./bash.md).
- [Latex](./latex.md).
- [Docker](./docker.md).
- [Java](./java.md).
- [Protobuf](./protobuf.md).
- [Yaml](./yaml.md).
- [Helm](./helm.md).
- [Bazel](./bazel.md).
- [Cue](./cue.md).
- [Haskell](./haskell/README.md).
- [Nix](./nix.md).

- [ ] TODO: languages to support:
  - Definitely:
    - [ ] [Web (html + css/scss/sass + js + ts + emmet)](./web/README.md).
    - [ ] Web.
      - [x] HTML: `html`.
      - [x] JSON: `jsonls`.
      - [x] Emmet: [emmet-language-server](https://github.com/olrtg/emmet-language-server).
      - CSS:
        - [x] `cssls`.
        - [x] [`css_variables`](https://github.com/vunguyentuan/vscode-css-variables/tree/master/packages/css-variables-language-server)
        - [x] SCSS/SASS: [`somesass_ls`](https://github.com/wkillerud/some-sass/tree/main/packages/language-server).
        - [ ] [`stylelint_lsp`](https://stylelint.io/).
        - [ ] Tailwind: `tailwindcss` (https://github.com/tailwindlabs/tailwindcss-intellisense).
      - JS:
        - [ ] `eslint`.
        - [ ] `quick-lint-js`.
      - [ ] TS: `ts_ls` (typescript-language-server - https://github.com/typescript-language-server/typescript-language-server).

Planned to be supported in future:
- Zig/Ziggy/Ziggy Schema.
- Verilog.
- VHDL.
- AWK.
- Scala (`metals`).
- Kotlin (`kotlin_language_server`).
- Gradle (`gradle_ls`).
- Harper [`harper_ls`](https://github.com/automattic/harper).
- htmx.
- `angularls`.
- `ts_query_ls` (https://github.com/ribru17/ts_query_ls).

## Useful links

- [lsp-website][lsp-website]
- [lsp-servers][lsp-servers]
- [lsp-servers-langserver][lsp-servers-langserver]

[lsp-website]: <https://microsoft.github.io/language-server-protocol/>
[lsp-servers]: <https://microsoft.github.io/language-server-protocol/implementors/servers/>
[lsp-servers-langserver]: <https://langserver.org/>
