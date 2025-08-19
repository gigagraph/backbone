# Graphics

## Intel

Install drivers for graphics hardware acceleration:

```bash
sudo apt update -y
sudo apt install -y \
  mesa-common-dev \
  libgl1-mesa-dev \
  libgl1-mesa-dri \
  libglapi-mesa \
  libglx-mesa0 \
  libegl-mesa0 \
  libegl1-mesa-dev \
  libosmesa6 \
  libosmesa6-dev \
  libxatracker2 \
  libxatracker-dev \
  mesa-vulkan-drivers \
  mesa-va-drivers \
  mesa-opencl-icd
```

### Intel `compute-runtime` (Level Zero, OpenCL driver, and GPU driver)

Follow the instruction form the [Intel's docs to install the `computer-runtime` libraries][intel-client-gpu-drivers]:

Install the prerequisites:

```bash
sudo apt update -y
sudo apt install -y software-properties-common
```

Add `inte-graphics` PPA:

```bash
sudo add-apt-repository -y ppa:kobuk-team/intel-graphics
```

Install the compute-related packages:

```bash
sudo apt update -y
sudo apt install -y \
  libze-intel-gpu1 \
  libze1 \
  libze-dev \
  libze-intel-gpu-raytracing \
  intel-metrics-discovery \
  intel-opencl-icd \
  intel-gsc \
  intel-ocloc \
  clinfo
```

Install the media-related packages:

```bash
sudo apt update -y
sudo apt install -y \
  intel-media-va-driver-non-free \
  libmfx-gen1 \
  libvpl2 \
  libvpl-tools \
  libva-glx2 \
  va-driver-all \
  vainfo
```

Ensure the group `render` exists and that the current user is a member of it:

```bash
sudo groupadd render
sudo usermod -aG render "${USER}"
```

### Intel oneAPI HPC Toolkit

Follow the instruction form the [Intel's docs to install the oneAPI HPC Toolkit][intel-docs-install-oneapi-hpc-toolkit]:

Install the prerequisites:

```bash
sudo apt update -y
sudo apt install -y gpg-agent wget
```

Add the Intel's GPG to the system keyring:

```bash
wget -O - https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB |
  gpg --dearmor |
  sudo tee /etc/apt/trusted.gpg.d/apt.repos.intel.com.gpg |
  sudo tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null
sudo chmod a+r /etc/apt/trusted.gpg.d/apt.repos.intel.com.gpg
```

Add `oneAPI` repositories to the list of `apt` repositories:

```bash
echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list
```

Update `apt` index:

```bash
sudo apt update -y
```

Install `intel-oneapi-hpc-toolkit` via `apt`:

```bash
sudo apt install -y intel-oneapi-hpc-toolkit
```

Ensure the group `video` exists and that the current user is a member of it:

```bash
sudo groupadd video
sudo usermod -aG video "${USER}"
```

## Nvidia

### Debian

#### Option 1 - Debian official instructions

Follow [Debian official instructions to install proprietary Nvidia drivers][debian-nvidia-drivers]:

```bash
sudo apt update -y && \
  sudo apt install -y nvidia-detect
nvidia-detect
```

Add "contrib", "non-free" and "non-free-firmware" components to `/etc/apt/sources.list`:

```
deb http://deb.debian.org/debian/ <debian-release-name> main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ <debian-release-name> main contrib non-free non-free-firmware
```

If the machine enables secure boot, [enroll machine owner key (MOK) to sign DKMS modules][enroll-machine-owner-key-to-sign-dkms-modules]:

```bash
sudo mokutil --import /var/lib/dkms/mok.pub
sudo mokutil --list-new
sudo systemctl reboot
```

Install the drivers:

```bash
sudo apt upgrade -y
sudo apt install -y \
  linux-headers-amd64 \
  nvidia-driver \
  firmware-misc-nonfree
```

Reboot the system to load the drivers:

```bash
sudo systemctl reboot
```

#### Option 2 - Nvidia instuctions

Follow Nvidia's official instructions to install the [GPU driver][nvidia-driver-installation-instructions] and [CUDA Toolkit][nvidia-cuda-installation].

## Useful links

- Intel:
  - [arch-wiki-intel-graphics][arch-wiki-intel-graphics].
  - [intel-client-gpu-drivers][intel-client-gpu-drivers].
  - [github-intel-compute-runtime][github-intel-compute-runtime].
  - [intel-docs-compute-runtime][intel-docs-compute-runtime].
  - [intel-docs-install-npu-driver][intel-docs-install-npu-driver].
    - [github-intel-npu-driver][github-intel-npu-driver].
  - [intel-docs-install-oneapi-hpc-toolkit][intel-docs-install-oneapi-hpc-toolkit].
Nvidia:
  - [arch-wiki-nvidia][arch-wiki-nvidia].
  - [debian-nvidia-drivers][debian-nvidia-drivers].
  - [ubuntu-nvidia-drivers-installation][ubuntu-nvidia-drivers-installation].
  - [nvidia-open-gpu-kernel-modules][nvidia-open-gpu-kernel-modules].
  - [nvidia-driver-installation-instructions][nvidia-driver-installation-instructions].
  - [nvidia-cuda-installation][nvidia-cuda-installation].
  - [nvidia-donwload-explore-files][nvidia-donwload-explore-files].
- [enroll-machine-owner-key-to-sign-dkms-modules][enroll-machine-owner-key-to-sign-dkms-modules].

[arch-wiki-intel-graphics]: https://wiki.archlinux.org/title/Intel_graphics
[intel-client-gpu-drivers]: https://dgpu-docs.intel.com/driver/client/overview.html
[github-intel-compute-runtime]: https://github.com/intel/compute-runtime
[intel-docs-compute-runtime]: https://www.intel.com/content/www/us/en/developer/articles/tool/opencl-drivers.html
[intel-docs-install-npu-driver]: https://amrdocs.intel.com/docs/2.2/gsg_robot/install-npu-driver.html
[github-intel-npu-driver]: https://github.com/intel/linux-npu-driver
[intel-docs-install-oneapi-hpc-toolkit]: https://www.intel.com/content/www/us/en/developer/tools/oneapi/hpc-toolkit-download.html?packages=hpc-toolkit&hpc-toolkit-os=linux&hpc-toolkit-lin=apt
[arch-wiki-nvidia]: https://wiki.archlinux.org/title/NVIDIA
[debian-nvidia-drivers]: https://wiki.debian.org/NvidiaGraphicsDrivers#Debian-packaged_drivers
[ubuntu-nvidia-drivers-installation]: https://ubuntu.com/server/docs/nvidia-drivers-installation
[nvidia-open-gpu-kernel-modules]: https://github.com/NVIDIA/open-gpu-kernel-modules
[nvidia-driver-installation-instructions]: https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/index.html#debian-installation-network
[nvidia-cuda-installation]: https://docs.nvidia.com/cuda/cuda-installation-guide-linux
[nvidia-donwload-explore-files]: https://download.nvidia.com/XFree86/
[enroll-machine-owner-key-to-sign-dkms-modules]: https://wiki.debian.org/SecureBoot#DKMS_and_secure_boot
