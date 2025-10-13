# `kubectl`

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Go](../../../system-setup/toolchains/go/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends [building `kubectl` from sources][github-k8s-build].

Clone the repo and checkout the latest stable version:

```bash
git clone --depth 1 --branch "${KUBERNETES_VERSION}" git@github.com:kubernetes/kubernetes.git
cd kubernetes
```

Build the project:

```bash
make kubectl kubectl-convert
```

Install the binaries:

```bash
sudo install -C -D -o root -g root -m 0755 "_output/local/bin/$(go env GOOS)/$(go env GOARCH)/"kube* /usr/local/bin/
```

### Integrate `kubectl` and `kubectl-convert` with other programs

#### zsh

See the corresponding section in the [zsh docs file in this repo](../../../../dotfiles/zsh/README.md#kubectl) to install `zhs` completions.

## Useful links

- [k8s-install-tools][k8s-install-tools]
- [install-kubectl-linux][install-kubectl-linux]
- [kuberc][kuberc]
- [kubectl-reference][kubectl-reference]

[k8s-install-tools]: https://kubernetes.io/docs/tasks/tools/
[install-kubectl-linux]: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
[kuberc]: https://kubernetes.io/docs/reference/kubectl/kuberc/
[kubectl-reference]: https://kubernetes.io/docs/reference/kubectl/
[github-k8s-build]: https://github.com/kubernetes/kubernetes/tree/master/build
