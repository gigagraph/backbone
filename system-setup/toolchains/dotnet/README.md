# .NET

## Installation

This guide considers .NET installation through .NET backports Ubuntu feed. If users want to use a different installation method, they should refer to the [official installation docs][install-dotnet-ubuntu] and the [decision guide][dotnet-ubuntu-installation-decision-guide].

Add Ubuntu .NET backports repository:

```bash
sudo add-apt-repository -y ppa:dotnet/backports
```

Install the dependencies:

```bash
sudo apt update -y
sudo apt install -y \
  ca-certificates \
  libc6 \
  libgcc-s1 \
  libicu74 \
  liblttng-ust1 \
  libssl3 \
  libstdc++6 \
  zlib1g
```

Install .NET SDK via `apt`:

```bash
sudo apt update -y
sudo apt install -y \
  dotnet-sdk-"${DOTNET_SDK_VERSION}"
```

### Completions

For more details refer to the [offical docs for .NET CLI completions][dotnet-completions].

#### `zsh` completions

Assuming that `ZSH_COMPLETIONS_DIR` env points to a path on your system that is present in `fpath`, run the following script:

```bash
cat <<EOF > "${ZSH_COMPLETIONS_DIR}/_dotnet"
#compdef dotnet

_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")

  # If the completion list is empty, just continue with filename selection
  if [ -z "$completions" ]
  then
    _arguments '*::arguments: _normal'
    return
  fi

  # This is not a variable assignment, don't remove spaces!
  _values = "${(ps:\n:)completions}"
}

compdef _dotnet_zsh_complete dotnet
EOF
```

## Useful links

- [dotnet-download][dotnet-download]
- [install-dotnet-ubuntu][install-dotnet-ubuntu]
- [dotnet-ubuntu-installation-decision-guide][dotnet-ubuntu-installation-decision-guide]
- [dotnet-cli-overview][dotnet-cli-overview]
- [dotnet-completions][dotnet-completions]

[dotnet-download]: https://dotnet.microsoft.com/en-us/download
[dotnet-install-ubuntu]: https://learn.microsoft.com/en-ca/dotnet/core/install/linux-ubuntu-install?tabs=dotnet9&pivots=os-linux-ubuntu-2410
[dotnet-ubuntu-installation-decision-guide]: https://learn.microsoft.com/en-ca/dotnet/core/install/linux-ubuntu-decision#install-uninstall-or-update-net
[dotnet-cli-overview]: https://learn.microsoft.com/en-ca/dotnet/core/tools/
[dotnet-completions]: https://learn.microsoft.com/en-ca/dotnet/core/tools/enable-tab-autocomplete
