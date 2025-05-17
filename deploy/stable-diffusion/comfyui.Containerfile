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
ARG COMFYUI_TORCH_VERSION
RUN pip install --no-cache-dir --pre "torch==${COMFYUI_TORCH_VERSION}" torchvision torchaudio \
    --index-url https://download.pytorch.org/whl/nightly/cu128
RUN pip install --no-cache-dir comfy-cli

ARG COMFYUI_VERSION
RUN git clone --depth 1 --branch "v${COMFYUI_VERSION}" https://github.com/comfyanonymous/ComfyUI.git /opt

WORKDIR "/opt/ComfyUI"

RUN pip install --no-cache-dir -r requirements.txt

ENV COMFYUI_HOME="/opt/ComfyUI"

RUN <<EOF
  comfy --skip-prompt tracking disable
  comfy --skip-prompt set-default "${COMFYUI_HOME}"
EOF

RUN <<EOF
  groupadd comfyui
  useradd -m --group comfyui comfy
EOF

RUN <<EOF
  chown -R root:comfy /opt/ComfyUI
  chmod -R g=u /opt/ComfyUI
EOF

USER comfy

ARG COMFYUI_CONTAINER_PORT=80
ENV COMFYUI_CONTAINER_PORT="${COMFYUI_CONTAINER_PORT}"
ENV COMFYUI_FRONTEND_VERSION="Comfy-Org/ComfyUI_frontend@latest"

EXPOSE ${COMFYUI_CONTAINER_PORT}

ENV MODEL_DIR="${COMFYUI_HOME}/models" \
    OUTPUT_DIR="${COMFYUI_HOME}/output" \
    INPUT_DIR="${COMFYUI_HOME}/input" \
    CMD="comfy --workspace '${COMFY_HOME}' launch -- --listen '*' --port '${COMFYUI_CONTAINER_PORT}' --preview-method auto --front-end-version '${COMFYUI_FRONTEND_VERSION}'"

VOLUME [ \
  "/opt/ComfyUI/models", \
  "/opt/ComfyUI/input", \
  "/opt/ComfyUI/output", \
  "/opt/ComfyUI/user", \
  "/opt/ComfyUI/custom_nodes", \
  "/opt/ComfyUI/temp", \
]

CMD [ \
  "comfy", \
  "--workspace", "'${COMFY_HOME}'", \
  "launch", \
  "--", \
  "--listen", "'*'", \
  "--port", "'${COMFYUI_CONTAINER_PORT}'", \
  "--preview-method", "auto", \
  "--front-end-version", "'${COMFYUI_FRONTEND_VERSION}'" \
]
