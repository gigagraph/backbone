# SSH

## Recommended SSH key setup

Generate 2 keys:
- One with a strong password. This key will enable access by just typing a password.
- One with a Yubikey. This key will be convenient to use

## Generate SSH keys on a client

Taken from the [official GitLab instructions][gitlab-generate-ssh-keys].

```shell
ssh-keygen -t ed25519 -C "<comment>"
```

## Add public SSH key to a remote server

Use [`ssh-copy-id`][linux-handbook-ssh-copy-id] to copy the **public** key to a server. This will enable the client with the private key to authenticate with the SSH server.

```shell
ssh-copy-id -i ~/.ssh/path/to/key.pub user@server-address
```

## SSH tunnelling

[Main guide][baeldung-ssh-proxy].

### Port forwarding

```shell
ssh -L [bind_address:]port:host:hostport [user@]remote_ssh_server
```

### SOKS proxy

```shell
ssh -D [bind_address:]port [user@]remote_ssh_server
```

### Reverse proxy

```shell
# Single port
ssh -R [bind_address:]port:host:hostport [user@]remote_ssh_server

# SOKS
ssh -R [bind_address:]port [user@]remote_ssh_server
```

## Forward the local `ssh-agent`

[Use the `-A` option][arch-wiki-forward-ssh-agent]:

```shell
ssh -A user@server-address
```

## SSH through jump hosts

```shell
ssh -A -p 22 -J jump-user1@jump-server1,jump-user2@jump-server2 user@target-server-address-from-the-jump2-machine
```

## Useful link

- [gitlab-generate-ssh-keys][gitlab-generate-ssh-keys]
- [linux-handbook-ssh-copy-id][linux-handbook-ssh-copy-id]
- [arch-wiki-forward-ssh-agent][arch-wiki-forward-ssh-agent]

[gitlab-generate-ssh-keys]: <https://docs.gitlab.com/ee/user/ssh.html#generate-an-ssh-key-pair>
[linux-handbook-ssh-copy-id]: <https://linuxhandbook.com/add-ssh-public-key-to-server/>
[arch-wiki-forward-ssh-agent]: <https://wiki.archlinux.org/title/SSH_keys#Forwarding_ssh-agent>
[baeldung-ssh-proxy]: <https://www.baeldung.com/linux/ssh-tunneling-and-proxying#forward-tcp-tunnels>
