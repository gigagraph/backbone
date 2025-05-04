# `neovim`

Source: https://github.com/neovim/neovim.

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [C/C++](../system-setup/toolchains/llvm/README.md).
>
> The following toolchains are optional, but recommended:
> - [Lua](../system-setup/toolchains/lua/README.md).
> - [Node](../system-setup/toolchains/node/README.md).
> - [Tree-sitter](../system-setup/toolchains/tree-sitter/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

Clone the [neovim repo][github-neovim] locally:

```bash
git clone git@github.com:neovim/neovim.git
cd ./neovim
git checkout "${NEOVIM_VERSION}"
```

Install build dependencies:

```bash
./install-dependencies.sh
```

Build neovim from sources and test the build:

```bash
export CC="$(which clang)"
export CFLAGS="--start-no-unused-arguments -fuse-ld=lld --end-no-unused-arguments"
export CXX="$(which clang++)"
export CXXFLAGS="--start-no-unused-arguments -fuse-ld=lld --end-no-unused-arguments"

make CMAKE_BUILD_TYPE=Release

make test
```

Install the build locally:

```bash
sudo make install
```

Set `nvim` as default alternative for editor

```bash
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

Use the config from this repository on your system by symlinking the user config default directory to the config dir in this repo (the script will prompt you for confirmation before running any configuration commands):

```bash
./setup-config.sh
```

### Plugins

This setup uses plugins listed in this seciton. Each section describes how the plugin contributes to the overal usage experience of this configuration. This should help find usage experience inconsistencies and help resolve funcitonality conflicts if different plugins provide overlapping functionality. This should help users to determine which behaviors of the setup they can depend on.

- [ ] TODO: specify the convention for plugin management and configuration in this config with lazy.

#### [`gruvbox`][gruvbox-nvim]

`gruvbox` is the default colorscheme in this setup in `neovim`.

Switch betwee dark and light by setting:

```lua
vim.o.background = "dark" -- or "light"
```

#### [`catppuccin/nvim`][catppucin-nvim]

This setup provides `catppuccin/nvim` colorscheme as an option for users.

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

##### [`mini.surround`][mini-nvim-surround]

Adds keybindings that enable manipulations with surrounding text of selected text objects.

```
:help mini.surround
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

#### [`nvim-treesitter`][nvim-treesitter]

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [C/C++](../system-setup/toolchains/llvm/README.md) (with libstdc++).
>
> The following toolchains are optional, but recommended:
> - [Node](../system-setup/toolchains/node/README.md).
> - [Tree-sitter](../system-setup/toolchains/tree-sitter/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

`nvim` already depends on [`tree-sitter`](../system-setup/toolchains/tree-sitter/README.md) library that enables it to use tree-sitter API, i.e. load parsers, use them to build parse trees incrementally, run queries agains the trees, etc.

```vim
:InspectTree " To inspect the current buffer tree
:EditQuery " To start a scratch buffer for a tree-sitter query that nvim will apply to the corresponding buffer
```

The purpose of this plugin is to provide a higher-level interface (compared to the default `nvim`'s `tree-sitter` integration) to operate `tree-sitter` in `nvim`, specifically:

- A simple way to install parsers for common languages.
- An API to manage the installed parsers.
- Other features that the plugin provides.

Run the following command to the a list of all languanges that the `nvim-treesitter` can install by default:

```vim
:TSInstallInfo
```

#### [`nvim-treesitter-context`][nvim-treesitter-context]

Ensure [`nvim-treesitter`][nvim-treesitter] is installed.

This plugin uses tree-sitter to display the definition of the scope in which cursor resides. This way users can see the context where they edit the text without having to scroll.

#### [`nvim-treesitter-textobjects`][nvim-treesitter-textobjects]

Ensure [`nvim-treesitter`][nvim-treesitter] is installed.

This plugin uses tree-sitter to define and manipulate `nvim` textobjects that tree-sitter captures for available languages.

#### [`nvim-treesitter-refactor`][nvim-treesitter-refactor]

Ensure [`nvim-treesitter`][nvim-treesitter] is installed.

This plugin uses tree-sitter to:

- Highlight definition of the current symbol under the cursor.
- Highlight the current scope in wihch the cursor resides.

Additionally, it can perform symbol renaming and go to definition, but because it operates at the tree-sitter level, this functionality is not as robust as language-semantics-aware tooling, so this configuration does not recommend using these features of the plugin. Instead, users should rely on LSP for these features.

#### [`nvim-lspconfig`][nvim-lspconfig]

> [!NOTE]
>
> Neovim has LSP client built in. However, it is the responsibility of LSP users to install the specific servers. See the [dedicated page](./lsp/README.md) for details about LSP and to find out how to install a specific LSP server that this setup supports.

Use `:help lsp` to find basic information about LSP integration in `neovim`.

[`nvim-lspconfig`][nvim-lspconfig] facilitates configuration of popular LSP servers.

#### [`plenary.nvim`][plenary-nvim]

This setup uses `plenary.nvim` as a "standard" library for nvim's Lua. It also relies on `plenary`'s [`test_harness`][plenary-test-harness] for [unit testing](#unit-testing) this setup.

### Testing

#### Unit testing

This setup uses [`plenary.nvim`][plenary-nvim] to write and run unit tests. Tests reside in `test/` directory relative to the file under test and have the same name of the file as the file being tested prefixed with `_spec` before the `.lua` extension. Tests that test interactions between modules reside under the `test/` directory as well and also end with `_spec` after the extension, but the name prefix can be any string allowed by common filesystems.

`plenary` offers similar interface to Lua's [`busted` testing library][lua-busted].

##### Running unit tests from `neovim`

```vim
:Lazy load plenary.nvim
:PlenaryBustedFile %
```

##### Running unit tests in a shell

Assuming your current working directory is the same as the directory where this file resides, run the following command:

```bash
nvim --headless -u './tests/minimal_init.lua' -c 'lua test_bkb_all()'
```

The script has a shebang line, so users can also simply execute the lua file directly to run all tests (`neovim` must be on the `$PATH`):

```bash
./tests/minimal_init.lua
```

###### Interact with testing environment

Additionally, users can initialize `neovim` in the testing environment interactively:

```bash
nvim -u './tests/minimal_init.lua'
```

Users can then run the following command to run all tests:

```vim
:lua test_bkb_all()
```

## Make `nvim` default pager

### Install `nvimpager`

Clone the `nvimpager` repo:

```bash
git clone git@github.com:lucc/nvimpager.git
cd ./nvimpager
git checkout "${NVIMPAGER_VERSION}"
```

Install build dependencies:

1. ```bash
   sudo apt update -y
   sudo apt install -y \
     scdoc
   ```
2. Install [`busted`](https://luarocks.org/modules/lunarmodules/busted):
     - ```bash
       luarocks install --local busted "${BUSTED_VERSION}"
       ```

Buidl & install `nvimpager`:

```bash
sudo make install
```

Test `nvimpager`:

```bash
make test BUSTED="$(luarocks show busted --porcelain | grep -e 'command\s+busted' | awk '{ print $3 }')"
```

> [!NOTE]
>
> It may be okay that the tests fail.

Set `PAGER` and `MANPAGER` envs to use `nvimpager` in your rc file:

```bash
export PAGER="$(which nvimpager)"
export MANPAGER="$(which nvimpager)"
```

```bash
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
- [nvim-tree-sitter][nvim-tree-sitter]
- Plugins
  - [catppucin-nvim][catppucin-nvim]
  - [gruvbox-nvim][gruvbox-nvim]
  - [mini-nvim][mini-nvim]
    - [mini-nvim-ai][mini-nvim-ai]
    - [mini-nvim-align][mini-nvim-align]
    - [mini-nvim-comment][mini-nvim-comment]
    - [mini-nvim-move][mini-nvim-move]
    - [mini-nvim-pairs][mini-nvim-pairs]
    - [mini-nvim-split-join][mini-nvim-split-join]
    - [mini-nvim-surround][mini-nvim-surround]
    - [mini-nvim-basics][mini-nvim-basics]
    - [mini-nvim-cursorword][mini-nvim-cursorword]
    - [mini-nvim-statusline][mini-nvim-statusline]
    - [mini-nvim-trailspace][mini-nvim-trailspace]
    - [mini-nvim-icons][mini-nvim-icons]
  - [nvim-treesitter][nvim-treesitter]
  - [nvim-treesitter-context][nvim-treesitter-context]
  - [nvim-treesitter-textobjects][nvim-treesitter-textobjects]
  - [nvim-lspconfig][nvim-lspconfig]
  - [plenary-nvim][plenary-nvim]
    - [plenary-test-harness][plenary-test-harness]
- [lua-busted][lua-busted]

[github-neovim]: <https://github.com/neovim/neovim>
[neovim-build-deps]: <https://github.com/neovim/neovim/blob/master/BUILD.md#build-prerequisites>
[lua-key-conceps-in-15-minutes]: <https://learnxinyminutes.com/docs/lua/>
[github-neovim-kickstart]: <https://github.com/nvim-lua/kickstart.nvim>
[youtube-tj-reads-whole-neovim-manual]: <https://youtu.be/rT-fbLFOCy0>
[youtube-tj-neovim-kickstart]: <https://youtu.be/m8C0Cq9Uv9o?si=ieM47MFLWca9lt01>
[youtube-tj-advent-of-neovim]: <https://www.youtube.com/watch?v=TQn2hJeHQbM&list=PLep05UYkc6wTyBe7kPjQFWVXTlhKeQejM>
[nvim-tree-sitter]: <https://neovim.io/doc/user/treesitter.html>
[catppucin-nvim]: <https://github.com/catppuccin/nvim>
[gruvbox-nvim]: <https://github.com/ellisonleao/gruvbox.nvim>
[mini-nvim]: <https://github.com/echasnovski/mini.nvim>
[mini-nvim-ai]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md>
[mini-nvim-align]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-align.md>
[mini-nvim-comment]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md>
[mini-nvim-move]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-move.md>
[mini-nvim-pairs]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-pairs.md>
[mini-nvim-split-join]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-splitjoin.md>
[mini-nvim-surround]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md>
[mini-nvim-basics]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-basics.md>
[mini-nvim-cursorword]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-cursorword.md>
[mini-nvim-statusline]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-statusline.md>
[mini-nvim-trailspace]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-trailspace.md>
[mini-nvim-icons]: <https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-icons.md>
[nvim-treesitter]: <https://github.com/nvim-treesitter/nvim-treesitter>
[nvim-treesitter-context]: <https://github.com/nvim-treesitter/nvim-treesitter-context>
[nvim-treesitter-textobjects]: <https://github.com/nvim-treesitter/nvim-treesitter-textobjects>
[nvim-lspconfig]: <https://github.com/neovim/nvim-lspconfig>
[plenary-nvim]: <https://github.com/nvim-lua/plenary.nvim>
[plenary-test-harness]: <https://github.com/nvim-lua/plenary.nvim?tab=readme-ov-file#plenarytest_harness>
[lua-busted]: <https://lunarmodules.github.io/busted/>
