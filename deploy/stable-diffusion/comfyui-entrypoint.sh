#!/usr/bin/env bash

exec python3 main.py \
  --listen '*' \
  --port "${COMFYUI_CONTAINER_PORT}" \
  --preview-method auto \
  --front-end-version "${COMFYUI_FRONTEND_VERSION}" \
  --comfy-api-base "http://localhost:${COMFYUI_CONTAINER_PORT}" \
  \
  --cpu
