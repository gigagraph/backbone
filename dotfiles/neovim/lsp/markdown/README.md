# Markdown

This guide recommends using [`marksman`][marksman] as an implementaion of LSP server for the [Markdown markup language][commonmark].

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [.NET](../../../../system-setup/toolchains/dotnet/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends [installing `marksman` from sources following the offical instuctions][marksman-install-from-sources].

Clone the repo and checkout the latest stable version:

```bash
git clone git@github.com:artempyanykh/marksman.git
cd marksman
git checkout "${MARKSMAN_VERSION}"
```

Build the project and install it:

```bash
make install
```

## Useful links

- [commonmark][commonmark]
- [marksman][marksman]
- [marksman-install][marksman-install]
- [marksman-install-from-sources][marksman-install-from-sources]
- [marksman-config][marksman-config]

[commonmark]: https://commonmark.org/
[marksman]: https://github.com/artempyanykh/marksman?tab=readme-ov-file
[marksman-install]: https://github.com/artempyanykh/marksman/blob/main/docs/install.md
[marksman-install-from-sources]: https://github.com/artempyanykh/marksman/blob/main/docs/install.md#option-3-build-from-source
[marksman-config]: https://github.com/artempyanykh/marksman/blob/main/docs/configuration.md
