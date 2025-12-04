# OpenAI `codex`

> [!WARNING]
>
> `codex` has been decomissioned from this setup.

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Rust](../../../../system-setup/toolchains/rust/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends installing [`codex` source][codex-build-from-source].

Clone the repo:

```bash
git clone git@github.com:openai/codex.git
cd codex
git checkout "${CODEX_VERSION}"

cd codex-rs
```

Run the following command to build release distribution and install it:

```bash
cargo install --all-features --locked --path codex-rs/cli
```

### Integrate `codex` with other programs

#### zsh

See the corresponding section in the [zsh docs file in this repo](../../zsh/README.md#codex).

## Uninstall

```bash
cargo uninstall codex-cli
```

## Configuration

This setup contains configuration for `codex`. To apply the config from this setup to your user's home directory run `./setup-config.sh` and follow instructions.

## Useful links

- [github-codex][github-codex]
- [codex-build-from-source][codex-build-from-source]
- [codex-config][codex-config]
- [anthropic-openai-sdk][anthropic-openai-sdk]

[github-codex]: https://github.com/openai/codex/tree/main?tab=readme-ov-file
[codex-build-from-source]: https://github.com/openai/codex/blob/main/docs/install.md#build-from-source
[codex-config]: https://github.com/openai/codex/blob/main/docs/config.md
[anthropic-openai-sdk]: https://docs.anthropic.com/en/api/openai-sdk
