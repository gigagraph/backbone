# `opencode`

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [`node` and `bun`](../../../../system-setup/toolchains/node/README.md).
>   - Ensure to [install `bun` as well](../../../../system-setup/toolchains/node/README.md#install-bun).
>
> [You can verify the versions of the installed toolcahins with the script](../../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends installing `opencode` from sources. The [instructions are partially documented in the contributions doc][opencode-build].

Clone the repo and checkout the latest stable version:

```bash
git clone git@github.com:anomalyco/opencode.git
cd opencode
git checkout "${OPENCODE_VERSION}"
```

Install dependencies:

```bash
bun install
```

Build the project:

```bash
env \
  OPENCODE_VERSION="$(git describe --exact-match --tags)" \
  \
  ./packages/opencode/script/build.ts --single
```

Install the built binary:

```bash
sudo install -C -D "./packages/opencode/dist/opencode-$(echo "$(uname -s)-$(uname -m | sed 's/x86_64/x64/')" | tr '[:upper:]' '[:lower:]')/bin/opencode" /usr/local/bin/opencode
```

### Integrate `opencode` with other programs

#### zsh

See the corresponding section in the [zsh docs file in this repo](../../../zsh/README.md#opencode) to install `zsh` completions.

## Configuration

`opencode` describes configuration in the [official doc page][opencode-config].

Use the config from this repository on your system by creating symlinking the user config default directory to the config dir in this repo (the script will prompt you for confirmation before running any configuration commands):

```bash
./setup-config.sh
```

## Useful links

- [opencode]
- [gh-opencode]
- [opencode-build]
- [opencode-config]

[opencode]: https://opencode.ai
[gh-opencode]: https://github.com/anomalyco/opencode
[opencode-build]: https://github.com/anomalyco/opencode/blob/dev/CONTRIBUTING.md#building-a-localcode
[opencode-config]: https://opencode.ai/docs/config/
