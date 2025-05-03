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
[arch-wiki-nvidia]: https://wiki.archlinux.org/title/NVIDIA
[debian-nvidia-drivers]: https://wiki.debian.org/NvidiaGraphicsDrivers#Debian-packaged_drivers
[ubuntu-nvidia-drivers-installation]: https://ubuntu.com/server/docs/nvidia-drivers-installation
[nvidia-open-gpu-kernel-modules]: https://github.com/NVIDIA/open-gpu-kernel-modules
[nvidia-driver-installation-instructions]: https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/index.html#debian-installation-network
[nvidia-cuda-installation]: https://docs.nvidia.com/cuda/cuda-installation-guide-linux
[nvidia-donwload-explore-files]: https://download.nvidia.com/XFree86/
[enroll-machine-owner-key-to-sign-dkms-modules]: https://wiki.debian.org/SecureBoot#DKMS_and_secure_boot

