# Kitty

Source: https://github.com/kovidgoyal/kitty.
Docs: https://sw.kovidgoyal.net/kitty/.

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [C/C++](../system-setup/toolchains/llvm/README.md).
> - [Python](../system-setup/toolchains/python/README.md).
> - [Go](../system-setup/toolchains/go/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

> [!NOTE]
>
> Additionally, ensure that you have [Nerd Fonts](../system-setup/fonts.md#nerd-fonts) installed and cloned on your system. The kitty's build requires `patched-fonts/NerdFontsSymbolsOnly/SymbolsNerdFontMono-Regular.ttf` to be available as `fonts/SymbolsNerdFontMono-Regular.ttf`.

Checkout kitty's sources of the desired version (`${KITTY_VERSION}`):

```shell
git clone https://github.com/kovidgoyal/kitty.git
cd ./kitty
git checkout "${KITTY_VERSION}"
```

Install the [necessary system dependencies][kitty-deps].

E.g. for a Debian-based system run:

```shell
./install-dependencies.sh
```

Ensure you have the [graphics libraries](../../system-setup/graphics.md) set up for your system (specifcially, you will need OpenGL implementation for your graphics hardware vendor).

Ensure that you have [Wayland](../system-setup/wayland/README.md) and the corresponding headers (i.e. the dev package) to build kitty with Wayland support.

Create a hardlink to the symbols Nerd Font file for the build:

```shell
mkdir -p fonts/
ln patched-fonts/NerdFontsSymbolsOnly/SymbolsNerdFontMono-Regular.ttf fonts/SymbolsNerdFontMono-Regular.ttf
```

<!--
> [!NOTE]
>
> You can run `./dev.sh --help` to list all the available commands and options.

Build kitty:

```shell
export CC="$(which clang)"
export CXX="$(which clang++)"
export LD="$(which ld.lld)"
./dev.sh build
```
-->

> [!NOTE]
>
> For this build to work you may need to compile python with `CFLAGS="-fPIC"`.

Install the python dependnecies required for the build into a venv and keep the venv activated when running the build:

```shell
python3 -m venv ./venv
. ./venv/bin/activate
pip install -r ./docs/requirements.txt
```

Kitty's build system uses system linker by default to build some C/C++ targets and there is no way to configure it to use a different linker. If some dependencies were previously built with LLVM's `lld` linker (e.g. python), there may be problems linking them with a the default system `ld` linker. Therefore for the duration of the build, we should change system linker to point to LLVM `lld` and then change it back.

```shell
sudo mv /usr/bin/ld /usr/bin/ld.back
sudo ln -s "$(which ld.lld)" /usr/bin/ld

make linux-package \
  CC="$(which clang)" \
  CFLAGS="--start-no-unused-arguments -fuse-ld=lld --end-no-unused-arguments" \
  CXX="$(which clang++)" \
  CXXFLAGS="--start-no-unused-arguments -fuse-ld=lld --end-no-unused-arguments" \
  LD="$(which ld.lld)"

sudo mv /usr/bin/ld /usr/bin/ld.back.lld
sudo mv /usr/bin/ld.back /usr/bin/ld 
```

Ensure that the `/ust/bin/ld` points to the native system's linker after the manupitations.

Delete all the backups:
- /usr/bin/ld.back.lld
- /usr/bin/ld.back

> [!NOTE]
>
> The default system linker on x64 Ubuntu is `/usr/bin/x86_64-linux-gnu-ld`.

> [!NOTE]
>
> In case something goes wrong with the build and you want to do a clean rebuild add a `--full` to the `./dev.sh build`. Alternatively, you can run `make clean`.

The `linux-package` target will "stage" all the kitty-related files in the `linux-package` directory. Copy all the files

```shell
sudo cp -r ./linux-package/* /usr/local/
```

## Set kitty as default terminal

### `update-alternatives`

If your system uses `update-alternatives` to manage programs alternatives, you can do the following to make kitty the default termianal emulator:

```shell
sudo update-alternatives --install \
  "$(update-alternatives --query x-terminal-emulator | awk '/Link: / { print $2 }')" \
  x-terminal-emulator \
  "$(which kitty)" \
  1
sudo update-alternatives --set x-terminal-emulator "$(which kitty)"
```

## Configuration

Use the config from this repository on your system by creating symlinking the user config default directory to the config dir in this repo (the script will prompt you for confirmation before running any configuration commands):

```shell
./setup-config.sh
```

- [ ] TODO
  - Don't scrollback after clear
  - Set neovim as default pager
    - https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Browse

### Kittens bundle

- [ ] TODO: setup
  - https://github.com/mikesmithgh/kitty-scrollback.nvim
  - https://github.com/jktr/matplotlib-backend-kitty
  - https://github.com/itsjunetime/tdf
  - https://github.com/trygveaa/kitty-kitten-search

### Features

#### Keyboard shortcuts

- [ ] TODO: document useful frequent keyboard shortcuts
  - Document the default keybindings from the [docs overview page][kitty-docs-local]

#### Shell integration

- [ ] [TODO][kitty-shell-integration]

## Useful links

- [build-kitty-from-source][build-kitty-from-source]
  - [kitty-deps][kitty-deps]
- [debian-desktop-change-terminal-emulator][debian-desktop-change-terminal-emulator]
- [kitty-docs-local][kitty-docs-local]
  - [kitty-mappings-local][kitty-mappings-local]
    - [kitty-mappings][kitty-mappings]
  - [kitty-hints-local][kitty-hints-local]
    - [kitty-hints][kitty-hints]
  - [kitty-shell-integration-local][kitty-shell-integration-local]
    - [kitty-shell-integration][kitty-shell-integration]
- [arch-wiki-kitty][arch-wiki-kitty]

[build-kitty-from-source]: <https://sw.kovidgoyal.net/kitty/build/>
[kitty-deps]: <https://sw.kovidgoyal.net/kitty/build/#dependencies>
[debian-desktop-change-terminal-emulator]: <https://askubuntu.com/questions/1135970/ctrl-alt-t-launches-a-different-terminal-than-that-from-the-launcher>
[kitty-docs-local]: <file:///usr/local/share/doc/kitty/html/overview.html>
[kitty-shell-integration-local]: <file:///usr/local/share/doc/kitty/html/shell-integration.html>
[kitty-shell-integration]: <https://sw.kovidgoyal.net/kitty/shell-integration/>
[kitty-mappings-local]: <file:///usr/local/share/doc/kitty/html/mapping.html>
[kitty-mappings]: <https://sw.kovidgoyal.net/kitty/mapping/>
[kitty-hints-local]: <file:///usr/local/share/doc/kitty/html/kittens/hints.html>
[kitty-hints]: <https://sw.kovidgoyal.net/kitty/kittens/hints/>
[arch-wiki-kitty]: <https://wiki.archlinux.org/title/Kitty>
