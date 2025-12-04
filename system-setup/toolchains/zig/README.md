# zig toolchain

## Installation

> [!NOTE]
>
> You need a [C/C++ toolchain](../llvm/README.md) to build Pyton.

This guide recommends building [`zig` toolchain from sources][build-zig-from-sources] using [zig-bootrstrap][zig-bootstrap].

Clone the [zig-bootstrap][zig-bootstrap] repo (the cloned repo root will be located at `${ZIG_BOOTSTRAP_PREFIX}`):

```bash
git clone ssh://git@codeberg.org:ziglang/zig-bootstrap.git
cd ./zig-bootstrap
git checkout "${ZIG_BOOTSTRAP_TAG}"
```

[Use zig-bootstgrap to retrieve dependencies to build zig from sources][zig-bootstrap-build-instructions]:

```bash
env CC="$(which clang)" CFLAGS="-fPIC" CXX="$(which clang++)" CXXFLAGS="-fPIC" LD="$(which ld.lld)" \
  ./build native-linux-gnu baseline
```

Clone the [zig repo][zig-source] in the same directory where you cloned zig-bootstrap (i.e. beside zig-bootstrap):

```bash
git clone ssh://git@codeberg.org:ziglang/zig.git
cd ./zig
git checkout "${ZIG_TAG}"
```

Build `zig`:

```bash
ZIG_BOOTSTRAP_PREFIX="$(realpath ..)"

"${ZIG_BOOTSTRAP_PREFIX}/out/zig-native-linux-gnu-baseline/zig" build \
  -p stage3 \
  --release=safe \
  --search-prefix "${ZIG_BOOTSTRAP_PREFIX}/out/native-linux-gnu-baseline" \
  --zig-lib-dir "lib" \
  -Dstatic-llvm
```

Install `zig` toolchain gloabally:

```bash
sudo mkdir -p "/usr/local/zig-$(git describe --exact-match --tags)/"
sudo cp -R ./stage3/* "/usr/local/zig-$(git describe --exact-match --tags)/"
```

Point the current `zig` to the newly built version:

```bash
sudo rm -rf /usr/local/zig-current
sudo ln -s "/usr/local/zig-$(git describe --exact-match --tags)" /usr/local/zig-current
```

Ensure the current `zig` toolchain is in the `PATH` in the shell rc file (e.g. `${HOME}/.bashrc`):

```bash
echo 'export PATH="${PATH}:/usr/local/zig-current/bin"' >> "${HOME}/.bashrc"
```

### [`ziggy`][ziggy]

This guide recommends installing [`ziggy` from sources][gh-ziggy].

Clone the repo:

```bash
git clone git@github.com:kristoff-it/ziggy.git
cd ziggy
git checkout "${ZIGGY_VERSION}"
```

Build:

```bash
zig build test
zig build
```

Install it systemwide:

```bash
sudo install -C -D ./zig-out/bin/ziggy /usr/local/bin/ziggy
```

### Completions

#### `zsh` completions

If you use [zsh](../../../dotfiles/zsh/README.md) your should install [`ziglang/shell-completions`][codeberg-zig-shell-completions]. See the [docs from this repo](../../../dotfiles/zsh/README.md#plugins) for more details.

### LSP

See [the LSP docs from the `neovim` setup](../../../dotfiles/neovim/lsp/READEME.md).

## Useful links

- [zig]
  - [zig-learn]
- [zig-source]
- [build-zig-from-sources]
- [zig-bootstrap]
  - [zig-bootstrap-build-instructions]
- [codeberg-zig-shell-completions]
- [ziggy]
- [gh-ziggy]

[zig]: https://ziglang.org/learn/
[zig-learn]: https://ziglang.org/learn/
[zig-source]: https://codeberg.org/ziglang/zig
[build-zig-from-sources]: https://codeberg.org/ziglang/zig#building-from-source-using-prebuilt-zig
[zig-bootstrap]: https://codeberg.org/ziglang/zig-bootstrap
[zig-bootstrap-build-instructions]: https://codeberg.org/ziglang/zig-bootstrap#build-instructions
[codeberg-zig-shell-completions]: https://codeberg.org/ziglang/shell-completions
[ziggy]: https://ziggy-lang.io/documentation/getting-started/
[gh-ziggy]: https://github.com/kristoff-it/ziggy
