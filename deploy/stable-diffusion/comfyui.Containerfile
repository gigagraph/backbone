ARG COMFYUI_UBUNTU_VERSION=24.10

FROM ubuntu:${COMFYUI_UBUNTU_VERSION}

ENV DEBIAN_FRONTEND=noninteractive

RUN <<EOF
  apt update -y
  apt install -y \
    wget \
    gnupg \
    curl \
    git \
    python3 \
    python3-pip \
    python3-venv \
    unzip \
    software-properties-common

  rm -rf /var/lib/apt/lists/*
EOF

# # Install intel GPU drivers
# ## Add apt repositories and keys
# RUN <<EOF
# wget -O - https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB |
#   gpg --dearmor |
#   tee /etc/apt/trusted.gpg.d/apt.repos.intel.com.gpg |
#   tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null

# wget -qO - https://repositories.intel.com/gpu/intel-graphics.key |
#     gpg --yes --dearmor --output /usr/share/keyrings/intel-graphics.gpg

# # oneAPI HPC Toolkit
# echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | tee /etc/apt/sources.list.d/oneAPI.list

# # OpenVino
# echo "deb https://apt.repos.intel.com/openvino ubuntu24 main" | tee /etc/apt/sources.list.d/intel-openvino.list
# EOF

# ## Add the user to the ubuntu group
# RUN <<EOF
# groupadd render
# gpasswd -a ubuntu render
# EOF

# ## Install intel drivers & HPC libs
# RUN <<EOF
# . /etc/os-release
# if [[ ! " jammy noble " =~ " ${VERSION_CODENAME} " ]]; then
#     echo "Ubuntu version ${VERSION_CODENAME} not supported"
# else
#     wget -qO - https://repositories.intel.com/gpu/intel-graphics.key | \
#     gpg --yes --dearmor --output /usr/share/keyrings/intel-graphics.gpg
#     echo "deb [arch=amd64 signed-by=/usr/share/keyrings/intel-graphics.gpg] https://repositories.intel.com/gpu/ubuntu ${VERSION_CODENAME}/lts/2523 unified" | \
#     tee /etc/apt/sources.list.d/intel-gpu-${VERSION_CODENAME}.list
#     apt update -y
# fi

# if [[ ! " jammy noble " =~ " ${VERSION_CODENAME} " ]]; then
#     echo "Ubuntu version ${VERSION_CODENAME} not supported"
# else
#     wget https://repositories.intel.com/gpu/ubuntu/dists/${VERSION_CODENAME}/lts/2523/intel-gpu-ubuntu-${VERSION_CODENAME}-2523.run
#     chmod +x intel-gpu-ubuntu-${VERSION_CODENAME}-2523.run
#     ./intel-gpu-ubuntu-${VERSION_CODENAME}-2523.run
# fi

# apt update -y
# apt install -y \
#     "linux-headers-$(uname -r)" \
#     "linux-modules-extra-$(uname -r)" \
#     flex bison \
#     intel-fw-gpu intel-i915-dkms xpu-smi
#     \
#     intel-opencl-icd libze-intel-gpu1 libze1 \
#     intel-media-va-driver-non-free libmfx-gen1 libvpl2 \
#     libegl-mesa0 libegl1-mesa-dev libgbm1 libgl1-mesa-dev libgl1-mesa-dri \
#     libglapi-mesa libgles2-mesa-dev libglx-mesa0 libigdgmm12 libxatracker2 mesa-va-drivers \
#     mesa-vdpau-drivers mesa-vulkan-drivers va-driver-all vainfo hwinfo clinfo \
#     \
#     libigc-dev intel-igc-cm libigdfcl-dev libigfxcmrt-dev libze-dev \
#     \
#     intel-oneapi-toolkit \
#     \
#     install-intel-deep-learning-essentials \
#     \
#     openvino-2026.2.0
# EOF

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

# RUN <<EOF
#   groupadd comfyui
#   useradd -m --group comfyui comfy
# EOF

# RUN <<EOF
#   chown -R comfy:comfyui /opt/ComfyUI
#   chmod -R g=u /opt/ComfyUI

#   chown -R comfy:comfyui /opt/venv
#   chmod -R g=u /opt/venv
# EOF

# USER comfy

COPY --chown=1000:1000 ./comfyui-manager-config.ini ./custom_nodes/comfyui-manager/config.ini
COPY --chown=1000:1000 ./extra_model_paths.yaml ./extra_model_paths.yaml

RUN <<EOF
  mkdir -p /opt/ComfyUI/manager_custom_nodes
  mkdir -p /opt/ComfyUI/temp
EOF

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

COPY --chown=1000:1000 ./comfyui-entrypoint.sh /home/ubuntu/entrypoint.sh
ENTRYPOINT ["/home/ubuntu/entrypoint.sh"]
