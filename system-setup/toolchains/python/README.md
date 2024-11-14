# Python toolchain

## Installation

> [!NOTE]
>
> You need a [C/C++ toolchain](./llvm/README) to build Pyton.

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
git checkout v3.12.7
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

## Useful links

- [python][python]
- [cpython-github][cpython-github]
- [cpython-build-dependencies][cpython-build-dependencies]

[python]: <https://www.python.org>
[cpython-github]: <https://github.com/python/cpython>
[cpython-build-dependencies]: <https://devguide.python.org/getting-started/setup-building/#build-dependencies>
