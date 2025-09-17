# Secrets

## Local secret management

### `KeePassXC`

#### Instalaltion

This guide recommends building [`keepassxc` from source][keepassxc-installation].

Install dependencies:

```bash
sudo apt update -y
sudo apt install -y build-essential cmake g++ asciidoctor \
    qtbase5-dev qtbase5-private-dev qttools5-dev qttools5-dev-tools \
    libqt5svg5-dev libargon2-dev libminizip-dev libbotan-2-dev libqrencode-dev \
    libkeyutils-dev zlib1g-dev libreadline-dev libpcsclite-dev libusb-1.0-0-dev \
    libxi-dev libxtst-dev  libqt5x11extras5-dev
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
  -DWITH_XC_ALL=ON \
  -DWITH_XC_YUBIKEY=ON \
  -DWITH_XC_AUTOTYPE=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DWITH_XC_BROWSER=OFF \
  -DWITH_XC_BROWSER_PASSKEYS=OFF \
  -DWITH_XC_NETWORKING=OFF \
  -DWITH_XC_SSHAGENT=OFF \
  -DWITH_XC_FDOSECRETS=OFF \
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
make
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
cat << EOF | sed 's/^[[:space:]]*//; s/[[:space:]]*$//' > ~/.local/share/applications/keepassxc.desktop
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

- [github-keepassxc][github-keepassxc]
  - [keepassxc-installation][keepassxc-installation]
  - [build-keepassxc][build-keepassxc]
  - [setup-keepassxc-build-env][setup-keepassxc-build-env]
- [keepassxc-docs][keepassxc-docs]
  - [yubikey-keepassxc][yubikey-keepassxc]

[github-keepassxc]: https://github.com/keepassxreboot/keepassxc
[keepassxc-installation]: https://github.com/keepassxreboot/keepassxc/blob/develop/INSTALL.md
[build-keepassxc]: https://github.com/keepassxreboot/keepassxc/wiki/Building-KeePassXC
[setup-keepassxc-build-env]: https://github.com/keepassxreboot/keepassxc/wiki/Set-up-Build-Environment-on-Linux
[keepassxc-docs]: https://keepassxc.org/docs/
[yubikey-keepassxc]: https://keepassxc.org/docs/#faq-yubikey-howto
