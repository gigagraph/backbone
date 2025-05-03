# `ollama`

## Installation

### Without Nvidia and AMD ROCm

This guide recommends install `ollama` as per [official manual installation instructions][ollama-manual-install-linux].

> [!NOTE]
>
> If you are upgrading from a prior version, you should remove the old libraries with `sudo rm -rf /usr/lib/ollama` first.

```bash
curl -L "https://github.com/ollama/ollama/releases/download/${OLLAMA_VERSION}/ollama-linux-amd64.tgz" -o ollama-linux-amd64.tgz
sudo tar -C /usr -xzf ollama-linux-amd64.tgz
```

Add the [`systemd` service](#add-systemd-service).

### Add `ollama` `systemd` service

Create `ollama` user and group and add the current user to the group:

```bash
sudo mkdir /home/ollama
sudo chown -R ollama:ollama /home/ollama
sudo chmod -R 'u=rwx,g=rwx,o=' /home/ollama

sudo useradd -r -s /bin/false -U -m -d /home/ollama ollama
sudo usermod -a -G ollama "$(whoami)"
newgrp ollama
```

Create a service file in `/etc/systemd/system/ollama.service`:

```
[Unit]
Description=Ollama Service
After=network-online.target

[Service]
ExecStart=/usr/bin/ollama serve
User=ollama
Group=ollama
Restart=always
RestartSec=3
Environment="PATH=${PATH}"
Environment="OLLAMA_MODELS=/home/ollama/.local/share/ollama/models"

[Install]
WantedBy=default.target
```

> [!NOTE]
>
> The reason this guide sets `/home/ollama` as a home directory for the `ollama` user account is because it can be the case that the `/usr/share/ollama` directory is on a disk partition that is of a smaller size than a "main" partition. In this case, users should set home directory of the `ollama` account to a directory on a partition where they want to store the models. `ollama` user and group should own the directory and it should have `u=rwx,g=rwx` permissions.

Reload `systemd` manager configuration after adding the service for the first time:

```bash
sudo systemctl daemon-reload
```

Start the ollama `systemd` service:

```bash
sudo systemctl start ollama
```

## Usage

### CLI

Use `ollama run <model-name>` to run a model supported by `ollama`.

Alternatively, users can customize `ollama` models by creating a [`Modelfile`][ollama-modelfile-syntax]. After a user created a Modelfile, they need to `create` a new model from the file, which they can then `run`:

```bash
ollama create <customized-model-name> -f <path-to-modelfile>
ollama run <customized-model-name>
```

## Useful links

- [ollama-site][ollama-site].
- [ollama-manual-install-linux][ollama-manual-install-linux].
- [ollama-faq-where-models-stored][ollama-faq-where-models-stored].
- [ollama-modelfile-syntax][ollama-modelfile-syntax].

[ollama-site]: https://ollama.com/
[ollama-manual-install-linux]: https://github.com/ollama/ollama/blob/main/docs/linux.md
[ollama-faq-where-models-stored]: https://github.com/ollama/ollama/blob/main/docs/faq.md#where-are-models-stored
[ollama-modelfile-syntax]: https://github.com/ollama/ollama/blob/main/docs/modelfile.md

