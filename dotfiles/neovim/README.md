# `neovim`

Source: https://github.com/neovim/neovim.

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [C/C++](../system-setup/toolchains/llvm/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

Clone the [neovim repo][github-neovim] locally:

```shell
git clone git@github.com:neovim/neovim.git
cd ./neovim
git checkout "${NEOVIM_VERSION}"
```

Install build dependencies:

```shell
./install-dependencies.sh
```

Build neovim from sources and test the build:

```shell
export CC="$(which clang)"
export CFLAGS="--start-no-unused-arguments -fuse-ld=lld --end-no-unused-arguments"
export CXX="$(which clang++)"
export CXXFLAGS="--start-no-unused-arguments -fuse-ld=lld --end-no-unused-arguments"

make CMAKE_BUILD_TYPE=Release 

make test
```

Install the build locally:

```shell
sudo make install
```

Set `nvim` as default alternative for editor

```shell
sudo update-alternatives --install /usr/bin/editor editor "$(which nvim)" 1
sudo update-alternatives --set editor "$(which nvim)"
sudo update-alternatives --install /usr/bin/vi vi "$(which nvim)" 1
sudo update-alternatives --set vi "$(which nvim)"
```

## Configuration

[`neovim` config resides in `${$XDG_CONFIG_HOME}/init.lua` file](https://neovim.io/doc/user/lua-guide.html#lua-guide-config). Find more info by inspecifng help pages in `neovim`:

> [!NOTE] Useful resources for configuring `neovim`
>
> - Consult with:
>   - [`kickstart.nvim`][github-neovim-kickstart] for a comprehensive single-file configuration of `neovim`.
>   - `neovim`'s reference docs to find more information about configuring `neovim`:
>     - ```
>       :help lua-guide
>       :help init.lua
>       ```
>   - Lua Reference manual in `neovim`:
>     - ```
>       :help luaref
>       ```
>   - Reference for Lua and `neovim` integration:
>     - ```
>       :help lua
>       ```

Use the config from this repository on your system by creating symlinking the user config default directory to the config dir in this repo (the script will prompt you for confirmation before running any configuration commands):

```shell
./setup-config.sh
```

- [ ] TODO: specify the convention for plugin management and configuration in this config with lazy.

## Make `nvim` default pager

### Install `nvimpager`

Clone the `nvimpager` repo:

```shell
git clone git@github.com:lucc/nvimpager.git
cd ./nvimpager
git checkout "${NVIMPAGER_VERSION}"
```

Install build dependencies:

1. ```shell
   sudo apt update -y
   sudo apt install -y \
     scdoc
   ```
2. Install [`busted`](https://luarocks.org/modules/lunarmodules/busted):
     - ```shell
       luarocks install --local busted "${BUSTED_VERSION}"
       ```

Buidl & install `nvimpager`:

```shell
sudo make install
```

Test `nvimpager`:

```shell
make test BUSTED="$(luarocks show busted --porcelain | grep -e 'command\s+busted' | awk '{ print $3 }')"
```

> [!NOTE]
>
> It may be okay that the tests fail.

Set `PAGER` and `MANPAGER` envs to use `nvimpager` in your rc file:

```shell
export PAGER="$(which nvimpager)"
export MANPAGER="$(which nvimpager)"
```

```shell
for pager_alternative in 'pager'; do
  sudo update-alternatives --install \
    "$(update-alternatives --query "${pager_alternative}" | awk '/Link: / { print $2 }')" \
    "${pager_alternative}"  \
    "$(which nvimpager)" \
    1
  sudo update-alternatives --set "${pager_alternative}" "$(which nvimpager)"
done
```

## Useful links

- [github-neovim][github-neovim]
- [neovim-build-deps][neovim-build-deps]
- [lua-key-conceps-in-15-minutes][lua-key-conceps-in-15-minutes]
- [github-neovim-kickstart][github-neovim-kickstart]
- [youtube-tj-reads-whole-neovim-manual][youtube-tj-reads-whole-neovim-manual]
- [youtube-tj-neovim-kickstart][youtube-tj-neovim-kickstart]
- [youtube-tj-advent-of-neovim][youtube-tj-advent-of-neovim]

[github-neovim]: <https://github.com/neovim/neovim>
[neovim-build-deps]: <https://github.com/neovim/neovim/blob/master/BUILD.md#build-prerequisites>
[lua-key-conceps-in-15-minutes]: <https://learnxinyminutes.com/docs/lua/>
[github-neovim-kickstart]: <https://github.com/nvim-lua/kickstart.nvim>
[youtube-tj-reads-whole-neovim-manual]: <https://youtu.be/rT-fbLFOCy0>
[youtube-tj-advent-of-neovim]: <https://www.youtube.com/watch?v=TQn2hJeHQbM&list=PLep05UYkc6wTyBe7kPjQFWVXTlhKeQejM>
[youtube-tj-neovim-kickstart]: <https://youtu.be/m8C0Cq9Uv9o?si=ieM47MFLWca9lt01>
