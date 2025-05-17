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

Run the following commands:

```bash
mkdir -p ./comfyui-persistence/{models,input,output,user,custom_nodes}
chown -R 1000:1000 ./comfyui-persistence

env "COMFYUI_VERSION=<comfyui-version>" \
  "COMFYUI_FRONTEND_VERSION=Comfy-Org/ComfyUI_frontend@<version>" \
  "COMFYUI_MANAGER_VERSION=<comfyui-manager-version>" \
  "COMFYUI_IMPACT_PACK_VERSION=<comfyui-impact-pack-version>" \
  "COMFYUI_CUDA_VERSION=<cuda-version>" \
  "COMFYUI_CUDNN_VERSION=<cudnn-version>" \
  "COMFYUI_UBUNTU_VERSION=<ubuntu-version>" \
  "COMFYUI_TORCH_VERSION=<torch-version>" \
  "COMFYUI_HOST_PORT=<comfyui-port>" \
  docker compose up -d --build
```

## Using

> [!NOTE]
>
> Unfortunately, currently, there is no simple way to install models or proprly containerize ComfyUI to enable both static and dynamic custom nodes installation at the same time. Find more info in the issue: https://github.com/Comfy-Org/ComfyUI-Manager/issues/420
>
> For now, this deployment chooses to install [ComfyUI-Manager][github-comfyui-manager] when building the container image. Therefore, it is recommended not to mount a volume under `/opt/ComfyUI/custom_nodes` in the container. Instead, users should modify the containerfile to add custom nodes statically when building the image.
>
> Nevertheless, the deployment mounts a custom volume under `/opt/ComfyUI/models`, so that users can persist the models across the container restarts.

### Install models that are not available in ComfyUI-Manager

Put the downloaded models in [the corresponding directory under `./comfyui-persistence/models/<model-type>`][comfyui-directory-structure].

## Useful links

- [stable-diffusion-webui][stable-diffusion-webui]
- [sd-webui-docker][sd-webui-docker]
- [comfyui-docs][comfyui-docs]
- [github-comfyui][github-comfyui]
- [github-comfyui-manager][github-comfyui-manager]
- [github-comfyui-api-docker][github-comfyui-api-docker]
- [github-comfyui-api-docker-prebuilt][github-comfyui-api-docker-prebuilt]
- [comfyui-directory-structure][comfyui-directory-structure]

[stable-diffusion-webui]: https://github.com/AUTOMATIC1111/stable-diffusion-webui
[sd-webui-docker]: https://github.com/neggles/sd-webui-docker
[comfyui-docs]: https://docs.comfy.org
[github-comfyui]: https://github.com/comfyanonymous/ComfyUI
[github-comfyui-manager]: https://github.com/Comfy-Org/ComfyUI-Manager
[github-comfyui-api-docker]: https://github.com/SaladTechnologies/comfyui-api
[github-comfyui-api-docker-prebuilt]: https://github.com/SaladTechnologies/comfyui-api?tab=readme-ov-file#prebuilt-docker-images
[comfyui-directory-structure]: https://comfyui-wiki.com/en/interface/files
