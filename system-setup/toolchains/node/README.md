# `node`

## Installation

This guide recommends installing `node` through `nvm`.

### Install `nvm`

This guide recommends [installing `nvm` manually][nvm-install-manually]:

```shell
export NVM_DIR="$HOME/.nvm"
git clone git@github.com:nvm-sh/nvm.git "${NVM_DIR}"
cd "${NVM_DIR}"
git checkout "$(git describe --abbrev=0 --tags --match "v[0-9]*" "$(git rev-list --tags --max-count=1)")"
source "${NVM_DIR}/nvm.sh"
```

Add the following to your shell's profile file:

```shell
export NVM_DIR="${HOME}/.nvm"
[ -s "${NVM_DIR}/nvm.sh" ] && source "${NVM_DIR}/nvm.sh"
```

> [!NOTE]
>
> This guide recommends to refrain from installing completions for zsh becuase `nvm` has poor native support for zsh completions (there is a high chance that setting up these completions will significantly impact shell startup time). Instead, users should discover subcommands and flags with `--help`.


> [!NOTE]
>
> This guide does not recommend using zsh plugins for nvm to not leak the "toolchain" abstraction into the shell environment. Additionally, it has unpredictable consequences for shell startup times and perofrmance. Instead, it recommends manually checking the current npm version and run `nvm use` when needed.

#### Updating `nvm`

```shell
cd "${NVM_DIR}"
git fetch --tags origin
git checkout "$(git describe --abbrev=0 --tags --match "v[0-9]*" "$(git rev-list --tags --max-count=1)")"
source "${NVM_DIR}/nvm.sh"
```

### Install `node` via `nvm`

List LTS versions of `node`:

```shell
nvm ls-remote
```

Select the desired version from the output of the previous command (or run the following command to select the latest LTS version):

```shell
NODE_VERSION_TO_INSTALL="$(nvm ls-remote --lts --no-colors | tail -n 1 | awk '{ print $1 }')"
```

Install `node`:

```shell
nvm install "${NODE_VERSION_TO_INSTALL}"
```

Optionally, use the following command to install the latest `npm`:

```shell
nvm install-latest-npm
```

> [!NOTE]
>
> `nvm` sets the `prefix` conf for the `npm` that it manages. This means that [`nvm` users must not set `prefix` config/cli flag or `${NPM_CONFIG_PREFIX}` env][nvm-compatibility-issues]. When users install npm packages gloabally with `npm install -g`, by default, `npm` that `nvm` manages will install them to `${NVM_BIN}` directory (which is ususally a subdirectory under `${NVM_DIR}`).
>
> This means that every time users change node verisons, they would need to install global npm pacakges again, [unless they add packages to `${NVM_DIR}/default-packages`][nvm-default-global-packages].


#### Setup `${NVM_DIR}/default-packages`

Use the `nvm-default-packages` from this repository on your system by symlinking `${NVM_DIR}/default-packages` to the config dir in this repo (the script will prompt you for confirmation before running any configuration commands and will print the difference between the current file and config in this repo):

```shell
./setup-config.sh
```

### Install `pnpm`

This guide recommends installing `pnpm` globally [as well as making it a global default package](#setup-nvm_dir-default-packages).

Run the following command to ensure `pnpm` is installed for the current `node` installation:

```shell
npm install -g pnpm@latest
```

## Usage

List installed verions:

```shell
nvm list
```

Add a specific installed `<version>` of `node` to `${PATH}` (ommit `<version>` if the current directory contains `.nvmrc` that specifies `node` version to use):

```shell
nvm use <version>
```

Display the currently selected `node` version via `nvm`:

```shell
nvm current
```

> [!NOTE]
>
> The source of truth for the shell is the `node` command itself, so trust the output of `node --version`. Additionally, run `which node` to check what executalbe would the shell run for the `node` command.

Uninstall a specific `<version>` of `node`:

```shell
nvm uninstall <version>
```

Always default to the latest available node version on a shell (change `node` to an arbitrary version to make it default):

```shell
nvm alias default node
```

## Useful links

- [nodejs-website][nodejs-website].
- [nodejs-github][nodejs-github].
- [github-nvm][github-nvm].
  - [nvm-install-manually][nvm-install-manually].
  - [nvm-compatibility-issues][nvm-compatibility-issues].
  - [nvm-default-global-packages][nvm-default-global-packages].
- [npm-docs][npm-docs].
  - [npm-docs-npmrc][npm-docs-npmrc].
  - [npm-docs-config][npm-docs-config].
  - [npm-docs-folders][npm-docs-folders].
- [pnpm-install][pnpm-install].

[nodejs-website]: <https://nodejs.org>
[github-nodejs]: <https://github.com/nodejs/node>
[github-nvm]: <https://github.com/nvm-sh/nvm>
[nvm-install-manually]: <https://github.com/nvm-sh/nvm?tab=readme-ov-file#manual-install>
[nvm-compatibility-issues]: <https://github.com/nvm-sh/nvm?tab=readme-ov-file#compatibility-issues>
[nvm-default-global-packages]: <https://github.com/nvm-sh/nvm?tab=readme-ov-file#default-global-packages-from-file-while-installing>
[npm-docs]: <https://docs.npmjs.com/>
[npm-docs-npmrc]: <https://docs.npmjs.com/cli/v11/configuring-npm/npmrc>
[npm-docs-config]: <https://docs.npmjs.com/cli/v11/using-npm/config>
[npm-docs-folders]: <https://docs.npmjs.com/cli/v11/configuring-npm/folders>
[pnpm-install]: <https://pnpm.io/installation>
