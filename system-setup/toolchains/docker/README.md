# `docker`

This guide recommends using only open-source components of docker, specifically, [`docker` engine][docker-docs-engine].

## Installation

This installation guide focuses on installing only `docker` engine. The guide is based on the [official instructions][docker-docs-engine-install]. Assuming that you run [Ubuntu, install `docker` using `apt`][docker-docs-engine-install-ubuntu].

Install the dependencies:

```shell
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

```shell
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
```

- [ ] TODO: installation instructions
Install docker via `apt`:

```shell
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

```shell
sudo groupadd docker
sudo usermod -aG docker "${USER}"
newgrp docker
```

#### Ensure `systemd` start `docker` daemon and `containerd` services

```shell
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
```

## Useful links

- [docker-docs-engine][docker-docs-engine].
  - [docker-docs-engine-install][docker-docs-engine-install].
    - [docker-docs-engine-install-ubuntu][docker-docs-engine-install-ubuntu].
    - [docker-docs-engine-post-install][docker-docs-engine-post-install].

[docker-docs-engine]: https://docs.docker.com/engine/
[docker-docs-engine-install]: https://docs.docker.com/engine/install/
[docker-docs-engine-install-ubuntu]: https://docs.docker.com/engine/install/ubuntu/
[docker-docs-engine-post-install]: https://docs.docker.com/engine/install/linux-postinstall/

