#!/usr/bin/env bash

set -e

# Initialize deps
. "${HOME}/.cargo/env"

# Variables

## vscodium
VSCODIUM_RELEASE_VERSION="${VSCODIUM_RELEASE_VERSION:?VSCODIUM_RELEASE_VERSION must be set}"
VSCODE_QUALITY="${VSCODE_QUALITY:-stable}"
VSCODIUM_GIT_URL="https://github.com/VSCodium/vscodium.git"
VSCODIUM_CHECKOUT_DIR="${WORKSPACE_DIR}/vscodium"
VSCODE_CHECKOUT_DIR="${VSCODIUM_CHECKOUT_DIR}/vscode"

### Build
VSCODE_BUILD_OS="linux"
VSCODE_BUILD_ARCH="$(uname -m | sed 's/x86_64/x64/g')"
VSCODE_OUT_DIR_GLOB="${VSCODIUM_CHECKOUT_DIR}/VSCode-*-*"

# Parse input flags
## vscodium
VSCODIUM_FORCE_CHECKOUT=""
VSCODIUM_FORCE_BUILD=""
VSCODIUM_SNAP_FORCE_BUILD=""

while [[ $# -gt 0 ]]; do
  case "${1}" in
    --vscodium-force-checkout)
      VSCODIUM_FORCE_CHECKOUT=1
      shift
      ;;
    --vscodium-force-build)
      VSCODIUM_FORCE_BUILD=1
      shift
      ;;
    --vscodium-snap-force-build)
      VSCODIUM_SNAP_FORCE_BUILD=1
      shift
      ;;
    *)
      echo "Unsupported argument: ${1}"
      exit 1
      ;;
  esac
done

# Functions
## VSCodium
checkout_vscodium() {
  local VSCODIUM_RELEASE_VERSION="${1}"

  if [[ -n "${VSCODIUM_FORCE_CHECKOUT}" || -z "$(ls "${VSCODIUM_CHECKOUT_DIR}")" || -z "$(ls "${VSCODE_CHECKOUT_DIR}")" ]]; then
    echo "Checking out vscodium into ${VSCODIUM_CHECKOUT_DIR}..."

    rm -rf "${VSCODIUM_CHECKOUT_DIR}"
    mkdir -p "${VSCODIUM_CHECKOUT_DIR}"

    git clone \
      --depth 1 \
      --recurse-submodules --shallow-submodules \
      --branch "${VSCODIUM_RELEASE_VERSION}" \
      "${VSCODIUM_GIT_URL}" \
      "${VSCODIUM_CHECKOUT_DIR}"

    rm -rf "${VSCODIUM_CHECKOUT_DIR}/.git"
  else
    echo "vscodium already checked out at ${VSCODIUM_CHECKOUT_DIR}"
  fi

  echo "vscodium checkout finished"
}

build_vscodium() {
  export SHOULD_BUILD="yes"
  export SHOULD_BUILD_TAR="yes"
  export SHOULD_BUILD_REH="no"
  export SHOULD_BUILD_REH_WEB="no"
  export SHOULD_BUILD_APPIMAGE="no"
  export SHOULD_BUILD_DEB="no"
  export SHOULD_BUILD_RPM="no"
  export CI_BUILD="no"
  export OS_NAME="${VSCODE_BUILD_OS}"
  export VSCODE_ARCH="${VSCODE_BUILD_ARCH}"
  export VSCODE_QUALITY="${VSCODE_QUALITY}"
  export RELEASE_VERSION="${VSCODIUM_RELEASE_VERSION}"

  cd "${VSCODIUM_CHECKOUT_DIR}"

  if [[ -z "$(find ./build/workdir/vscodium -type d -name "${VSCODE_OUT_DIR_GLOB}")" || -n "${VSCODIUM_FORCE_BUILD}" ]]; then
    echo "Building vscodium from $(pwd)..."

    # Checkout vscode
    rm -rf "${VSCODE_CHECKOUT_DIR}"
    . get_repo.sh

    # Build
    . build.sh

    ## Only for CI builds
    # ./build/linux/package_bin.sh

    # Package
    export CI_BUILD="yes"
    . prepare_assets.sh
  else
    echo "vscodium has already been built in " "${VSCODE_OUT_DIRS[@]}"
  fi

  echo "vscodium build finished"
}

# VSCodium
checkout_vscodium "${VSCODIUM_RELEASE_VERSION}"
build_vscodium
