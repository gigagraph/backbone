# LLVM Toolchain

## Installation

Follow the [official instructions for apt to install LLVM][apt-llvm].

Import the repository GPG key

```bash
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc > /dev/null
sudo chmod a+r /etc/apt/trusted.gpg.d/apt.llvm.org.asc
```

Set the desired major LLVM version with the `LLVM_VERSION` variable and add apt repositories:

```bash
UBUNTU_CODENAME="$(lsb_release -sc 2>/dev/null)"
LLVM_VERSION="18"

sudo tee "/etc/apt/sources.list.d/llvm-toolchain-${LLVM_VERSION}-${UBUNTU_CODENAME}.list" <<EOF
deb http://apt.llvm.org/${UBUNTU_CODENAME}/ llvm-toolchain-${UBUNTU_CODENAME}-${LLVM_VERSION} main
deb-src http://apt.llvm.org/${UBUNTU_CODENAME}/ llvm-toolchain-${UBUNTU_CODENAME}-${LLVM_VERSION} main
EOF
```

Install all LLVM tools.

Option 1. Set the version in the `./install-llvm-all.sh` and run it:

```bash
vi ./intall-llvm-all.sh
./install-llvm-all.sh
```

Or install individual components:

```bash
# LLVM
sudo apt install libllvm-${LLVM_VERSION}-ocaml-dev libllvm${LLVM_VERSION} llvm-${LLVM_VERSION} llvm-${LLVM_VERSION}-dev llvm-${LLVM_VERSION}-doc llvm-${LLVM_VERSION}-examples llvm-${LLVM_VERSION}-runtime
# Clang and co
sudo apt install clang-${LLVM_VERSION} clang-tools-${LLVM_VERSION} clang-${LLVM_VERSION}-doc libclang-common-${LLVM_VERSION}-dev libclang-${LLVM_VERSION}-dev libclang1-${LLVM_VERSION} clang-format-${LLVM_VERSION} python3-clang-${LLVM_VERSION} clangd-${LLVM_VERSION} clang-tidy-${LLVM_VERSION}
# compiler-rt
sudo apt install libclang-rt-${LLVM_VERSION}-dev
# polly
sudo apt install libpolly-${LLVM_VERSION}-dev
# libfuzzer
sudo apt install libfuzzer-${LLVM_VERSION}-dev
# lldb
suod apt install lldb-${LLVM_VERSION}
# lld (linker)
sudo apt install lld-${LLVM_VERSION}
# libc++
sudo apt install libc++-${LLVM_VERSION}-dev libc++abi-${LLVM_VERSION}-dev
# OpenMP
sudo apt install libomp-${LLVM_VERSION}-dev
# libclc
sudo apt install libclc-${LLVM_VERSION}-dev
# libunwind
sudo apt install libunwind-${LLVM_VERSION}-dev
# mlir
sudo apt install libmlir-${LLVM_VERSION}-dev mlir-${LLVM_VERSION}-tools
# bolt
sudo apt install libbolt-${LLVM_VERSION}-dev bolt-${LLVM_VERSION}
# flang
sudo apt install flang-${LLVM_VERSION}
# wasm support
sudo apt install libclang-rt-${LLVM_VERSION}-dev-wasm32 libclang-rt-${LLVM_VERSION}-dev-wasm64 libc++-${LLVM_VERSION}-dev-wasm32 libc++abi-${LLVM_VERSION}-dev-wasm32 libclang-rt-${LLVM_VERSION}-dev-wasm32 libclang-rt-${LLVM_VERSION}-dev-wasm64
```

Add clang toolchain to `PATH` in `${HOME}/.bashrc`:

```bash
echo 'export PATH="${PATH}:/usr/lib/llvm-'"${LLVM_VERSION}"'/bin"' >> "${HOME}/.bashrc"
```

### Set as default `cc`, `cpp`, and `c++` with `update-alternatives`

```bash
sudo update-alternatives --install \
  "$(update-alternatives --query cc | awk '/Link: / { print $2 }')" \
  cc \
  "$(which clang)" \
  1
sudo update-alternatives --set cc "$(which clang)"

for cpp_alternative in 'cpp' 'c++'; do
  sudo update-alternatives --install \
    "$(update-alternatives --query "${cpp_alternative}" | awk '/Link: / { print $2 }')" \
    "${cpp_alternative}" \
    "$(which clang++)" \
    1
  sudo update-alternatives --set "${cpp_alternative}" "$(which clang++)"
done
```

## Building from source

Follow the [official instructions for apt to build LLVM from source][apt-llvm].

## Useful links

- [apt-llvm][apt-llvm]
- [apt-llvm-build-instructions][apt-llvm-build-instructions]

[apt-llvm]: <https://apt.llvm.org/>
[apt-llvm-build-instructions]: <https://apt.llvm.org/building-pkgs.php>


