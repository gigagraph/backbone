# Bazel

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Go](../go/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends following [Bazel's offcial recommendation][bazel-installation] and install Bazel [`bazelisk`][github-bazelisk].

### `bazelisk` installation

1. Obtain `bazelisk` build using one of the options:
  - Download a prebuilt `bazelisk` binary from the [`bazelisk`'s release page][bazelisk-releases].
  - Build bazelisk from sources:
    - Clone the `bazelisk` repo and checkout the desired version:
      - ```bash
        git clone git@github.com:bazelbuild/bazelisk.git
        cd bazelisk
        git checkout "${BAZELISK_VERSION}"
        ```
    - Update the project go dependencies and build it:
      - ```bash
        go mod tidy
        go build
        env CC="$(which clang)" CXX="$(which clang++)" LD="lld" \
          ./bazelisk build --config=release "//:bazelisk-$(go env GOOS)-$(go env GOHOSTARCH)"
        rm -rf ./bazelisk
        ```
2. Install the built binary to a location on the `PATH` & create a `bazel` symlink to `bazelisk`:
  - ```bash
    sudo install -C -D "./bazel-bin/bazelisk-$(go env GOOS)_$(go env GOHOSTARCH)" '/usr/local/bin/bazelisk'
    sudo ln -s '/usr/local/bin/bazelisk' '/usr/local/bin/bazel'
    ```

#### `bazel` shell completions

Follow the [official instruction to install bazel completions for your shell][bazel-install-completions].

For an example, see the corresponding section in the [zsh docs file in this repo](../../../dotfiles/zsh/README.md#bazel).

## Useful links

- [bazel][bazel]
- [bazel-installation][bazel-installation]
- [bazel-install-completions][bazel-install-completions]
- [github-bazel][github-bazel]
- [github-bazel-buildtools][github-bazel-buildtools]
- [github-bazelisk][github-bazelisk]
- [bazelisk-releases][bazelisk-releases]
- [github-bazel-contrib][github-bazel-contrib]
- [aspecct-build-blog][aspecct-build-blog]

[bazel]: https://bazel.build/
[bazel-installation]: https://bazel.build/install/bazelisk
[bazel-install-completions]: https://bazel.build/install/completion
[github-bazel]: https://github.com/bazelbuild/bazel
[github-bazel-buildtools]: https://github.com/bazelbuild/buildtools
[github-bazelisk]: https://github.com/bazelbuild/bazelisk
[bazelisk-releases]: https://github.com/bazelbuild/bazelisk/releases
[github-bazel-contrib]: https://github.com/bazel-contrib
[aspecct-build-blog]: https://blog.aspect.build/
