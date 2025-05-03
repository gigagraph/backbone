# Perl

## Installation

> [!NOTE]
>
> You need a [C/C++ toolchain](../llvm/README.md) to build and install Perl from sources.

Clone the perl repo:

```bash
git clone git@github.com:Perl/perl5.git perl
cd ./perl
git checkout "${PERL_EVEN_VERSION_TAG}"
```

Configure the build:

```bash
./Configure \
  -Dcc="$(which clang)" \
  -Doptimize="-O2 -pipe -fstack-protector -fno-strict-aliasing" \
  -Dusethreads \
  -Duselongdouble \
  -Duse64bitall \
  -Duselargefiles \
  -de
```

Run the build, test it, and install:

```bash
make
make test
sudo make install
```

> [!NOTE]
>
> In case you need to reconfigure the build or rebuild the project, clean it with `make distclean`.

## Useful links

- [perl-docs][perl-docs]
  - [perl-docs-tutorials][perl-docs-tutorials]
- [perl-installation][perl-installation]
- [perl-github][perl-github]

[perl-docs]: <https://perldoc.perl.org/>
[perl-docs-tutorials]: <https://perldoc.perl.org/perl#Tutorials>
[perl-github]: <https://github.com/Perl/perl5>
[perl-installation]: <https://github.com/Perl/perl5>

