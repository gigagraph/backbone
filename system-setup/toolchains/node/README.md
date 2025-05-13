# `node`

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Rust](../rust/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).
>
> Additionally, ensure you have the following tools installed that this setup requires to initialize `fnm`:
> - [`yq`](../../../dotfiles/terminal-utils/yq/README.md).

> [!NOTE]
>
> This guide does not recommend using [`nvm`][github-nvm] to manage `node` installation due to the [performance issues with shell startup times][nvm-performance-issues].

This guide recommends installing `node` through `fnm`.

### [`fnm`][github-fnm] installation

This guide recommends building and installing `fnm` from sources with `cargo`:

```bash
git clone git@github.com:Schniz/fnm.git
cd fnm
git checkout "${FNM_VERSION}"
```

Run the following command to build release distribution and install it:

```bash
cargo install --all-features --locked --path .
```

Add the following to your shell's rc file. For security purposes, the command will parse the envs that need to be initialized and initialize them manually, instead of evaluating the output of `fnm env` directly (the guide recommends adding this snippet after all plugins initializations to ensure faster prompt initialization):

```bash
eval \
  "$(fnm env --version-file-strategy=recursive --json |
  yq --input-format='json' --output-format props |
  awk -F ' = ' $'{ printf "%s=\'%s\'\\n", $1, $2 }' |
  xargs -I '{}' env - {} |
  sed -e 's/^/export /' -)"

[[ -n "${FNM_MULTISHELL_PATH}" ]] && path+=("${FNM_MULTISHELL_PATH}/bin")
export PATH
```

### Install `node` via `fnm`

See the `fnm --help` or the [official docs][fnm-usage] for the list of `fnm` commands.

List LTS versions of `node`:

```bash
fnm ls-remote --lts --sort=asc
```

Select the desired version from the output of the previous command (or run the following command to select the latest LTS version):

```bash
NODE_VERSION_TO_INSTALL="$(fnm ls-remote --lts --sort=asc | tail -n 1 | awk '{ print $1 }')"
```

Install `node`:

```bash
fnm install "${NODE_VERSION_TO_INSTALL}"
```

Alternatively, use the following command to install the latest stable `node`:

```bash
fnm install --lts
```

List current node version:

```bash
fnm current
```

Use a specific node version

```bash
fnm use "${NODE_VERSION_TO_INSTALL}"
```

#### Completions

##### `zsh` completions for `node`

If you use [zsh](../../../dotfiles/zsh/README.md) your should install `zsh-completions`. See the [docs from this repo](../../../dotfiles/zsh/README.md#plugins) for more details.

##### `zsh` completions for `npm`

If you use [zsh](../../../dotfiles/zsh/README.md), it should come with the [default comptions script for `npm`](https://github.com/zsh-users/zsh/blob/master/Completion/Unix/Command/_npm).

### Integrate `fnm` with other programs

#### zsh

See the corresponding section in the [zsh docs file in this repo](../../zsh/README.md#fnm).

### Install global tools via `fnm`

> [!NOTE]
>
> When `npm install -g` using `npm` that `fnm` manages, `npm` will install packages globally per `node` installation. Therefore, users may need to reinstall global packages when they update `node` via `fnm`.

#### Install `pnpm`

This guide recommends installing `pnpm` globally.

Run the following command to ensure `pnpm` is installed for the current `node` installation:

```bash
npm install -g pnpm@latest
```

##### `pnpm` completions

###### `zsh` completions for `pnpm`

Assuming that `ZSH_COMPLETIONS_DIR` env points to a path on your system that is present in `fpath`, run the following script:

```bash
pnpm completion "${SHELL##*/}" > "${ZSH_COMPLETIONS_DIR}/_pnpm"
```

#### Install all global tools that this setup depends on

Since (`fnm` does not support reinstallation of global packages](https://github.com/Schniz/fnm/issues/620), users can rely on this method to manage global package installation manually.

> [!WARNING]
>
> This method will reinstall packages from the `npm` registry. I.e. if users globally installed packages from sources that have not been published to the `npm` registry, users will need to reinstall them manually.
>
> This might also be a potential security vulnerability if one of the packages gets compomized in the remote `npm` registry.

Save the installed node packages into [`./global-packages.json`](./global-packages.json) in this directory:

```bash
fnm exec --using="${OLD_NODE_VERSION}" npm list -g --depth=0 --json |
  yq --output-format json '[.dependencies | to_entries[] | {"package": .key}]' > \
    "${BACKBONE_BASE_DIR}/system-setup/toolchains/node/global-packages.json"
```

Switch to the target `fnm` version where you want to install the dependencies:

```bash
fnm use "${TARGET_NODE_VERSION}"
```

Install the packages for the target `node` installation:

```bash
yq --output-format yaml '.[].package' "${BACKBONE_BASE_DIR}/system-setup/toolchains/node/global-packages.json" |
  sed 's/$/@latest/' |
  xargs npm install -g
```

If you are upgrading to a new `node` version set the new version to be the default (`fnm defualt "${TARGET_NODE_VERSION}"`) and uninstall the old version (`fnm uninstall "${OLD_NODE_VERSION}"`).

"Oneliner" that installs packages from a different `fnm` `node` installation into the target:

```bash
fnm exec --using="${OLD_NODE_VERSION}" npm list -g --depth=0 --json |
  yq --output-format json '[.dependencies | to_entries[] | {"package": .key}]' |
  yq --output-format yaml '.[].package' |
  sed 's/$/@latest/' |
  xargs fnm exec --using="${TARGET_NODE_VERSION}" npm install -g
```

## Useful links

- [nodejs-website][nodejs-website].
- [github-nodejs][github-nodejs].
- [github-fnm][github-fnm].
  - [fnm-installation][fnm-installation].
  - [fnm-usage][fnm-usage].
- [npm-docs][npm-docs].
  - [npm-docs-npmrc][npm-docs-npmrc].
  - [npm-docs-config][npm-docs-config].
  - [npm-docs-folders][npm-docs-folders].
- [pnpm-install][pnpm-install].
- [github-nvm][github-nvm].
  - [nvm-performance-issues][nvm-performance-issues].

[nodejs-website]: <https://nodejs.org>
[github-nodejs]: <https://github.com/nodejs/node>
[github-fnm]: <https://github.com/Schniz/fnm>
[fnm-installation]: <https://github.com/Schniz/fnm>
[fnm-usage]: <https://github.com/Schniz/fnm/blob/master/docs/commands.md>
[npm-docs]: <https://docs.npmjs.com/>
[npm-docs-npmrc]: <https://docs.npmjs.com/cli/v11/configuring-npm/npmrc>
[npm-docs-config]: <https://docs.npmjs.com/cli/v11/using-npm/config>
[npm-docs-folders]: <https://docs.npmjs.com/cli/v11/configuring-npm/folders>
[pnpm-install]: <https://pnpm.io/installation>
[github-nvm]: <https://github.com/nvm-sh/nvm>
[nvm-performance-issues]: <https://github.com/nvm-sh/nvm/issues/730#issuecomment-226949107>
