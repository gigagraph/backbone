# Python toolchain

## Installation

> [!NOTE]
>
> You need a [C/C++ toolchain](../llvm/README.md) to build Pyton.

This section describes how to install the latest stable version of [Cpython][python] interpreter systemwide on a linux distribution. On Linux, system admins should build Cpython from source.

### Build dependencies

Ensure you have [dependencies that the build requires][cpython-build-dependencies], e.g. on Debian-based systems run the script from this repo:

```bash
sudo ./install-debian-deps.sh
```

### Build instructions

```bash
git clone git@github.com:python/cpython.git
cd ./cpython
git checkout "${PYTHON_VERSION_TAG}"
env CC="$(which clang)" CFLAGS="-fPIC" CXX="$(which clang++)" CXXFLAGS="-fPIC" LD="lld" \
  ./configure --enable-optimizations --with-lto
make
make test
sudo make install
```

> [!NOTE]
>
> To remove everything that the `./configure` script created to start a fresh build, run `make distclean`.

### Add to `PATH`

Ensure `/usr/local/bin` is in `PATH` so that the system can locate the built python interpreter.

## [`pipx`][python-key-projects-pipx]

[`pipx`][python-key-projects-pipx] is a package manager for CLI tools in python ecosystem. It helps installing Python-based CLI tools without introducing global system dependency conflicts.

### `pipx` installation

Based on the [official installation instructions][pipx-docs-installation]:

Install the package:

```bash
# Ubuntu-based systems
sudo apt update -y
sudo apt install -y pipx

# Systems that do not provide `pipx` package in their package manager's repos
python3 -m pip install --user pipx
```

Ensure [`pipx`'s target installation location][pipx-docs-installation-dirs] in on your `PATH`.

Ensure that `pipx` is initialized:

```bash
pipx ensurepath
```

#### `pipx` completions

> [!NOTE]
>
> Since there is not simple way to install completions for `pipx` that is compatible with this setup and it does not bring that much value, this guide does not recommend setting up completions for `pipx`.

Print completion installation instructions:

```bash
pipx completions
```

## `uv`

[`uv`][uv] is package manager in python ecosystem that can replace `pip`. On top of dependency management functionalty, it offers [feature][uv-features] like management of python toolchains, virtual environments, projects, tools, script execution.

### `uv` installation

> [!NOTE]
>
> You may need a [Rust](../rust/README.md) to install `uv`.

Users can [install `uv` using a variety of methods][uv-installation]. This guide recommends installing it either from PyPI via [`pipx`](#pipx) or using [`cargo`](../rust/README.md).

This guide will use [`pipx`](#pipx) to manage the `uv` installation.

Install `uv` with `pipx`:

```bash
pipx install uv
```

[Ensure the `uv tool`'s bin path is on the `PATH`][uv-tools-bin-path].

#### `uv` completions

Depending on the shell, [users can install completions for `uv` and `uvx`][uv-installation-autocompletion].

See the corresponding section in the [zsh docs file in this repo](../../../dotfiles/zsh/README.md#uv-completions).

#### Updating `uv`

Depending on your [installation method](#uv-installation), you will need to use the corresponding method to update `uv`.

Since this guide uses `pipx` to manage `uv`, run the following command to upgrade `uv`:

```bash
pipx upgrade uv
```

## Useful links

- [python][python]
- [cpython-github][cpython-github]
- [cpython-build-dependencies][cpython-build-dependencies]
- [python-key-projects-pipx][python-key-projects-pipx]
- [pipx-docs-installation][pipx-docs-installation]
- [pipx-docs-installation-dirs][pipx-docs-installation-dirs]
- [github-uv][github-uv]
- [uv][uv]
  - [uv-installation][uv-installation]
    - [uv-installation-autocompletion][uv-installation-autocompletion]
  - [uv-features][uv-features]
  - [uv-tools][uv-tools]
    - [uv-tools-bin-path][uv-tools-bin-path]

[python]: <https://www.python.org>
[cpython-github]: <https://github.com/python/cpython>
[cpython-build-dependencies]: <https://devguide.python.org/getting-started/setup-building/#build-dependencies>
[python-key-projects-pipx]: <https://packaging.python.org/en/latest/key_projects/#pipx>
[pipx-docs-installation]: <https://pipx.pypa.io/stable/installation/#installing-pipx>
[pipx-docs-installation-dirs]: <https://pipx.pypa.io/stable/installation/#installation-options>
[github-uv]: https://github.com/astral-sh/uv
[uv]: https://docs.astral.sh/uv/
[uv-installation]: https://docs.astral.sh/uv/getting-started/installation/
[uv-installation-autocompletion]: https://docs.astral.sh/uv/getting-started/installation/#shell-autocompletion
[uv-features]: https://docs.astral.sh/uv/getting-started/features/
[uv-tools]: https://docs.astral.sh/uv/concepts/tools/
[uv-tools-bin-path]: https://docs.astral.sh/uv/concepts/tools/#tool-executables
