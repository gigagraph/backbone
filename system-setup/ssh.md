# SSH

## Recommended SSH key setup

Generate 2 keys:
- [One with a strong password](#generate-ssh-keys-on-a-client). This key will enable access by just typing a password.
- [One with a Yubikey](./authentication.md#configure-ssh-access-with-yubikey). This key will be convenient to use.

## Generate SSH keys on a client

Taken from the [official GitLab instructions][gitlab-generate-ssh-keys].

```bash
ssh-keygen -t ed25519 -C "<comment>"
```

## Set up SSH with Yubikey

See the corresponding section in the [Authentication doc](./authentication.md#configure-ssh-access-with-yubikey).

## Add public SSH key to a remote server

Use [`ssh-copy-id`][linux-handbook-ssh-copy-id] to copy the **public** key to a server. This will enable the client with the private key to authenticate with the SSH server.

```bash
ssh-copy-id -i ~/.ssh/path/to/key.pub user@server-address
```

Alternatively, just insert the contents of the public key file as a new line in `~/.ssh/authorized_key` file on the target host.

## SSH tunnelling

[Main guide][baeldung-ssh-proxy].

### Port forwarding

```bash
ssh -L [bind_address:]port:host:hostport [user@]remote_ssh_server
```

### SOKS proxy

```bash
ssh -D [bind_address:]port [user@]remote_ssh_server
```

### Reverse proxy

```bash
# Single port
ssh -R [bind_address:]port:host:hostport [user@]remote_ssh_server

# SOKS
ssh -R [bind_address:]port [user@]remote_ssh_server
```

## Forward the local `ssh-agent`

[Use the `-A` option][arch-wiki-forward-ssh-agent]:

```bash
ssh -A user@server-address
```

## SSH through jump hosts

```bash
ssh -A -p 22 -J jump-user1@jump-server1:port1,jump-user2@jump-server2:port2 user@target-server-address-from-the-jump2-machine
```

## Useful link

- [gitlab-generate-ssh-keys][gitlab-generate-ssh-keys]
- [arch-wiki-open-ssh][arch-wiki-open-ssh]
- [linux-handbook-ssh-copy-id][linux-handbook-ssh-copy-id]
- [arch-wiki-forward-ssh-agent][arch-wiki-forward-ssh-agent]
- [baeldung-ssh-proxy][baeldung-ssh-proxy]

[gitlab-generate-ssh-keys]: <https://docs.gitlab.com/ee/user/ssh.html#generate-an-ssh-key-pair>
[linux-handbook-ssh-copy-id]: <https://linuxhandbook.com/add-ssh-public-key-to-server/>
[arch-wiki-open-ssh]: <https://wiki.archlinux.org/title/OpenSSH>
[arch-wiki-forward-ssh-agent]: <https://wiki.archlinux.org/title/SSH_keys#Forwarding_ssh-agent>
[baeldung-ssh-proxy]: <https://www.baeldung.com/linux/ssh-tunneling-and-proxying#forward-tcp-tunnels>
