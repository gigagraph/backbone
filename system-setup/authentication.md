# Authentication

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

### Remove the default configuration for OTP slot 1

By default, a new Yubikey comes with OTP slot 1 programmed. The default configuration will make Yubikey output a token when a user touches the button. This may be inconvenient when touched accidently. To remove this configuration run the following command:

```shell
ykman otp delete 1
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

> [!NOTE]
>
> Alternatively, you can use `ykman` to manage PIV.

Generate the key:

```shell
yubico-piv-tool -a generate -s 9a -o ssh-public.pem
```

Create a self-signed certificate for the key:

> [!NOTE]
>
> The following command will prompt for the PIV PIN. The default PIV PIN is 123456. Change the default PIN before generating keys with `yubico-piv-tool -a change-pin`.
>
> Additionally, if it is the first setup for the Yubikey, you should:
> - Change PUK as well,  with `ykman piv access change-puk`.
> - Generate a new management `ykman piv access change-management-key --generate --protect`. `ykman` will store the generated key on the Yubikey and protect it with PIN.

```shell
yubico-piv-tool -a verify-pin -a selfsign-certificate -s 9a -S "/CN=SSH key/" -i ssh-public.pem -o ssh-cert.pem
```

Import the created certfificate to Yubikey:

```shell
yubico-piv-tool -a verify-pin -a import-certificate -s 9a --touch-policy always -i ssh-cert.pem
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

### Authenticate sudo for unix user account remotely over ssh with Yubikey

SSH to the remote server and configure authentication with [`pam_ssh_agent_auth`][pam-ssh-agent-auth-man] PAM module on the remote server.

Install the `pam_ssh_agent_auth` PAM module:

- FreeBSD:
   - It must be built from sources.
   - ```shell
     git clone --recurse-submodules git@github.com:jbeverly/pam_ssh_agent_auth.git
     cd pam_ssh_agent_auth
     ./configure --without-openssl-header-check
     make
     sudo make install
     sudo ln -s /usr/local/libexec/pam_ssh_agent_auth.so /usr/lib/pam_ssh_agent_auth.so
     ```
- Debian
   - ```shell
     sudo apt install -y libpam-ssh-agent-auth
     ```

> [!IMPORTANT]
>
> To ensure that you will not accidently lock yourself out while changing the PAM cofiguration, **connect to the server from a separate shell and run one one of the following commands to keep a superuser rescue shell session**:
> - `su`
> - `su -i`
> - `sudo -s`

- FreeBSD:
   - Keep `SSH_AUTH_SOCK` env in sudoers. Add the follwing line to `/usr/local/etc/sudoers.d/pam_ssh_agent_auth`:
     ```
     Defaults    env_keep += "SSH_AUTH_SOCK"
     ```
   - ```shell
     sudo visudo -f /usr/local/etc/sudoers.d/pam_ssh_agent_auth
     sudo chmod 0440 /usr/local/etc/sudoers.d/pam_ssh_agent_auth
     ```
   - Add the public key to the `authorized_keys` file. If an associated private key is present in ssh agent on the server, the PAM authentication will succeed.
     ```shell
     sudo vi /etc/security/authorized_keys
     sudo chmod u=rw,g=r,o= /etc/security/authorized_keys
     ```
   - Add the following line to `common-auth` PAM file that we will use later to enable authentication in other services/programs. The line will enable PAM to optionally authenticate a user with the `pam_ssh_agent_auth` module.
     ```
     auth	sufficient	pam_ssh_agent_auth.so file=/etc/security/authorized_keys
     ```
   - ```shell
     sudo vi /etc/pam.d/common-auth
     sudo vi /usr/local/etc/pam.d/common-auth
     ```
   - Add the following line to the PAM file for the specific services. The line will include the previous auth configuration in each file that imports it:
     ```shell
     auth     include        common-auth
     ```
   - ```shell
     sudo vi /usr/local/etc/pam.d/sudo
     sudo vi /etc/pam.d/ftp
     sudo vi /etc/pam.d/imap
     sudo vi /etc/pam.d/login
     sudo vi /etc/pam.d/other 
     sudo vi /etc/pam.d/pop3 
     sudo vi /etc/pam.d/sshd 
     sudo vi /etc/pam.d/su
     sudo vi /etc/pam.d/system 
     sudo vi /etc/pam.d/xdm
     ```
   - Test the configuration by creating a new ssh session with the server (ensure that you forward the local ssh-agent with `-A` flag) and running `sudo ls` with the Yubikey plugged in.
- Debian:
   - Keep `SSH_AUTH_SOCK` env in sudoers. Add the follwing line to `/etc/sudoers.d/pam_ssh_agent_auth`:
     ```
     Defaults    env_keep += "SSH_AUTH_SOCK"
     ```
   - ```shell
     sudo visudo -f /etc/sudoers.d/pam_ssh_agent_auth
     sudo chmod 0440 /etc/sudoers.d/pam_ssh_agent_auth
     ```
   - Add the public key to the `authorized_keys` file. If an associated private key is present in ssh agent on the server, the PAM authentication will succeed.
     ```shell
     sudo vi /etc/security/authorized_keys
     sudo chmod u=rw,g=r,o= /etc/security/authorized_keys
     ```
   - Add the following line to `common-auth` PAM file that we will use later to enable authentication in other services/programs. The line will enable PAM to optionally authenticate a user with the `pam_ssh_agent_auth` module.
     ```
     auth	sufficient	pam_ssh_agent_auth.so file=/etc/security/authorized_keys
     ```
   - ```shell
     sudo vi /etc/pam.d/common-auth
     ```

#### Configure PAM to require a keypress confirmation with Yubikey

- [ ] TODO
  - Possibly:
    - Write a custom script/program, to prompt for a button press with `pam_exec`.
    - Write a custom PAM module.
    - Make sure the module is configurable to fail in non-interactve mode, if this is possible.

### Unenroll a Yubikey

When a Yubikey is lost or compromized follow these instructions to remove it:

- Remove SSH key from GitHub.
- Local system:
  - Remove the corresponding challenge-response file from `/etc/yubico-auth/`.
- Remote machines:
  - Remove the corresponding public key from users' `.ssh/authorized_keys`.
  - Remove the corresponding public key from `/etc/security/authorized_keys`.

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
- [pam-ssh-agent-auth-man][pam-ssh-agent-auth-man]
  - [pam-ssh-agent-auth-github][pam-ssh-agent-auth-github]

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
[pam-ssh-agent-auth-man]: <https://linux.die.net/man/8/pam_ssh_agent_auth>
[pam-ssh-agent-auth-github]: <https://github.com/jbeverly/pam_ssh_agent_auth-2.0>
