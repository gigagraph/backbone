ARG OLLAMA_IMAGE_TAG

FROM "ollama/ollama:${OLLAMA_IMAGE_TAG}"

RUN <<EOF
  apt update -y 
  apt install -y \
    curl
EOF

