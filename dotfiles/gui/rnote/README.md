# Rnote

## Installation

> [!NOTE]
>
> To install some of the software listed here, users may require the following language toolhcains:
> - [C/C++](../../../system-setup/toolchains/llvm/README.md).
> - [Python](../../../system-setup/toolchains/python/README.md).
> - [Rust](../../../system-setup/toolchains/rust/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends [building Rnote from sources using Meson][rnote-linux-build-instructions].

Install the dependencies:

```bash
sudo apt update -y
sudo apt install -y \
  build-essential \
  make \
  cmake \
  meson \
  appstream \
  gettext \
  desktop-file-utils \
  shared-mime-info \
  libgtk-4-dev \
  libadwaita-1-dev \
  libpoppler-glib-dev \
  libasound2-dev \
  libappstream-dev
```

Clone the repo:

```bash
git clone git@github.com:flxzt/rnote.git
cd rnote
git checkout "${RNOTE_VERSION}"
```

Initialize the build directory:

```bash
meson setup --prefix=/usr _mesonbuild
```

Configure the build options:

```bash
meson configure \
  -Dprofile=default \
  -Dcli=true \
  _mesonbuild
```

Compile the project:

```bash
meson compile -C _mesonbuild
```

Test the build:

```bash
meson test -v -C _mesonbuild
```

Install the build:

```bash
meson install -C _mesonbuild
```

## Useful link

- [rnote-github][rnote-github]
  - [rnote-linux-build-instructions][rnote-linux-build-instructions]
- [rnote-website][rnote-website]

[rnote-github]: <https://github.com/flxzt/rnote>
[rnote-linux-build-instructions]: <https://github.com/flxzt/rnote/blob/main/BUILDING.md>
[rnote-website]: <https://rnote.flxzt.net/>

