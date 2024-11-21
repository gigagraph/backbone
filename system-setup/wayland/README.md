# Wayland

## Installation

### Ubuntu

Ensure the following packages are present on a Ubuntu to be able to use Wayland:

```shell
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

```shell
sudo vi /etc/gdm3/custom.conf
```

Set `WaylandEnable` to `true`:

```shell
WaylandEnable=true
```

Restart the `gdm3` `systemd` service:

```shell
sudo systemctl restart gdm3
```

After the restart test the setup:

```shell
echo "${XDG_SESSION_TYPE}"
```

#### Enable other programs to use Wayland clipboard

Some programs may integrate with Wayland clipboard. E.g. [`neovim`](../dotfiles/neovim/README.md) can discover and paste to the clipboard of the environment it is running in. If it is running in wayland, it can operate the Wayland's clipboard. To enable programs to use Wayland clipboard install the following package:

```shell
sudo apt update -y
sudo apt install -y wl-clipboard
```

## Configuration

- [ ] TODO: guide on where to find wayland config file and how to configure different functionality wayland

### Customization

- [eww](./eww/README.md)
- [rofi](./rofi/README.md)

## Useful links

- [wayland-arch-wiki][wayland-arch-wiki]
- [enable-wayland-on-ubuntu][enable-wayland-on-ubuntu]

[wayland-arch-wiki]: <https://wiki.archlinux.org/title/Wayland>
[enable-wayland-on-ubuntu]: <https://linuxconfig.org/how-to-enable-disable-wayland-on-ubuntu-22-04-desktop>
