#!/usr/bin/env bash

exec comfy \
  --workspace "${COMFY_HOME}" \
  --skip-prompt launch \
  -- \
  --listen '*' \
  --port "${COMFYUI_CONTAINER_PORT}" \
  --preview-method auto \
  --front-end-version "${COMFYUI_FRONTEND_VERSION}" \
  --comfy-api-base "http://localhost:${COMFYUI_CONTAINER_PORT}"
