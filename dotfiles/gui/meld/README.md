# Meld

## Installation

> [!NOTE]
>
> To install some of the software listed here, users may require the following language toolhcains:
> - [Python](../../../system-setup/toolchains/python/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends [building Meld from sources using Meson][build-meld-from-sources].

Install the dependencies:

```bash
sudo apt update -y
sudo apt install -y \
  build-essential \
  meson \
  ninja-build \
  gettext \
  libglib2.0-0 \
  libglib2.0-bin \
  libglib2.0-data \
  libglib2.0-dev \
  libglib2.0-doc \
  gsettings-desktop-schemas \
  gsettings-desktop-schemas-dev \
  libpango-1.0-0 \
  libpango1.0-dev \
  libpango1.0-doc \
  libcairo2-dev \
  python3-cairo-dev \
  python3-cairo-doc \
  pkg-config \
  python-gi-dev \
  python3-gi \
  python3-gi-cairo \
  gir1.2-gtk-4.0 \
  libgtk-3-0 \
  libgtk-3-common \
  libgtk-3-dev \
  libgtk-3-doc \
  libgtksourceview-4-0 \
  libgtksourceview-4-common \
  libgtksourceview-4-dev \
  libgtksourceview-4-doc \
  itstool \
  appstream-util
```

Clone the repo:

```bash
git clone https://gitlab.gnome.org/GNOME/meld.git
cd meld
git checkout "${MELD_VERSION}"
```

Initialize the build:

```bash
echo "[binaries]\npython = '/usr/bin/python3'" > ./native.ini
meson setup \
  --python.install-env=system \
  --wipe \
  --native-file ./native.ini \
  _build
cd _build
```

Build meld:

```bash
ninja
```

Install meld:

```bash
ninja install
```

### Integrate meld with other programs

#### [`jj`](../../tools/jj/README.md)

`jj` supports meld for editing diffs and resolving conflicts. [See the corresponding section in the `jj` doc in this repo to configure `jj` to use meld as a diff and conflict editor](../../tools/jj/README.md#meld).

## Useful link

- [gitlab-meld][gitlab-meld]
- [build-meld-from-sources][build-meld-from-sources]

[gitlab-meld]: https://gitlab.gnome.org/GNOME/meld
[build-meld-from-sources]: https://gitlab.gnome.org/GNOME/meld#building
# Meld

## Installation

> [!NOTE]
>
> To install some of the software listed here, users may require the following language toolhcains:
> - [Python](../../../system-setup/toolchains/python/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends [building Meld from sources using Meson][build-meld-from-sources].

Install the dependencies:

```bash
sudo apt update -y
sudo apt install -y \
  build-essential \
  meson \
  ninja-build \
  gettext \
  libglib2.0-0 \
  libglib2.0-bin \
  libglib2.0-data \
  libglib2.0-dev \
  libglib2.0-doc \
  gsettings-desktop-schemas \
  gsettings-desktop-schemas-dev \
  libpango-1.0-0 \
  libpango1.0-dev \
  libpango1.0-doc \
  libcairo2-dev \
  python3-cairo-dev \
  python3-cairo-doc \
  pkg-config \
  python-gi-dev \
  python3-gi \
  python3-gi-cairo \
  gir1.2-gtk-4.0 \
  libgtk-3-0 \
  libgtk-3-common \
  libgtk-3-dev \
  libgtk-3-doc \
  libgtksourceview-4-0 \
  libgtksourceview-4-common \
  libgtksourceview-4-dev \
  libgtksourceview-4-doc \
  itstool \
  appstream-util
```

Clone the repo:

```bash
git clone https://gitlab.gnome.org/GNOME/meld.git
cd meld
git checkout "${MELD_VERSION}"
```

Initialize the build:

```bash
echo "[binaries]\npython = '/usr/bin/python3'" > ./native.ini
meson setup \
  --python.install-env=system \
  --wipe \
  --native-file ./native.ini \
  _build
cd _build
```

Build meld:

```bash
ninja
```

Install meld:

```bash
ninja install
```

## Useful link

- [gitlab-meld][gitlab-meld]
- [build-meld-from-sources][build-meld-from-sources]

[gitlab-meld]: https://gitlab.gnome.org/GNOME/meld
[build-meld-from-sources]: https://gitlab.gnome.org/GNOME/meld#building
