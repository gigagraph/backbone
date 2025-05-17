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

## Image generation

[Open WebUI][open-webui] can [connect to ComfyUI to generate images][open-webui-image-generation-config]. Ensure that you set the following envs for Open WebUI:

- `IMAGE_GENERATION_ENGINE="comfyui"`.
- `ENABLE_IMAGE_GENERATION="True"`.
- `ENABLE_IMAGE_PROMPT_GENERATION="True"`.
- (Optional) `IMAGE_PROMPT_GENERATION_PROMPT_TEMPLATE`.
- `IMAGE_SIZE=512x512`.
- `IMAGE_STEPS=50`.
- `IMAGE_GENERATION_MODEL=<model-name>` - users must choose the image generation model that they want to use for image generation.
- `COMFYUI_BASE_URL=<comfyui-url>` - url which Open WebUI will use to access ComfyUI.
- `COMFYUI_API_KEY=<comfyui-api-key>` - ComfyUI API key.
- (Optional) `COMFYUI_WORKFLOW` - ComfyUI workflow file contents to use.

> [!NOTE]
>
> This repo configures Open WebUI deployment to work with the [ComfyUI deployment](../stable-diffusion/README.md) from this repo. See the [parent readme](../README.md#deploy-all-services).

## Useful links

- [ollama][ollama]
- [open-webui][open-webui]
  - [open-webui-docs][open-webui-docs]
  - [open-webui-envs][open-webui-envs]
  - [open-webui-image-generation-config][open-webui-image-generation-config]
  - [open-webui-image-generation-usage][open-webui-image-generation-usage]

[ollama]: ../../dotfiles/tools/ai/ollama/README.md
[open-webui]: https://github.com/open-webui/open-webui
[open-webui-docs]: https://docs.openwebui.com/
[open-webui-envs]: https://docs.openwebui.com/getting-started/env-configuration
[open-webui-image-generation-config]: https://docs.openwebui.com/getting-started/env-configuration#comfyui
[open-webui-image-generation-usage]: https://docs.openwebui.com/tutorials/images/#using-image-generation
