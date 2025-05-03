# `tmux`

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [C/C++](../system-setup/toolchains/llvm/README.md).
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

## Useful links

- [arch-wiki-tmux][arch-wiki-tmux]
- [github-tmux][github-tmux]
- [tmux-docs][tmux-docs]
- [youtube-tmux-zen-config][youtube-tmux-zen-config]

[arch-wiki-tmux]: <https://wiki.archlinux.org/title/Tmux>
[github-tmux]: <https://github.com/tmux/tmux>
[tmux-docs]: <https://github.com/tmux/tmux/wiki>
[youtube-tmux-zen-config]: <https://www.youtube.com/watch?v=DzNmUNvnB04>
