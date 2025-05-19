#!/usr/bin/env bash

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

(
  export OLLAMA_IMAGE_TAG="latest" # FIXME: This setup recommends to take a specific version from https://hub.docker.com/r/ollama/ollama/tags and maintain the updates maunally.
  export OPEN_WEBUI_IMAGE_TAG="latest" # FIXME: This setup recommends to take a specific version from https://github.com/open-webui/open-webui/pkgs/container/open-webui and maintain the updates maunally. This setup assumes that users have an Nvidia GPU, so make sure to select the cuda version without Ollama (as it is deployed as a separate service).
  export OLLAMA_HOST_PORT="" # FIXME: Port on the host which will expose Ollama.
  export OPEN_WEBUI_HOST_PORT="" # FIXME: Port on the host which will expose Open WebUI.

  export OPEN_WEBUI_IMAGE_SIZE="512x512" # FIXME: Image size that model from ComfyUI will generate when user request it form Open WebUI.
  export OPEN_WEBUI_IMAGE_STEPS="50" # FIXME: Number of steps that the ComfyUI should use to generate the image that user requests from Open WebUI.
  export OPEN_WEBUI_IMAGE_GENERATION_MODEL="" # FIXME: Name of the image generation model that ComfyUI should use to generate an image when user requests it via Open WebIU.

  export COMFYUI_VERSION="" # FIXME: Choose the version that the setup should deploy from the tag from https://github.com/comfyanonymous/ComfyUI without "v".
  export COMFYUI_FRONTEND_VERSION="Comfy-Org/ComfyUI_frontend@latest" # FIXME: Choose the version from https://github.com/Comfy-Org/ComfyUI_frontend wihtout "v". Include the repo path too.
  export COMFYUI_MANAGER_VERSION="" # FIXME: Choose the version that the setup should deploy from the tag from https://github.com/Comfy-Org/ComfyUI-Manager.
  export COMFYUI_IMPACT_PACK_VERSION="" # FIXME: Choose the version that the setup should deploy from the tag from https://github.com/ltdrdata/ComfyUI-Impact-Pack.
  export COMFYUI_CUDA_VERSION="" # FIXME: Choose cuda version from the available tags https://hub.docker.com/r/nvidia/cuda/tags. Note: different cuda versions have different tag formats. Check with the ./stable-diffusion/compose.yaml file to see how to properly fill this version for the tag to be substituted.
  export COMFYUI_CUDNN_VERSION="" # FIXME: Choose cudnn version from the available tags https://hub.docker.com/r/nvidia/cuda/tags. Note: different cuda versions have different tag formats. Check with the ./stable-diffusion/compose.yaml file to see how to properly fill this version for the tag to be substituted.
  export COMFYUI_UBUNTU_VERSION="" # FIXME: Choose ubuntu version from the available tags https://hub.docker.com/r/nvidia/cuda/tags. Note: different cuda versions have different tag formats. Check with the ./stable-diffusion/compose.yaml file to see how to properly fill this version for the tag to be substituted.
  export COMFYUI_TORCH_VERSION="" # FIXME: Choose pytorch version from https://pypi.org/project/torch/#history.
  export COMFYUI_HOST_PORT="" # FIXME: Port on the host which will expose ComfyUI.

  # stable-diffusion deployment needs these directories
  mkdir -p "${SCRIPT_DIR}/comfyui-persistence/"{models,input,output,user,custom_nodes}
  chown -R 1000:1000 "${SCRIPT_DIR}/comfyui-persistence"

  docker compose up -d --build
)
