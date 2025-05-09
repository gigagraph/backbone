# Go toolchain

## Installation

### System go

1. Remove the previous installation (depending), e.g.:
  - ```bash
    rm -rf /usr/local/go &&
    ```
2. Download the desired version of go (`${GO_VERSION}`), e.g. from the [official mirror][download-go].
3. Unpack the downloaded archive to a directory on the filesystem, where you want to be able to access it from. E.g. you can install it for a specific user by unpacking go to `${HOME}/.local/bin/go`, or you can install it system-wide at `/usr/local/go` Go calls this directory `${GOROOT}`.
 - ```bash
   # Set the path you want to install go
   GOROOT="/usr/local/go"
   # Remove the /go part from the end of GOROOT, because the archive has this directory. Depending on the installation location, you may need to prepend the command with `sudo`
   tar -C "${GOROOT%/*}" -xzf "go${GO_VERSION}.${OS}-${ARCH}.tar.gz"
   ```
4. Add `${GOROOT}`, `${GOBIN}`, `${GOPATH}/bin`, and `${HOME}/go/bin` to your `${PATH}`, e.g.:
  - In bash:
    ```bash
    cat << EOF >> "${HOME}/.bashrc"
    __goroot="$(go env GOROOT)"
    __gobin="$(go env GOBIN)"
    __gopath="$(go env GOBIN)"
    [[ -d "${__goroot}" ]] && path+=("${__goroot}")
    [[ -d "${__gobin}" ]] && path+=("${__gobin}")
    [[ -d "${__gopath}/bin" ]] && path+=("${__gopath}/bin")
    [[ -d "${HOME}/go/bin" ]] && path+=("${HOME}/go/bin")
    EOF
    ```
5. Open a new terminal session and test the installation. The following command should print go version:
   ```bash
   go version
   ```

### Install multiple versions

> [!IMPORTANT]
>
> These commands require `git` to be present on the system.

```bash
go install golang.org/dl/go1.10.7@latest
go1.10.7 download
go1.10.7 version
```

## Uninstall go

For Unix-like OS-es:

1. Delete the go directory:
  - `go env GOROOT`.
  - Usually `/usr/local/go`
2. Remove the go bin directory from `PATH`.

## Useful links

- [install-go][install-go]
  - [download-go][download-go]
- [manage-go-installation][manage-go-installation]
- [install-go-from-sources][install-go-from-sources]

[install-go]: <https://go.dev/doc/install>
[download-go]: <https://go.dev/dl/>
[manage-go-installation]: <https://go.dev/doc/manage-install>
[install-go-from-sources]: <https://go.dev/doc/install/source>
