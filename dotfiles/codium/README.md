# VSCodium

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Docker](../../system-setup/toolchains/docker/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

> [!NOTE]
>
> Additionally, ensure that you have [Nerd Fonts](../../system-setup/fonts.md#nerd-fonts) installed and cloned on your system.

This guide recommends [building VSCodium from sources][gh-codium-how-to-build] into a snap.

Run the build in container.

> [!NOTE]
>
> Retrieve the latest version from [here][vscode-latest-version] or from [tags on GitHub][gh-vscode].

This command will run the the VSCodium build in container and output build artifacts in `./build/workdir/vscodium/assets/VSCodium-*.tar.gz`:

```bash
env \
  "DEFAULT_UID=$(id -u)" \
  "DEFAULT_GID=$(id -g)" \
  "VSCODIUM_RELEASE_VERSION=<vscodium-version>" \
    docker compose -f "build/compose.yaml" up -d --build
```

Create a group that will own the installation and add the current user to the group:

```bash
CODIUM_GROUP="codium"
sudo groupadd "${CODIUM_GROUP}"
sudo usermod -aG "${CODIUM_GROUP}" "${USER}"
newgrp "${CODIUM_GROUP}"
# If the last command does not work install shadow-utils or relogin to the account

# After this, the current user must be have the firefox group
groups "${USER}"
```

Install the build & update `chrome-sandbox` permissions and ownership:

```bash
CODIUM_INSTALL_BASE_DIR="/opt/codium"

# Unpack the installation
sudo mkdir -p "${CODIUM_INSTALL_BASE_DIR}"
sudo tar xvf build/workdir/vscodium/assets/VSCodium*.tar.gz -C "${CODIUM_INSTALL_BASE_DIR}"

## Upnack vscodium-cli
CODIUM_CLI_TMP_DIR="$(mktemp -d)"
sudo tar xvf build/workdir/vscodium/assets/vscodium-cli*.tar.gz -C "${CODIUM_CLI_TMP_DIR}"
sudo mv "${CODIUM_CLI_TMP_DIR}/codium" "${CODIUM_INSTALL_BASE_DIR}/bin/codium-cli"
rm -rf "${CODIUM_CLI_TMP_DIR}"

# Set permissions
sudo chown -R ":${CODIUM_GROUP}" "${CODIUM_INSTALL_BASE_DIR}"/*
sudo chown root:root "${CODIUM_INSTALL_BASE_DIR}/chrome-sandbox"
sudo chmod u=rwx,g=rx,o=rx,u+s "${CODIUM_INSTALL_BASE_DIR}/chrome-sandbox"
```

Add `/opt/codium` to your `PATH`.

Create a desktop entry:

```bash
codium_desktop_entry_content="[Desktop Entry]
Name=Codium
GenericName=Codium
Exec=/opt/codium/codium %u
Terminal=false
Icon=/opt/codium/resources/app/resources/linux/code.png
Type=Application
Categories=Application;X-Developer;
Comment=VSCodium Text Editor.
StartupWMClass=VSCodium
"

echo "${codium_desktop_entry_content}" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//' > "${XDG_DATA_HOME:-${HOME}/.local/share}/applications/codium.desktop"
```

Give the desktop entry file execute permissions:

```bash
chmod +x "${XDG_DATA_HOME:-${HOME}/.local/share}/applications/codium.desktop"
```

## Configuration

Use the config from this repository on your system by symlinking the user config default directory to the config dir in this repo (the script will prompt you for confirmation before running any configuration commands):

```bash
./setup-config.sh
```

### Manage extensions

Install codium extensions managed in this repo:

```bash
./install-exts.sh
```

When a new extension is installed interatively, update the extension index in this repo to restore the setup later:

```bash
./export-exts.sh
```

## Useful links

- [codium]
- [gh-codium]
- [gh-codium-how-to-build]
- [gh-vscode]
- [vscode-latest-version]

[codium]: https://vscodium.com/
[gh-codium]: https://github.com/VSCodium/vscodium
[gh-codium-how-to-build]: https://github.com/VSCodium/vscodium/blob/master/docs/howto-build.md
[gh-vscode]: https://github.com/microsoft/vscode
[vscode-latest-version]: https://update.code.visualstudio.com/api/update/darwin/stable/0000000000000000000000000000000000000000
