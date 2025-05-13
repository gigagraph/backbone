# Java

[OpenJDK][wiki-openjdk] is the most popular free and open-source implemention of the Java Platform. The most important components of the Java ecosystem that it includes are the java compiler (`javac`), java virtual machine (JVM) - a runtime environemnt that executes Java bytecode on a target processor, and the Java Class Library.

Different vendors provide OpenJDK builds that users can install to run and develop JVM-based applications. Find a comprehensive comparison list of OpenJDK builds from known vendors [here][compare-jdks].

This guide recommends installing and using [Adoptium Temurin OpenJDK builds][adoptium-temurin-releases]. These builds are free, production ready, and well-maintained.

## Temurin installation

This guide recommends [installing Temurin OpenJDK build][adoptium-temurin-installation] using your system's package manager and [switching versions using your system/environment's default method for JDK management][switch-between-java-versions].

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

## Switch between Java versions

When installing [Temurin OpenJDK on Ubuntu using Temurin's apt packages](#temurin-installation), the users can switch between java versions using `update-alternatives`:

```bash
sudo update-alternatives --config java
```

## Useful links

- [wiki-openjdk][wiki-openjdk]
- [compare-jdks][compare-jdks]
- [github-openjdk][github-openjdk]
- [adoptium-temurin-releases][adoptium-temurin-releases]
- [adoptium-temurin-installation][adoptium-temurin-installation]
  - [adoptium-temurin-installation-linux][adoptium-temurin-installation-linux]

[wiki-openjdk]: https://en.wikipedia.org/wiki/OpenJDK
[compare-jdks]: https://jdkcomparison.com
[github-openjdk]: https://github.com/openjdk/jdk
[adoptium-temurin-releases]: https://adoptium.net/temurin/releases
[adoptium-temurin-installation]: https://adoptium.net/installation/
[adoptium-temurin-installation-linux]: https://adoptium.net/installation/linux/
