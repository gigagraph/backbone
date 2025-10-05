# `grpcurl`

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Go](../../../../system-setup/toolchains/go/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends installing [`grpcurl` from sources][grpcurl-install-from-source].

Clone the repo and checkout the latest stable version:

```bash
git clone git@github.com:fullstorydev/grpcurl.git
cd grpcurl
git checkout "${GRPCURL_VERSION}"
```

Build and install the project:

```bash
make install
```

## Useful links

- [grpcurl-github][grpcurl-github]
- [grpcurl-install-from-source][grpcurl-install-from-source]

[grpcurl-github]: https://github.com/fullstorydev/grpcurl
[grpcurl-install-from-source]: https://github.com/fullstorydev/grpcurl?tab=readme-ov-file#from-source
