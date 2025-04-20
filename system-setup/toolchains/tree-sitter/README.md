# Tree-sitter

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Rust](../system-setup/toolchains/rust/README.md).
> - [C/C++](../system-setup/toolchains/llvm/README.md).
> - [Node](../system-setup/toolchains/node/README.md).
>
> Optionally, but recommended:
> - [Docker](../system-setup/toolchains/docker/README.md) or `emscripten` to build WASM library to run `tree-sitter playground` locally.
>
> [You can verify the versions of the installed toolcahins with the script](../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends building and installing `tree-sitter` from sources with `cargo` and `pnpm`.

Clone the repo and checkout the latest stable version:

```shell
git clone git@github.com:tree-sitter/tree-sitter.git
cd tree-sitter
git checkout "${TREE_SITTER_VERSION}"
```

Install the WASM library (specify a fresh stable version of `node` when running `nvm`):

```shell
cd lib/binding_web
nvm use default
pnpm install
pnpm run build
```

Go back to the `tree-sitter` repo root:

```shell
cd ../..
```

Run the following command to build release distribution and install it:

```shell
cargo install --all-features --locked --path cli
```

### Shell completions

Use the [`tree-sitter complete` subcommand][tree-sitter-completions] to generate shell completions.

For an example, see the corresponding section in the [zsh docs file in this repo](../../zsh/README.md#tree-sitter).

## Useful links

- [tree-sitter-website][tree-sitter-website].
- [github-tree-sitter][github-tree-sitter].
- [tree-sitter-completions][tree-sitter-completions].

[tree-sitter-website]: <https://tree-sitter.github.io/tree-sitter/index.html>
[github-tree-sitter]: <https://github.com/tree-sitter/tree-sitter>
[tree-sitter-completions]: <https://tree-sitter.github.io/tree-sitter/cli/complete.html>
