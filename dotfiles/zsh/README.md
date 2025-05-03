# ZSH

## Installation

> [!NOTE]
>
> It is better to use the system native C toolchain to compile zsh from sources. Otherwise, the shell may be hanging in certain scenarios. E.g. with Clang 18 on Ubuntu a test was failing by just hanging the shell. With GCC on the same system everything worked fine.

[Download source distribution of zsh][zsh-download], unpack it, and open the terminal in the directory.

Alternatively, you can clone the sources:

```bash
git clone git://git.code.sf.net/p/zsh/code zsh
cd ./zsh
git checkout "${ZSH_VERSION}"
```

Install the build dependencies:

```bash
sudo apt update -y
sudo apt install -y \
  yodl \
  perl \
  info texinfo texinfo-lib install-info
```

> [!NOTE]
> If you checked the repo from git run `./Util/preconfig`. Otherwise, skip it.
>
> ```bash
> ./Util/preconfig
> ```

Configure the build:

```bash
mkdir ./build
../configure --enable-cflags="-O2"
```

Build and test:

```bash
make
make check
```

> [!NOTE]
>
> If something goes wrong with the build, run `make distclean` to remove everything that the `./configure` script generated.

After the build and tests successful completion, intsall zsh:

```bash
sudo make install
sudo make install.info
```

### Source `/etc/profile` from `/etc/zsh/zprofile`

> [!IMPORTANT]
>
> [`/etc/profile` file should be sourced by all POSIX sh-compatible shells upon login][arch-wiki-startup-shutdown-files].

```bash
sudo mkdir -p /etc/zsh
sudo echo ". /etc/profile" | sudo tee -a /etc/zsh/zprofile
```

### Set zsh as a default login shell

Ensure `zsh` is present in `/etc/shells`:

```bash
ZSH_PATH="$(which zsh)"; [[ -z "$(cat /etc/shells | grep "${ZSH_PATH}")" ]] && (echo "${ZSH_PATH}" | sudo tee -a /etc/shells) || echo "${ZSH_PATH} is already present in /etc/shells"
```

Set zsh as [default login shell][arch-wiki-change-default-shell]:

> [!NOTE]
>
> As per default PAM configuration, ensure that the shell you run this command from is listed in `/etc/shells`.

```bash
sudo chsh -s "$(which zsh)" "${USER}"
```

## Configuration

> [!NOTE]
>
> Ensure you have the following tools installed because the config depends on their avaialbility:
> - [`yq`](../../dotfiles/terminal-utils/yq/REAMDE.md).

Setup config from this repo on your system:

```bash
./setup-config.sh
```

For a reference, see the [description of startup and shutdown files for zsh][arch-wiki-startup-shutdown-files]. Visally it looks as follows:

![Well-known shells startup and shutdown files](./img/shell-startup-actual.png)

### Prompt

#### Pure prompt

[Pure prompt][github-pure-prompt] is a promp implemented it zsh. It's features include, displaying:
- The current working direcotry.
- Basic information about the changes in git.
- The status of the zle vi mode.
- Time it took to execute the repious command.

It is not customizable compared to the alternatives, such as [powerlevel10k][github-p10k] or [startship](../deprecated/starship/README.md), however its main advantage is that it is maintained and fast.

Install it to the custom plugin directory (`$ZSH_CUSTOM_PLUGINS_DIR`) and activate it by adding the following commands to `.zshrc`.

```bash
if [ ! -e "${ZSH_CUSTOM_PLUGINS_DIR}/pure-prompt" ]; then
  git clone --branch="v1.23.0" --depth=1 git@github.com:sindresorhus/pure.git "${ZSH_CUSTOM_PLUGINS_DIR}/pure-prompt"
  zcompile-many "${ZSH_CUSTOM_PLUGINS_DIR}"/pure-prompt/{pure.zsh,async.zsh}
fi
fpath+=("${ZSH_CUSTOM_PLUGINS_DIR}/pure-prompt")

autoload -U promptinit; promptinit
prompt pure
```

### Plugins

This guide sets up the following plugins:

