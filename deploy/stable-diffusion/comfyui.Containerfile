ARG CUDNN_BASE=devel
ARG COMFYUI_CUDA_VERSION
ARG COMFYUI_CUDNN_VERSION=""
ARG COMFYUI_UBUNTU_VERSION
FROM nvcr.io/nvidia/cuda:${COMFYUI_CUDA_VERSION}-cudnn${COMFYUI_CUDNN_VERSION}-${CUDNN_BASE}-ubuntu${COMFYUI_UBUNTU_VERSION}
ENV DEBIAN_FRONTEND=noninteractive

RUN <<EOF
  apt update -y
  apt install -y \
    wget \
    curl \
    git \
    python3 \
    python3-pip \
    python3-venv \
    unzip
  rm -rf /var/lib/apt/lists/*
EOF

RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:${PATH}"
RUN . /opt/venv/bin/activate

RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir uv
ARG COMFYUI_TORCH_VERSION
RUN uv pip install --no-cache-dir --pre "torch==${COMFYUI_TORCH_VERSION}" torchvision "torchaudio==${COMFYUI_TORCH_VERSION}"
RUN uv pip install --no-cache-dir comfy-cli

ARG COMFYUI_VERSION
RUN git clone --depth 1 --branch "v${COMFYUI_VERSION}" https://github.com/comfyanonymous/ComfyUI.git /opt/ComfyUI

WORKDIR "/opt/ComfyUI"

RUN uv pip install --no-cache-dir --requirements requirements.txt

# Install custom nodes
ARG COMFYUI_MANAGER_VERSION
ARG COMFYUI_IMPACT_PACK_VERSION
RUN <<EOF
  git clone --depth 1 --branch "${COMFYUI_MANAGER_VERSION}" https://github.com/Comfy-Org/ComfyUI-Manager ./custom_nodes/comfyui-manager
  uv pip install --no-cache-dir --requirements ./custom_nodes/comfyui-manager/requirements.txt
EOF
RUN <<EOF
  git clone --depth 1 --branch "${COMFYUI_IMPACT_PACK_VERSION}" https://github.com/ltdrdata/ComfyUI-Impact-Pack ./custom_nodes/comfyui-impact-pack
  uv pip install --no-cache-dir --requirements ./custom_nodes/comfyui-impact-pack/requirements.txt
EOF

ENV COMFYUI_HOME="/opt/ComfyUI"
ENV COMFYUI_PATH="${COMFYUI_HOME}"

RUN <<EOF
  comfy --skip-prompt tracking disable
  comfy --skip-prompt set-default "${COMFYUI_HOME}"
EOF

RUN <<EOF
  groupadd comfyui
  useradd -m --group comfyui comfy
EOF

RUN <<EOF
  chown -R comfy:comfyui /opt/ComfyUI
  chmod -R g=u /opt/ComfyUI

  chown -R comfy:comfyui /opt/venv
  chmod -R g=u /opt/venv
EOF

USER comfy

COPY --chown=comfy:comfyui ./comfyui-manager-config.ini ./custom_nodes/comfyui-manager/config.ini
COPY --chown=comfy:comfyui ./extra_model_paths.yaml ./extra_model_paths.yaml

RUN mkdir -p /opt/ComfyUI/{manager_custom_nodes,temp}

ARG COMFYUI_CONTAINER_PORT=80
ENV COMFYUI_CONTAINER_PORT="${COMFYUI_CONTAINER_PORT}"
ENV COMFYUI_FRONTEND_VERSION="Comfy-Org/ComfyUI_frontend@latest"

EXPOSE ${COMFYUI_CONTAINER_PORT}

ENV MODEL_DIR="${COMFYUI_HOME}/models" \
    OUTPUT_DIR="${COMFYUI_HOME}/output" \
    INPUT_DIR="${COMFYUI_HOME}/input"

VOLUME [ \
  "/opt/ComfyUI/manager_custom_nodes", \
  "/opt/ComfyUI/models", \
  "/opt/ComfyUI/input", \
  "/opt/ComfyUI/output", \
  "/opt/ComfyUI/user", \
  "/opt/ComfyUI/temp" \
]

COPY --chown=comfy:comfyui ./comfyui-entrypoint.sh /home/comfy/entrypoint.sh
ENTRYPOINT ["/home/comfy/entrypoint.sh"]
