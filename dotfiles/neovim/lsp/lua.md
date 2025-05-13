# Lua LSP

This setup recommends using [LuaLS][github-luals] as an implementaion of LSP server for Lua programming langugage.

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [C/C++](../../../system-setup/toolchains/llvm/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This setup recommends [installing LuaLS from sources][luals-build-instructions].

Install the dependencies:

```bash
sudo apt update -y
sudo apt install -y \
  ninja-build
```

Clone the repo and checkout the latest stable version:

```bash
git clone git@github.com:LuaLS/lua-language-server.git
cd lua-language-server
git checkout "${LUALS_VERSION}"
```

Build the project and install it:

```bash
env CC="$(which clang)" CXX="$(which clang++)" LD="lld" \
  ./make.sh
```

Create a symlink to the build output (ensure that `/usr/local/bin` is on the `$PATH`, otherwise, either add it to the `$PAHT` or copy the binary to another directory that is on the `$PATH`):

```bash
sudo ln -s "$(pwd)/bin/lua-language-server" /usr/local/bin/lua-language-server
```

## Useful links

- [github-luals][github-luals]
- [luals-build-instructions][luals-build-instructions]
- [luals-configure][luals-configure]
- [luals-typechecking][luals-typechecking]

[github-luals]: https://github.com/LuaLS/lua-language-server
[luals-build-instructions]: https://luals.github.io/wiki/build/
[luals-configure]: https://luals.github.io/wiki/configuration/
[luals-typechecking]: https://luals.github.io/wiki/type-checking/
