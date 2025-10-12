# Local Kubernets

This document contains infromation on how to setup, run, and operate kubernetes locally.

## Setup

The guide recommends running k8s cluster using [`minikube`][minikube] on a [Linux host inside virtual machines running under `QEMU` + `kvm`](../../../system-setup/vitrual.md). This setup provides the most flexibility on to experiment with, scale, and debug k8s setup on a single host.

### `minikube` installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Go](../../../system-setup/toolchains/go/README.md).
> - [Docker](../../../system-setup/toolchains/docker/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).
>
> Additionally, ensure that you can run [virtual machines via `QEMU` + `kvm`](../../../system-setup/vitrual.md).

This guide recommends [building `minikube` from sources in Docker][minikube-build-from-sources].

Clone the repo and checkout the latest stable version:

```bash
git clone git@github.com:kubernetes/minikube.git
cd minikube
git checkout "${MINIKUBE_VERSION}"
```

Build and test the project:

```bash
MINIKUBE_BUILD_IN_DOCKER=y make
make test
make functional

# Optionally, generate test report
make html_report
```

Install the binary:

```bash
sudo install -C -D out/minikube /usr/local/bin/minikube
```

#### Integrate `minikube` with other programs

##### zsh

See the corresponding section in the [zsh docs file in this repo](../../../dotfiles/zsh/README.md#minikube) to install `zhs` [completions][minikube-completion].

#### `minikube` configuration

Run the script to apply config from this repo to your `minikube` installation:

```bash
./minikube/setup-config.sh
```

## Operating the local

```bash
minikube start \
  \
  --profile='local-k8s-cluster' \
  \
  --vm='true' \
  --driver='kvm2' \
  --kvm-qemu-uri='qemu:///system' \
  \
  --container-runtime='containerd' \
  \
  --ha='false' \
  --nodes='3' \
  \
  --cpus='4' \
  --memory='2g' \
  --disk-size='20g' \
  \
  --dns-domain='cluster.local' \
  \
  --namespace='default' \
  \
  --addons='metrics-server,dashboard,ingress,' \
  --install-addons='true' \
  \
  --interactive='false' \
  --keep-context='true'
```

## Useful links

- [minikube][minikube]
  - [minikube-start][minikube-start]
  - [minikube-build-from-sources][minikube-build-from-sources]
  - [minikube-commands][minikube-commands]
    - [minikube-completion][minikube-completion]

[minikube]: https://minikube.sigs.k8s.io/docs/
[minikube-start]: https://minikube.sigs.k8s.io/docs/start
[minikube-handbook]: https://minikube.sigs.k8s.io/docs/handbook/
[minikube-build-from-sources]: https://minikube.sigs.k8s.io/docs/contrib/building/binaries/
[minikube-commands]: https://minikube.sigs.k8s.io/docs/commands/
[minikube-completion]: https://minikube.sigs.k8s.io/docs/commands/completion/
