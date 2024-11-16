# ZSH

- [ ] TODO: plugins and customizations
  - antidote
  - powerlevel10k

## Installation

> [!NOTE]
>
> It is better to use the system native C toolchain to compile zsh from sources. Otherwise, the shell may be hanging in certain scenarios. E.g. with Clang 18 on Ubuntu a test was failing by just hanging the shell. With GCC on the same system everything worked fine.

[Download source distribution of zsh][zsh-download], unpack it, and open the terminal in the directory.

Alternatively, you can clone the sources:

```shell
git clone git://git.code.sf.net/p/zsh/code zsh
cd ./zsh
git checkout "${ZSH_VERSION}"
```

Install the build dependencies:

```shell
sudo apt update -y
sudo apt install -y \
  yodl \
  perl \
  info texinfo texinfo-lib install-info
```

> [!NOTE]
> If you checked the repo from git run `./Util/preconfig`. Otherwise, skip it.
>
> ```shell
> ./Util/preconfig
> ```

Configure the build:

```shell
mkdir ./build
../configure --enable-cflags="-O2"
```

Build and test:

```shell
make
make check
```

> [!NOTE]
>
> If something goes wrong with the build, run `make distclean` to remove everything that the `./configure` script generated.

After the build and tests successful completion, intsall zsh:

```shell
sudo make install
sudo make install.info
```

### Set zsh as a default login shell

Ensure `zsh` is present in `/etc/shells`:

```shell
ZSH_PATH="$(which zsh)"; [[ -z "$(cat /etc/shells | grep "${ZSH_PATH}")" ]] && (echo "${ZSH_PATH}" | sudo tee -a /etc/shells) || echo "${ZSH_PATH} is already present in /etc/shells"
```

Set zsh as [default login shell][arch-wiki-change-default-shell]:

> [!NOTE]
>
> As per default PAM configuration, ensure that the shell you run this command from is listed in `/etc/shells`.

```shell
sudo chsh -s "$(which zsh)" "${USER}"
```

## Configuration

See the [description of startup and shutdown files for zsh][arch-wiki-startup-shutdown-files]. Visally it looks as follows:

![Well-known shells startup and shutdown files](./img/shell-startup-actual.png)

- [ ] TODO
  - Move current zsh config to this repo and implement a script to symbolic link the config to the user configuration dir
  - Select back with shift tab
  - Configure such that all zsh files are in ~/.config/.zsh dir (set ZDOTDIR in ~/.zenv)
  - Figure out what to do with keybindings (how to jump between words conveniently)

### Plugins

- [ ] TODO

#### Antidote plugin manager

- [ ] TODO

## Useful links

- [arch-wiki-change-default-shell][arch-wiki-change-default-shell]
- [arch-wiki-startup-shutdown-files][arch-wiki-startup-shutdown-files]
- [zsh-org][zsh-org]
  - [zsh-download][zsh-download]
  - Docs
    - [zsh-intro-doc][zsh-intro-doc]
    - [zsh-faq][zsh-faq]
    - [zsh-manual-toc][zsh-manual-toc]
    - [zsh-user-guide-toc][zsh-user-guide-toc]

[arch-wiki-change-default-shell]: <https://wiki.archlinux.org/title/Command-line_shell#Changing_your_default_shell>
[arch-wiki-startup-shutdown-files]: <https://wiki.archlinux.org/title/Zsh#Startup/Shutdown_files>
[zsh-org]: <https://www.zsh.org/>
[zsh-download]: <https://zsh.sourceforge.io/Arc/source.html>
[zsh-intro-doc]: <https://zsh.sourceforge.io/Intro/intro_toc.html>
[zsh-faq]: <https://zsh.sourceforge.io/FAQ/>
[zsh-manual-toc]: <https://zsh.sourceforge.io/Doc/Release/zsh_toc.html>
[zsh-user-guide-toc]: <https://zsh.sourceforge.io/Guide/zshguide.html>
