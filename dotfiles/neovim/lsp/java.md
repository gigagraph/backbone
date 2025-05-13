# Java

## [`java_language_server`][java-language-server] installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Java](../../../system-setup/toolchains/java/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends [installing `java_language_server` from sources following the offical instuctions][java-language-server-installation].

Clone the repo and checkout the latest stable version:

```bash
git clone git@github.com:georgewfraser/java-language-server.git
cd java-language-server
git checkout "${JAVA_LANGUAGE_SERVER_VERSION}"
```

Build the project:

```bash
./scripts/download_linux_jdk.sh
env PATH="$(realpath jdks/linux/jdk-*/bin):${PATH}" ./scripts/link_linux.sh
mvn package -DskipTests
```

Create a launcher script on the path, so that `java-language-server` can be run as if it was a normal binary/script:

```bash
JAVA_LSP_BIN_PATH="/usr/local/bin/java-language-server"
cat << EOF | sudo tee "${JAVA_LSP_BIN_PATH}"
#!/usr/bin/env bash
BASE_JAVA_LSP_SOURCE_DIR="$(pwd)"

JAVA_LSP_LANUCH_SCRIPT="\${BASE_JAVA_LSP_SOURCE_DIR}/dist/lang_server_linux.sh"

env PATH="\$(realpath jdks/linux/jdk-*/bin):\${PATH}" "\${JAVA_LSP_LANUCH_SCRIPT}" "\${@}"
EOF
sudo chmod +x "${JAVA_LSP_BIN_PATH}"
```

> [!NOTE]
>
> `java_language_server` LSP server may call other tools at runtime, e.g. `maven`. If these tools are not available on the `PATH`, the sever will crash. Ensure that these tools are present on the `PATH` for successful server execution.
>
> For example, if you initialzie `sdkman` lazily, the `mvn` may not be on your `PATH` until you initialize `sdkman` explictly. In this case, ensure that `sdkman` is intialized, e.g.: `sdk version`.

## [`jdtls`][jdtls] installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Java](../../../system-setup/toolchains/java/README.md).
> - [Python](../../../system-setup/toolchains/python/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

This guide recommends [installing `jdtls` from sources following the offical instuctions][jdtls-installation].

Clone the repo and checkout the latest stable version:

```bash
git clone git@github.com:eclipse-jdtls/eclipse.jdt.ls.git
cd eclipse.jdt.ls
git checkout "${JDTLS_VERSION}"
```

Ensure that the required version of `java` is installaed for the build:

```bash
JDTLS_JAVA_VERSION="$(sed -n '/^Requirements$/,/\*\*Java [0-9]*\*\*/p' README.md | rg  --max-count=1 -o '\*\*Java \d+\*\*' | rg -o '\d+')"
sdk install java "${JDTLS_JAVA_VERSION}-tem"
```

Build the project:

```bash
JAVA_HOME="$(sdk home java "${JDTLS_JAVA_VERSION}-tem")" ./mvnw clean verify -U -DskipTests=true
```

Create a launcher script on the path, so that `jdtls` can be run as if it was a normal binary/script:

```bash
JDTLS_BIN_PATH="/usr/local/bin/jdtls"
cat << EOF | sudo tee "${JDTLS_BIN_PATH}"
#!/usr/bin/env bash

JDTLS_BUILD_REPOSITORY_DIR="$(pwd)/org.eclipse.jdt.ls.product/target/repository"

env \\
  "JAVA_HOME=$(sdk home java "${JDTLS_JAVA_VERSION}-tem")" \\
  'JVM_ARGS=-Djava.telemetry.enabled=false' \\
    "\${JDTLS_BUILD_REPOSITORY_DIR}/bin/jdtls" \\
      -configuration "\${JDTLS_BUILD_REPOSITORY_DIR}/config_linux" \\
      \\
      "\${@}"
EOF
sudo chmod +x "${JDTLS_BIN_PATH}"
```

## Useful link

- [java-language-server][java-language-server]
- [java-language-server-installation][java-language-server-installation]
- [java-lang-and-vm-spec][java-lang-and-vm-spec]
- [jdtls][jdtls]
- [jdtls-github][jdtls-github]
- [jdtls-installation][jdtls-installation]
- [nvim-jdtls][nvim-jdtls]

[java-language-server]: https://github.com/georgewfraser/java-language-server
[java-language-server-installation]: https://github.com/georgewfraser/java-language-server/tree/master#installation-other-editors
[java-lang-and-vm-spec]: https://docs.oracle.com/javase/specs/
[jdtls]: https://projects.eclipse.org/projects/eclipse.jdt.ls
[jdtls-github]: https://github.com/eclipse-jdtls/eclipse.jdt.ls
[jdtls-installation]: https://github.com/eclipse-jdtls/eclipse.jdt.ls#installation
[nvim-jdtls]: https://github.com/mfussenegger/nvim-jdtls
