ARG COMFYUI_IMAGE_TAG
ARG COMFYUI_FRONTEND_VERSION
ARG COMFYUI_IMAGE_NAME="ghcr.io/saladtechnologies/comfyui-api"

FROM "${COMFYUI_IMAGE_NAME}:${COMFYUI_IMAGE_TAG}"

RUN comfy tracking disable

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
ENV CMD="comfy --workspace '${COMFY_HOME}' launch -- --listen '*' --port '${COMFYUI_CONTAINER_PORT}' --preview-method auto --front-end-version '${COMFYUI_FRONTEND_VERSION}'"
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

VOLUME [ \
  "/opt/ComfyUI/models", \
  "/opt/ComfyUI/input", \
  "/opt/ComfyUI/output", \
  "/opt/ComfyUI/user", \
  "/opt/ComfyUI/custom_nodes", \
  "/opt/ComfyUI/temp", \
]
