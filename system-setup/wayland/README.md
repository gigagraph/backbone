# Wayland

## Installation

### Ubuntu

Ensure the following packages are present on a Ubuntu to be able to use Wayland:

```bash
sudo apt update -y
sudo apt install -y \
  libwayland-bin \
  libwayland-client0 \
  libwayland-cursor0 \
  libwayland-dev \
  libwayland-doc \
  libwayland-egl-backend-dev \
  libwayland-egl1 \
  libwayland-server0 \
  wayland-protocols
```

#### Enable Wayland on Gnome in Ubuntu

The [original guide][enable-wayland-on-ubuntu].

```bash
sudo vi /etc/gdm3/custom.conf
```

Set `WaylandEnable` to `true`:

```bash
WaylandEnable=true
```

Restart the `gdm3` `systemd` service:

```bash
sudo systemctl restart gdm3
```

After the restart test the setup:

```bash
echo "${XDG_SESSION_TYPE}"
```

#### Enable other programs to use Wayland clipboard

Some programs may integrate with Wayland clipboard. E.g. [`neovim`](../../dotfiles/neovim/README.md) can discover and paste to the clipboard of the environment it is running in. If it is running in wayland, it can operate the Wayland's clipboard. To enable programs to use Wayland clipboard install the following package:

```bash
sudo apt update -y
sudo apt install -y wl-clipboard
```

## Configuration

### Window management

This setup eventually plans to integrate [Hyperland](./window-management/hyperland/README.md) as a window manager. See the corresponding docs about the configuration.

## Useful links

- [wayland-arch-wiki][wayland-arch-wiki]
- [enable-wayland-on-ubuntu][enable-wayland-on-ubuntu]

[wayland-arch-wiki]: <https://wiki.archlinux.org/title/Wayland>
[enable-wayland-on-ubuntu]: <https://linuxconfig.org/how-to-enable-disable-wayland-on-ubuntu-22-04-desktop>
