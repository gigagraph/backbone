# Docker

This setup recommends using the following LSP servers for Docker:
- [`docker_compose_language_service`][docker-compose-language-service].
- [`dockerls`][dockerfile-language-server].

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Node](../../../system-setup/toolchains/node/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

### [`docker_compose_language_service`][docker-compose-language-service] installation

#### `docker_compose_language_service` installation from `npm` registry

Users can install [`docker_compose_language_service` from `npm` registry][npm-docker-compose-language-service] using the following command:

```bash
npm install -g @microsoft/compose-language-service@latest
```

### [`dockerls`][dockerfile-language-server] installation

- [ ] TODO

## Useful links

- [docker-compose-language-service][docker-compose-language-service]
- [npm-docker-compose-language-service][npm-docker-compose-language-service]
- [dockerfile-language-server][dockerfile-language-server]

[docker-compose-language-service]: https://github.com/microsoft/compose-language-service
[npm-docker-compose-language-service]: https://www.npmjs.com/package/@microsoft/compose-language-service
[dockerfile-language-server]: https://github.com/rcjsuen/dockerfile-language-server
