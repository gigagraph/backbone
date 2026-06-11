# `pi`

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [`node` and `bun`](../../../../system-setup/toolchains/node/README.md).
>   - Ensure to [install `bun` as well](../../../../system-setup/toolchains/node/README.md#install-bun).
>
> [You can verify the versions of the installed toolcahins with the script](../../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends installing `pi` from sources.

Clone the repo and checkout the latest stable version:

```bash
git clone git@github.com:earendil-works/pi.git
cd pi
git checkout "${PI_VERSION}"
```

Install dependencies:

```bash
npm ci --ignore-scripts
```

Build the project:

```bash
env \
  RELEASE_TAG="$(git describe --exact-match --tags)" \
  \
  ./scripts/build-binaries.sh --skip-deps --skip-install --platform "$(echo "$(uname -s)-$(uname -m | sed 's/x86_64/x64/')" | tr '[:upper:]' '[:lower:]')"
```

Install the build:

```bash
mkdir -p "${HOME}/.local/opt/pi"
cp -a "./packages/coding-agent/binaries/$(echo "$(uname -s)-$(uname -m | sed 's/x86_64/x64/')" | tr '[:upper:]' '[:lower:]')/"* "${HOME}/.local/opt/pi/"
```

### Integrate `pi` with other programs

#### zsh

> [NOTE]
>
> [`pi` does not currently support shell completions](https://github.com/earendil-works/pi/issues/4776).

## Configuration

`pi` describes configuration in the [official doc page][pi-docs-settings].

Use the config from this repository on your system by copying the config from the repo to the user config default directory (the script will prompt you for confirmation before running any configuration commands):

```bash
./setup-config.sh
```

## Useful links

- [pi]
- [gh-pi]
- [pi-docs-settings]

[pi]: https://pi.dev/
[gh-pi]: https://github.com/earendil-works/pi/
[pi-docs-settings]: https://pi.dev/docs/latest/settings
