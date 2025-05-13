# Bash

This setup recommends using [`bash-language-server`][bash-lsp-github] as an implementaion of LSP server for the [Bash][bash-gnu-reference-maunal] scripting langugage.

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Node](../../../system-setup/toolchains/node/README.md).
> - [Go](../../../system-setup/toolchains/go/README.md).
> - [Haskell](../../../system-setup/toolchains/haskell/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

`bash-language-server` can use [`shellcheck`][shellcheck-github] and [`shfmt`][shfmt-github]. Therefore, this guide recommends to install these extansions first.

### `shellchek` installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Haskell](../../../system-setup/toolchains/haskell/README.md).

This guide recommends building `shellcheck` from source, however, for simplicity, users can use [other installation methods mentioned in the official docs][shellcheck-installation].

Clone the repo and checkout the latest stable version:

```bash
git clone git@github.com:koalaman/shellcheck.git
cd shellcheck
git checkout "${SHELLCHECK_VERSION}"
```

Build the project and install it:

```bash
cabal install --installdir="${HOME}/.local/bin" --install-method=copy
```

### `shfmt` installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Go](../../../system-setup/toolchains/go/README.md).

This guide recommends installing `shfmt` following the [official installtion instructions][shfmt-github].

Install `shfmt` using `go install`:

```bash
go install "mvdan.cc/sh/v${SHFMT_VERSION%%.*}/cmd/shfmt@v${SHFMT_VERSION}"
```

### `bash-language-server` installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Node](../../../system-setup/toolchains/node/README.md).

#### `bash-language-server` installation from `npm` registry

Users can install [`bash-language-server` from `npm` registry][npm-bash-language-server] using the following command:

```bash
npm install -g bash-language-server@latest
```

#### `bash-language-server` installation from sources

Alternatively, users can install `bash-language-server` from sources.

Clone the repo and checkout the latest stable version:

```bash
git clone git@github.com:bash-lsp/bash-language-server.git
cd bash-language-server
git checkout "${BASH_LANGUAGE_SERVER_VERSION}"
```

Build the project:

```bash
pnpm install
pnpm compile
npm pack ./server
```

Install the build:

```bash
npm install -g "./bash-language-server-${BASH_LANGUAGE_SERVER_VERSION}.tgz"
```

## Useful links

- [bash-lsp-github][bash-lsp-github]
- [bash-lsp-config][bash-lsp-config]
- [bash-gnu-reference-maunal][bash-gnu-reference-maunal]
- [npm-bash-language-server][npm-bash-language-server]
- [shellcheck-github][shellcheck-github]
  - [shellcheck-installation][shellcheck-installation]
- [shfmt-github][shfmt-github]

[bash-lsp-github]: https://github.com/bash-lsp/bash-language-server
[bash-lsp-config]: https://github.com/bash-lsp/bash-language-server/blob/main/server/src/config.ts
[bash-gnu-reference-maunal]: https://www.gnu.org/software/bash/manual/bash.html
[npm-bash-language-server]: https://www.npmjs.com/package/bash-language-server
[shellcheck-github]: https://github.com/koalaman/shellcheck?tab=readme-ov-file#installing
[shellcheck-installation]: https://github.com/koalaman/shellcheck?tab=readme-ov-file#installing
[shfmt-github]: https://github.com/mvdan/sh#shfmt
