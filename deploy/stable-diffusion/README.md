# `stable-diffusion`

Service to interact with locally deployed GenAI models that work with images.

## Deployment

### Prerequisites

- Host with Nvidia GPU.
- [Nvidia GPU drivers](../../system-setup/graphics.md#nvidia).
- [Docker Engine](../../system-setup/toolchains/docker/README.md).
  - [Nvidia Container Toolkit](../../system-setup/toolchains/docker/README.md#nvidia-contianer-toolkit)

### Deployment instructions

> [!NOTE]
>
> The `compose.yaml` deployment assumes users set `COMFYUI_IMAGE_TAG` to the one that [includes `cuda`][github-comfyui-api-docker-prebuilt].

Run the following command:

```bash
env "COMFYUI_VERSION=<comfyui-version>" \
  "COMFYUI_FRONTEND_VERSION=Comfy-Org/ComfyUI_frontend@<version>"
  "COMFYUI_CUDA_VERSION=<cuda-version>" \
  "COMFYUI_UBUNTU_VERSION=<ubuntu-version>" \
  "COMFYUI_HOST_PORT=<comfyui-port>" \
  docker compose up -d --build
```

## Useful links

- [stable-diffusion-webui][stable-diffusion-webui]
- [sd-webui-docker][sd-webui-docker]
- [comfyui-docs][comfyui-docs]
- [github-comfyui][github-comfyui]
- [github-comfyui-api-docker][github-comfyui-api-docker]
- [github-comfyui-api-docker-prebuilt][github-comfyui-api-docker-prebuilt]

[stable-diffusion-webui]: https://github.com/AUTOMATIC1111/stable-diffusion-webui
[sd-webui-docker]: https://github.com/neggles/sd-webui-docker
[comfyui-docs]: https://docs.comfy.org
[github-comfyui]: https://github.com/comfyanonymous/ComfyUI
[github-comfyui-api-docker]: https://github.com/SaladTechnologies/comfyui-api
[github-comfyui-api-docker-prebuilt]: https://github.com/SaladTechnologies/comfyui-api?tab=readme-ov-file#prebuilt-docker-images
