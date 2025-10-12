# Virtual Machines setup on Linux

## Setup

### Enable [`kvm`][archwiki-kvm]

Ensure the hosts supports virtualization:

```bash
lscpu | grep Virtualization
```

Ensure virtualization is enabled in BIOS.

Ensure `kvm` kernel module is loaded:

```bash
lsmod | grep kvm
```

Alternatively, on Ubuntu users can run a helper script:

```bash
kvm-ok
```

### Install [`QEMU`][archwiki-qemu]

This guide recommends installing `QEMU` using system package manager:

```bash
sudo apt update -y
sudo apt install -y \
  qemu-system \
  qemu-user-static
```

### Install [`libvirt`][archwiki-libvirt]


This guide recommends installing `libvirt` using system package manager:

```bash
sudo apt update -y
sudo apt install -y \
  libvirt-daemon-system \
  libvirt-clients \
  libvirt-doc \
  bridge-utils
```

Add user to the `libvirt` group:

```bash
sudo adduser "${USER}" libvirt
```

Enable `systemd` services:

```bash
sudo systemctl enable libvirtd.socket
sudo systemctl start libvirtd.socket

sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.socket
```

### Install [`virt-manager`][archwiki-virt-manager]

This guide recommends installing `virt-manager` using system package manager:

```bash
sudo apt update -y
sudo apt install -y \
  virt-manager \
  virtinst
```

### Verify the setup with `virt-host-validate`

Run `virt-host-validate` to verify the setup.

#### cgroup 'devices' controller support

```
QEMU: Checking for cgroup 'devices' controller support : WARN (Enable 'devices' in kernel Kconfig file or mount/enable cgroup controller in your system)
```

When you see this warning, you can disregard it. It means that you are booted with pure cgroup v2 hierarchy. `devices` controller is only available in legacy v1 cgroup hierarchy.

#### Secure guest support

```
QEMU: Checking for secure guest support : WARN (Unknown if this platform has Secure Guest support)
```

When you see this warning, you can disregard it. It means that your processor most probably does not support AMD SEV or Intel TDX technology to provide more isolation to virtual machines. The feature is mostly supported on server CPUs.

## Sharing host accelerators with VM(s)

> [!NOTE]
>
> To share a GPU across multiple virtual machines, either:
> - The GPU hardware must support SR-IOV and the corresponding driver must implement it as well.
> - The driver must support sharing the accelerator device.

## Useful links

- [wiki-virtualization][wiki-virtualization]
- [wiki-kvm][wiki-kvm]
- [archwiki-kvm][archwiki-kvm]
- [kvm-faq][kvm-faq]
- [archwiki-qemu][archwiki-qemu]
- [archiwiki-qemu-graphics-acceleration][archiwiki-qemu-graphics-acceleration]
- [wiki-qemu][wiki-qemu]
  - [build-qemu-from-source][build-qemu-from-source]
- [qemu-download][qemu-download]
- [qemu-docs][qemu-docs]
- [qemu-networking][qemu-networking]
- [archwiki-libvirt][archwiki-libvirt]
- [libvirt][libvirt]
- [libvirt-docs][libvirt-docs]
  - [libvirt-build-from-source][libvirt-build-from-source]
  - [libvirt-qemu-kvm][libvirt-qemu-kvm]
  - [libvirt-config-reference][libvirt-config-reference]
- [libvirt-wiki][libvirt-wiki]
- [ubuntu-libvirt][ubuntu-libvirt]
- [archwiki-virt-manager][archwiki-virt-manager]
- [virt-manager][virt-manager]
- [virt-manager-installation][virt-manager-installation]
- [ubuntu-virt-manager][ubuntu-virt-manager]
- [arch-wiki-pci-passtrhough-in-vm][arch-wiki-pci-passtrhough-in-vm]
- [wiki-gpu-virtualization][wiki-gpu-virtualization]
- [open-iov][open-iov]
- [github-lima][github-lima]
- [lima][lima]
- [archwiki-kernelmodules][archwiki-kernelmodules]

[wiki-virtualization]: https://en.wikipedia.org/wiki/Virtualization
[archwiki-kvm]: https://wiki.archlinux.org/title/KVM
[wiki-kvm]: https://en.wikipedia.org/wiki/Kernel-based_Virtual_Machine
[kvm-faq]: https://www.linux-kvm.org/page/FAQ#General_KVM_information
[archwiki-qemu]: https://wiki.archlinux.org/title/QEMU
[archiwiki-qemu-graphics-acceleration]: https://wiki.archlinux.org/title/QEMU/Guest_graphics_acceleration
[wiki-qemu]: https://en.wikipedia.org/wiki/QEMU
[build-qemu-from-source]: https://wiki.qemu.org/Hosts/Linux
[qemu-download]: https://www.qemu.org/download
[qemu-docs]: https://www.qemu.org/docs/master/
[qemu-networking]: https://qemu.weilnetz.de/doc/6.0/system/net.html
[archwiki-libvirt]: https://wiki.archlinux.org/title/Libvirt
[libvirt]: https://libvirt.org/index.html
[libvirt-docs]: https://libvirt.org/docs.html
[libvirt-build-from-source]: https://libvirt.org/compiling.html
[libvirt-qemu-kvm]: https://libvirt.org/drvqemu.html
[libvirt-config-reference]: https://libvirt.org/format.html
[libvirt-wiki]: https://wiki.libvirt.org/
[ubuntu-libvirt]: https://documentation.ubuntu.com/server/how-to/virtualisation/libvirt/
[archwiki-virt-manager]: https://wiki.archlinux.org/title/Virt-manager
[virt-manager]: https://virt-manager.org/index.html
[virt-manager-installation]: https://github.com/virt-manager/virt-manager/blob/main/INSTALL.md
[ubuntu-virt-manager]: https://documentation.ubuntu.com/server/how-to/virtualisation/virtual-machine-manager/
[arch-wiki-pci-passtrhough-in-vm]: https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF
[wiki-gpu-virtualization]: https://en.wikipedia.org/wiki/GPU_virtualization
[open-iov]: https://open-iov.org/index.php/Introduction
[github-lima]: https://github.com/lima-vm/lima
[lima]: https://lima-vm.io/
[archwiki-kernelmodules]: https://wiki.archlinux.org/title/Kernel_module
