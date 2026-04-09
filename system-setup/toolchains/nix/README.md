# `nix`

## Installation

This guide recommends installing a [prebuilt distribution of `nix`][nix-installation-from-prebuilt-binary] for a multi-user usage:

```bash
# Go to https://github.com/NixOS/nix/tags and assign the following variables
export VERSION='<nix-version>'
export SYSTEM='<nix-architecture>'

curl --output-dir "${HOME}/Downloads" -LO "https://releases.nixos.org/nix/nix-${VERSION}/nix-${VERSION}-${SYSTEM}.tar.xz"

tar -C "${HOME}/Downloads" -xJf "${HOME}/Downloads/nix-${VERSION}-${SYSTEM}.tar.xz"

cd "${HOME}/Downloads/nix-${VERSION}-${SYSTEM}"

env 'NIX_USER_COUNT=32' \
  'NIX_FIRST_BUILD_UID=30001' \
  'NIX_FIRST_BUILD_UID=30000' \
  'NIX_BUILD_USER_NAME_TEMPLATE=nixbld%d' \
  ./install --daemon --yes
```

Set `NIX_REMOTE=daemon` in your shell's rc file:

```bash
export NIX_REMOTE='daemon'
```

### Completions

#### `zsh` completions for `nix-zsh-completions`

If you use [zsh](../../../dotfiles/zsh/README.md) your should install [`nix-zsh-completions`](https://github.com/nix-community/nix-zsh-completions). See the [docs from this repo](../../../dotfiles/zsh/README.md#plugins) for more details.

### Upgrade `nix`

```bash
sudo --preserve-env=PATH -- bash -c 'nix-env --install --file "<nixpkgs>" --attr nix cacert -I nixpkgs=channel:nixpkgs-unstable'
sudo systemctl daemon-reload
sudo systemctl restart nix-daemon
```

## Configuration

Nix's main system config file resides in `${NIX_CONF_DIR:-etc}/nix/nix.conf`.

Use the config from this repository on your system by symlinking the user config default directory to the config dir in this repo (the script will prompt you for confirmation before running any configuration commands):

```bash
./setup-config.sh
```

## Useful links

- [learn-nix][learn-nix]
- [how-nix-works][how-nix-works]
- [nix-dev][nix-dev]
  - [nix-tutorials][nix-tutorials]
    - [nix-tutorial-first-steps][nix-tutorial-first-steps]
  - [nix-guides][nix-guides]
  - [nix-reference][nix-reference]
    - [nix-reference-manual][nix-reference-manual]
      - [nix-installation][nix-installation]
      - [nix-installation-from-prebuilt-binary][nix-installation-from-prebuilt-binary]
      - [nix-conf][nix-conf]
    - [nixpkgs-manual][nixpkgs-manual]
    - [nixos-manual][nixos-manual]
  - [nix-concepts][nix-concepts]
- [nix-pills][nix-pills]
- [nixos-wiki][nixos-wiki]

[learn-nix]: https://nixos.org/learn/
[how-nix-works]: https://nixos.org/guides/how-nix-works/
[nix-dev]: https://nix.dev/
[nix-tutorials]: https://nix.dev/tutorials/
[nix-tutorial-first-steps]: https://nix.dev/tutorials/first-steps/
[nix-guides]: https://nix.dev/guides/
[nix-reference]: https://nix.dev/reference/
[nix-reference-manual]: https://nix.dev/manual/nix/latest/
[nix-installation]: https://nix.dev/manual/nix/latest/installation/index.html
[nix-installation-from-prebuilt-binary]: https://nix.dev/manual/nix/latest/installation/installing-binary.html
[nix-conf]: https://nix.dev/manual/nix/2.24/command-ref/conf-file.html
[nixpkgs-manual]: https://nixos.org/manual/nixpkgs/stable/
[nixos-manual]: https://nixos.org/manual/nixos/stable/
[nix-concepts]: https://nix.dev/concepts/
[nix-pills]: https://nixos.org/guides/nix-pills/
[nixos-wiki]: https://wiki.nixos.org/wiki/NixOS_Wiki
