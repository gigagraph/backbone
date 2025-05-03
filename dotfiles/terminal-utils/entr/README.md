# `entr`

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [C/C++](../../system-setup/toolchains/llvm/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends building and installing `entr` from sources.

Clone the repo and checkout the latest stable version:

```bash
git clone git@github.com:eradman/entr.git
cd entr
git checkout "${ENTR_VERSION}"
```

Build and test `entr`:

```bash
make test \
  CC="$(which clang)" \
  CFLAGS="--start-no-unused-arguments -fuse-ld=lld --end-no-unused-arguments" \
  CXX="$(which clang++)" \
  CXXFLAGS="--start-no-unused-arguments -fuse-ld=lld --end-no-unused-arguments" \
  LD="$(which ld.lld)"
```

Install `entr`:

```bash
sudo make install
```

## Useful links

- [github-entr][github-entr]

[github-entr]: <https://github.com/eradman/entr>
