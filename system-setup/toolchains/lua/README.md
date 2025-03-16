# Lua

[Lua is designed to be an embeddable language][a-look-at-the-design-of-lua]. This means, that, ususally, a program embeds and distributes lua runtime/interpreter with it. Therefore, this Lua toolchain guide considers some of the tools that users of such embedded Lua may be interested in setting up.

## [LuaJIT][luagit]

### LuaJIT installation

> [!NOTE]
>
> You need a [C/C++ toolchain](../llvm/README.md) to build LuaJIT.

Based on the [official installation instructions][luajit-installation].

Clone LuaJIT repo:

```shell
git clone git@github.com:LuaJIT/LuaJIT.git
cd ./LuaJIT
git checkout "${LUAJIT_VERSION}"
```

Install build dependencies:

```shell
sudo apt update -y
sudo apt install -y build-essential
```

Build LuaJIT:

```shell
env CC="$(which clang)" make
```

Install LuaJIT build:

```shell
sudo make install
```

## [`luarocks`][luarocks]

### `luarocks` installation

> [!IMPORTANT]
>
> Users must first install a Lua implementation before installing `luarocks`. I.e. they should install [LuaJIT](#luajit) first.

Based on the [official installation instructions][luarocks-install-unix].

Clone `luarocks` repo:

```shell
git clone git@github.com:luarocks/luarocks.git
cd ./luarocks
git clone "${LUAROCKS_VERSION}"
```

Install build dependencies:

```shell
sudo apt update -y
sudo apt install -y \
  build-essential \
  libreadline-dev \
  unzip
```

Configure the build:

```shell
env CC="$(which clang)" \
  ./configure
```

Build `luarocks`:

```shell
make
```

Install `luarocks` build:

```shell
sudo make install
```

## Useful links

- [luajit][luajit]
  - [luajit-installation][luajit-installation]
- [luarocks][luarocks]
  - [luarocks-docs][luarocks-docs]
  - [luarocks-install-unix][luarocks-install-unix]
- [a-look-at-the-design-of-lua][a-look-at-the-design-of-lua]

[luajit]: <https://luajit.org>
[luajit-installation]: <https://luajit.org/install.html>
[luarocks]: <https://luarocks.org/>
[luarocks-docs]: <https://github.com/luarocks/luarocks/blob/main/docs/index.md>
[luarocks-install-unix]: <https://github.com/luarocks/luarocks/blob/main/docs/installation_instructions_for_unix.md>
[a-look-at-the-design-of-lua]: <https://www.lua.org/doc/cacm2018.pdf>
