# `chat-llm`

Service to chat with locally deployed LLMs.

## Deployment

### Prerequisites

- Host with Nvidia GPU.
- [Nvidia GPU drivers](../../system-setup/graphics.md#nvidia).
- [Docker Engine](../../system-setup/toolchains/docker/README.md).
  - [Nvidia Container Toolkit](../../system-setup/toolchains/docker/README.md#nvidia-contianer-toolkit)

### Deployment instructions

> [!NOTE]
>
> The `compose.yaml` deployment assumes users set `OPEN_WEBUI_IMAGE_TAG` to the one that ends with `cuda`.

Run the following command:

```bash
env "OLLAMA_IMAGE_TAG=<ollama-image-tag>" \
  "OLLAMA_HOST_PORT=<ollama-port>" \
  "OPEN_WEBUI_HOST_PORT=<open-webui-port>" \
  "OPEN_WEBUI_IMAGE_TAG=<open-webui-tag>" \
  docker compose up -d --build
```

## Useful links

- [ollama][ollama].
- [open-webui][open-webui].
  - [open-webui-docs][open-webui-docs].
  - [open-webui-envs][open-webui-envs].

[ollama]: ../../dotfiles/tools/ai/ollama/README.md
[open-webui]: https://github.com/open-webui/open-webui
[open-webui-docs]: https://docs.openwebui.com/
[open-webui-envs]: https://docs.openwebui.com/getting-started/env-configuration
