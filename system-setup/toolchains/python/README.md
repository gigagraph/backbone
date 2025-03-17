# Python toolchain

## Installation

> [!NOTE]
>
> You need a [C/C++ toolchain](../llvm/README.md) to build Pyton.

This section describes how to install the latest stable version of [Cpython][python] interpreter systemwide on a linux distribution. On Linux, system admns should build Cpython from source. This guide will use [python 3.12, because not all packages support 3.13 for now](#minor-version-upgrade).

### Build dependencies

Ensure you have [dependencies that the build requires][cpython-build-dependencies], e.g. on Debian-based systems run the script from this repo:

```shell
sudo ./install-debian-deps.sh
```

### Build instructions

```shell
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

### Minor version upgrade

The latest python version is 3.13, although, the pacakge ecosystem does not yet provide builds for all major packages for 3.13. Use this version at your own risk.

List of common packages that have support for 3.13.

- [ ] https://pypi.org/project/tensorflow/#files
- [x] https://pypi.org/project/numpy/#files
- [x] https://pypi.org/project/numpy/#files
- [x] https://pypi.org/project/numpy/#files
- [x] https://pypi.org/project/yarl/#files
- [x] https://pypi.org/project/PyYAML/#files
- [x] https://pypi.org/project/fastapi/#files
- [x] https://pypi.org/project/pydantic/#files
- [x] https://pypi.org/project/pydantic/#files

## [`pipx`][python-key-projects-pipx]

[`pipx`][python-key-projects-pipx] is a package manager for CLI tools in python ecosystem. It helps installing Python-based CLI tools without introducing global system dependency conflicts.

### `pipx` installation

Based on the [official installation instructions][pipx-docs-installation]:

Install the package:

```shell
# Ubuntu-based systems
sudo apt update -y
sudo apt install -y pipx

# Systems that do not provide `pipx` package in their package manager's repos
python3 -m pip install --user pipx
```

Ensure [`pipx`'s target installation location][pipx-docs-installation-dirs] in on your `PATH`.

Ensure that `pipx` is initialized:

```shell
pipx ensurepath
```

#### `pipx` completions

> [!NOTE]
>
> Since there is not simple way to install completions for `pipx` that is compatible with this setup and is does not bring that much value, this guide does not recommend setting up completions for `pipx`.

Print completion installation instructions:

```shell
pipx completions
```

## Useful links

- [python][python]
- [cpython-github][cpython-github]
- [cpython-build-dependencies][cpython-build-dependencies]
- [python-key-projects-pipx][python-key-projects-pipx]
- [pipx-docs-installation][pipx-docs-installation]
- [pipx-docs-installation-dirs][pipx-docs-installation-dirs]

[python]: <https://www.python.org>
[cpython-github]: <https://github.com/python/cpython>
[cpython-build-dependencies]: <https://devguide.python.org/getting-started/setup-building/#build-dependencies>
[python-key-projects-pipx]: <https://packaging.python.org/en/latest/key_projects/#pipx>
[pipx-docs-installation]: <https://pipx.pypa.io/stable/installation/#installing-pipx>
[pipx-docs-installation-dirs]: <https://pipx.pypa.io/stable/installation/#installation-options>
