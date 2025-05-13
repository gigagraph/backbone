# Java

## JDK distribution selection

[OpenJDK][wiki-openjdk] is the most popular free and open-source implemention of the Java Platform. The most important components of the Java ecosystem that it includes are the java compiler (`javac`), java virtual machine (JVM) - a runtime environemnt that executes Java bytecode on a target processor, and the Java Class Library.

Different vendors provide OpenJDK builds that users can install to run and develop JVM-based applications. Find a comprehensive comparison list of OpenJDK builds from known vendors [here][compare-jdks].

This guide recommends installing and using [Adoptium Temurin OpenJDK builds][adoptium-temurin-releases]. These builds are free, production ready, and well-maintained.

## Installation

This guide recommends installing both [`sdkman`](#sdkman-installation) and [`temurin` directly on your using system](#install-temurin-openjdk-build-via-system-package-manager).

### [`sdkman`][sdkman] installation

Download `sdkman` setup script for your system from [the official website](https://get.sdkman.io):

```bash
GET_SDKMAN_TARGET_PATH="./getsdkman.sh"

curl -sSfo "${GET_SDKMAN_TARGET_PATH}" "https://get.sdkman.io"
chmod +x "${GET_SDKMAN_TARGET_PATH}"
```

Run the installer:

```bash
"${GET_SDKMAN_TARGET_PATH}"
```

Due to the [performance issues when sourcing `sdkman` during shell startup](https://github.com/sdkman/sdkman-cli/issues/977), this guide recommends lazy-loading `sdkman` in your shell's `rc` file.

> [!IMPORTANT]
>
> Remove `sdkman`'s initialization in all your shells' `rc` files.
>
> ```bash
> grep --line-number "sdkman-init.sh" "${HOME}/.bashrc"
> grep --line-number "sdkman-init.sh" "${ZDOTDIR:-${HOME}}/.zshrc"
> # check rc files for other shells
> ```

Add the following lazy-loading script to your shell's `rc` file:

```bash
export SDKMAN_DIR="${SDKMAN_DIR:-${HOME}/.sdkman}"

sdk() {
  local SDKMAN_INIT_SCRIPT_PATH="${SDKMAN_DIR}/bin/sdkman-init.sh"

  if [[ -s "${SDKMAN_INIT_SCRIPT_PATH}" ]]; then
    unset -f sdk
    source "${SDKMAN_INIT_SCRIPT_PATH}"
    sdk "$@"
  else
    echo "Error: could not initialize sdkman, because sdkman init script does not exist at the existed path: '${SDKMAN_INIT_SCRIPT_PATH}'."
    exit 1
  fi
}
```

> [!NOTE]
>
> With the lazy-loading approach, toolchains that `sdkman` manages will not be available unitl users explicitly initialize `sdkman` for the first time in a new shell session:
>
> ```bash
> sdk
> ```

#### `sdkman` completions

##### `zsh` completions for `sdkman`

Run `sdk config` and set `sdkman_auto_complete` to `true`. This will make the initialization script to initialize completions for the `sdk` command.

### Temurin installation

#### Install Temurin OpenJDK build via [`sdkman`](#sdkman)

Run the following command to install Temurin OpenJDK build via `sdkman`:

```bash
sdk install java "${TEMURIN_JDK_VERSION}-tem"
```

##### Switch between system Java installation

```bash
sdk use tool "${TOOL_VERSION}"
```

#### Install Temurin OpenJDK build via system package manager

This guide recommends [installing Temurin OpenJDK build][adoptium-temurin-installation] using your system's package manager and [switching versions using your system/environment's default method for JDK management](#switch-between-java-versions).

The following instruction are based on the [official Temurin installation instrucitons for Linux distributions][adoptium-temurin-installation-linux].

Install the dependencies:

```bash
sudo apt install -y \
  wget \
  apt-transport-https
```

Import the repository GPG key:

```bash
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public |
  gpg --dearmor |
  sudo tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
```

Add apt repositories:

```bash
UBUNTU_CODENAME="$(lsb_release -sc 2>/dev/null)"

sudo tee "/etc/apt/sources.list.d/adoptium-${UBUNTU_CODENAME}.list" <<EOF
deb https://packages.adoptium.net/artifactory/deb ${UBUNTU_CODENAME} main
EOF
```

Install the desired version of temurin (`TEMURIN_VERSION`):

```bash
sudo apt update -y
sudo apt install -y "temurin-${TEMURIN_VERSION}-jdk"
```

##### Switch between system Java installation

When installing [Temurin OpenJDK on Ubuntu using Temurin's apt packages](#temurin-installation), the users can switch between java versions using `update-alternatives`:

```bash
sudo update-alternatives --config java
```

### Other tools installation

In addition to java distribution, this guide recommends installing the following tools using `sdkman` to work with java projects:

```bash
sdk install maven
```

## Useful links

- [wiki-openjdk][wiki-openjdk]
- [compare-jdks][compare-jdks]
- [github-openjdk][github-openjdk]
- [adoptium-temurin-releases][adoptium-temurin-releases]
- [adoptium-temurin-installation][adoptium-temurin-installation]
  - [adoptium-temurin-installation-linux][adoptium-temurin-installation-linux]
- [sdkman][sdkman]
- [sdkman-installation][sdkman-installation]
- [sdkman-usage][sdkman-usage]

[wiki-openjdk]: https://en.wikipedia.org/wiki/OpenJDK
[compare-jdks]: https://jdkcomparison.com
[github-openjdk]: https://github.com/openjdk/jdk
[adoptium-temurin-releases]: https://adoptium.net/temurin/releases
[adoptium-temurin-installation]: https://adoptium.net/installation/
[adoptium-temurin-installation-linux]: https://adoptium.net/installation/linux/
[sdkman]: https://sdkman.io/
[sdkman-installation]: https://sdkman.io/install
[sdkman-usage]: https://sdkman.io/usage/
