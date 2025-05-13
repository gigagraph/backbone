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

<!-- TODO: tomorrow - setup LSP -->
<!-- TODO -->
- [ ] TODO: languages to support:
  - Definitely:
    - Helm (`helm_ls`).
    - Bazel (`bazelrc_lsp`, `starpls`).
    - Cue (`cue`).
    - Nix (`nixd`).
    - Haskell (`hls`).
    - Javascript/Typescript (+ the rest of the web stack - HTLM, CSS, SCSS, SASS).
      - Emmet LSP ([emmet-language-server](https://github.com/olrtg/emmet-language-server)).
      - eslint.
      - `tailwindcss`.
      - `ts_ls` (typescript-language-server).
      - ...
      - Optionally:
        - angularls.
        - htmx.
        - something for react.

Planned to be supported in future:
- Zig/Ziggy/Ziggy Schema.
- Verilog.
- VHDL.
- AWK.
- Scala (`metals`).
- Kotlin (`kotlin_language_server`).
- Gradle (`gradle_ls`).

## Useful links

- [lsp-website][lsp-website]
- [lsp-servers][lsp-servers]
- [lsp-servers-langserver][lsp-servers-langserver]

[lsp-website]: <https://microsoft.github.io/language-server-protocol/>
[lsp-servers]: <https://microsoft.github.io/language-server-protocol/implementors/servers/>
[lsp-servers-langserver]: <https://langserver.org/>
