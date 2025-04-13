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

### Plugins

This setup uses plugins listed in this seciton. Each section describes how the plugin contributes to the overal usage experience of this configuration. This should help find usage experience inconsistencies and help resolve funcitonality conflicts if different plugins provide overlapping functionality. This should help users to determine which behaviors of the setup they can depend on.

- [ ] TODO: specify the convention for plugin management and configuration in this config with lazy.

#### [`catppuccin/nvim`][catppucin-nvim]

This setup uses `catppuccin/nvim` as a default colorscheme for `neovim`.

#### [`mini.nvim`][mini-nvim]

This section contains subsections that describe all `mini`-modules that this setup depends on. See the corresponding section for details on how exactly it contributes to the setup.

##### [`mini.ai`][mini-nvim-ai]

Enhances `vim`'s `a`/`i`-keybinding experience providing more flexibility for addressing text objects inside and around other text objects.

```
:help mini.ai
```

##### [`mini.align`][mini-nvim-align]

Enables to quickly align potions of text in a specified way.

```
:help mini.align
```

##### [`mini.comment`][mini-nvim-comment]

Enable a keybinding to comment and uncomment text. Integrates with Treesitter to derive 'commentstring' per file type.

```
:help mini.comment
```

##### [`mini.move`][mini-nvim-move]

Enables moving the selected text in a specified direction.

```
:help mini.move
```

##### [`mini.pairs`][mini-nvim-pairs]

Add a matching string when another part of the matching string is insertedfrom a predefined list. By default, the plugin will match the following strings:

- Quotes (`''`, `""`, `\`\``)
- Parentheses (`()`, `[]`, `{}`), etc.

```
:help mini.pairs
```

##### [`mini.split-join`][mini-nvim-split-join]

Enables to split arguments passed to a function into multiplelines and collapse them back into one. Works with regexes and does not integrate with Treesitter or LSP. It should be good enough to work for most C-like languages out of the box.

```
:help mini.split-join
```

##### [`mini.basics`][mini-nvim-basics]

Sane default opinions for basic options that the config does not set manually.

```
:help mini.basics
```

##### [`mini.cursorword`][mini-nvim-cursorword]

Highlights words that are the same as the current word under the cursor. Uses `<cword>` to find the mathcing words. I.e. does not integrate with Treesitter or LSP.

```
:help mini.cursorword
```

> [!NOTE]
>
> To disable core functionality, set `vim.g.minicursorword_disable` (globally) or `vim.b.minicursorword_disable` (for a buffer) to `true`.

##### [`mini.statusline`][mini-nvim-statusline]

Changes the default status line to better reflect the state of the current buffer when editing text, yet still keeps it minimalistic.

```
:help mini.statusline
```

##### [`mini.trailspace`][mini-nvim-trailspace]

Highlights tailing whitespaces in buffers and allows to get trim them.

```
:help mini.trailspace
```

> [!NOTE]
>
> Run the following command to trim trailing whitespaces and empty lines in the current buffer.
>
> ```
> :lua MiniTrailspace.trim()
> :lua MiniTrailspace.trim_last_lines()
> ```

###### [`mini.trailspace`] custom keymaps

This config sets custom keymaps to trim trailing spaces:

- `<leader><leader>t`**`w`** - to trim **w**hitespaces.
- `<leader><leader>t`**`l`** - to trim last empty **l**lines (including if they have only whitespaces) in the buffer.
- `<leader><leader>t`**`a`** - to trim **a**ll: whitespaces and last empty lines.

##### [`mini.icons`][mini-nvim-icons]

Enables [`mini.nvim`][mini-nvim] to use icons.

```
:help mini.icons
```

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
- Plugins
  - [catppucin-nvim][catppucin-nvim]
  - [mini-nvim][mini-nvim]
    - [mini-nvim-ai][mini-nvim-ai]
    - [mini-nvim-align][mini-nvim-align]
    - [mini-nvim-comment][mini-nvim-comment]
    - [mini-nvim-move][mini-nvim-move]
    - [mini-nvim-pairs][mini-nvim-pairs]
    - [mini-nvim-split-join][mini-nvim-split-join]
    - [mini-nvim-basics][mini-nvim-basics]
    - [mini-nvim-cursorword][mini-nvim-cursorword]
    - [mini-nvim-statusline][mini-nvim-statusline]
    - [mini-nvim-trailspace][mini-nvim-trailspace]
    - [mini-nvim-icons][mini-nvim-icons]

[github-neovim]: <https://github.com/neovim/neovim>
[neovim-build-deps]: <https://github.com/neovim/neovim/blob/master/BUILD.md#build-prerequisites>
[lua-key-conceps-in-15-minutes]: <https://learnxinyminutes.com/docs/lua/>
[github-neovim-kickstart]: <https://github.com/nvim-lua/kickstart.nvim>
[youtube-tj-reads-whole-neovim-manual]: <https://youtu.be/rT-fbLFOCy0>
[youtube-tj-advent-of-neovim]: <https://www.youtube.com/watch?v=TQn2hJeHQbM&list=PLep05UYkc6wTyBe7kPjQFWVXTlhKeQejM>
[youtube-tj-neovim-kickstart]: <https://youtu.be/m8C0Cq9Uv9o?si=ieM47MFLWca9lt01>
[catppucin-nvim]: <https://github.com/catppuccin/nvim>
[mini-nvim]: <https://github.com/echasnovski/mini.nvim>
[mini-nvim-ai]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md>
[mini-nvim-align]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-align.md>
[mini-nvim-comment]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md>
[mini-nvim-move]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-move.md>
[mini-nvim-pairs]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-pairs.md>
[mini-nvim-split-join]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-splitjoin.md>
[mini-nvim-basics]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-basics.md>
[mini-nvim-cursorword]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-cursorword.md>
[mini-nvim-statusline]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-statusline.md>
[mini-nvim-trailspace]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-trailspace.md>
[mini-nvim-icons]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-icons.md>
