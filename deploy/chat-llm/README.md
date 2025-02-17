# `chat-llm`

Service to chat with locally deployed LLMs.

## Deployment

### Prerequisites

- Host with Nvidia GPU.
- [Nvidia GPU drivers](../../system-setup/graphics.md#nvidia).
- [Docker Engine](../../system-setup/toolchains/docker/README.md).
  - [Nvidia Container Toolkit](../../system-setup/toolchains/docker/README.md#nvidia-contianer-toolkit)

### Deployment instructions

- [ ] TODO

```shell
env "OLLAMA_IMAGE_TAG=<ollama-image-tag>" \
  "OLLAMA_HOST_PORT=<ollama-port>" \
  docker compose up -d --build
```

## Useful links

- [ollama][ollama].
- [open-webui][open-webui].

[ollama]: ../../dotfiles/tools/ai/ollama/README.md
[open-webui]: https://github.com/open-webui/open-webui

