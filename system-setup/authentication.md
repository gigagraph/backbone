# Authentication

- [ ] TODO: figure out if it is possible to pass Yubikeys via SSH

## Authentication with Yubico Yubikey

> [!IMPORTANT]
>
> Prefer to enroll at least 2 Yubikeys (main and backup) for convenience in the case of hardware failure.

### Installation

#### [`ykman`][ykman-github]

[Install `ykman` CLI](https://github.com/Yubico/yubikey-manager?tab=readme-ov-file#linux):

```shell
sudo apt-add-repository ppa:yubico/stable
sudo apt update
sudo apt install yubikey-manager -y
```

##### `ykman` completions

###### Bash

```shell
source <(_YKMAN_COMPLETE=bash_source ykman | sudo tee /etc/bash_completion.d/ykman)
```

#### [`yubico-pam`][yubico-pam-github]

```shell
sudo add-apt-repository ppa:yubico/stable
sudo apt-get update
sudo apt-get install libpam-yubico -y
```

#### [`yubico-piv-tool`][yubico-piv-tool]

> [!NOTE]
>
> Users must build [`yubico-piv-tool`][yubico-piv-tool] from sources. Therefore, ensure that you have [LLVM toolchain](./llvm-toolchain/README.md) before proceeding.

Clone the git repo and switch to the latest stable version:

```shell
git clone git@github.com:Yubico/yubico-piv-tool.git
cd ./yubico-piv-tool
git checkout yubico-piv-tool-2.6.1
```

Install build dependencies:

```
cmake libtool libssl-dev pkg-config check libpcsclite-dev gengetopt help2man zlib-devel
```

E.g. for Ubuntu:

```shell
sudo apt update -y && sudo apt install -y \
  cmake libtool libssl-dev pkg-config check libpcsclite-dev gengetopt help2man zlib1g zlib1g-dev
```

Build:

```shell
mkdir ./build; cd ./build
CC="$(which clang)" CXX="$(which clang++)" cmake ..
make
sudo make install
sudo ldconfig
```

### Configure local user account authentication with PAM

Based on the [official guide][yubico-pam-unix-user-login].

This configuration will enable offline challenge-response authentication based on HMAC-SHA1 for a unix user account with a Yubikey. When prompted to authenticate, users can touch the enrolled Yubikey to authenticate.

Program the 2nd slot of the Yubikey:

```shell
ykman otp chalresp --totp --touch --generate 2
```

This command will generate a key for the challenge-response OTP authentication in the 2nd Yubikey slot. The command will print the generated key used to set up the slot. Store this key securely, it can be reused to migrate to a new Yubikey.

Generate the initial challange and response:

```shell
mkdir ~/.yubico
ykpamcfg -2 -v
```

Move the generated challenge-response file to the system configuration directory:

```shell
sudo mkdir /etc/yubico-auth
sudo chown root:root /etc/yubico-auth/
sudo chmod 700 /etc/yubico-auth/
sudo mv ~/.yubico/challenge-12345678 "/etc/yubico-auth/${USER}-12345678"
sudo chown root:root "/etc/yubico-auth/${USER}-12345678"
sudo chmod 600 "/etc/yubico-auth/${USER}-12345678"
```

Before updating PAM configuration, start a separate superuser-enabled shell so that you can fix PAM config in case of lockout:

```shell
sudo -s
```

Go back to the main shell and edit the PAM configuration :

```shell
# On Ubuntu edit the `/etc/pam.d/common-auth` file
sudo vi /etc/pam.d/common-auth
```

Configure PAM to accept challenge-response response that Yubikey generates as an **alternative** authentication method. Add the following line to the beginning of the file:

```
auth    sufficient      pam_yubico.so mode=challenge-response chalresp_path=/etc/yubico-auth
```

Apply the changes to PAM:

```shell
sudo pam-auth-update
```

### Configure SSH access with Yubikey

Generate the key:

```shell
yubico-piv-tool -a generate -s 9a -o ssh-public.pem
```

Create a self-signed certificate for the key:

> [!NOTE]
>
> The following command will prompt for the PIV PIN. The default PIV PIN is 123456. Change the default PIN before generating keys with `yubico-piv-tool -a change-pin`.

```shell
yubico-piv-tool -a verify-pin -a selfsign-certificate -s 9a -S "/CN=SSH key/" -i ssh-public.pem -o ssh-cert.pem
```

Import the created certfificate to Yubikey:

```shell
yubico-piv-tool -a import-certificate -s 9a -i ssh-cert.pem
```

Find out where ykcs11 has been installed:

- Debian-based system: `/usr/local/lib/libykcs11.so`.
- MacOS: `/usr/local/lib/libykcs11.dylib`.

Export the public keys from Yubikey and add them to the target system. The keys order corresponds to the slots on Yubikey.

```shell
ssh-keygen -D /usr/local/lib/libykcs11.so -e
```

Now you can access the hosts with added public SSH keys:

```shell
ssh -I /usr/local/lib/libykcs11.so user@host
```

Add the keys to the agent:

```shell
ssh-add -s /usr/local/lib/libykcs11.so

# Check that agent added the keys
ssh-add -L
```

You can delete the private certificate at this point. You should keep the public key just in case.

- [ ] TODO: remote user login and sudo over ssh with Yubikey

## Configure fingerprint sensor

> [!NOTE]
>
> It is recommended to enroll at least 2 fingers to the fingerprint sensor.

### User login

#### Gnome

Users can configure authentication with fingerprint sensor in Gnome out of the box.

1. Go to "Settings" -> "System" -> "Users" and find the user you want to allow to authenticate with the fingerprint sensor.
2. "Fingerprint Login"
3. Scan the fingers you want to use to authenticate.

### Sudo

[Users can configure `sudo` authentication with fingerprints][ubuntu-so-fingerprint-for-sudo]:

1. `sudo pam-auth-update`.
2. Ensure `Fingerprint authentication` is selected.
3. Press enter to apply the settings.
4. Open a new terminal session and run `sudo ls` to test the configuration.

## Useful links

- [arch-wiki-yubikey][arch-wiki-yubikey]
- [yubico-dev-docs][yubico-dev-docs]
  - [yubico-docs-config][yubico-docs-config]
    - [ykman-docs][ykman-docs]
      - [ykman-github][ykman-github]
    - [ykman-qt-docs][ykman-qt-docs]
      - [ykman-qt-github][ykman-qt-github]
  - [yubico-pam-docs][yubico-pam-docs]
    - [yubico-pam-github][yubico-pam-github]
    - [yubico-pam-unix-user-login][yubico-pam-unix-user-login]
  - [yubico-pgp-docs][yubico-pgp-docs]
    - [yubico-pgp-ssh-docs][yubico-pgp-ssh-docs]
  - [yubico-piv]
    - [yubico-secure-ssh-with-openpgp-or-piv][yubico-secure-ssh-with-openpgp-or-piv]
      - [yubico-piv-ssh-pkcs11][yubico-piv-ssh-pkcs11]
      - [yubico-ssh-user-certs-piv][yubico-ssh-user-certs-piv]
    - [yubico-piv-tool][yubico-piv-tool]
- [yubico-product-docs][yubico-product-docs]
  - [yubico-tech-docs][yubico-tech-docs]
- [arch-wiki-fprint][arch-wiki-fprint]
- [fprint-docs][fprint-docs]
- [ubuntu-so-fingerprint-for-sudo][ubuntu-so-fingerprint-for-sudo]
- [arch-wiki-polkit][arch-wiki-polkit]
- [pam-8-man][pam-8-man]
- [pam-conf-man][pam-conf-man]

[arch-wiki-yubikey]: <https://wiki.archlinux.org/title/YubiKey>
[yubico-dev-docs]: <https://developers.yubico.com/>
[yubico-docs-config]: <https://developers.yubico.com/Software_Projects/YubiKey_Device_Configuration/>
[ykman-docs]: <https://developers.yubico.com/yubikey-manager/>
[ykman-github]: <https://github.com/Yubico/yubikey-manager>
[ykman-qt-docs]: <https://developers.yubico.com/yubikey-manager-qt/>
[ykman-qt-github]: <https://github.com/Yubico/yubikey-manager-qt>
[yubico-pam-docs]: <https://developers.yubico.com/yubico-pam/>
[yubico-pam-github]: <https://github.com/Yubico/yubico-pam>
[yubico-pam-unix-user-login]: <https://developers.yubico.com/yubico-pam/Authentication_Using_Challenge-Response.html>
[yubico-pgp-docs]: <https://developers.yubico.com/PGP/>
[yubico-pgp-ssh-docs]: <https://developers.yubico.com/PGP/SSH_authentication/>
[yubico-piv]: <https://developers.yubico.com/PIV/>
[yubico-secure-ssh-with-openpgp-or-piv]: <https://developers.yubico.com/PIV/Guides/Securing_SSH_with_OpenPGP_or_PIV.html>
[yubico-piv-ssh-pkcs11]: <https://developers.yubico.com/PIV/Guides/SSH_with_PIV_and_PKCS11.html>
[yubico-ssh-user-certs-piv]: <https://developers.yubico.com/PIV/Guides/SSH_user_certificates.html>
[yubico-piv-tool]: <https://developers.yubico.com/yubico-piv-tool/>
[yubico-product-docs]: <https://docs.yubico.com/>
[yubico-tech-docs]: <https://docs.yubico.com/hardware/yubikey/yk-tech-manual/index.html>
[arch-wiki-fprint]: <https://wiki.archlinux.org/title/Fprint>
[fprint-docs]: <https://fprint.freedesktop.org/>
[ubuntu-so-fingerprint-for-sudo]: <https://askubuntu.com/questions/1015416/use-fingerprint-authentication-not-only-for-login>
[arch-wiki-polkit]: <https://wiki.archlinux.org/title/Polkit>
[pam-8-man]: <https://man.archlinux.org/man/pam.8>
[pam-conf-man]: <https://man.archlinux.org/man/pam.conf.5>
