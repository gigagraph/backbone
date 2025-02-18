ARG OLLAMA_IMAGE_TAG
ARG OLLAMA_IMAGE_NAME="ollama/ollama"

FROM "${OLLAMA_IMAGE_NAME}:${OLLAMA_IMAGE_TAG}"

RUN <<EOF
  apt update -y 
  apt install -y \
    curl
EOF

