# `git`

## Installation

This guide recommnds following the [Git Book][git-book] and [install git with your system's package manager](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

### `apt` based systems

```bash
sudo apt install git
```

## Configuration

> [!NOTE]
>
> Ensure you have the following terminal utils to use this config:
> - [`delta`](../terminal-utils/delta/README.md).
>
> You can verify the versions of the installed toolcahins with the followin script located relative to the repo root: `./dotfiles/terminal-utils/check-versions.sh`.

[User's git configuration should reside in `${XDG_CONFIG_HOME}/git/config`](https://git-scm.com/docs/git-config#Documentation/git-config.txt---global).

Use the config from this repository on your system by creating symlinking the user config default directory to the config dir in this repo (the script will prompt you for confirmation before running any configuration commands):

```bash
./setup-config.sh
```

## Useful links

- [github-git][github-git]
- [git-book][git-book]
- [git-reference-docs][git-reference-docs]

[github-git]: <https://github.com/git/git>
[git-book]: <https://git-scm.com/book/en/v2>
[git-reference-docs]: <https://git-scm.com/docs>
