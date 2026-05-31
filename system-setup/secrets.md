# Secrets

## Local secret management

### `KeePassXC`

#### Instalaltion

##### Build from sources locally

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [C/C++](./system-setup/toolchains/llvm/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends building [`keepassxc` from source][keepassxc-installation].

Install dependencies:

```bash
sudo apt update -y
sudo apt install -y \
  build-essential cmake g++ asciidoctor \
  \
  qtbase5-private-dev \
  \
  qt6-base-dev qt6-svg-dev qt6-tools-dev libusb-1.0-0-dev \
  libbotan-3-dev zlib1g-dev libminizip-dev libpcsclite-dev libkeyutils-dev \
  libxi-dev libxtst-dev libqrencode-dev
```

Clone the repo:

```bash
git clone git@github.com:keepassxreboot/keepassxc.git
cd keepassxc
git checkout "${KEEPASSXC_VERSION}"
```

Create the build directory:

```bash
mkdir build
cd build
```

Build `keepassxc`:

```bash
export CC="$(which clang)"
export CFLAGS="--start-no-unused-arguments -fuse-ld=lld --end-no-unused-arguments"
export CXX="$(which clang++)"
export CXXFLAGS="--start-no-unused-arguments -fuse-ld=lld --end-no-unused-arguments"

cmake \
  -DWITH_XC_ALL=OFF \
  -DWITH_XC_YUBIKEY=ON \
  -DWITH_XC_AUTOTYPE=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DWITH_XC_BROWSER=ON \
  -DWITH_XC_BROWSER_PASSKEYS=ON \
  -DWITH_XC_NETWORKING=OFF \
  -DWITH_XC_SSHAGENT=OFF \
  -DWITH_XC_FDOSECRETS=ON \
  -DWITH_XC_KEESHARE=OFF \
  \
  -DWITH_XC_UPDATECHECK=OFF \
  \
  -DWITH_TESTS=ON \
  -DWITH_GUI_TESTS=OFF \
  -DWITH_DEV_BUILD=OFF \
  -DWITH_ASAN=OFF \
  -DWITH_COVERAGE=OFF \
  -DWITH_APP_BUNDLE=OFF \
  \
  -DKEEPASSXC_BUILD_TYPE=Release \
  -DKEEPASSXC_DIST_TYPE=Other \
  ..
make -j8
```

Test the build:

```bash
make test ARGS+="--output-on-failure"
```

Install the build:

```bash
sudo make install
```

Create a desktop entry:

```bash
cat << EOF | sed 's/^[[:space:]]*//; s/[[:space:]]*$//' > "${XDG_DATA_HOME:-${HOME}/.local/share/applications/keepassxc.desktop}"
[Desktop Entry]
Name=KeePassXC
GenericName=KeePassXC
Exec=/usr/local/bin/keepassxc %u
Terminal=false
Icon=/usr/local/share/keepassxc/icons/application/256x256/apps/keepassxc.png
Type=Application
Categories=Application;X-Developer;
Comment=Keychain and password manager
StartupWMClass=KeePassXC
EOF
```

Give the desktop entry file execute permissions:
```bash
chmod +x ~/.local/share/applications/keepassxc.desktop
```

#### `keepassxc` Yubikey integration

If you use [Yubikey](./authentication.md) that has at least one of the slots configured to use OTP, pass the `--yubikey` CLI option with the slot number and the Yubikey ID (`ykman info | grep 'Serial number:' | awk '{ print $3 }'`) when creating the database or register it in the UI when creating or ediditg a database.

#### Usage

##### Obtain the secret value from the database

```bash
keepassxc-cli show -y "<otp-slot-num>:$(ykman info | grep 'Serial number:' | awk '{ print $3 }')" --no-password "<path-to-the-db>" --attributes "Password" --show-protected "<db-entry-name>"
```

##### Creating new secrets

```bash
keepassxc-cli add -y "<otp-slot-num>:$(ykman info | grep 'Serial number:' | awk '{ print $3 }')" --no-password "<path-to-the-db>" --password-prompt --username="<username>" "<db-entry-name>"
```

##### Updating existing secrets

```bash
keepassxc-cli edit -y "<otp-slot-num>:$(ykman info | grep 'Serial number:' | awk '{ print $3 }')" --no-password "<path-to-the-db>" --password-prompt --username="<username>" "<db-entry-name>"
```

##### Removing the secrets

```bash
keepassxc-cli rm -y "<otp-slot-num>:$(ykman info | grep 'Serial number:' | awk '{ print $3 }')" --no-password "<path-to-the-db>" "<db-entry-name>"
```

## Useful links

- [github-keepassxc]
  - [keepassxc-installation]
  - [build-keepassxc]
  - [build-keepassxc-in-container]
  - [setup-keepassxc-build-env]
- [keepassxc-docs]
  - [yubikey-keepassxc]

[github-keepassxc]: https://github.com/keepassxreboot/keepassxc
[keepassxc-installation]: https://github.com/keepassxreboot/keepassxc/blob/develop/INSTALL.md
[build-keepassxc]: https://github.com/keepassxreboot/keepassxc/wiki/Building-KeePassXC
[build-keepassxc-in-container]: https://github.com/keepassxreboot/keepassxc/wiki/Building-KeePassXC#building-inside-a-docker-container
[setup-keepassxc-build-env]: https://github.com/keepassxreboot/keepassxc/wiki/Set-up-Build-Environment-on-Linux
[keepassxc-docs]: https://keepassxc.org/docs/
[yubikey-keepassxc]: https://keepassxc.org/docs/#faq-yubikey-howto