- [`fast-syntax-highlighting`](#fast-syntax-highlighting)
- [`zsh-autosuggestions`](#zsh-autosuggestions)
- [`zsh-completions`][github-zsh-completions]
- [`rust-zsh-completions`][github-rust-zsh-completions]
- [`fzf-tab`](#use-fzf-to-match-completions-via-fzf-tab)
- [`fzf-git`](#use-fzf-to-search-for-git-objects-via-fzf-git)

Additionally, see the [Integrations](#integrations) section to setup zsh to work with other tools.

#### Note on plugin installation

This guide targets zsh setup to have a decent performance. As per [`zsh-bench`][github-zsh-bench] the fastest way to install and activate plugins is to manually download the plugin (if it is not present), compile it using `zcompile` (if it hasn't been compiled previously), and activate it. `zsh-bench` calls this setup [`diy++`](https://github.com/romkatv/zsh-bench?tab=readme-ov-file#do-it-yourself). After the measurements, this guide decided to go with this approach for plugin management. For more details, see the [Benchmarking](#benchmarking) section for more details.

In general, the `diy++` plugin instalaltion is as follows.

`.zshrc` defines the following function. The method will use it to compile zsh files:

```bash
function zcompile-many() {
  local f
  for f; do zcompile -R -- "$f".zwc "$f"; done
}
```

User clones the plugin to its directory if it does not exist (e.g. `fzf-tab` in this case) and compiles all zsh files in the repository using the `zcompile-many` function:

```bash
if [ ! -e "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-tab" ]; then
  git clone --branch="v1.1.2" --depth=1 git@github.com:Aloxaf/fzf-tab.git "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-tab"
  zcompile-many "${ZSH_CUSTOM_PLUGINS_DIR}"/fzf-tab/{fzf-tab.plugin.zsh,fzf-tab.zsh,lib/**/*.zsh}
fi
```

Then, based on the purpose of the plugin the user should use the files to make them available to zsh. Generally, this means that they should `source` `.plugin.zsh` file in the correct place. See the [`./config/zsh/.zshrc`](./config/zsh/.zshrc) for more examples.

#### `fast-syntax-highlighting`

> [!NOTE]
>
> You should source this plugin at the end of `.zshrc`, after [`fzf-tab`](#use-fzf-to-match-completions-via-fzf-tab) and before [`zsh-autosuggestion`](#zsh-autosuggestions) if you use it.

```bash
if [ ! -e "${ZSH_CUSTOM_PLUGINS_DIR}/fast-syntax-highlighting" ]; then
  git clone git@github.com:zdharma-continuum/fast-syntax-highlighting.git "${ZSH_CUSTOM_PLUGINS_DIR}/fast-syntax-highlighting"
  git -C "${ZSH_CUSTOM_PLUGINS_DIR}/fast-syntax-highlighting" checkout '<fast-syntax-highlighting-commit-sha>' 
  zcompile-many "${ZSH_CUSTOM_PLUGINS_DIR}"/fast-syntax-highlighting/{fast-syntax-highlighting.plugin.zsh,fast-highlight,fast-string-highlight,fast-theme,share/**/*.zsh}
fi
```

Then, make sure your `.zshrc` contains the following:

```bash
source "${ZSH_CUSTOM_PLUGINS_DIR}/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
```

> [!NOTE]
>
> If you use:
> - [`zsh-vi-mode`][github-zsh-vi-mode], source `fast-syntax-highlighting` after it.
> - [`fzf-tab`](#use-fzf-to-match-completions-via-fzf-tab), source `fast-syntax-highlighting` after it.
> - [`zsh-autosuggestion`](#zsh-autosuggestions), source `fast-syntax-highlighting` before it.

##### `fast-syntax-highlighting` theming

Users can customize `fast-syntax-highlighting`'s theme. E.g. there is [Catpuccin theme][github-catpuccin-zsh-fsh] for the plugin.

[Users can implement and set custom themes using the `fast-theme` command][fast-syntax-highlighting-theming] when the plugin is activated.

#### `zsh-autosuggestions`

##### `zsh-autosuggestions` installation

> [!NOTE]
>
> You should source this plugin at the end of `.zshrc`.

```bash
if [ ! -e "${ZSH_CUSTOM_PLUGINS_DIR}/zsh-autosuggestions" ]; then
  git clone --branch="<zsh-autosuggestions-version>" --depth=1 git@github.com:zsh-users/zsh-autosuggestions.git "${ZSH_CUSTOM_PLUGINS_DIR}/zsh-autosuggestions"
  zcompile-many "${ZSH_CUSTOM_PLUGINS_DIR}"/zsh-autosuggestions/{zsh-autosuggestions.zsh,src/**/*.zsh}
fi
```

Then, make sure your `.zshrc` contains the following:

```bash
source "${ZSH_CUSTOM_PLUGINS_DIR}/zsh-autosuggestions/zsh-autosuggestions.zsh"
```

> [!NOTE]
>
> If you use [`zsh-syntax-highlighting`](#zsh-syntax-highlighting) or [`fast-syntax-highlighting`](#fast-syntax-highlighting), source `zsh-autosuggestions` after it.

### Integrations

#### `fzf`

Before proceeding, [ensure that you have `fzf` installed on your system](../terminal-utils/fzf/README.md#installation).

##### `fzf` shell integration for zsh

> [!NOTE]
>
> For security reasons, this guide recommends to statically save the integration script to a file that you will load from your `.zshrc`. This also means that it is best to use `fzf` to update this script every time you update `fzf`.

```bash
fzf "--${SHELL##*/}" > "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-integration.zsh"
```

Then, make sure your `.zshrc` contains the following:

```bash
if [[ "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-integration.zsh" -nt "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-integration.zsh.zwc" ]]; then
  zcompile-many "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-integration.zsh"
fi

source "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-integration.zsh"
```

After you set up the integration, you can use the [following keys to use `fzf` to peform common tasks in the interactive shell][fzf-shell-integration] (in the default configuration):

- `CTRL-T` - opens a prompt where the user can search and select files under the current working directory. After the confirmation, the shell integration will **insert the selected files in the current command**.
- `ALT-Q` (rebound from the original ALT-C) - opens a prompt where the user can search and select directories under the current working directory. After the confirmation, the shell integration will **change the current working directory to the selected one**.
- `CRTL-R` - opens a prompt where the user can search the command history. After the configmation, the shell integration will insert the selected command in the current prompt.

##### Use `fzf` to match completions via `fzf-tab`

###### `fzf-tab` installation

> [!NOTE]
>
> `fzf-tab` must be sourced after the `compinit` but before plugins that wrap widgets (e.g. [`zsh-autosuggestion`](#zsh-autosuggestion)).

```bash
if [ ! -e "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-tab" ]; then
  git clone --branch="<fzf-tab-version>" --depth=1 git@github.com:Aloxaf/fzf-tab.git "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-tab"
  zcompile-many "${ZSH_CUSTOM_PLUGINS_DIR}"/fzf-tab/{fzf-tab.plugin.zsh,fzf-tab.zsh,lib/**/*.zsh}
fi
```

> [!IMPORTANT]
>
> Make sure you source the plugin after `compinit`, but before [`zsh-autosuggestions`](#zsh-autosuggestions).

Then, make sure your `.zshrc` contains the following configuration after `compinit`, but before [`zsh-autosuggestions`](#zsh-autosuggestions):

```bash
source "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-tab/fzf-tab.plugin.zsh"
```

- [ ] TODO?
    - ```bash
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color "${realpath}"'
      ```

##### Use `fzf` to search for git objects via `fzf-git`

###### `fzf-git` installation

Make sure your `.zshrc` contains the following:

```bash
if [ ! -e "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-git" ]; then
  git clone git@github.com:junegunn/fzf-git.sh.git "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-git"
  git -C "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-git" checkout '<fzf-git-commit-sha>'
  zcompile-many "${ZSH_CUSTOM_PLUGINS_DIR}"/fzf-git/fzf-git.sh
fi

source "${ZSH_CUSTOM_PLUGINS_DIR}/fzf-git/fzf-git.sh"
```

#### `ripgrep`

Before proceeding, [ensure that you have `ripgrep` installed on your system](../terminal-utils/ripgrep/README.md#installation).

##### `ripgrep` shell completions

Use `ripgrep` to generate completions for zsh:

```bash
rg --generate "complete-${SHELL##*/}" > "${ZSH_COMPLETIONS_DIR}/_rg"
```

After you generated the completions, ensure that the directory with the `_rg` completions file is on your zsh `fpath`.

#### `eza`

Before proceeding, [ensure that you have `eza` installed on your system](../terminal-utils/eza/README.md#installation).

##### `eza` shell completions

Clone the eza repo locally:

```bash
git clone git@github.com:eza-community/eza.git
cd eza
git checkout "${EZA_VERSION}"
```

Copy the completions from the `eza` repo:

```bash
cp "$(pwd)/completions/zsh/_eza" "${ZSH_COMPLETIONS_DIR}/_eza"
sed 's/__eza/_eza/g' --in-place "${ZSH_COMPLETIONS_DIR}/_eza"
```

#### `zoxide`

Before proceeding, [ensure that you have `zoxide` installed on your system](../terminal-utils/zoxide/README.md#installation).

##### `zoxide` shell integration

> [!NOTE]
>
> For security reasons, this guide recommends to statically save the integration script to a file that you will load from your `.zshrc`. This also means that it is best to use `zoxide` to update this script every time you update `zoxide`.

If you want to configure `zoxide`, set the environment variables before running the following command. If you want to reconfigure `zoxide` - set the envs and rerun the commands.

```bash
zoxide init "${SHELL##*/}" > "${ZSH_CUSTOM_PLUGINS_DIR}/zoxide-integration.zsh"
```

Then, make sure your `.zshrc` contains the following configuration **after the `compinit`**:

```bash
[ -f "${ZSH_CUSTOM_PLUGINS_DIR}/zoxide-integration.zsh" ] && source "${ZSH_CUSTOM_PLUGINS_DIR}/zoxide-integration.zsh"
```

> [!NOTE]
>
> For completions to work, the above line must be added after compinit is called. You may have to rebuild your completions cache by running `rm ~/.zcompdump*; compinit`.

#### `bat`

##### `bat` completions

This guide assumes you followed the [instructions from this repo and inslled `bat` from sources](../terminal-utils/bat/README.md#installation). After the build, the target directory should now have the completions script. Copy it to where you install custom completions (`$ZSH_COMPLETIONS_DIR` in this guide):

```bash
cp ./target/release/build/bat-*/**/completions/bat."${SHELL##*/}" "${ZSH_COMPLETIONS_DIR}/_bat"
```

##### `bat-extras` completions

Unfortunately, [`bat-extras`](../terminal-utils/bat/README.nd#install-bat-extras) does not come with the completions. The best effort that the user can do to enable the completions is to configure zsh to use completions for the commands that `bat-extras` wrap. Add the following after `compinit`:

```bash
compdef batdiff=diff
compdef batwatch=watch
compdef batgrep=rg
```

> [!NOTE]
>
> This method may still not enable completions for some `bat-extras` commands.

#### `delta`

##### `delta` completions

[Use `delta` to generate completions for zsh](https://dandavison.github.io/delta/tips-and-tricks/shell-completion.html):

```bash
delta --generate-completion "${SHELL##*/}" > "${ZSH_COMPLETIONS_DIR}/_delta"
```

#### `fd`

##### `fd` completions

This guide assumes you followed the [instructions from this repo and inslled `fd` from sources](../terminal-utils/fd/README.md#installation). The completion script resides under `contrib/completion`. Copy it to where you install custom completions (`$ZSH_COMPLETIONS_DIR` in this guide):

```bash
cp ./contrib/completion/_fd "${ZSH_COMPLETIONS_DIR}/_fd"
```

#### [`tree-sitter`](../../system-setup/toolchains/tree-sitter/README.md)

##### `tree-sitter` completions

```bash
tree-sitter complete --shell="${SHELL##*/}" > "${ZSH_COMPLETIONS_DIR}/_tree-sitter"
```

#### [`fnm`](../../system-setup/toolchains/fnm/README.md)

##### `fnm` completions

Use `fnm` to generate completions for zsh:

```bash
fnm completions --shell "${SHELL##*/}" > "${ZSH_COMPLETIONS_DIR}/_fnm"
```

After you generated the completions, ensure that the directory with the `_fnm` completions file is on your zsh `fpath`.

#### [`yq`](../../system-setup/toolchains/yq/README.md)

##### `yq` completions

Use `yq` to generate completions for zsh:

```bash
yq shell-completion "${SHELL##*/}" > "${ZSH_COMPLETIONS_DIR}/_yq"
```

After you generated the completions, ensure that the directory with the `_yq` completions file is on your zsh `fpath`.

#### Deprecated plugins

##### `zsh-vi-mode`

❌Not recommended. Use the standard vi mode in zsh instead.❌

> [!WARNING]
>
> This guide does not recommend to use `zsh-vi-mode` due to how it reduces the performance of the shell.

[Configuration & default keybindings docs][github-zsh-vi-mode].

> [!NOTE]
>
> This guide recommends to use `ZVM_INIT_MODE=sourcing`. You should setup custom keybindings with `zvm_after_init_commands` and `zvm_after_lazy_keybindings_commands` respoctively. Additionally, you should initialize this plugin before [fzf integration](#fzf), [`fzf-tab`](#use-fzf-to-match-completions-via-fzf-tab), and [`zsh-autosuggestions`](#zsh-autosuggestions). The guide recommends to initialize thees plugins in the specified order after the `zsh-vi-mode` directly in `.zshrc` file. Do not use `zvm_after_init_commands` to initialize these plugins.

##### `zsh-syntax-highlighting`

❌Not recommended. Use [`fast-syntax-highlighting`](#fast-syntax-highlighting) instead.❌

> [!WARNING]
>
> This guide does not recommend to use `zsh-syntax-highlighting` due to incompatibility with [`zsh-vi-mode`](#zsh-vi-mode). For more details see this issue: https://github.com/zsh-users/zsh-syntax-highlighting/issues/871

######  `zsh-syntax-highlighting` installation

> [!NOTE]
>
> If you decide to to install [`zsh-syntax-highlighting`][github-zsh-syntax-highlighting], the guide recommends that you do this manually, because it should be sourced at the end of `.zshrc`.

```bash
mkdir -p "${ZSH_CUSTOM_PLUGINS_DIR}/zsh-syntax-highlighting"
git clone --branch "${ZSH_SYNTAX_HIGHLIGHTING_VERSION}" git@github.com:zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM_PLUGINS_DIR}/zsh-syntax-highlighting"
```

Then, make sure your `.zshrc` contains the following configuration:

```bash
[ -f "${ZSH_CUSTOM_PLUGINS_DIR}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "${ZSH_CUSTOM_PLUGINS_DIR}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
```

### Benchmarking

This guide recommends using [`zsh-bench`][github-zsh-bench] to benchmark the shell performance. Follow the instructions from the project's README to measure the performance you a zsh setup and to understand how to improve it.

This guide recommends not exceeding the same numbers as mentioned in `zsh-bench`, i.e.:

| latency (ms)          | the maximum value indistinguishable from zero |
|-----------------------|----------------------------------------------:|
| **first prompt lag**  |                                            50 |
| **first command lag** |                                           150 |
| **command lag**       |                                            10 |
| **input lag**         |                                            20 |

#### Benchmarking tips

The metrics that `zsh-bench` outputs are insufficeint to understand how to improve the performance. Instead, it could be useful to see how much time each plugin takes when it initializes. zsh has a tool for that - [`zprof`](https://zsh.sourceforge.io/Doc/Release/Zsh-Modules.html#The-zsh_002fzprof-Module).

To use `zprof`, add the following to the start of `.zshrc`:

```bash
zmodload zsh/zprof
```

And the following at the end:

```bash
zprof
```

When you start a new shell `zprof` will print the amount of time and the percentage it spent in each function while executing `.zshrc`.

Another helpful profiling technique is to disable a plugin and see how `zsh-bench` metrics change.

#### Optimization tips

To optimize zsh startup and usage performance, follow the [`diy++` installation scheme](#note-on-plugin-installation).

## Useful links

- [arch-wiki-change-default-shell][arch-wiki-change-default-shell]
- [arch-wiki-startup-shutdown-files][arch-wiki-startup-shutdown-files]
- [zsh-org][zsh-org]
  - [zsh-download][zsh-download]
  - Docs
    - [zsh-intro-doc][zsh-intro-doc]
    - [zsh-faq][zsh-faq]
    - [zsh-manual-toc][zsh-manual-toc]
      - [zsh-options][zsh-options]
    - [zsh-user-guide-toc][zsh-user-guide-toc]
- [youtube-zsh-dream-of-autonomy][youtube-zsh-dream-of-autonomy]
- [github-pure-prompt][github-pure-prompt]
- [github-zsh-vi-mode][github-zsh-vi-mode]
- [github-fast-syntax-highlighting][github-fast-syntax-highlighting]
  - [fast-syntax-highlighting-theming][fast-syntax-highlighting-theming]
  - [github-catpuccin-zsh-fsh][github-catpuccin-zsh-fsh]
- [github-zsh-syntax-highlighting][github-zsh-syntax-highlighting]
- [github-zsh-autosuggestions][github-zsh-autosuggestions]
- [github-rust-zsh-completions][github-rust-zsh-completions]
- [github-zsh-completions][github-zsh-completions]
- [github-zsh-bench][github-zsh-bench]
- [fzf-shell-integration][fzf-shell-integration]
- [github-fzf-tab][github-fzf-tab]
- [github-fzf-git][github-fzf-git]
- [github-fzf-alt-c-in-vi-mode][github-fzf-alt-c-in-vi-mode]
- [github-p10k][github-p10k]

[arch-wiki-change-default-shell]: <https://wiki.archlinux.org/title/Command-line_shell#Changing_your_default_shell>
[arch-wiki-startup-shutdown-files]: <https://wiki.archlinux.org/title/Zsh#Startup/Shutdown_files>
[zsh-org]: <https://www.zsh.org/>
[zsh-download]: <https://zsh.sourceforge.io/Arc/source.html>
[zsh-intro-doc]: <https://zsh.sourceforge.io/Intro/intro_toc.html>
[zsh-faq]: <https://zsh.sourceforge.io/FAQ/>
[zsh-manual-toc]: <https://zsh.sourceforge.io/Doc/Release/zsh_toc.html>
[zsh-options]: <https://zsh.sourceforge.io/Doc/Release/Options.html>
[zsh-user-guide-toc]: <https://zsh.sourceforge.io/Guide/zshguide.html>
[youtube-zsh-dream-of-autonomy]: <https://www.youtube.com/watch?v=ud7YxC33Z3w>
[github-pure-prompt]: <https://github.com/sindresorhus/pure>
[github-zsh-vi-mode]: <https://github.com/jeffreytse/zsh-vi-mode>
[github-fast-syntax-highlighting]: <https://github.com/zdharma-continuum/fast-syntax-highlighting>
[fast-syntax-highlighting-theming]: <https://github.com/zdharma-continuum/fast-syntax-highlighting/blob/v1.55/THEME_GUIDE.md>
[github-catpuccin-zsh-fsh]: <https://github.com/catppuccin/zsh-fsh>
[github-zsh-syntax-highlighting]: <https://github.com/zsh-users/zsh-syntax-highlighting>
[github-zsh-autosuggestions]: <https://github.com/zsh-users/zsh-autosuggestions>
[github-zsh-completions]: <https://github.com/zsh-users/zsh-completions/tree/master>
[github-rust-zsh-completions]: <https://github.com/ryutok/rust-zsh-completions>
[github-zsh-bench]: <https://github.com/romkatv/zsh-bench>
[fzf-shell-integration]: <https://junegunn.github.io/fzf/shell-integration/>
[github-fzf-tab]: <https://github.com/Aloxaf/fzf-tab>
[github-fzf-git]: <https://github.com/junegunn/fzf-git.sh>
[github-fzf-alt-c-in-vi-mode]: <https://github.com/junegunn/fzf/issues/1238>
[github-p10k]: <https://github.com/romkatv/powerlevel10k>
