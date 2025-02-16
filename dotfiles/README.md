# Dotfiles

Configuration and setup instructions for the commonly used customized software.

> [!NOTE]
>
> To install some of the software listed here, users may require the following language toolhcains:
> - [C/C++](../system-setup/toolchains/llvm/README.md).
> - [Python](../system-setup/toolchains/python/README.md).
> - [Go](../system-setup/toolchains/go/README.md).
> - [Rust](../system-setup/toolchains/rust/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

## Software

### Structure

This directory contains instructions to install and set up programs for power user/developer's workflow and the corresponding configuration files for these programs that users of this repo can use to reproduce the setup from this repo. The idea of this repository is to enable anybody who is interested in replicating this setup to do so. This should allow users of the software in this repo to depend on the software behavior and their workstation setup over time, withstanding the change in hardware or a loss of data on their persistent storage.

#### `core`

The **top level** of this directory contains subdirectories that correspond to **core** programs around which maintainers of this repo build the setup and their workflow. These programs and their corresponding adoption status are:

- Usable:
  - [zsh](./zsh/README.md).
- In progress:
  - [Kitty](./kitty/README.md).
  - [`neovim`](./neovim/README.md).
  - [tmux](./tmux/README.md).
- TODO:
  - [ ] Code suggestions in text editors (perhaps using codellama).
    - Consider sourcegraph's Cody for text editor integration.
  - [ ] Hyperland.

##### [Terminal utils](./terminal-utils/README.md)

[Terminal utils](./terminal) are **terminal programs** that dramatically **increase user experience of the [`core`](#core) programs and closely integrate with them**. However, these programs are developed independently of the `core` programs and users can set them up and use them without `core` programs if they wish to do so.

#### [GUI](./gui/README.md)

Programs that are **primarily [GUI-based](./gui/README.md)**.

#### [Tools](./tools/README.md)

Other programs that are **not primarily [GUI-based](./gui/README.md)** and that users can **set up, cofigure, and use independently of the [`core`](#core) programs**. Nevertheless, they can still impact end-to-end system usage experience significatly.

#### Notes on [toolchains](../system-setup/toolchains/README.md)

This repo distinguishes another category of the software that is an essential component of the system setup - **toolchains**. This repo classifies a program as a toolchain if it has the following properties (up to functional equivalence):

- Takes files as inputs and produces other files as an output. It can be said that, a toolcahin compiles source files into target artifacts. The produced files need not necessarily be executable. Usually:
  - The compilation process is non-interactive with the respect to the command used to produce the output.
  - There can be another program that runs a toolchain on a set of source files to produce the target artifact - a **build system**. In this repo, such a program would be considered a [tool](#tools).
  - E.g. this repo does not consider programs that process data (such as `awk`) to be toolcahins. However, programs like `lualatex` would be considered a toolchain.
- The target artifact can be a runnable file or a toolchain program runs/interprets source files on its own.
  - E.g. this way `python` and `node` are toolchains as well.

Since this repo considers toolchains to be a part of the system setup, rather than a workspace setup (workspace setup is built on top of the system setup), toolchains reside under the [`../system-setup/toolchains`](../system-setup/toolchains/README.md).

### Deprecated

The subtree under the [`./deprecated/`](./deprecated/) directory consists of the software that the setup used previously, but decided to abandon using it. Therefore, this guide does not recommend setting this software up as a part of this setup.

## Future plans

- [ ] TODO: Make this setup (or a part of it) into a nix package.

<!--

### `home-manager`

Source: https://github.com/nix-community/home-manager
Docs: https://nix-community.github.io/home-manager/

-->
