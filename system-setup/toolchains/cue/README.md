# Cue

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Go](../go/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../README.md#verify-versions-of-the-installed-toolchains).

This guide recommends installing `cue` from sources using `go install`:

Go to https://pkg.go.dev/cuelang.org/go/cmd/cue and find the latest version (`CUE_VERSION`).

Install `cue` using `go install`:

```bash
go install "cuelang.org/go/cmd/cue@v${CUE_VERSION}"
```

### Completions

#### `zsh` completions

Assuming that `ZSH_COMPLETIONS_DIR` env points to a path on your system that is present in `fpath`, run the following script:

```bash
cue completion "${SHELL##*/}" > "${ZSH_COMPLETIONS_DIR}/_cue"
```

## Useful links

[cue]: https://cuelang.org/
[github-cue]: https://github.com/cue-lang/cue
