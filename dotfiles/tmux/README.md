# `tmux`

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [C/C++](../../system-setup/toolchains/llvm/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

Install the dependencies:

```bash
./install-dependencies.sh
```

Clone the repo and checkout the latest stable version:

```bash
git clone git@github.com:tmux/tmux.git
cd ./tmux
git checkout "${TMUX_VERSION}"
```

Make the build use `clang`:

```bash
export CC="$(which clang)"
export CFLAGS="--start-no-unused-arguments -fuse-ld=lld --end-no-unused-arguments"
export CXX="$(which clang++)"
export CXXFLAGS="--start-no-unused-arguments -fuse-ld=lld --end-no-unused-arguments"
```

Prepare the build:

```bash
sh autogen.sh
./configure
```

Build and install:

```bash
make
sudo make install
```

## Configuration

- [ ] TODO

### Plugins

- [ ] TODO

Tmux plugins lists:

- [gh-tmux-plugin-list].
- [gh-awesome-tmux].

List of plugins to be considered for installation:

- [`tpm`][gh-tpm].
- [`tmux-sensible`][gh-tmux-sensible].
- [`tmux-yank`][gh-tmux-yank].
- [`tmux-harpoon`][gh-tmux-harpoon].
- [`tmux-easy-motion`][gh-tmux-easy-motion].
- [`tmux-easymotion`][gh-tmux-easymotion].
- [`vim-tmux-navigator`][gh-vim-tmux-navigator].

## Useful links

- [arch-wiki-tmux]
- [github-tmux]
- [tmux-docs]
- [youtube-tmux-zen-config]
- [gh-tmux-plugin-list]
- [gh-awesome-tmux]
- [gh-tpm]
- [gh-tmux-sensible]
- [gh-tmux-yank]
- [gh-tmux-harpoon]
- [gh-tmux-easy-motion]
- [gh-tmux-easymotion]
- [gh-vim-tmux-navigator]

[arch-wiki-tmux]: <https://wiki.archlinux.org/title/Tmux>
[github-tmux]: <https://github.com/tmux/tmux>
[tmux-docs]: <https://github.com/tmux/tmux/wiki>
[youtube-tmux-zen-config]: <https://www.youtube.com/watch?v=DzNmUNvnB04>
[gh-tmux-plugin-list]: https://github.com/tmux-plugins/list
[gh-awesome-tmux]: https://github.com/rothgar/awesome-tmux
[gh-tpm]: https://github.com/tmux-plugins/tpm
[gh-tmux-sensible]: https://github.com/tmux-plugins/tmux-sensible
[gh-tmux-yank]: https://github.com/tmux-plugins/tmux-yank
[gh-tmux-harpoon]: https://github.com/Chaitanyabsprip/tmux-harpoon
[gh-tmux-easy-motion]: https://github.com/IngoMeyer441/tmux-easy-motion
[gh-tmux-easymotion]: https://github.com/ddzero2c/tmux-easymotion
[gh-vim-tmux-navigator]: https://github.com/christoomey/vim-tmux-navigator
