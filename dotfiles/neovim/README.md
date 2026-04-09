# `neovim`

Source: https://github.com/neovim/neovim.

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [C/C++](../../system-setup/toolchains/llvm/README.md).
>
> The following toolchains are optional, but recommended:
> - [Lua](../../system-setup/toolchains/lua/README.md).
> - [Node](../../system-setup/toolchains/node/README.md).
> - [Tree-sitter](../../system-setup/toolchains/tree-sitter/README.md).
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

Plugins to be considered for installation:

- Uncategorized:
  - [`noice.nvim`](https://github.com/folke/noice.nvim).
  - [`nvim-surround`](https://github.com/kylechui/nvim-surround).
  - [`zoxide.nvim`](https://github.com/nanotee/zoxide.vim).
  - [`fzf-lua`](https://github.com/ibhagwan/fzf-lua).
  - [`render-markdown.nvim`](https://github.com/MeanderingProgrammer/render-markdown.nvim).
  - [`which-key.nvim`](https://github.com/folke/which-key.nvim).
  - [`harpoon`](https://github.com/ThePrimeagen/harpoon/).
  - [`vim-illuminate`](https://github.com/RRethy/vim-illuminate).
  - [`flatten.nvim`](https://github.com/willothy/flatten.nvim).
- Quicker navigation:
  - [`hop.nvim`](https://github.com/smoka7/hop.nvim).
  - [`flash.nvim`](https://github.com/folke/flash.nvim).
  - [`mini.jump2d`](https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-jump2d.md).
  - [`vim-easymotion`](https://github.com/easymotion/vim-easymotion).
- Explainability:
  - [telescope cheatsheet](https://github.com/doctorfree/cheatsheet.nvim).
- VCS:
  - [`gitsigns.nvim`](https://github.com/lewis6991/gitsigns.nvim).
  - [`neogit`](https://github.com/NeogitOrg/neogit).
- AI:
  - [`CopilotChat.nvim`](https://github.com/CopilotC-Nvim/CopilotChat.nvim).
  - [`gp.nvim`](https://github.com/Robitx/gp.nvim).
  - [`gen.nvim`](https://github.com/David-Kunz/gen.nvim).
  - [`minuet-ai.nvim`](https://github.com/milanglacier/minuet-ai.nvim).
  - [`codecompanion.nvim`](https://github.com/olimorris/codecompanion.nvim).
  - [`mcphub.nvim`](https://github.com/ravitemer/mcphub.nvim).

#### Custom plugins

[`lazy.nvim`][lazy-nvim] users may find it hard to install some plugins, e.g. those that reside in a subdirectory of another repostiory ([`quick-lint/quick-lint-js/issues/1195`](https://github.com/quick-lint/quick-lint-js/issues/1195), [`folke/lazy.nvim/issues/1319`](https://github.com/folke/lazy.nvim/issues/1319), [`folke/lazy.nvim/issues/183`](https://github.com/folke/lazy.nvim/issues/183), [`folke/lazy.nvim/issues/756`](https://github.com/folke/lazy.nvim/issues/756)).

In these cases users should install such a plugin semi-manually.

Users should create a directory under `neovim`'s `data` dir where they will install the custom plugin (this setup calls such directory `bkb-plugins`).

```bash
echo "$(nvim --headless -c 'lua vim.print(vim.fn.stdpath("data"))' +qa 2>&1 | sed -E 's/(^"|"$)//g')/bkb-plugins"
```

Then users should clone their plugins under this directory and add the plugin diectories to `neovim`'s `runtimepath`. E.g. with `lazy.nvim`, users can specify the path to the plugin in the plugin spec with the `dir` property, for example:

```lua
{
  dir = vim.fn.stdpath("data") .. "/bkb-plugins/quick-lint-js/plugin/vim/quick-lint-js.vim",
  name = "quick-lint-js",
  pin = false,
  lazy = false,
}
```

#### [`catppuccin/nvim`][catppucin-nvim]

This config builds a custom colorscheme based on [`catppuccin/nvim`][catppucin-nvim] colorscheme that shifts Cattpuccin Mocha more to the red part of the visible spectrum to reduce eye strain. This works well when continuosuly looking at text for long periods of time.

Switch betwee dark and light by setting:

```vim
:set background=dark " or light
```

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
> - [C/C++](../../system-setup/toolchains/llvm/README.md) (with libstdc++).
>
> The following toolchains are optional, but recommended:
> - [Node](../../system-setup/toolchains/node/README.md).
> - [Tree-sitter](../../system-setup/toolchains/tree-sitter/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

`nvim` already depends on [`tree-sitter`](../../system-setup/toolchains/tree-sitter/README.md) library that enables it to use tree-sitter API, i.e. load parsers, use them to build parse trees incrementally, run queries agains the trees, etc.

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

#### [`nvim-jdtls`](./lsp/java.md#jdtls-installation)

This setup uses `nvim-jdtls` to enable better integration with `jdtls` LSP server. Find more info about Java LSP servers and their usage specifics in `neovim` in [`./lsp/java.md`](./lsp/java.md). Additionally, users can view `nvim-jdtls` plugin help with: `:help jdtls`.

#### [`helm-ls.nvim`](./lsp/helm.md#installation)

This setup uses `helm-ls.nvim` for enhanced filetype detection and `helm-ls` LSP server integration experience. Users can view `helm-ls.nvim`'s docs with `:help helm-ls-docs.txt`.

This plugin requires installed:

- `helm` treesitter grammar.
- [`helm-ls` LSP server](./lsp/helm.md).

#### [`haskell-tools.nvim`](./lsp/haskell/README.md#instalaltion)

This setup uses `haskell-tools.nvim` for enhanced `hls` LSP server integration experience. Users can view `haskell-tools.nvim`'s docs with `:help haskell-tools.config`.

This plugin requires installed [`hls` LSP server](./lsp/haskell/README.md).

#### [`nvim-emmet`](./lsp/web/README.md#emmet-language-server-installation)

This setup uses `nvim-emmet` for enhanced `emmet-language-server` LSP server integration experience. Specifically, the plugin enables users to wrap text into the expansions of emmet abbreviations.

#### [`nvim-colorizer`][nvim-colorizer]

This setup uses `nvim-colorizer` to colorize color "literals" such as #00000 or #ffffff with their actual color.

#### [`nvim-notify`][nvim-notify]

This setup uses `nvim-notify` to display notifications from `vim.notify` asyncronously and store their history for later inspection. The setup also configures `vim.lsp.handlers` that handle messages from LSP servers to [print the received messages via `nvim-notify`][nvim-notify-usage-recipes].

It is planned that later the setup will use `nvim-notify` with `nvim-dap` and `nvim-telescope`.

#### [`LuaSnip`][luasnip]

This setup uses [`LuaSnip`][luasnip] to enable snippet support in `neovim`. Additionally, it helps [`blink.cmp`](#blink-cmp) completion engine to parse LSP completions.

`LuaSnip` has an optional dependency on [`jsregexp`][jsregexp], which this guide recommends to install. It sets `build = "make install_jsregexp"` when it defines the plugin. This may be a not reliable way to install `jsregexp`. For [temporary alternative installation methods see `LuaSnip`'s recommendations](https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#transformations).

#### [`blink.cmp`][github-blink-cmp]

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Rust](../../system-setup/toolchains/rust/README.md).

This setup uses `blink.cmp` to configure completions and to enable expansion of LSP snippets. Use `:help blink-cmp` to find `blink-cmp`'s docs.

> [!NOTE]
>
> This setup points `blink.cmp` to a release version and installs Rust implementation of fuzzy matcher by downloading the prebuilt binaries.

#### [`colorful-menu.nvim`][colorful-menu-nvim]

This setup uses `colorful-menu.nvim` to highlight completion items from [`blink.cmp`](#blink-cmp) with treesitter.

#### [`nvim-lspconfig`][nvim-lspconfig]

> [!NOTE]
>
> Neovim has LSP client built in. However, it is the responsibility of LSP users to install the specific servers. See the [dedicated page](./lsp/README.md) for details about LSP and to find out how to install a specific LSP server that this setup supports.

This setup uses `nvim-lspconfig` to provide default configuration for common LSP servers from the `nvim`'s built-in LSP client.

Use `:help lsp` to find basic information about LSP integration in `neovim`.

[`nvim-lspconfig`][nvim-lspconfig] facilitates configuration of popular LSP servers.

Users must install LSP servers separately. This setup maintains configurations for supported LSP servers in [`config/lua/config/infra/lsp/init.lua`](./config/lua/config/infra/lsp/init.lua). Instructions to install specific LSP servers reside in [`lsp/`](./lsp/).

#### [`nvim-nio`][nvim-nio]

`nvim-nio` provides library for asynchronous IO in Neovim. It is also a dependency for other plugins.

Plugins that are known to depend on it:

- [`nvim-dap-ui`][nvim-dap-ui].

#### [`nvim-dap`][nvim-dap]

This setup uses `nvim-dap` to enable debugging capabilities in `neovim` via the .

More info about DAP, its setup in neovim, and how to install specific degubbers resides in [dap/README.md](./dap/README.md).

Use `:help dap.txt` to find the plugin's docs.

#### [`nvim-dap-ui`][nvim-dap-ui]

`nvim-dap-ui` provides UI for debugging programs via the [DAP protocol](#nvim-dap).

Use `:help nvim-dap-ui` to find the plugin's docs.

#### [`nvim-dap-virtual-text`][nvim-dap-virtual-text]

`nvim-dap-virtual-text` ads virtual text to [DAP](#nvim-dap) debugging sessions.

Use `:help nvim-dap-virtual-text-nvim-dap-virtual-text` to find the plugin docs.

#### [`nvim-dap-go`][nvim-dap-go]

Enables [`nvim-dap`](#nvim-dap) integration with Go's `delve` debugger. I.e. makes `nvim-dap` run `delve` as a DAP adapter to debug Go programs.

Use `:help nvim-dap-go` to find the plugin docs.

Dependencies:

- [`delve`](./lsp/go.md#debugger).

#### [`telescope.nvim`][telescope-nvim]

This setup uses `telescope.nvim` to search and select different types of objects (files, strings, LSP references, diagnostics, `nvim` buffers, registers, etc.). One of the primary features of the plugin is that it facilitates file navigation.

Use `:help telescope` to find basic information.

##### `telescope.nvim` dependencies

`telescope.nvim` has an optional dependencies on the following software and this guide strongly recommends to install all of them:
- [`ripgrep`](../terminal-utils/ripgrep/README.md).
- [`fd`](../terminal-utils/fd/README.md).

##### [`telescope-fzf-native.nvim`][telescope-fzf-native-nvim]

This setup uses `telescope-fzf-native.nvim` to implement a performant version of the fuzzy search algorithm.

`telescope-fzf-native.nvim` depends on [`cmake`](../../system-setup/toolchains/llvm/README.md#cmake) for installation, so users must install it before they can build the plugin.

##### [`telescope-directory`][telescope-directory]

This setup uses `telescope-directory` to run actions on directories that users select in [`telescope`](#telescopenvim). One of the main goals of this plugin in this setup is to fuzzy search for a directory in the current dir and open using [`oil`](#oil-nvim).

`telescope-directory` can use [`fd`](../terminal-utils/fd/README.md) to search for directories, so this guide strongly recommends installing it for the best performance.

#### [`nvim-web-devicons`][nvim-web-devicons]

This setup uses `nvim-web-devicons` to provide icons based on [Nerd Fonts](../../system-setup/fonts.md#nerd-fonts). Therefore, `nvim-web-devicons` depens on [Nerd Fonts](../../system-setup/fonts.md#nerd-fonts). Users must ensure that their terminal uses Nerd Fonts for this plugin to work correctly.

Test if all the defined icons are supported with `:NvimWebDeviconsHiTest`.

#### [`oil.nvim`][oil-nvim]

This setup uses `oil.nvim` to enble vim-style manipulation of files on the filesystem.

Find out more with `:help oil`.

##### [`oil-git.nvim`][oil-git-nvim]

This setup uses `oil-git.nvim` to enrich [`oil.nvim`](#oil-nvim) listing with git-status-relate information.

##### [`oil-lsp-diagnostics.nvim`][oil-lsp-diagnostics-nvim]

This setup uses `oil-git.nvim` to enrich [`oil.nvim`](#oil-nvim) listing with LSP-diagnostic-related information.

##### [`Otree.nvim`][otree-nvim]

This setup uses `Otree.nvim` as a file tree that developers can use to naviate directories and files in the current working directory. `Otree` integrates with [`oil`](#oil-nvim) to manupulate the filesystem.

`Otree.nvim` can use [`fd`](../terminal-utils/fd/README.md) to list files, so this guide strongly recommends installing it for the best performance.

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
- [lua-annotations][lua-annotations]
- [github-neovim-kickstart][github-neovim-kickstart]
- [youtube-tj-reads-whole-neovim-manual][youtube-tj-reads-whole-neovim-manual]
- [youtube-tj-neovim-kickstart][youtube-tj-neovim-kickstart]
- [youtube-tj-advent-of-neovim][youtube-tj-advent-of-neovim]
  - [youtube-tj-quickfix][youtube-tj-quickfix]
- [youtube-neovimconf-2024-ai][youtube-neovimconf-2024-ai]
- [nvim-tree-sitter][nvim-tree-sitter]
- [lazy-nvim-github][lazy-nvim-github]
- [lazy-nvim][lazy-nvim]
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
  - [nvim-dap]
  - [dap]
  - [nvim-dap-ui]
  - [nvim-dap-virtual-text]
  - [nvim-dap-go]
  - [telescope-nvim][telescope-nvim]
  - [telescope-fzf-native-nvim][telescope-fzf-native-nvim]
  - [telescope-directory][telescope-directory]
  - [nvim-web-devicons][nvim-web-devicons]
  - [oil-nvim][oil-nvim]
  - [oil-git-nvim][oil-git-nvim]
  - [oil-lsp-diagnostics-nvim][oil-lsp-diagnostics-nvim]
  - [otree-nvim][otree-nvim]
  - [plenary-nvim][plenary-nvim]
    - [plenary-test-harness][plenary-test-harness]
  - [nvim-colorizer][nvim-colorizer]
  - [nvim-notify][nvim-notify]
    - [nvim-notify-usage-recipes][nvim-notify-usage-recipes]
  - [luasnip][luasnip]
    - [luasnip-doc][luasnip-doc]
    - [jsregexp][jsregexp]
    - [youtube-tj-luasnip-basics][youtube-tj-luasnip-basics]
    - [youtube-tj-luasnip-advanced][youtube-tj-luasnip-advanced]
- [lua-busted][lua-busted]
- [github-blink-cmp][github-blink-cmp]
  - [blink-cmp][blink-cmp]
- [colorful-menu-nvim][colorful-menu-nvim]

[github-neovim]: <https://github.com/neovim/neovim>
[neovim-build-deps]: <https://github.com/neovim/neovim/blob/master/BUILD.md#build-prerequisites>
[lua-key-conceps-in-15-minutes]: <https://learnxinyminutes.com/docs/lua/>
[lua-annotations]: <https://luals.github.io/wiki/annotations/>
[github-neovim-kickstart]: <https://github.com/nvim-lua/kickstart.nvim>
[youtube-tj-reads-whole-neovim-manual]: <https://youtu.be/rT-fbLFOCy0>
[youtube-tj-neovim-kickstart]: <https://youtu.be/m8C0Cq9Uv9o?si=ieM47MFLWca9lt01>
[youtube-tj-advent-of-neovim]: <https://www.youtube.com/watch?v=TQn2hJeHQbM&list=PLep05UYkc6wTyBe7kPjQFWVXTlhKeQejM>
[youtube-tj-quickfix]: https://www.youtube.com/watch?v=wOdL2T4hANk
[youtube-neovimconf-2024-ai]: <https://www.youtube.com/watch?v=GKQ9rJ12hjc&list=PLhlaLyAlbLlq9xWf2xm_9p422GgqvATXk&index=11>
[nvim-tree-sitter]: <https://neovim.io/doc/user/treesitter.html>
[lazy-nvim-github]: <https://github.com/folke/lazy.nvim>
[lazy-nvim]: <https://lazy.folke.io/>
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
[nvim-dap]: <https://codeberg.org/mfussenegger/nvim-dap>
[dap]: <https://microsoft.github.io/debug-adapter-protocol/>
[nvim-dap-ui]: <https://github.com/rcarriga/nvim-dap-ui>
[nvim-dap-virtual-text]: <https://github.com/theHamsta/nvim-dap-virtual-text>
[nvim-dap-go]: <https://github.com/leoluz/nvim-dap-go>
[telescope-nvim]: <https://github.com/nvim-telescope/telescope.nvim>
[telescope-fzf-native-nvim]: <https://github.com/nvim-telescope/telescope-fzf-native.nvim>
[telescope-directory]: <https://github.com/fbuchlak/telescope-directory.nvim>
[nvim-web-devicons]: <https://github.com/nvim-tree/nvim-web-devicons>
[oil-nvim]: <https://github.com/stevearc/oil.nvim>
[oil-git-nvim]: <https://github.com/benomahony/oil-git.nvim>
[oil-lsp-diagnostics-nvim]: <https://github.com/JezerM/oil-lsp-diagnostics.nvim>
[otree-nvim]: <https://github.com/Eutrius/Otree.nvim>
[plenary-nvim]: <https://github.com/nvim-lua/plenary.nvim>
[plenary-test-harness]: <https://github.com/nvim-lua/plenary.nvim?tab=readme-ov-file#plenarytest_harness>
[nvim-colorizer]: <https://github.com/norcalli/nvim-colorizer.lua>
[lua-busted]: <https://lunarmodules.github.io/busted/>
[nvim-notify]: <https://github.com/rcarriga/nvim-notify>
[nvim-notify-usage-recipes]: <https://github.com/rcarriga/nvim-notify/wiki/Usage-Recipes>
[luasnip]: <https://github.com/L3MON4D3/LuaSnip>
[luasnip-doc]: <https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md>
[jsregexp]: <https://github.com/kmarius/jsregexp>
[youtube-tj-luasnip-basics]: <https://www.youtube.com/watch?v=Dn800rlPIho>
[youtube-tj-luasnip-advanced]: https://www.youtube.com/watch?v=KtQZRAkgLqo
[github-blink-cmp]: <https://github.com/Saghen/blink.cmp?tab=readme-ov-file>
[blink-cmp]: <https://cmp.saghen.dev>
[colorful-menu-nvim]: <https://github.com/xzbdmw/colorful-menu.nvim>
