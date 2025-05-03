# `docker`

This guide recommends using only open-source components of docker, specifically, [`docker` engine][docker-docs-engine].

## Installation

This installation guide focuses on installing only `docker` engine. The guide is based on the [official instructions][docker-docs-engine-install]. Assuming that you run [Ubuntu, install `docker` using `apt`][docker-docs-engine-install-ubuntu].

Install the dependencies:

```bash
sudo apt-get update -y
sudo apt-get install ca-certificates curl
```

Add docker gpg signature to the `apt`'s keyring:

```
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

Add docker's repository to `apt`:

```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
```

Install docker via `apt`:

```bash
sudo apt install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin
```

### Post installation

Perform [post-installation steps][docker-docs-engine-post-install].

#### Add linux user to `docker` group

```bash
sudo groupadd docker
sudo usermod -aG docker "${USER}"
newgrp docker
```

> [!NOTE]
>
> You may need to log in your user account again to apply the group changes.

#### [Set `buildx` as a default builder][docker-buildx-set-default]

```bash
docker buildx install
```

#### Ensure `systemd` start `docker` daemon and `containerd` services

```bash
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
```

If you do not want to keep `docker` to automatically start on system startup, disable the services:

```bash
sudo systemctl disable docker.service
sudo systemctl disable containerd.service
```

In this case, when you want to run docker, you will need to start and stop the services manually.

### GPU support

#### Nvidia Container Toolkit

> [!IMPORTANT] Prerequisites
>
> Users must have [Nvidia driver](../../graphics.md#nvidia) installed before they install Nvidia Container Toolkit.

Add Nvidia Container Toolkit GPG key and repository to `apt`:

```bash
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list > /dev/null
```

Update `apt` repositories and install the toolkit:

```bash
sudo apt update -y && \
  sudo apt install -y nvidia-container-toolkit
```

Configure `docker` to use Nvidia Container Toolkit and restart the daemon:

```bash
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
```

## Useful links

- [docker-docs-engine][docker-docs-engine].
  - [docker-docs-engine-install][docker-docs-engine-install].
    - [docker-docs-engine-install-ubuntu][docker-docs-engine-install-ubuntu].
    - [docker-docs-engine-post-install][docker-docs-engine-post-install].
- [nvidia-install-container-toolkit][nvidia-install-container-toolkit].
- [compose-gpu-support][compose-gpu-support]. 

[docker-docs-engine]: https://docs.docker.com/engine/
[docker-docs-engine-install]: https://docs.docker.com/engine/install/
[docker-docs-engine-install-ubuntu]: https://docs.docker.com/engine/install/ubuntu/
[docker-docs-engine-post-install]: https://docs.docker.com/engine/install/linux-postinstall/
[docker-buildx-set-default]: https://github.com/docker/buildx?tab=readme-ov-file#set-buildx-as-the-default-builder
[nvidia-install-container-toolkit]: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
[compose-gpu-support]: https://docs.docker.com/compose/how-tos/gpu-support/

