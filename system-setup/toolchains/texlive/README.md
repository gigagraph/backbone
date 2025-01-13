# TeX Live

## Installation

> [!NOTE]
>
> You need a [Perl](../perl/README.md) to install TeX Live.

This guide is based on the [official instructions][tex-live-installation-unix].

Download the TeX Live distribution:

```shell
curl -L -o install-tl-unx.tar.gz https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
```

Unpack the archive:

```shell
tar xf ./install-tl-unx.tar.gz
cd ./install-tl-*
```

Install the distribution interactively, using the settings defined in this repo:

```shell
sudo perl install-tl --init-from-profile "${WORKSPACE_SETUP_DIR}/system-setup/toolchains/texlive/texlive.profile"
```

> [!NOTE]
>
> If you selected to install most of the components, which is the default, the command may take time to run.

By default, TeX Live installer will install the distribution into `/usr/local/texlive/${TEX_LIVE_VERSION}`. Users most porbably will need to add the paths under this directory to their environment variables (e.g. they will want to update `PATH` in their `.zshrc`). To not update the variable every time a new distribution version is installed, this guide recommends creating a symlink `/usr/local/texlive/current` that points to the currently selected version of TeX Live and use this path to update their envs.

```shell
sudo ln -s "/usr/local/texlive/${TEX_LIVE_VERSION}" "/usr/local/texlive/current"
```

- TODO: additionally add symlinc for the CPU architecture
- TODO: add manpages path

<!--

Add /usr/local/texlive/2024/texmf-dist/doc/man to MANPATH.
Add /usr/local/texlive/2024/texmf-dist/doc/info to INFOPATH.
Most importantly, add /usr/local/texlive/2024/bin/x86_64-linux
to your PATH for current and future sessions.

-->

## Useful links

- [tug-tex-live][tug-tex-live]
  - [tex-live-installation-unix][tex-live-installation-unix]
  - [tex-live-docs][tex-live-docs]
  - [manage-tex-live-packages][manage-tex-live-packages]
- [so-tex-live-tex-mf-cache-issue][so-tex-live-tex-mf-cache-issue]

[tug-tex-live]: <https://www.tug.org/texlive/>
[tex-live-installation-unix]: <https://www.tug.org/texlive/quickinstall.html>
[tex-live-docs]: <https://www.tug.org/texlive/>
[manage-tex-live-packages]: <https://www.tug.org/texlive/pkginstall.html>
[so-tex-live-tex-mf-cache-issue]: <https://tex.stackexchange.com/questions/582779/texlive-2020s-lualatex-fails-to-compile-due-to-no-writeable-cache-path-texli>
