# Nix

This guide recommends using [`nixd`][nixd] as an implementaion of LSP server for the [nix](../../../system-setup/toolchains/nix/README.md) configuration language.

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [nix](../../../system-setup/toolchains/nix/README.md) with `flakes` enabled.
>
> [You can verify the versions of the installed toolcahins with the script](../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends installing `nixd` as a flake:

```bash
nix profile add github:nixos/nixpkgs#nixd
```

This setup also recommends using `nixd` together with `nixfmt` code formatter. Therefore, users should also install `nixfmt` as a flake as well:

```bash
nix profile add github:nixos/nixpkgs#nixfmt
```

## Useful links

- [nixd][nixd]

[nixd]: https://github.com/nix-community/nixd
